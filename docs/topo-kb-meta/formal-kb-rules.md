# 知识库形式化规则

## 目的

这份文件定义 `14-拓扑序学习库` 里“正式入库”条目的硬约束。

它不是用来阻止草稿存在，而是用来区分两类对象：

\[
\text{学习草稿 / 过渡卡}
\neq
\text{正式入库条目}
\]

后者必须满足公式优先、可组合、可验证、可回溯到 `TeX` 来源。

## 适用范围

这些规则适用于下列内容中一切声称数学或物理命题成立的条目：

- `concepts/`
- `papers/`
- `books/`
- `papers/close-reading/`
- `books/close-reading/`
- `relations/`
- `roadmap/`

## 规则 1：公式优先

成熟条目必须围绕显式公式或形式化数据组织，而不是只靠说明性文字。

\[
\text{定义}
\to
\text{关键公式/数据}
\to
\text{规则或推导}
\to
\text{后果}
\to
\text{最小例子}
\]

文字只能服务于公式，负责说明：

- 公式在说什么
- 使用了哪些假设
- 适用边界在哪里
- 与其他条目的连接关系是什么

## 规则 2：原子化构建

每个可复用知识原子都应尽量写成可组合对象：

\[
\mathrm{Atom}
=
(\mathrm{name},\ \mathrm{input},\ \mathrm{output},\ \mathrm{rules},\ \mathrm{invariants},\ \mathrm{example})
\]

最少应包含：

- 形式定义
- 输入/输出数据
- 变换、组合或推理规则
- 不变量或物理可观测后果
- 最小 worked example
- 依赖的前置原子

## 规则 3：TeX 可追溯入库

正式入库的每一条结论都必须能回溯到严谨的 `TeX/LaTeX` 来源。

\[
\text{本地条目中的命题}
\longrightarrow
\text{TeX 源位置}
\longrightarrow
\text{本地规范化改写}
\]

允许作为正式入库依据的来源：

- 作者提供的 `tex` / `latex` 源文件
- arXiv source package
- 出版方可获得的源文件

单独使用时不够作为正式入库依据的来源：

- 只读 PDF
- OCR 文本
- 截图
- 二手转述

如果某条材料暂时没有可用 `TeX` 源，它可以保留在库里，但只能作为过渡草稿，
必须显式标记为“待 TeX 溯源”，不能直接算正式入库。

## 规则 4：TeX 优先阅读

当 `PDF` 与 `TeX` 同时存在时，正式阅读与正式摘录应以 `TeX` 为准。

具体包括：

- 定义
- 定理/命题陈述
- 公式
- 记号
- 交叉引用
- 假设条件

PDF 可以继续用来辅助看排版、图和整体结构，但不能替代正式引用依据。

## 规则 5：迁移兼容

现有旧卡在尚未按新标准重写前，可以保留，但必须显式承认自己是过渡状态。

换句话说：

\[
\text{旧卡未重写完成}
\Rightarrow
\text{不能假装自己已经是正式入库条目}
\]

迁移期条目至少应在 frontmatter 中标出：

```yaml
entry_mode: legacy-learning-note
formalization_status: pending
tex_trace_status: pending
source_mode: tex-audit-pending
```

这三个字段的含义是：

- `entry_mode`: 这是旧版学习卡，不是已经完成形式化验收的正式条目
- `formalization_status`: 尚未完成公式优先重写
- `tex_trace_status`: 尚未完成 `TeX` 溯源核对
- `source_mode`: 当前来源模式仍待 `TeX` 审核，不能默认视为已经满足 `TeX-first`

## 规则 6：正式入库标准

一个条目只有在下列条件都满足时，才算正式入库：

\[
\text{TeX 来源}
\land
\text{形式陈述}
\land
\text{本地规范化改写}
\land
\text{依赖定位}
\land
\text{最小例子或可检验后果}
\]

否则它仍属于草稿、学习卡或过渡条目。

## 推荐骨架

正式条目尽量采用下列最小骨架：

```md
## 命题
\[
...
\]

## 来源追踪
- TeX 来源：
- 文件 / 压缩包：
- 节 / 定理 / 公式位置：
- 原 TeX 片段：

## 形式数据
\[
\text{input} \mapsto \text{output}
\]

## 规则 / 推导
\[
...
\]

## 后果
\[
...
\]

## 最小例子
\[
...
\]

## 依赖
- ...
```
