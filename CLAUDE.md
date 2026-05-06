# literature-lab — Claude Code Entry

> 文献搜索、分析、关联、沉淀系统。纯 Claude Code 驱动。

## 启动

每次会话开始时读这个文件，然后读 `protocols/step-composition.md`。

## 核心规则

1. **读 config/topics.json** — 所有搜索从这里的 active topic 列表出发
2. **读 state/*.json** — 搜索前去重，沉淀后更新状态
3. **TEX-first** — 有 arXiv ID 优先拉 TeX 源
4. **文本产出全落到 BaiduSyncdisk** — `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\`
5. **protocols/ 是唯一规则源** — 改行为 = 改 protocol，不动脚本
6. **protocols/engineering-constraints.md** — 工程约束（编码、定时任务、飞书卡片限制），改配置前必读

## 目录速查

| 目录 | 用途 |
|------|------|
| `protocols/` | 各环节规则（搜、读、关联、沉淀、thesis、飞书格式） |
| `prompts/` | 可复用 prompt 片段 |
| `config/` | topics.json 主题配置 |
| `state/` | 运行时状态（搜过什么、发过什么） |
| `scripts/` | 机械脚本（飞书推送、文献矩阵） |

## 典型调用

- 日常 thesis 推进：`按 topics.json 跑 thesis 线全流程`
- 学拓扑序：`搜拓扑序最近一周新文献，挑两篇读，不写论文素材`
- 快速扫描：`扫一遍 LSCO 和二极管，只筛不读`
