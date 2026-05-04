# Paper Note 格式规范

> 基于 Wasp 暗色主题 Obsidian 实测调优。每次建 note 遵循此规范。

## 前置铁律

- **理论论文必须有 TeX 源** → 无 TeX 不建 note（见 `paper-analysis.md`）
- **禁止从摘要生成** → 摘要只能写 radar 条目，不能建 `papers/*.md`
- **读原文写笔记** → note 的质量天花板是你对原文的理解深度，不是重组元数据的技巧

## 结构模板

```markdown
---
type: paper-note
title: "..."
authors: "..."
year: 2026
venue: "arXiv:XXXX.XXXXX"
topic: "topic-from-index"
priority: "thesis | core | interest"
status: "arXiv | published | accepted"
citation_chapter: "Chap_..."
ref_priority: "A | B | C"
tags: [...]
---

# Full Title

> Author (Year) — Affiliation — [arXiv:XXXX](https://arxiv.org/abs/XXXX)
> **来源雷达:** [[daily/YYYY-MM/paper-radar-YYYY-MM-DD]]

## 一句话
（核心结论，1-2 句，主语+动词+结果）

## 核心主张
1. **[主张要点]**（每点一句判断，不是话题标签）
2. ...
（≤6 条，挑最重要的。不是摘要复读——是你读了全文后的判断）

## 模型
（核心方程 + 设定要点，公式优先）

## 对称性约束 / 关键机制
（如果有的话。非必须，理论论文常用）

## 推演链
（精简版代码块 + [[#完整推演]] 跳转锚点）

## 与 TS 课题
（具体关联 + 可检验预测 + 同类文献对比表）

## 来源
（TeX 文件名、行号、关键公式片段）

## 形式数据
- **输入:**
- **输出:**
- **不变量:**

## 未解决
（别人没解决的 + 和 TS 课题相关的缺口）

## 完整推演 {#完整推演}
（理论论文必附。公式驱动，说清"为什么"，不限长度。放在文末）
```

## Obsidian 渲染规则

### 数学

- 行内：`$...$`（单行，不能跨行）
- 独立行：`$$...$$`（必须在单独行上，前后有空行）
- 不用 `\[...\]` — Live Preview 可能不渲染
- **表头禁止 `$`** — 用纯文本列名（如 `Sx` 不用 `$S_x$`）。表身可以用 `$`
- `\boxed{}`、`\mathcal{}`、`\langle \rangle`、`\mathbf{}`、`\boldsymbol{}`、`\text{}` 都在 `$` 内使用
- `\begin{aligned}...\end{aligned}` 放在 `$$` 块内

### 表格

- 表头用 `| --- | --- |`（有空格），表前必须有空行
- 表头纯文本，表身可含 `$`

### 强调

- **金色（主题 accent，Wasp = `#f8c537`）：** `var(--text-accent)` 关键词/短语 2-5 词。用于：核心结论关键词、counterintuitive 发现、thesis 闭环点
- **粗体 `** **`：** 一般强调，段落内区分论点
- **Callout：** 整段要点用 `> [!important]` / `> [!abstract]` / `> [!warning]`，不涂色
- **不用 `<mark>` / `== ==`：** Wasp 主题 `--text-highlight-bg: #640211`（暗红底），丑
- **不用自定义 HTML 色码：** 用 `var(--text-accent)` 跟随主题切换
- **金色只点关键词，不成句涂，不成段涂**

### Callout 类型

| Callout | 用途 |
|---------|------|
| `> [!important]` | 全文最重要的洞察/对称性分析的深层含义 |
| `> [!abstract]` | 与 TS 课题的直接关联总结 |
| `> [!warning]` | 可检验的预测 / 需要注意的约束 |

## 交叉引用

- paper note ↔ daily radar：双向 `[[wikilink]]`
- 同类文献对比表：全部用 `[[wikilink]]`（即使 note 尚未创建——Obsidian 灰色待创建态即可）
- 引用 topic-index 里的概念：`[[../indexes/topic-index#topic-name]]`
- 跨库引用拓扑序知识库：`[[../../14-拓扑序学习库/concepts/概念名]]`

## 推演链（理论论文）

### 要求

- 放在文末 `## 完整推演 {#完整推演}` 的锚点下方
- 正文中 `## 推演链` 放精简代码块 + `[[#完整推演]]` 跳转
- **公式驱动，不怕长**——说清楚每一步的物理逻辑。读者跳过公式看文字也能跟上，需要精确时公式就在那里
- 每节编号 `### N — 标题`，N 是步骤序号
- 格式：文字叙述夹公式。公式只列关键的（$\boxed{}$ 框住主结论），中间推导用文字桥接

### 应该包含

- 模型的**设定**和**为什么这样设定**
- **对称性分析**的完整群论论证（理论论文最容易出彩的部分）
- 机制链的**每一步逻辑**（A → B 是因为什么物理原因）
- 与**竞争机制的对比**（为什么是这个而不是那个）
- **定量标度**和**数值的物理含义**

### 不应该

- 每步一个公式的机械罗列
- 重复摘要里的结论而不加推演
- 回避复杂的对称性论证
- 省略"为什么"只给"是什么"

## 与已有 note 的关系

- 本规范是对 `paper-analysis.md` 的补充，专注于**格式层**
- `paper-analysis.md` 定义**什么能做 note**（源质量门槛）
- `deposit-rules.md` 定义**note 写到哪里**（产出路径）
- `feishu-format.md` 定义**radar 格式**（日报推飞书）
- 本规范定义**note 怎么写**（结构、渲染、强调、交叉引用）
