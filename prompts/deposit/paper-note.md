# Paper Note Prompt

Create individual paper notes in `papers/` for papers that pass the quality threshold.

## Output Location
`D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\papers\{slug}.md`

## Slug Convention
`{first-author-lowercase}-{keyword}-{year}` e.g. `xu-lsco-lszo-sis-2023.md`

## Template

```yaml
---
title: ""
authors: ""
year: 
venue: ""
doi: ""
arxiv: ""
topic: ""
priority: ""
status: ""
citation_chapter: ""
ref_priority: ""
---

# {Title}

## 基本信息
- Authors:
- Year:
- Venue:
- DOI / arXiv ID:
- Source status:
- Topic:

## 核心问题

## 主要结论

## 方法 / 表征 / 理论工具

## 关键图像与机制

## 与 TS 课题的关系

## 是否适合作为正式参考文献

## 为什么值得读

## 我的备注

## 关联
- 引用链:
- 主题聚类:
- 与已有笔记:
```

Only create a paper note if the paper meets the quality threshold in `protocols/paper-analysis.md`.
