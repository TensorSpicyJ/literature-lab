#!/bin/bash
# ============================================================
# Feishu Webhook Push (Linux)
# 按 literature-lab 的飞书格式发送交互卡片 (JSON 2.0)
#
# 用法:
#   ./feishu-push.sh -t "标题" -b "markdown正文"
#   ./feishu-push.sh -t "标题" -f /path/to/report.md
#   ./feishu-push.sh -f /path/to/report.md          # 从文件提取首个 ## 作为标题
#   ./feishu-push.sh -t "标题" -b "正文" -u <webhook-url>
#
# Webhook URL 优先级: -u 参数 > FEISHU_WEBHOOK_URL 环境变量 > 内置默认值
# ============================================================
set -e

# ── 默认 webhook ──
WEBHOOK_URL="https://open.feishu.cn/open-apis/bot/v2/hook/4e9aeb27-b7db-48e1-812b-b37b49933d42"

usage() {
    cat <<'EOF'
Usage: feishu-push.sh -t <title> -b <body> [-u <webhook_url>]
       feishu-push.sh -t <title> -f <file>   [-u <webhook_url>]
       feishu-push.sh -f <file>              [-u <webhook_url>]

Options:
  -t   Card title (required unless -f extracts it from first ## heading)
  -b   Markdown body text
  -f   Read body from a markdown file; without -t, first ## heading becomes title
  -u   Feishu webhook URL (default: env FEISHU_WEBHOOK_URL or built-in)
  -h   Show this help

Card format: JSON 2.0, blue-header interactive card with markdown element.
EOF
}

# ── 参数解析 ──
TITLE=""
BODY=""
FILE=""
HOOK=""

while getopts "t:b:f:u:h" opt; do
    case $opt in
        t) TITLE="$OPTARG" ;;
        b) BODY="$OPTARG" ;;
        f) FILE="$OPTARG" ;;
        u) HOOK="$OPTARG" ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done

# ── 确定 webhook URL ──
if [ -z "$HOOK" ]; then
    HOOK="${FEISHU_WEBHOOK_URL:-$WEBHOOK_URL}"
fi

# ── 读取文件内容 ──
if [ -n "$FILE" ]; then
    if [ ! -f "$FILE" ]; then
        echo "Error: file not found: $FILE" >&2
        exit 1
    fi
    BODY=$(cat "$FILE")

    # 如果没传 -t，从文件首个 ## 提取标题
    if [ -z "$TITLE" ]; then
        TITLE=$(grep -m1 '^## ' "$FILE" | sed 's/^## //' || true)
        if [ -z "$TITLE" ]; then
            TITLE=$(basename "$FILE" .md)
        fi
    fi
fi

# ── 校验 ──
if [ -z "$TITLE" ]; then
    echo "Error: title is required (-t or first ## heading in file)" >&2
    usage
    exit 1
fi
if [ -z "$BODY" ]; then
    echo "Error: body is required (-b or -f)" >&2
    usage
    exit 1
fi

# ── 飞书卡片 markdown 清洗 ──
# 仅处理 Obsidian [[wiki links]]（飞书不认）
sanitize_for_feishu() {
    sed -E \
      -e 's/\[\[([^]]*\/)?([^]|]+)\]\]/\2/g' \
      -e 's/\.md([^a-z])/\1/g' \
      -e 's/\.md$//g'
}

BODY=$(echo "$BODY" | sanitize_for_feishu)

# ── 构建飞书 interactive card JSON (2.0 schema) ──
PAYLOAD=$(jq -n \
    --arg title "$TITLE" \
    --arg body "$BODY" \
    '{
        msg_type: "interactive",
        card: {
            schema: "2.0",
            header: {
                title: { content: $title, tag: "plain_text" },
                template: "blue"
            },
            body: {
                elements: [
                    { tag: "markdown", content: $body }
                ]
            }
        }
    }')

# ── 发送 ──
RESP=$(curl -s -w "\n%{http_code}" \
    -X POST "$HOOK" \
    -H "Content-Type: application/json; charset=utf-8" \
    -d "$PAYLOAD" 2>&1)

HTTP_CODE=$(echo "$RESP" | tail -1)
RESP_BODY=$(echo "$RESP" | sed '$d')

if [ "$HTTP_CODE" -eq 200 ]; then
    CODE=$(echo "$RESP_BODY" | jq -r '.code // empty' 2>/dev/null)
    if [ "$CODE" = "0" ]; then
        echo "Sent OK: $TITLE"
    else
        MSG=$(echo "$RESP_BODY" | jq -r '.msg // empty' 2>/dev/null)
        echo "Feishu API error: code=$CODE msg=$MSG" >&2
        exit 1
    fi
else
    echo "HTTP error: $HTTP_CODE" >&2
    echo "$RESP_BODY" >&2
    exit 1
fi
