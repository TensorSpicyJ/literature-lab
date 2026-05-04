# Deposit Rules

## Priority-Based Routing

| Topic priority | daily/ | papers/ | indexes/ | for-thesis/ |
|---------------|--------|---------|----------|-------------|
| thesis | ✓ | ✓ | ✓ | ✓ (published/accepted only) |
| core | ✓ | ✓ | ✓ | ✗ |
| interest | ✓ | ✗ | ✓ | ✗ |

## Daily Radar (`daily/YYYY-MM/paper-radar-YYYY-MM-DD.md`)

Always produced. Follows `protocols/feishu-format.md` for the six-section structure.

Even if no qualifying literature was found, write a truthful radar that says so.

## Paper Notes (`papers/<slug>.md`)

Created only for papers meeting the quality threshold in `paper-analysis.md`. Each note is a standalone markdown file with YAML frontmatter:

```yaml
---
title: "Paper Title"
authors: "Author List"
year: 2026
venue: "Journal Name"
doi: "10.xxxx/xxxxx"
arxiv: "arXiv:XXXX.XXXXX"
topic: "topic-name-from-index"
priority: "thesis|core|interest"
status: "published|accepted|arXiv|preprint|unpublished"
citation_chapter: "Chap_Intro|Chap_LSCO|Chap_Diode|Chap_Magnetic"
ref_priority: "A|B|C"
---
```

Body follows the extraction fields from `paper-analysis.md`, plus the correlation block from `correlation.md`.

## Index Updates (`indexes/topic-index.md`)

After each run:
1. Add new papers under their topic heading
2. Use format: `[[papers/<slug>]]：one-line description`
3. If a genuinely new sub-topic emerged, add a new `## <topic>` heading

## For-Thesis (`for-thesis/<descriptive-slug>.md`)

Created only for thesis-priority papers that are `published` or `accepted`. Content is more distilled than the paper note — focused on what can be directly reused in thesis writing.

File naming: `YYYY-MM-DD-thesis-extract-<topic-slug>.md`

## Output Paths

All output goes to BaiduSyncdisk, not playground:

| Output | Full Path |
|--------|-----------|
| Daily radar | `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\daily\YYYY-MM\` |
| Paper notes | `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\papers\` |
| Index | `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\indexes\topic-index.md` |
| For-thesis | `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\for-thesis\` |
