---
entry_mode: formal
formalization_status: complete
tex_trace_status: verified
source_mode: tex-first
topic: 拓扑序
created: 2026-05-05
---

# Vison ↔ mTO 关联

## 关系类型
**定义性依赖** — mTO 的阿贝尔扇区是 vison 生成的群，极小性条件等价于 vison 取最小可能的群阶。

## 形式关系

\[
\mathcal{T}_{\text{mTO}} = \text{MME}\left(\mathcal{V}^{s=q, r=p}\right)
\]

其中：
- \(\mathcal{V}^{s,r} = \{1, v, v^2, \ldots, v^{s-1}\}\) 是 vison 生成的阿贝尔任意子群
- s = q 是极小性条件（ℓ = 1）
- MME = minimal modular extension（若 \(\mathcal{V}^{q,p}\) 已是模的，则不做扩展）

## 分支

\[
\begin{cases}
q \text{ 奇}: & \mathcal{V}^{q,p} \text{ 本身是模张量范畴} \Rightarrow \mathcal{T}_{\text{mTO}} = \mathcal{V}^{q,p} \\
q \text{ 偶}: & \mathcal{V}^{q,p} \text{ 是准模的} \Rightarrow \mathcal{T}_{\text{mTO}} = \text{MME}(\mathcal{V}^{q,p}) = \mathsf{Pf}^f_{q,p,n},\; n=0,1,2,3
\end{cases}
\]

## 物理意义

vison 提供了 mTO 的"骨架"（阿贝尔扇区）。q 偶时骨架需要"补肉"（非阿贝尔扇区），恰有 4 种等价的补法，对应 4 个 Pfaffian 变体。

## 关联的概念卡
- [[vison]] — vison 的定义与性质
- [[minimal-topological-order]] — mTO 分类
- [[minimal-modular-extension]] — MME 构造（待建）
- [[pfaffian-states]] — Pfaffian 变体（待建）
