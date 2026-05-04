# Thesis Extraction Protocol

## Qualification

A paper qualifies for `for-thesis/` extraction only when ALL of:
1. `status` is `published` or `accepted` (not arXiv/preprint/unpublished)
2. `priority` from topics.json is `thesis`
3. Has direct, specific relevance to TS's thesis chapters (not just "interesting background")

## Extraction Granularity

For-thesis notes must be more distilled than daily radars or paper notes:
- **Usable claim**: 1-2 sentences that could be dropped into a thesis paragraph with minimal rewriting
- **Supporting evidence**: what data/figures/tables back the claim
- **Placement**: which chapter/section this serves
- **Citation-ready**: complete reference info ready for the bibliography

## Chapter Mapping

| Keyword match in topic/paper | Target chapter |
|------------------------------|---------------|
| LSCO, cuprate, monolayer, ultrathin, BKT, SIT | Chap_Intro / Chap_LSCO |
| diode, Josephson, tunnel junction, nonreciprocal | Chap_Diode |
| magnetic, manganite, ferromagnet, AFM, interface magnetism | Chap_Magnetic |
| characterization, XRD, RHEED, transport | Chap_Methods |

Papers that don't match any chapter keyword but are still thesis-relevant go to `Chap_Intro` as background.

## Output Format

```markdown
# [Descriptive Title]

**Source:** [Full citation]
**Status:** [published/accepted]
**Chapter:** [target chapter]

## 可复用结论
- [distilled claim 1]
- [distilled claim 2]

## 支撑证据
- [key figure/table/data point]

## 引用备注
- [how to use this in the thesis, what it supports or contrasts]
```
