# Paper Extraction Prompt

Deep-read papers that passed the filter and produce structured notes.

## TEX-First Protocol

For each paper:
1. If arXiv ID present → visit `https://arxiv.org/abs/{id}` → check for TeX source → read `.tex` if available
2. If no TeX → WebFetch the abstract page
3. If paywalled → work from abstract + figures

## Extraction

Follow `protocols/paper-analysis.md` for field definitions. Produce these sections:

```
# {Paper Title}

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
```

If a paper does not meet the quality threshold, write a brief note explaining why it was skipped rather than producing the full structure.
