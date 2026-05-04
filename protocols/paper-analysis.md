# Paper Analysis Protocol

## Source Quality: Theory vs Experiment

| | 理论论文 | 实验论文 |
|--|---------|---------|
| 最低要求 | **TeX 源（arXiv e-print）** | PDF（arXiv 或期刊页面） |
| 无 TeX 时的处理 | 仅写 radar 摘要，标注"待获取全文"，**不建 note** | 可从 PDF 提取方法和结论建 note |
| arXiv e-print 返回空 | 等同无 TeX | 尝试 curl PDF 源 `https://arxiv.org/pdf/<id>` |

**判断依据：**
- 论文主要结论是公式/推导/模型 → 理论论文
- 论文主要结论是测量数据/器件性能/材料表征 → 实验论文
- 某些论文兼具两者（如 DFT 计算+实验对比），按主导判断

## Access Methods

For every paper with an arXiv ID:

1. Fetch metadata: `curl -sL "https://export.arxiv.org/api/query?id_list=<arxiv_id>&max_results=1"`
2. Fetch TeX source: `curl -sL "https://export.arxiv.org/e-print/<arxiv_id>"`
3. If TeX available (gzip tarball): extract → read `.tex` direct (best signal-to-noise)
4. If TeX unavailable AND paper is experimental: fall back to PDF or journal page
5. If TeX unavailable AND paper is theoretical: **stop** — radar entry only, mark "待获取全文"

For papers without an arXiv ID:
1. WebFetch the journal page
2. Paywalled → radar only, no note

**Note:** The WebFetch tool blocks arxiv.org and ar5iv.labs.arxiv.org domains. Always use Bash+curl for arXiv access, not WebFetch.

## Extraction Fields

For each paper that passes the filter, extract:

### Required Fields

| Field | Description |
|-------|-------------|
| 核心问题 | What question does this paper try to answer? 1-2 sentences. |
| 主要结论 | What are the key findings? List as bullet points. |
| 方法 / 表征 / 理论工具 | What methods, instruments, or theoretical frameworks were used? |
| 与 TS 课题的关系 | How does this connect to TS's thesis or research interests? Be specific. |
| 来源状态 | `published / accepted / arXiv / preprint / unpublished` with venue name. |
| 是否适合作为正式参考文献 | 是/否 + one sentence why. |

## Hard Rule: Source-Gated Note Creation

- **理论论文** → TeX 源是建 note 的前提。没有 TeX 源 → radar 仅标记"待获取"，不建 `papers/*.md`
- **实验论文** → PDF 是最低要求。方法段+图表+结论必须在 PDF 中可读
- **绝对禁止**从摘要、搜索片段或二手描述生成 paper note。那不是在读文献，是在重组元数据

### Optional Fields

| Field | Description |
|-------|-------------|
| 关键图像与机制 | Describe key figures or mechanisms worth remembering. |
| 为什么值得读 | If this paper is particularly high-signal, explain why. |
| 我的备注 | Any personal notes, caveats, or follow-up ideas. |

## Quality Threshold

A paper is "worth keeping as a paper note" if:
- It is formally published or accepted, AND
- It has direct relevance to at least one active topic in topics.json, AND
- It contains new data, methods, or conclusions (not just a review/summary unless particularly useful)

arXiv/preprint papers may still produce daily-radar entries but default to NOT getting individual paper notes unless they are exceptionally high-signal.

## Reading Order

Within the shortlist, read in this order:
1. thesis-priority papers (published/accepted first)
2. core-priority papers
3. interest-priority papers (at most 2 deep reads per run)
