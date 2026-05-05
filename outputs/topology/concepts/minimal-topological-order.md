---
entry_mode: formal
formalization_status: complete
tex_trace_status: verified
source_mode: tex-first
topic: 拓扑序
aliases: [mTO, 极小拓扑序]
status: formal
created: 2026-05-05
tex_source: arXiv:2505.14767 (Hall.tex)
updated_by: []
---

# 极小拓扑序 (mTO)

## 命题

给定 Hall 电导 σ_H = p/q（p, q 互质），存在极小拓扑序（mTO），定义为具有最少不同任意子种类的相容拓扑序：

\[
\boxed{
\begin{aligned}
q \text{ 奇}: &\quad \text{唯一 mTO } \mathcal{V}^{q,p},\quad |\mathcal{A}| = q,\quad \text{全阿贝尔} \\[4pt]
q \text{ 偶}: &\quad \text{四个 mTO: } \mathsf{Pf}^f_{q,p,n}\;(n=0,1,2,3),\quad |\mathcal{A}| = 3q \\[4pt]
&\quad \text{（q 个阿贝尔 + 2q 个非阿贝尔），均为 Pfaffian 类变体}
\end{aligned}
}
\]

这里 \(\mathsf{Pf}^f_{q,p,n}\) 的量子维数平方 \(\mathcal{D}^2_{\mathcal{T}} = 4q\)，任意子总数 \(N_{\mathcal{T}} = 3q\)（当 n 为奇数时，因为某些任意子自共轭而减少）。

## 来源追踪
- **TeX 来源**: arXiv:2505.14767, Hall.tex
- **节 / 定理 / 公式位置**: Sec. 1.1 "Summary of main results", Table II; Sec. 7 (IR classification)
- **原 TeX 片段** (Table II):
```latex
Spin$^c$, $\sigma_H = p/q$ & & & & \\
$q$ odd& $\mathcal{V}^{q,p}$  & $\mathcal{V}^{q,p}$ & $q$& $q$\\
$q$ even& $\mathcal{V}^{2q,2p}$  & $\mathsf{Pf}^f_{q,p,n}$& $4q$& $4q$ ($3q$) for $n$ even (odd)\\
```

## 形式数据

\[
\begin{aligned}
\text{输入}: &\quad \sigma_H = p/q,\quad \text{系统类型} \in \{\text{spin}^c, \text{bosonic}, \text{spin}\} \\
\text{输出}: &\quad \mathcal{T}_{\text{min}} = \arg\min_{\mathcal{T} \text{ 相容}} N_{\mathcal{T}} \\
\text{约束}: &\quad v \in \mathcal{A},\; h(v) = \sigma_H/2,\; Q(v) = \sigma_H,\; s_{\text{vison}} = q
\end{aligned}
\]

极小性等价于 vison 的群阶取最小值 s = q（ℓ = 1）。

## 规则 / 推导

### 算法概要（Sec. 7 of 2505.14767）

1. **起点**: 给定 σ_H → 确定 vison v，其自旋 h(v) = σ_H/2，电荷 Q(v) = σ_H
2. **阿贝尔扇区**: vison 生成 one-form 对称群 \(\mathcal{V}^{s,r}\)。mTO 要求 s = q
3. **q 奇**: \(\mathcal{V}^{q,p}\) 已经是模张量范畴（MTC），不需要扩展。任意子即 {1, v, v², ..., v^{q-1}}
4. **q 偶**: \(\mathcal{V}^{q,p}\) 是准模（premodular）的，存在与所有任意子平凡编织的透明粒子 v^{q/2}，必须通过"取极小模扩张"（minimal modular extension）补全。对 spin^c 系统恰好有 4 种可能的极小模扩张，对应 4 个 Pfaffian 变体：
   \[
   \mathsf{Pf}^f_{q,p,n},\quad n = 0,1,2,3
   \]
   其中 n = 0 为 Moore-Read Pfaffian，n = 1 为 anti-Pfaffian（取决于 q 和 p 的具体值）

5. **非阿贝尔扇区**: 扩展引入 \(2^{\lfloor N/2\rfloor}\) 维非阿贝尔场（自旋算子 σ），与阿贝尔 vison 的融合规则由 so(N)_1 CFT 决定

## 后果

1. **几乎所有已知 FQH 态都是 mTO**：实验上观测到的分数量子霍尔态几乎全部由 mTO 描述
2. **从 σ_H 即可唯一（或近乎唯一）确定低能 TQFT**：不需要知道微观哈密顿量的细节
3. **mTO 是"最小假设"原则的体现**：在无额外实验输入时，minimality 是自然的理论选择
4. **q 偶时的非阿贝尔性不可避免**：任何偶数分母 FQH 态的 mTO 必然包含非阿贝尔任意子

## 最小例子

**ν = 1/3 (q = 3, 奇)**: mTO = \(\mathcal{V}^{3,1}\)，3 个阿贝尔任意子 {1, v, v²}，h(v) = 1/6, h(v²) = 2/3。这是 Laughlin 态。

**ν = 1/2 (q = 2, 偶)**: mTO 有 4 个候选 — Pfaffian, anti-Pfaffian, PH-Pfaffian, 和另一个变体。每个有 6 个任意子（3 个阿贝尔 + 3 个非阿贝尔 Ising 类）。量子维数平方 = 8。

## 依赖
- [[vison]] — mTO 的阿贝尔扇区就是 vison 及其幂
- [[modular-tensor-category]] — MTC 公理
- [[minimal-modular-extension]] — 准模范畴的极小模扩张
- [[pfaffian-states]] — 四个 Pfaffian 变体的具体结构
