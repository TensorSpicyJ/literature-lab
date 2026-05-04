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

# ── Feishu summary builder (simplified) ──

function Get-MarkdownSections {
    param([string]$Body)
    $sections = @{}
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

function Build-FeishuSummary {
    param([string]$Body, [string]$SentId)

    $sections = Get-MarkdownSections -Body $Body
    $lines = [System.Collections.Generic.List[string]]::new()
    $sectionNames = @($sections.Keys | Where-Object { $_ -ne '_root' })

    if ($sectionNames.Count -eq 0) {
        [void]$lines.Add("**摘要**")
        $bodyLines = $Body -split '\r?\n' | Select-Object -First 10
        foreach ($l in $bodyLines) { if ($l.Trim()) { [void]$lines.Add("- $($l.Trim())") } }
        return ($lines -join "`n").Trim()
    }

    # First section = 今日结论
    $conclusionLines = $sections[$sectionNames[0]]
    $conclusionItems = @($conclusionLines | Where-Object { $_.Trim() -match '^-\s+' } | Select-Object -First 3)
    if ($conclusionItems.Count -gt 0) {
        [void]$lines.Add("**结论**")
        foreach ($item in $conclusionItems) { [void]$lines.Add($item.Trim()) }
    }

    # 必看论文 section (has ### sub-headings)
    $mustReadName = $null
    foreach ($name in $sectionNames) {
        if (($sections[$name] | Where-Object { $_.Trim() -match '^###\s+' }).Count -gt 0) {
            $mustReadName = $name; break
        }
    }
    if ($mustReadName) {
        if ($lines.Count -gt 0) { [void]$lines.Add('') }
        [void]$lines.Add("**必看论文**")
        $mustReadLines = $sections[$mustReadName] -join "`n"
        $paperBlocks = $mustReadLines -split '(?=^###\s+)' | Where-Object { $_.Trim() }
        $count = 0
        foreach ($block in $paperBlocks) {
            if ($count -ge 3) { break }
            $blockLines = $block -split '\r?\n'
            $title = ''
            $oneLiner = ''
            foreach ($bl in $blockLines) {
                if ($bl -match '^###\s+(.+)') { $title = $Matches[1].Trim() }
                if ($bl -match '\*\*一句话\*\*[：:]?\s*(.+)') { $oneLiner = $Matches[1].Trim() }
            }
            if ($title) {
                [void]$lines.Add("$($count+1). $title")
                if ($oneLiner) { [void]$lines.Add("   $oneLiner") }
            }
            $count++
        }
    }

    # Thesis section
    $thesisName = $null
    foreach ($name in $sectionNames) {
        if ($name -match '(?i)thesis') { $thesisName = $name; break }
    }
    if ($thesisName) {
        $thesisItems = @($sections[$thesisName] | Where-Object { $_.Trim() -match '^-\s+' } | Select-Object -First 2)
        if ($thesisItems.Count -gt 0) {
            if ($lines.Count -gt 0) { [void]$lines.Add('') }
            [void]$lines.Add("**对 thesis 的直接用处**")
            foreach ($item in $thesisItems) { [void]$lines.Add($item.Trim()) }
        }
    }

    # Last section = 下一步
    $lastItems = @($sections[$sectionNames[-1]] | Where-Object { $_.Trim() -match '^-\s+' } | Select-Object -First 1)
    if ($lastItems.Count -gt 0) {
        if ($lines.Count -gt 0) { [void]$lines.Add('') }
        [void]$lines.Add("**下一步**")
        foreach ($item in $lastItems) { [void]$lines.Add($item.Trim()) }
    }

    if ($SentId) {
        [void]$lines.Add('')
        [void]$lines.Add("完整笔记：$SentId")
    }

    return ($lines -join "`n").Trim()
}

# ── HTTP send ──

function Send-FeishuWebhook {
    param([string]$Url, [string]$Title, [string]$Body)
    $payload = @{
        msg_type = "interactive"
        card = @{
            header = @{
                title = @{ content = $Title; tag = "plain_text" }
                template = "blue"
            }
            elements = @(
                @{
                    tag = "markdown"
                    content = $Body
                }
            )
        }
    } | ConvertTo-Json -Depth 5 -Compress

    $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($payload)
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
    $summary = Build-FeishuSummary -Body $body -SentId $report.SentId

    if ($DryRun) {
        Write-Host "DRY RUN — would send: $($report.File.Name)"
        Write-Host $summary
        Write-Host "---"
        continue
    }

    $title = "Paper Radar — $($report.SentId)"
    $ok = Send-FeishuWebhook -Url $WebhookUrl -Title $title -Body $summary
    if ($ok) {
        [void]$sentSet.Add($report.Fingerprint)
        Save-SentFingerprints -Path $StatePath -Fingerprints @($sentSet)
        Write-Host "Sent: $($report.File.Name)"
    } else {
        Write-Warning "Failed to send: $($report.File.Name)"
    }
}

Write-Host "Done. Sent: $($toSend.Count) report(s)."
