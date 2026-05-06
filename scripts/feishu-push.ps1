<#
.SYNOPSIS
Push unsent literature reports to Feishu webhook.
Standalone — no dependency on local-growth-hub.
#>
param(
    [string]$LiteratureRepo = "D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库",
    [string]$StatePath = "D:\playground\literature-lab\state\sent-reports.json",
    [string]$WebhookUrl = "",
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# ── Fingerprint helpers ──

function Get-ContentFingerprint {
    param([string]$Path)
    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $sha256 = [System.Security.Cryptography.SHA256]::Create()
    $hash = $sha256.ComputeHash($bytes)
    return [BitConverter]::ToString($hash) -replace '-', ''
}

function Load-SentFingerprints {
    param([string]$Path)
    if (-not (Test-Path $Path)) { return @() }
    try {
        $raw = (Get-Content $Path -Raw -Encoding UTF8).TrimStart([char]0xFEFF)
        if (-not $raw.Trim()) { return @() }
        $data = $raw | ConvertFrom-Json
        return @($data.sent)
    } catch { return @() }
}

function Save-SentFingerprints {
    param([string]$Path, [string[]]$Fingerprints)
    $dir = Split-Path -Parent $Path
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    $payload = @{ sent = @($Fingerprints) } | ConvertTo-Json -Depth 4
    Set-Content -Path $Path -Value $payload -Encoding UTF8
}

# ── Report scanning ──

function Get-LiteratureReports {
    param([string]$RepoPath)
    $reports = @()
    $dailyDir = Join-Path $RepoPath "daily"
    $weeklyDir = Join-Path $RepoPath "weekly"

    foreach ($dir in @($dailyDir, $weeklyDir)) {
        if (-not (Test-Path $dir)) { continue }
        $files = Get-ChildItem -Path $dir -Filter "*.md" -File -Recurse
        foreach ($file in $files) {
            $dateMatch = $file.Name -match '(\d{4}-\d{2}-\d{2})'
            $reportDate = if ($dateMatch) { [datetime]$Matches[1] } else { [datetime]::MinValue }
            $fingerprint = Get-ContentFingerprint -Path $file.FullName
            $isDaily = $file.FullName -match '\\daily\\'
            $sentId = if ($isDaily) {
                $file.Name -replace 'paper-radar-', '' -replace '\.md$', ''
            } else {
                $file.Name -replace 'weekly-paper-brief-', '' -replace '\.md$', ''
            }
            $reports += [PSCustomObject]@{
                File        = $file
                SentId      = $sentId
                ReportDate  = $reportDate
                Fingerprint = $fingerprint
            }
        }
    }
    return $reports | Sort-Object { $_.File.Name }
}

# ── Feishu rich card builder ──

function Get-MarkdownSections {
    param([string]$Body)
    $sections = [ordered]@{}
    $currentSection = '_root'
    $sections[$currentSection] = @()
    foreach ($line in ($Body -split '\r?\n')) {
        if ($line -match '^##\s+(.+)') {
            $currentSection = $Matches[1].Trim()
            $sections[$currentSection] = @()
        } else {
            $sections[$currentSection] += $line
        }
    }
    return $sections
}

function Extract-Bullets {
    param([string[]]$Lines, [int]$Max = 6)
    $items = @($Lines | Where-Object { $_ -match '^\s*-\s+' } | ForEach-Object { $_ -replace '^\s*-\s+', '' })
    return $items | Select-Object -First $Max
}

function Build-FeishuCardData {
    param([string]$Body, [string]$SentId)

    $sections = Get-MarkdownSections -Body $Body
    $sectionNames = @($sections.Keys | Where-Object { $_ -ne '_root' })
    $elements = [System.Collections.Generic.List[object]]::new()

    # ── Metadata we track and return ──
    $paperCount = 0
    $script:fbHasHighImpact = $false
    $script:fbAllArXiv = $true
    $script:fbDOIs = [System.Collections.Generic.List[string]]::new()

    if ($sectionNames.Count -eq 0) {
        [void]$elements.Add(@{ tag = "markdown"; content = $Body.Substring(0, [Math]::Min(4000, $Body.Length)) })
        return [PSCustomObject]@{ Elements = $elements.ToArray(); PaperCount = 0; HasHighImpact = $false; AllArXiv = $true; DOIs = @() }
    }

    $hr = @{ tag = "hr" }

    # ── Helper: section header div with icon ──
    function Section-Header {
        param([string]$Title, [string]$IconToken, [string]$IconColor = "blue")
        return [ordered]@{
            tag = "div"
            text = [ordered]@{ tag = "lark_md"; content = "**$Title**" }
            icon = [ordered]@{ tag = "standard_icon"; token = $IconToken; color = $IconColor }
        }
    }

    # ── Helper: status badge + impact tracking ──
    function Status-Badge {
        param([string]$RawStatus)
        $status = $RawStatus.Trim()
        $color = if ($status -match '(?i)published|Nature|Science|PRL|PRX|PRB|accepted') {
            'green'
        } elseif ($status -match '(?i)arXiv|preprint') {
            'orange'
        } else {
            'indigo'
        }
        $label = if ($status -match '(?i)published') { '已发表' }
                 elseif ($status -match '(?i)accepted') { '已接收' }
                 elseif ($status -match '(?i)arXiv|preprint') { '预印本' }
                 else { '新论文' }
        # Track impact
        if ($status -match '(?i)Nature\s+Nanotech|Nature\s+Physics|Nature\s+Materials|Science|PRL|PRX') {
            $script:fbHasHighImpact = $true
        }
        if ($status -notmatch '(?i)arXiv|preprint') { $script:fbAllArXiv = $false }
        return @{ Color = $color; Label = $label; FullStatus = $status }
    }

    # ── Helper: extract DOI from text ──
    function Extract-Link {
        param([string]$Text)
        if ($Text -match '(10\.\d{4,}/[^\s]+)') {
            $doi = $Matches[1] -replace '[.,;:]$', ''
            $script:fbDOIs.Add("doi:$doi")
            return [PSCustomObject]@{ Url = "https://doi.org/$doi"; Label = "查看原文" }
        }
        # arXiv ID
        if ($Text -match 'arXiv[^\d]*(\d{4}\.\d{4,}(v\d+)?)') {
            $arxId = $Matches[1]
            return [PSCustomObject]@{ Url = "https://arxiv.org/abs/$arxId"; Label = "查看原文" }
        }
        return $null
    }

    # ════════════════════════════════════════════
    # 1. Key Conclusions
    # ════════════════════════════════════════════
    $conclusionName = $sectionNames[0]
    $conclusionBullets = Extract-Bullets -Lines $sections[$conclusionName] -Max 3
    if ($conclusionBullets.Count -gt 0) {
        [void]$elements.Add((Section-Header "今日结论" "lamp_outlined" "turquoise"))
        $md = ($conclusionBullets | ForEach-Object { "- $_" }) -join "`n"
        [void]$elements.Add(@{ tag = "markdown"; content = $md })
    }

    # ════════════════════════════════════════════
    # 2. Must-Read Papers — column_set layout
    # ════════════════════════════════════════════
    $mustReadName = $null
    foreach ($name in $sectionNames) {
        if (($sections[$name] | Where-Object { $_ -match '^###\s+' }).Count -gt 0) {
            $mustReadName = $name; break
        }
    }

    if ($mustReadName) {
        [void]$elements.Add($hr)
        [void]$elements.Add((Section-Header "必看论文" "book-open_outlined" "blue"))

        $mustReadLines = $sections[$mustReadName] -join "`n"
        $paperBlocks = $mustReadLines -split '\r?\n(?=###\s)' | Where-Object { $_.Trim() }
        foreach ($block in $paperBlocks) {
            if ($paperCount -ge 5) { break }
            $blockLines = $block -split '\r?\n'
            $title = ''; $oneLiner = ''; $status = ''; $why = ''; $relation = ''
            foreach ($bl in $blockLines) {
                if ($bl -match '^###\s+(.+)') { $title = $Matches[1].Trim() }
                if ($bl -match '\*\*一句话\*\*[：:]?\s*(.+)') { $oneLiner = $Matches[1].Trim() }
                if ($bl -match '\*\*状态\*\*[：:]?\s*(.+)') { $status = $Matches[1].Trim() }
                if ($bl -match '\*\*为什么重要\*\*[：:]?\s*(.+)') { $why = $Matches[1].Trim() }
                if ($bl -match '\*\*和\s*(TS|thesis)\s*的关系\*\*[：:]?\s*(.+)') { $relation = $Matches[2].Trim() }
                if (-not $relation) { if ($bl -match '\*\*和.*关系\*\*[：:]?\s*(.+)') { $relation = $Matches[1].Trim() } }
            }
            if (-not $title) { continue }

            $paperCount++
            $badgeInfo = Status-Badge $status
            $link = Extract-Link $status
            if (-not $link) { $link = Extract-Link "$title $oneLiner $why" }

            # Mobile-friendly: bold labels with line breaks, no tables
            $paperMd = "<text_tag color='$($badgeInfo.Color)'>$($badgeInfo.Label)</text_tag> **$paperCount. $title**`n`n"
            $paperMd += "**状态** $($badgeInfo.FullStatus)`n`n"
            if ($oneLiner) { $paperMd += "**一句话** $oneLiner`n`n" }
            if ($why) { $paperMd += "**为什么重要** $why`n`n" }
            if ($relation) { $paperMd += "**和你的关系** $relation" }

            [void]$elements.Add(@{ tag = "markdown"; content = $paperMd.Trim() })

            # Add link button if DOI or arXiv ID found
            if ($link) {
                [void]$elements.Add([ordered]@{
                    tag = "button"
                    text = [ordered]@{ tag = "plain_text"; content = $link.Label }
                    type = "primary"
                    action_type = "link"
                    url = $link.Url
                })
            }

            # Separator between papers (skip after last)
            if ($paperCount -lt $paperBlocks.Count) {
                [void]$elements.Add($hr)
            }
        }
    }

    # ════════════════════════════════════════════
    # 3. Background / Frontier Tracking
    # ════════════════════════════════════════════
    $bgName = $sectionNames | Where-Object {
        $_ -match '(?i)(背景|前沿|background|frontier|tracking)'
    } | Select-Object -First 1
    if ($bgName) {
        $bgItems = Extract-Bullets -Lines $sections[$bgName] -Max 6
        if ($bgItems.Count -gt 0) {
            [void]$elements.Add($hr)
            [void]$elements.Add((Section-Header "背景 / 前沿跟踪" "info_outlined" "grey"))
            $md = ($bgItems | ForEach-Object { "- $_" }) -join "`n"
            [void]$elements.Add(@{ tag = "markdown"; content = $md })
        }
    }

    # ════════════════════════════════════════════
    # 4. Thesis Impact
    # ════════════════════════════════════════════
    $thesisName = $sectionNames | Where-Object {
        $_ -match '(?i)thesis'
    } | Select-Object -First 1
    if ($thesisName) {
        $thesisItems = Extract-Bullets -Lines $sections[$thesisName] -Max 4
        if ($thesisItems.Count -gt 0) {
            [void]$elements.Add($hr)
            [void]$elements.Add((Section-Header "对 thesis 的直接用处" "academic-cap_outlined" "green"))
            $md = ($thesisItems | ForEach-Object { "- $_" }) -join "`n"
            [void]$elements.Add(@{ tag = "markdown"; content = $md })
        }
    }

    # ════════════════════════════════════════════
    # 5. Deposit Summary
    # ════════════════════════════════════════════
    $depositName = $sectionNames | Where-Object {
        $_ -match '(?i)(沉淀|产出|deposit|output)'
    } | Select-Object -First 1
    if ($depositName) {
        $depositItems = Extract-Bullets -Lines $sections[$depositName] -Max 5
        if ($depositItems.Count -gt 0) {
            [void]$elements.Add($hr)
            [void]$elements.Add((Section-Header "当日沉淀" "folder_outlined" "grey"))
            $md = ($depositItems | ForEach-Object { "- $_" }) -join "`n"
            [void]$elements.Add(@{ tag = "markdown"; content = $md })
        }
    }

    # ════════════════════════════════════════════
    # 6. Next Steps
    # ════════════════════════════════════════════
    $nextName = $sectionNames | Where-Object {
        $_ -match '(?i)(下一步|next|todo|follow)'
    } | Select-Object -First 1
    if (-not $nextName) { $nextName = $sectionNames[-1] }
    if ($nextName) {
        $nextItems = Extract-Bullets -Lines $sections[$nextName] -Max 2
        if ($nextItems.Count -gt 0) {
            [void]$elements.Add($hr)
            [void]$elements.Add((Section-Header "下一步" "right_outlined" "blue"))
            $md = ($nextItems | ForEach-Object { "- $_" }) -join "`n"
            [void]$elements.Add(@{ tag = "markdown"; content = $md })
        }
    }

    # ── Footer ──
    if ($SentId) {
        [void]$elements.Add($hr)
        [void]$elements.Add(@{ tag = "markdown"; content = "完整日报: $SentId" })
    }

    return [PSCustomObject]@{
        Elements       = $elements.ToArray()
        PaperCount     = $paperCount
        HasHighImpact  = $script:fbHasHighImpact
        AllArXiv       = ($paperCount -gt 0 -and $script:fbAllArXiv)
        DOIs           = $script:fbDOIs.ToArray()
    }
}

# ── HTTP send ──

function Send-FeishuCard {
    param([string]$Url, [string]$Title, [array]$Elements, [int]$PaperCount, [bool]$HasHighImpact, [bool]$AllArXiv)

    # Header color: red for high-impact, yellow for all-arxiv, blue default
    $headerTemplate = if ($HasHighImpact) { "red" } elseif ($AllArXiv) { "yellow" } else { "blue" }

    # Header with paper count badge
    $header = [ordered]@{
        title = [ordered]@{ content = $Title; tag = "plain_text" }
        template = $headerTemplate
    }
    if ($PaperCount -gt 0) {
        $header.text_tag_list = @(
            [ordered]@{
                tag = "text_tag"
                text = [ordered]@{ tag = "plain_text"; content = "${PaperCount}篇" }
                color = "neutral"
            }
        )
    }

    $payload = [ordered]@{
        msg_type = "interactive"
        card = [ordered]@{
            schema = "2.0"
            header = $header
            body = [ordered]@{
                elements = $Elements
            }
        }
    }

    $json = ConvertTo-Json -InputObject $payload -Depth 8 -Compress
    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($json)
    $response = Invoke-WebRequest -Uri $Url -Method Post -Body $bodyBytes -ContentType "application/json; charset=utf-8" -UseBasicParsing
    $statusCode = $response.StatusCode
    if ($statusCode -eq 200) {
        $respBody = $response.Content | ConvertFrom-Json
        if ($respBody.code -eq 0) { return $true }
        Write-Warning "Feishu API returned code=$($respBody.code), msg=$($respBody.msg)"
        return $false
    }
    Write-Warning "HTTP $statusCode from Feishu webhook"
    return $false
}

# ── Main ──

Write-Host "=== literature-lab Feishu Push ==="

if (-not $WebhookUrl) {
    $WebhookUrl = [Environment]::GetEnvironmentVariable("FEISHU_WEBHOOK_URL", "Process")
}
if (-not $WebhookUrl) {
    $ctiPath = Join-Path $HOME ".claude-to-im\config.env"
    if (Test-Path $ctiPath) {
        $match = Select-String -Path $ctiPath -Pattern 'FEISHU_WEBHOOK_URL=(.+)' | Select-Object -First 1
        if ($match) { $WebhookUrl = $match.Matches.Groups[1].Value.Trim() }
    }
}
if (-not $WebhookUrl) {
    Write-Error "No Feishu webhook URL found. Set FEISHU_WEBHOOK_URL env var or pass -WebhookUrl."
    exit 1
}

$sentFingerprints = @(Load-SentFingerprints -Path $StatePath)
$sentSet = [System.Collections.Generic.HashSet[string]]::new()
foreach ($fp in $sentFingerprints) { [void]$sentSet.Add($fp) }
$reports = Get-LiteratureReports -RepoPath $LiteratureRepo
$toSend = @($reports | Where-Object { -not $sentSet.Contains($_.Fingerprint) -and $_.ReportDate -ne [datetime]::MinValue })

if ($toSend.Count -eq 0) {
    Write-Host "No unsent literature reports found."
    exit 0
}

foreach ($report in $toSend) {
    $body = Get-Content -Path $report.File.FullName -Raw -Encoding UTF8
    $cardData = Build-FeishuCardData -Body $body -SentId $report.SentId
    $elements = $cardData.Elements
    $paperCount = $cardData.PaperCount
    $hasHighImpact = $cardData.HasHighImpact
    $allArXiv = $cardData.AllArXiv

    $title = "文献雷达 - $($report.SentId)"

    if ($DryRun) {
        $headerLabel = if ($hasHighImpact) { "RED" } elseif ($allArXiv) { "YELLOW" } else { "BLUE" }
        Write-Host "DRY RUN - $($report.File.Name)"
        Write-Host "Papers: $paperCount | Header: $headerLabel | Elements: $($elements.Count)"
        Write-Host "Elements:"
        foreach ($el in $elements) {
            switch ($el.tag) {
                "hr" { Write-Host "  [hr]" }
                "markdown" {
                    $c = if ($el.content) { $el.content.Substring(0, [Math]::Min(80, $el.content.Length)).Replace("`n",' ') + '...' } else { '(empty)' }
                    Write-Host "  [markdown] $c"
                }
                "div" {
                    $t = if ($el.text.content) { $el.text.content.Substring(0, [Math]::Min(60, $el.text.content.Length)) } else { '(no text)' }
                    $i = if ($el.icon.token) { " icon=$($el.icon.token)" } else { "" }
                    Write-Host "  [div$i] $t"
                }
                "column_set" {
                    $n = $el.columns.Count
                    Write-Host "  [column_set ($n cols)]"
                    foreach ($col in $el.columns) {
                        $sub = ($col.elements | ForEach-Object { "[$($_.tag)]" }) -join ' '
                        Write-Host "    col (w=$($col.weight)): $sub"
                    }
                }
                "button" {
                    $btnText = if ($el.text.content) { $el.text.content } else { '(no text)' }
                    Write-Host "  [button -> $btnText]"
                }
                default { Write-Host "  [$($el.tag)]" }
            }
        }
        # Output raw JSON for debugging
        $headerTemplate = if ($hasHighImpact) { "red" } elseif ($allArXiv) { "yellow" } else { "blue" }
        $header = [ordered]@{ title = [ordered]@{ content = $title; tag = "plain_text" }; template = $headerTemplate }
        if ($paperCount -gt 0) {
            $header.text_tag_list = @([ordered]@{ tag = "text_tag"; text = [ordered]@{ tag = "plain_text"; content = "${paperCount}篇" }; color = "neutral" })
        }
        $payload = [ordered]@{ msg_type = "interactive"; card = [ordered]@{ schema = "2.0"; header = $header; body = [ordered]@{ elements = $elements } } }
        $json = ConvertTo-Json -InputObject $payload -Depth 8 -Compress
        Write-Host "--- RAW JSON (first 2000 chars) ---"
        Write-Host $json.Substring(0, [Math]::Min(2000, $json.Length))
        Write-Host "---"
        continue
    }

    $ok = Send-FeishuCard -Url $WebhookUrl -Title $title -Elements $elements -PaperCount $paperCount -HasHighImpact $hasHighImpact -AllArXiv $allArXiv
    if ($ok) {
        [void]$sentSet.Add($report.Fingerprint)
        Save-SentFingerprints -Path $StatePath -Fingerprints @($sentSet)
        Write-Host "Sent: $($report.File.Name)"
    } else {
        Write-Warning "Failed to send: $($report.File.Name)"
    }
}

Write-Host "Done. Sent: $($toSend.Count) report(s)."
