# Correlation Protocol

## Purpose

After analyzing new papers, cross-reference them against the existing library to:
1. Build citation chains (who cites whom)
2. Cluster papers by topic/method proximity
3. Flag similarities with existing notes

## Citation Tracking

For each analyzed paper:

1. Check its references (from the paper text or arxiv abstract page) — do any of its cited papers already exist in `papers/`? If so, record a "cites → X" annotation.
2. Check Semantic Scholar (via WebSearch: `site:semanticscholar.org "<paper title>" citations`) to see who has cited this paper. Note any that are already in the library.
3. Record the citation edges in the correlation annotation.

## Topic Clustering

1. Read `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\indexes\topic-index.md` to get current topic axes.
2. For each new paper, determine which existing topic cluster(s) it belongs to.
3. If the paper opens a genuinely new sub-topic not in the index, flag it for index addition.
4. The `topic-index.md` themes are the distance metric — two papers are "close" if they share a topic heading.

## Similarity Check

For each new paper note:
1. Compare its core question and key conclusions against existing paper notes in the same topic cluster.
2. If high overlap: flag it as "similar to [existing paper]" — this helps avoid duplicate collection and makes comparison explicit.
3. If complementary: flag as "complements [existing paper]" with one sentence on how they fit together.

## Output Format

For each analyzed paper, add a correlation block to the analysis notes:

```
## 关联
- 引用链: [cites X] / [cited by Y]
- 主题聚类: [topic axis from topic-index]
- 与已有笔记: [similar to Z / complements W / new angle]
```

## Mechanism Extraction

After completing correlation annotations, run mechanism extraction per `mechanism-extraction.md`:

1. Identify distinct physical mechanisms from the newly analyzed paper notes
2. For each mechanism, check `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\mechanisms\00-mechanism-index.md` for existing cards
3. Create or update cards in `mechanisms/cards/{mechanism_id}.md`
4. Update `mechanisms/00-mechanism-index.md` with new entries and cross-query tables
