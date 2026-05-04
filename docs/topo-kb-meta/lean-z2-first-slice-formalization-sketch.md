# `Z2` 第一切片 formalization sketch

## 2026-04-25 checkpoint addendum

The live Lean handoff is now branch `codex/toric-code-checkpoint` in
`D:\Playground\topological-order-lean`.

Use these Lean-repo docs before continuing:

- `docs/TORIC-CODE-CHECKPOINT.md`
- `docs/FULL-GROUNDSPACE-EQUIVALENCE-SPIKE.md`

The current next proof target is `closed_config_decompose_mod_GX`: prove the
classical quotient bridge before attempting the full stabiliser-eigenspace
linear equivalence.

## 2026-04-25 校正

这份 sketch 记录的是第一切片的设计理由。
后续复核发现，真实 Lean 工程已经在 `D:\Playground\topological-order-lean` 与 `D:\Playground\worktrees\topological-order-lean\z2-first-slice` 中推进到 `Z2` 和 toric-code 的实现层，并且两个 repo/worktree 的 `lake build` 均已通过。

因此，本文件不应再被理解为“Lean 实现尚未开始”。
当前下一步不是重做 label/fusion 起步，而是核对 live Lean repo 的 theorem 覆盖。
`TopoOrder/ToricCode/QuantumGroundSpace.lean::gsd_eq_four` 已经改为并证明 sector/readout 层的 `GSD(T^2)=4`，且 `TopoOrder/**/*.lean` 已无 `sorry` / `admit` / `axiom` 命中。
后续如果继续加强，应把目标写成 full stabiliser-eigenspace 与 sector space 的线性等价，而不是重新打开第一切片。

## 目的

这份文档把 [第一 article slice 选择说明](lean-first-article-slice-selection.md) 里选中的默认第一刀，进一步压成一个可执行的 formalization sketch。

它不是完整 implementation plan。
它回答的是：

- 第一刀到底 formalize 到哪一步
- 先做哪些 Lean 工件
- 哪些内容明确留到下一刀

## 当前切片定义

当前默认第一切片是：

- `Z2拓扑序` 的有限数据层

最小主链只包含三件事：

1. four anyon labels
2. fusion rules
3. 最小 mutual statistics 数据 `M_{e,m}=-1`

## 切片来源

- [Z2拓扑序](../concepts/Z2拓扑序.md)
- [2003 Kitaev](../papers/2003-Kitaev-fault-tolerant-quantum-computation-by-anyons.md)
- [2008 Nayak et al.](../papers/2008-Nayak-non-Abelian-anyons-topological-quantum-computation.md)

## 为什么这刀要切得这么小

如果第一刀同时试图涵盖：

- `Z2` 有限数据
- `toric code` 稳定子模型
- `GSD(T^2)=4`
- BF 有效理论

那么它就不再是“第一 article slice”，而是在第一步里同时扛四层语义。

当前最稳的策略是先把最小有限数据层站稳。

## 当前推荐的 Lean 工件类型

### 1. label 层：`def` / `inductive`

目标：

- 显式表示四类 anyon

候选形态：

- 一个四元 `inductive`
- 或等价地表示成 `ZMod 2 × ZMod 2`

当前推荐：

- 外层保留可读标签
- 内层再给到 `ZMod 2 × ZMod 2` 的编码

理由：

- 对知识库可读性更友好
- 对后续 fusion 计算也更清楚

### 2. fusion 层：`def` + 基本 theorem

目标：

- 明确写出
  - `e * e = 1`
  - `m * m = 1`
  - `e * m = ε`

第一刀需要的 theorem 不求太多，但至少要有：

- 闭包性
- 单位元行为
- 若采用编码形式，则与 `Z2 × Z2` 加法的一致性

### 3. statistics 层：最小数据 `def`

目标：

- 先把 `M_{e,m}=-1` 作为最小 mutual statistics 数据接进来

第一刀默认不追求：

- 完整 braiding category 语义
- 从 monodromy toy 自动推出 statistics

更稳的做法是：

- 先把它写成 canonical model 的最小数据对象
- 等后续结构层与模型层更近时，再加强它与上游 monodromy 语言的桥接

## 当前不纳入本切片的内容

### 不纳入 1：完整 `toric code` 模型

原因：

- 那是下一刀

### 不纳入 2：`GSD(T^2)=4` 的完整证明

原因：

- 它更适合放到 `toric code` 切片中，和基态空间一起出现

### 不纳入 3：BF 场论

原因：

- 这会把连续场论语义带进第一刀

### 不纳入 4：高层 category-theoretic 封装

原因：

- 第一刀的任务是站稳 canonical model 数据层，不是立刻把它嵌进高层范畴语义

## 和现有 Lean spine 的关系

这条切片和当前 toy spine 的关系，不是“直接依赖所有 toy”。

更准确地说：

- 它和当前 spine 是并行关系中的第一 canonical model lane
- 它不会直接复用每一个 bubble / trace-like toy
- 但它未来要和 `braiding / monodromy` 语言会合

这正是它值得单独切出来的原因：

- 它避免 canonical model lane 永远被 toy lane 取代

## 推荐的最小分步

### Step A：建立 label 与编码

先完成：

- 四类 anyon 的显式表示
- 与 `Z2 × Z2` 编码的往返

### Step B：建立 fusion

再完成：

- componentwise 加法式 fusion
- 基本 table 的 Lean 版本

### Step C：加入最小 statistics 数据

最后完成：

- `M_{e,m}=-1`
- 以及至少一个“为什么这是最小非平庸互绕数据”的注释性说明

## 成功标准

这个切片完成时，不要求“已经得到 `Z2` 拓扑序的完整 Lean formalization”。

只要求下面三件事成立：

- 任何子标签与 fusion 已经不是纯 prose，而是 Lean 中的可操作对象
- `M_{e,m}=-1` 已经作为模型层数据被稳定接入
- 这条切片能明确作为后续 `toric code` 切片的上游

## 风险提醒

### 风险 1：把第一刀又做大

典型表现：

- 顺手把 `GSD`
- BF 场论
- category structure

都一起拉进来

纠偏：

- 本切片默认只守住有限数据层

### 风险 2：完全不碰 statistics

典型表现：

- 只做 fusion table，结果第一刀退化成普通离散代数练习

纠偏：

- 至少把 `M_{e,m}=-1` 留下来，保住它是拓扑序样板而不是抽象四元表

## 当前默认下一步

如果继续推进规划层，下一份文档已经补上：

- [`Z2` 第一切片 implementation breakdown](lean-z2-first-slice-implementation-breakdown.md)

如果开始进入实现层，则默认先从：

- label 编码
- fusion 数据

这两块开始。

## 相关文档

- [第一 article slice 选择说明](lean-first-article-slice-selection.md)
- [第一 canonical model 选择说明](lean-first-canonical-model-choice.md)
- [Lean 翻译合同](lean-translation-contract.md)
