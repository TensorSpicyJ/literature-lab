# `Z2` 第一切片 implementation breakdown

## 2026-04-25 checkpoint addendum

The live Lean handoff is now branch `codex/toric-code-checkpoint` in
`D:\Playground\topological-order-lean`.

New restore/proof-plan docs in that repo:

- `docs/TORIC-CODE-CHECKPOINT.md`
- `docs/FULL-GROUNDSPACE-EQUIVALENCE-SPIKE.md`

The newly added Lean module
`TopoOrder.ToricCode.GroundSpaceEquivalence` proves
`vertexStabiliser_apply_boundary` and records the next theorem targets.
The next full-GSD bridge is `closed_config_decompose_mod_GX`, not a direct
jump to the final `GroundSpace` linear equivalence.

## 2026-04-25 校正

这份拆解只适用于知识库内旧 `archive/lean-sandbox/` 视角。
后续复核发现真正的 Lean 工程不在当前同步的知识库目录下，而在：

- `D:\Playground\topological-order-lean`
- `D:\Playground\worktrees\topological-order-lean\z2-first-slice`

因此，不能再把“恢复 `archive/lean-sandbox/TopoOrder/`”当成当前 Lean 化的主 blocker。
当前实情是：`Z2` 有限数据和 toric-code 的相当一部分 Lean 化已经完成并可构建。
截至本次复核：

- `D:\Playground\topological-order-lean` 的 `lake build` 通过，且 `TopoOrder/**/*.lean` 已无 `sorry` / `admit` / `axiom` 命中。
- `TopoOrder/ToricCode/QuantumGroundSpace.lean` 现在证明的是 sector/readout 层的 `GSD(T^2)=4`：四个 `GroundStateLabel`、两个非收缩 loop readout 分辨 sector、`GroundStateSectorSpace K := GroundStateLabel → K` 的 finrank 为 `4`。
- 完整 stabiliser eigenspace `GroundSpace` 与 sector space 的线性等价仍是后续 strengthening，不应和当前已证明的 sector/readout GSD 混写。
- `D:\Playground\worktrees\topological-order-lean\z2-first-slice` 的 `lake build` 通过。
- 主仓 `master` 还有未提交修改，集中在 `TopoOrder/ToricCode/Basic.lean`、`QuantumGroundSpace.lean`、`Stabilisers.lean`，看起来是在补 toric-code loop 与 stabiliser 交换证明。

本文件以下内容保留为“第一切片设计记录”，但下一步工作流应优先转向：

1. 复核并收口 `D:\Playground\topological-order-lean` 的未提交 Lean 修改；
2. 明确记录 `Z2` / toric-code 哪些 theorem 已经 Lean 检查；
3. 把 full stabiliser-eigenspace equivalence 作为后续 strengthening，而不是把 toric-code Lean 化整体视为未开始。

## 目的

这份文档把 [`Z2` 第一切片 formalization sketch](lean-z2-first-slice-formalization-sketch.md) 再往前推进一格：

- 不再只说“应该 formalize 什么”
- 而是拆成真正进入 Lean 实现时的最小任务序列

它仍然不是源码实现。
当前 `archive/lean-sandbox/TopoOrder/` 源文件树缺失，所以这里先固定任务边界，避免恢复源码时又重新讨论第一刀切法。

## 当前前提

当前已固定的第一切片是：

1. four anyon labels
2. fusion rules
3. 最小 mutual statistics 数据 `M_{e,m}=-1`

这里的“第一切片”只指 **Lean 实现层**。
知识库内容层里，[Z2拓扑序](../concepts/Z2拓扑序.md) 和 [toric-code模型](../concepts/toric-code模型.md) 已经是 `formal-note / tex-first` 条目，不能误读成“toric code 概念卡还没做完”。

当前明确不纳入：

- 把已完成的 `toric-code模型` 概念卡整体搬进 Lean
- `GSD(T^2)=4` 证明
- BF 场论
- 高层 category-theoretic 封装

## 实现入口条件

进入源码实现前，至少需要满足一个条件：

- 恢复 `archive/lean-sandbox/TopoOrder/` 源文件树；或
- 明确决定用新源码树重启 Lean 支线，并把这个决定写回 [Lean 源码恢复选项](lean-source-recovery-options.md)。

在此之前，本切片只做任务拆解，不声明任何 Lean 代码已经完成。

## 推荐文件边界

