# Step Composition Guide

## Atomic Steps

The pipeline has five independent steps. Combine them as needed.

| Step | What it does | Input | Output |
|------|-------------|-------|--------|
| `search` | WebSearch across specified topics | topics.json + search-log.json | candidate list |
| `filter` | Score by source policy, pick shortlist | candidate list | shortlist (≤5 main, rest in background) |
| `analyze` | TEX-first deep read, structured extraction | shortlist | structured paper notes |
| `correlate` | Cross-reference with existing library | notes + topic-index + papers/ | correlation annotations |
| `deposit` | Write output to BaiduSyncdisk | notes + correlations | daily radar, paper notes, index updates, for-thesis |

## Common Modes

### Full Thesis Run: `search → filter → analyze → correlate → deposit`
Daily thesis push. Covers all thesis + core topics. Output enters `for-thesis/`.

### Interest Reading: `search → analyze → deposit`
Topological order or other interest-line learning. No thesis steps. Output only in `daily/` + `indexes/`.

### Quick Scan: `search → filter`
Check what's new. No deep reading, nothing enters the library.

## Free Composition

Invoke with natural language. The topic's `priority` field in topics.json is a hint only — the user's instruction at invocation time always takes precedence.

Examples:
- "按 topics.json 跑今天的 thesis 线全流程"
- "搜拓扑序最近一周的新文献，挑两篇好的读一下，不用写论文素材"
- "快速扫一遍 LSCO 超薄方向，只筛不读"
- "搜铜基和拓扑序，读完做关联，但不用写日报"

## Priority-Aware Defaults

When the user doesn't specify steps explicitly, these defaults apply per topic priority:

| priority | default steps | for-thesis? |
|----------|--------------|-------------|
| thesis | search → filter → analyze → correlate → deposit | yes |
| core | search → filter → analyze → deposit | no |
| interest | search → analyze → deposit | no |
