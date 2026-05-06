# Mechanism Extraction Protocol

## Purpose

Extract physical mechanisms from analyzed paper notes into persistent, queryable mechanism cards. Each card distills one mechanism across all papers that discuss it.

## When to Run

During the `correlate` step of a thesis-priority run. Not run for core or interest runs.

## Source Qualification

A mechanism is worth a card when at least ONE of:
1. It appears in a paper note's symmetry-constraint or core-claim sections
2. It has a distinct microscopic driver (VHS, Hubbard U, ISHE, chiral mismatch...)
3. It appears in `cross_run_correlations` as a novel mechanism contrast
4. It answers a query the user might ask ("what are all JDE mechanisms?")

Do NOT create a card when:
- The mechanism is already fully captured by an existing card (merge it instead)
- It is purely an experimental observation with no mechanistic explanation
- It is a methodological contribution

## Extraction Process

### 1. Identify Mechanisms

For each newly analyzed paper note, read:
- `## 核心主张` section — claims about HOW something happens
- `## 对称性约束 / 关键机制` section — symmetry conditions and driving forces
- `## 形式数据` section — I/O signatures

### 2. Check Against Existing Cards

Read `mechanisms/00-mechanism-index.md`. For each candidate:
- Exact match → UPDATE card (add paper to source_papers, add evidence)
- Same class but different driver → CREATE new card, link as related
- No match → CREATE new card

### 3. Create or Update Card

Write to `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\mechanisms\cards\{mechanism_id}.md`.

**mechanism_id convention:** `{class-abbrev}-{key-driver}`

Examples: `jde-vhs`, `jde-strong-correlation`, `pair-breaking-magnetic-instability`

### 4. Update Index

Regenerate relevant sections of `mechanisms/00-mechanism-index.md`:
- Class table
- Cross-query tables
- Chapter mapping
- `last_updated` date

## Card Template

```yaml
---
mechanism_id: "{id}"
mechanism_name: "{descriptive name}"
mechanism_class: "JDE | SDE | TRSB | pair-breaking | phi-junction | reentrant | BKT | SIT | pairing | enhancement | other"
requires_soc: true|false
requires_magnetism: true|false
requires_structural_inversion_breaking: true|false
requires_nonequilibrium: true|false
symmetry_condition: "{minimal symmetry description}"
evidence_level: "experimental | theoretical | mixed"
platforms: ["platform"]
status: "active | superseded | speculative"
source_papers: ["slug1"]
related_mechanisms: ["id1", "id2"]
contrasts_with: ["id1"]
thesis_chapter: "Chap_Diode | Chap_LSCO | Chap_Magnetic | Chap_Methods | Chap_Intro"
last_updated: "YYYY-MM-DD"
---
```

## Body

### 一句话
[physical cause] → [key effect], ≤30 words.

### 机制链
≤5 steps, arrow-chained or numbered.

### 输入 / 输出
- **输入:** physical conditions needed
- **输出:** observable consequences
- **可检验预测:** one testable prediction if any

### 与同类机制的关系
Comparison vs 1-2 closest mechanisms. Can be a mini-table.

### 证据
Papers providing what type of evidence.

### 未解决
Open questions, ≤3 items.

### 来源论文
[[wikilinks]] to paper notes.

## Quality Rule

One card ~200 words. This is NOT a paper note. If you exceed 300 words, you are either recapitulating a paper (→ papers/), discussing too broad a mechanism (→ split), or speculating without a mechanism chain (→ cut).

The card answers: "What is the mechanism, what does it need, what does it predict, and how is it different from similar mechanisms?" Nothing more.