如果沿旧 spine 恢复，第一实现文件建议命名为：

- `TopoOrder/Z2FiniteData.lean`

如果新建更清楚的模型层目录，则建议命名为：

- `TopoOrder/Models/Z2FiniteData.lean`

二者只选其一。
不要同时制造两个入口。

## Step A：label 与编码

### 目标

建立四类 anyon 的最小可读标签，并给出到 `Z2 × Z2` 的编码。

### 推荐 Lean 对象

- `inductive Z2Anyon`
  - `one`
  - `e`
  - `m`
  - `eps`
- `def Z2Anyon.toCode : Z2Anyon -> ZMod 2 × ZMod 2`
- `def Z2Anyon.ofCode : ZMod 2 × ZMod 2 -> Z2Anyon`

### 最小 theorem

- `ofCode (toCode a) = a`
- `toCode one = (0, 0)`
- `toCode e = (1, 0)`
- `toCode m = (0, 1)`
- `toCode eps = (1, 1)`

### 验收边界

这一层只证明标签和编码一致。
不在这里引入 fusion、statistics 或 toric-code 语义。

## Step B：fusion 数据

### 目标

把 `Z2` anyon fusion 写成可计算对象。

### 推荐 Lean 对象

- `def Z2Anyon.fusion (a b : Z2Anyon) : Z2Anyon`
- 或在确认不会污染命名后再提供 `Mul Z2Anyon`

推荐先用显式 `fusion`，暂不急着全局挂 `Mul`。

### 最小 theorem

- `fusion one a = a`
- `fusion a one = a`
- `fusion e e = one`
- `fusion m m = one`
- `fusion e m = eps`
- `fusion m e = eps`
- `fusion eps eps = one`
- `toCode (fusion a b) = toCode a + toCode b`

### 验收边界

这一层只做有限 fusion 表。
不证明完整群结构，除非它能自然从 `ZMod 2 × ZMod 2` 编码免费得到。

## Step C：最小 mutual statistics 数据

### 目标

接入 `M_{e,m}=-1`，保证第一切片不是普通四元融合表，而仍然是拓扑序样板。

### 推荐 Lean 对象

第一版不急着引入复数根。
可以先用 `Int` 或 `Bool` 表示最小互绕符号：

- `def Z2Anyon.mutualParity (a b : Z2Anyon) : ZMod 2`
- `def Z2Anyon.mutualSign (a b : Z2Anyon) : Int`

其中 `mutualSign e m = -1`，平凡互绕给 `1`。

### 最小 theorem

- `mutualSign e m = -1`
- `mutualSign m e = -1`
- `mutualSign one a = 1`
- `mutualSign a one = 1`
- 至少一个注释性 theorem 或 docstring 说明：
  `M_{e,m}=-1` 是本切片保留的最小非平庸拓扑数据。

### 验收边界

这一层不声称已经 formalize 完整 braiding category。
它只把第一 canonical model 的最小互绕数据接入 Lean。

## 最小构建验证

源码实现后，最小验证顺序是：

```powershell
git status --short
Get-ChildItem .\TopoOrder
& $env:USERPROFILE\.elan\bin\lake.exe build
```

如果采用 `TopoOrder/Models/Z2FiniteData.lean`，还要确认聚合入口正确 import 该文件。

## 知识库回挂

完成源码实现后，至少更新这些知识库入口：

- [Z2拓扑序](../concepts/Z2拓扑序.md)
- [toric-code模型](../concepts/toric-code模型.md)
- [第一 article slice 选择说明](lean-first-article-slice-selection.md)
- [Lean 能力图谱](lean-capability-map.md)

回挂时要写清：

- 哪些结论已经 Lean 检查
- 哪些仍然只是 concept-level 解释
- 为什么 `GSD(T^2)=4` 留到下一切片

## 当前停止信号

遇到下面任一情况时，停止扩大范围：

- `lake build` 仍因缺 `TopoOrder/` 或 package 损坏失败
- 开始引入完整 toric-code 哈密顿量
- 开始讨论 BF 场论或 genus-`g` 公式
- 为了证明 fusion 表而新建大规模 category 抽象

## 下一步

默认下一步不是直接扩写理论，而是二选一：

1. 恢复 `TopoOrder/` 源文件树后实现 Step A 和 Step B；
2. 如果源码恢复仍不可行，先写一份新源码树重启决策，再从 `Z2FiniteData` 的 label / fusion 层开始。
