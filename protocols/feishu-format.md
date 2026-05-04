# Feishu Format Spec

## Delivery Goal

Each daily radar pushed to Feishu must be scannable in under 30 seconds. TS reads these on mobile between tasks.

## Six-Section Structure (固定顺序)

```
## 今日结论
## 必看论文
## 背景 / 前沿跟踪
## 对 thesis 最直接的用处
## 当日沉淀
## 下一步
```

## Section Rules

### 今日结论
1-3 bullet points. Answer: "what happened today in literature?" Include the verdict even when there's nothing: "今天没有新的强正式文献，只做了主线收口或背景补充。"

### 必看论文
Up to 5 papers. Each paper MUST have these 4 labeled elements:
- **一句话**：what the paper says in one sentence
- **状态**：`published/accepted/arXiv/preprint` + venue
- **为什么重要**：why TS should care
- **和 TS 的关系**：specific connection to thesis or research

Use bold labels. Do NOT stack long paragraphs.

### 背景 / 前沿跟踪
arXiv-only papers, preprints, and broader-interest items. Explicitly labeled as "前沿跟踪 / 学习线索", never mixed with main recommendations.

### 对 thesis 最直接的用处
Concrete, actionable. What from today's reading can go straight into thesis chapters? If nothing, say so.

### 当日沉淀
Which new paper notes, index updates, or for-thesis files were created today. File names with brief descriptions.

### 下一步
What to do tomorrow. Specific research questions to follow up, gaps to fill, or papers to re-check.

## Anti-Patterns

- Do not put arXiv/preprint papers in 必看论文 (they go in 背景/前沿跟踪)
- Do not skip 今日结论 when there's nothing — state it clearly
- Do not write long paragraphs — Feishu renders markdown but TS skims on phone
- Do not omit the 4 required elements under 必看论文
