# Cross-Reference Prompt

After analyzing new papers, correlate with the existing library.

## Workflow

1. Read `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\indexes\topic-index.md` for current topic structure.
2. Read existing paper notes in `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\papers\` that share the same topic cluster.
3. For each new paper, search Semantic Scholar for citation edges (who cites this, who it cites).
4. Compare core questions and conclusions against similar existing notes.

## Output

Add this section to each paper note:

```
## 关联
- 引用链: [lists]
- 主题聚类: [topic]
- 与已有笔记: [similar/complements/new]
```

If a new topic axis emerged, flag it for index addition.

## Mechanism Extraction

After correlation annotations, extract physical mechanisms per `protocols/mechanism-extraction.md`:

1. Identify distinct mechanisms from `## 核心主张`, `## 对称性约束 / 关键机制`, `## 形式数据` sections
2. Check existing cards at `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\mechanisms\00-mechanism-index.md`
3. Create/update cards in `mechanisms/cards/` using the template
4. Update `mechanisms/00-mechanism-index.md` — class tables, cross-query tables, chapter mapping
