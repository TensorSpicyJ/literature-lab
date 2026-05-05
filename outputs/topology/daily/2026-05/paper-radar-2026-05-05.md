# 拓扑序文献雷达 — 2026-05-05

## 今日结论
- 今天搜了 5 个拓扑序相关 topic，arxiv 新文献丰富，筛选后精读 2 篇理论论文（均获 TeX 源）
- 两篇都提供了概念卡级别的核心公式：vison 的普适性质与 paired FQH states 的统一输运框架
- 多篇前沿 preprint 未精读，按学习宪章原则优先奠基性理论工作

## 必看论文
（本日为 interest 线，无 published/accepted 论文进入必看；以下为 TeX 精读的两篇 arXiv 理论工作，按学习优先级排列）

### 1. Ordering the topological order in the fractional quantum Hall effect
- **一句话**：给定 Hall 电导率 σ_H = p/q，可以用 one-form 对称性及其反常唯一确定极小拓扑序——q 奇时唯一（q 个 Abelian anyon），q 偶时有四个 Pfaffian 类非阿贝尔理论（3q 个 anyon）。
- **状态**：arXiv:2505.14767 (v2, 2026-03-06 修订)，83 页
- **为什么重要**：Cheng–Musser–Raz–Seiberg–Senthil 五位顶级理论家合作。这篇文章把"从 σ_H 倒推拓扑序"这个方向做到了系统化——反向于通常的 SET 分类。对所有已知 FQH 实验平台都有直接约束力。
- **和 TS 的关系**：文中给出的 mTO 分类表（Table II）直接适用于 TS 关心的 FQH 拓扑序鉴定问题；vison 的定义和性质（h(v)=σ_H/2, Q(v)=σ_H）是后续所有概念卡的基石。

### 2. Universal Transport Theory for Paired Fractional Quantum Hall States in the Quantum Point Contact Geometry
- **一句话**：在 so(N)_1 × u(1) CFT 框架下统一处理所有 paired FQH states（Pfaffian, 331, anti-Pfaffian, K=8 等）在 QPC 几何中的输运，给出准粒子隧穿标度维数 Δ_QP = (2ν+N)/8 和强弱对偶性。
- **状态**：arXiv:2601.08792 (v2, 2026-04-30)，10 页
- **为什么重要**：首次对所有 paired states 的 QPC 输运做统一处理，证明强弱对偶性在一般 N 下的成立。实验上可直接通过电输运区分不同的 paired 拓扑序。
- **和 TS 的关系**：电输运指数（G ∼ T^{2/ν} 和 G ∼ T^{2Δ_QP-2}）是区分 paired FQH states 的实验指纹，可直接指导 TS 的输运数据分析。

## 背景 / 前沿跟踪
以下为本次搜索中筛出的前沿工作，仅记录未精读：

### 拓扑序/FQH 方向
- **2604.24058** — Testing robustness of topological quantities from modular Hamiltonian for Laughlin and Moore-Read states（arXiv, 2026-04-27）
- **2602.17564** — Hybrid Monte Carlo for FQH states: N > 1000 electrons, non-Abelian braiding matrices for Moore-Read quasiholes（arXiv, 2026-02-19）
- **2604.21434** — Decomposing FQH wave functions via operator contraction multiplication（arXiv, 2026-04-23）
- **2601.12165** — FQH states: infinite matrix product representation（arXiv, 2026-01-17）
- **2602.02292** — Non-Perturbative SDiff Covariance of FQH Excitations（EPL 2026, published）
- **2603.22029** — Drinfeld Center as Quantum State Monodromy over Bloch Hamiltonians（arXiv, 2026-03-23）

### 非阿贝尔任意子/Majorana 方向
- **2605.00669** — Experimental Evidence of Fractional Entropy in Critical Kondo Systems: ΔS = k_B ln(√2) for MZM, k_B ln((1+√5)/2) for Fibonacci anyon（arXiv, 2026-05）⚠️ 高信号实验论文
- **2507.00128** — MZMs in nanowires: defining topology through Majorana splitting（Pan & Das Sarma, arXiv, 2026-04）
- **2506.21534** — Rashba SOC review for topological superconductors（Das Sarma et al., arXiv, 2026-04）
- **2501.16056** — Braiding Majoranas in linear QD-SC array（PRB 113, 085302, 2026）
- **2604.00492** — Braiding of liquid crystalline Majorana quasiparticles（arXiv, 2026-04）
- **2604.11692** — Statistical signatures of MZMs in disordered TSC antidot vortices（arXiv, 2026-04）

### 量子自旋液体方向
- **2603.15745** — Unified gauge-theory description of QSL on square-based frustrated lattices（Iqbal et al., arXiv, 2026-03）
- **2509.02663** — Semi-Dirac spin liquids on trellis lattice（PRR 8, 013191, 2026）
- **2105.12726** — Symmetric U(1) and Z₂ spin liquids on pyrochlore（PRB 104, 054401, revised 2026-03）

### SPT/范畴论方向
- **2601.08615** — Generalized cluster states in 2+1d with non-invertible symmetries（arXiv, 2026-01）
- **2601.05518** — Fully local Reshetikhin-Turaev theories（Freed, Scheimbauer, Teleman, arXiv, 2026-01）
- **2502.20435** — Duality viewpoint of noninvertible SPT phases（PRL, 2026）
- **2507.05185** — Operator algebraic approach to fusion category symmetry on lattice（arXiv, 2026-04）
- **2512.21687** — Classifying fusion rules of anyons or SymTFTs（arXiv, 2026-04）

## 对 thesis 最直接的用处
今天为 interest 线，不直接为 thesis 产出素材。但两篇精读论文为后续 thesis 工作提供了基础：
- vison 的定义和 mTO 分类可以直接用于 thesis 的理论背景章（Chap_Intro）
- QPC 输运的普适标度律可复用于 TS 的输运数据分析框架

## 当日沉淀
- `concepts/vison.md` — Vison 原子概念卡（公式优先，TeX 可追溯）
- `concepts/minimal-topological-order.md` — 极小拓扑序分类概念卡
- `concepts/so-n1-fqh-paired.md` — so(N)_1 × u(1) paired FQH 框架概念卡
- `indexes/topic-index.md` — 拓扑序主题索引（新建）
- `relations/vison-mto.md` — Vison ↔ mTO 关联标注

## 下一步
- 追读 2605.00669（Kondo 分数熵实验）——这篇可能是非阿贝尔任意子的重要实验进展
- 对 2505.14767 的 mTO 分类表做逐行验证——确认为什么 q 偶时正好四个 Pfaffian 变体
- 将 QPC 输运标度律与已有实验数据（如 Banerjee 2018 热导测量）做交叉比对
- 检查是否有已有概念卡可以被今天的新文献更新（首次运行，所有概念卡均为新建）
