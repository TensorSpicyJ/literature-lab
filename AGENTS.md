# Agent Instructions — literature-lab

## Workspace

This repository is the engine for TS's daily literature pipeline.
- Engine path: `D:\playground\literature-lab\`
- Output path: `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\`
- GitHub (output repo): `https://github.com/Taishaojie061/daily-literature-kb`

Treat this as a prompt-driven automation project, not a traditional codebase.

## Scope

Work here when the task involves:
- searching for new papers across TS's research topics
- reading and extracting insights from papers
- cross-referencing papers against the existing library
- depositing daily radars, paper notes, index updates, or for-thesis extracts
- pushing literature updates to Feishu

## Fixed Rules

- TEX-first: when a paper has an arXiv ID, try to read the TeX source before falling back to HTML/PDF
- Source status is mandatory: every paper must be labeled `published | accepted | arXiv | preprint | unpublished`
- arXiv/preprint/unpublished papers do NOT enter `for-thesis/` and do NOT appear in 必看论文
- All text output goes to BaiduSyncdisk; playground only holds engine/config/state
- `config/topics.json` is the single source of truth for what to search
- State files in `state/` must be updated after every run

## Precedence

When there's a conflict between a protocol file and this AGENTS.md, the protocol file wins. Protocol files are the executable rules; this file is orientation.
