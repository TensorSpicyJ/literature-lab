# Feishu Format Spec

Each daily radar pushed to Feishu must be scannable in under 30 seconds.

## Parser Contract

`scripts/feishu-push.ps1` 读取日报 markdown，提取结构化信息构建飞书卡片。以下规则必须严格遵守，否则卡片内容丢失或错乱。

### 节标题（严格匹配）

节标题必须用 `##` 开头，按固定顺序出现。解析器用以下正则匹配：

| 节 | 匹配正则 | 卡片表现 |
|----|---------|---------|
| `## 今日结论` | `(?i)conclusion\|summary\|结论\|摘要` | note 高亮框 |
| `## 必看论文` | `(?i)must.read\|key.paper\|必看\|重点` + 内含 `###` 子标题 | 每篇论文独立展示，`<hr>` 分隔 |
| `## 背景 / 前沿跟踪` | `(?i)background\|frontier\|tracking\|背景\|前沿\|跟踪` | 折叠区 |
| `## 对 thesis 最直接的用处` | `(?i)thesis` | 绿色高亮 |
| `## 当日沉淀` | `(?i)deposit\|output\|沉淀\|产出` | 紧凑列表 |
| `## 下一步` | `(?i)next\|todo\|follow\|下一步` | 紧凑列表 |

### 必看论文格式（解析器强制要求）

每篇论文必须以 `### 标题` 开头。标题后紧跟四个必填字段，每字段一行：

```
### Lou et al. — Kagome 结量子射频整流

- **一句话**：在 Kagome 超导 Josephson 结阵列中首次实现量子化射频整流
- **状态**：published in Nature Nanotechnology
- **为什么重要**：为超导二极管提供了全新机制路径
- **和 TS 的关系**：TS 的 SDE 器件可直接借鉴 Kagome 结的设计
```

**字段约束：**

| 字段 | 解析正则 | 必填 | 说明 |
|------|---------|------|------|
| `**一句话**` | `\*\*一句话\*\*[：:]?\s*(.+)` | **是** | 30 字以内最佳 |
| `**状态**` | `\*\*状态\*\*[：:]?\s*(.+)` | **是** | 含 `published`/`accepted`/`arXiv` 关键词决定 text_tag 颜色；含 `10.XXXX/...` (DOI) 或 `arXiv:XXXX.XXXXX` 会生成"查看原文"按钮 |
| `**为什么重要**` | `\*\*为什么重要\*\*[：:]?\s*(.+)` | 否 | 与领域的关联 |
| `**和 TS 的关系**` | `\*\*和\s*(TS\|thesis)\s*的关系\*\*[：:]?\s*(.+)` | 否 | 与博士论文的具体关联 |

**标题约束：**
- 使用 `### Paper Title` 格式，**不要在 ### 后加序号**（如 `### 1. Title`），序号由解析器自动添加
- 标题应包含第一作者姓氏和简短描述：`### Lou et al. — Kagome 结量子射频整流`

**状态字段约束：**
- 优先写完整发表信息：`published in Nature Nanotechnology` 而非仅 `published`
- 如有 DOI，写在状态中：`published in PRL (DOI: 10.1103/PhysRevLett.136.086401)`
- 如有 arXiv ID，写在状态中：`arXiv preprint (2605.01316)` 或 `accepted in Nature Communications (arXiv:2604.23162)`
- 状态关键词决定 header 颜色：含 Nature/Science/PRL/PRX → 红色 header，全 arXiv → 黄色 header

### 背景 / 前沿跟踪（注意）

该节条目用 `- bullet` 格式，**不要用 `###` 子标题**。如果必须用子标题，解析器可能将其误识别为必看论文。

正确格式：
```
## 背景 / 前沿跟踪

- Zhang et al. (arXiv) 提出 twisted bi-layer cuprate 中的拓扑超导
- 多个课题组报告 FeSe/SrTiO3 界面声子各向异性
```

### 今日结论

1-3 条 bullet。没有新材料时也要写结论（如"今日无新的正式文献，仅做主线收口"）。

### 对 thesis 最直接的用处

每行 `- bullet`，具体可操作。无内容时可写"无"。

### 当日沉淀

列出新建/更新的文件名。

### 下一步

具体可执行的行动，≤3 条。

## Anti-Patterns

- 必看论文省略任一必填字段 → 卡片该篇论文信息不完整
- 必看论文标题用 `### 1. Title` → 标题显示冗余序号
- 状态不含 published/accepted/arXiv 关键词 → text_tag 颜色默认灰色
- 背景节用 `###` 子标题 → 可能被误解析为必看论文
- 状态含 DOI 但格式不对（如 `DOI:10.1038/...` 无空格）→ 按钮不生成
- 写长段落 → 手机阅读体验差
