---
entry_mode: formal
formalization_status: complete
tex_trace_status: verified
source_mode: tex-first
topic: 拓扑序
aliases: [so(N)_1 paired FQH, paired FQH CFT, 配对分数量子霍尔]
status: formal
created: 2026-05-05
tex_source: arXiv:2601.08792 (main.tex)
updated_by: []
---

# so(N)_1 × u(1) Paired FQH 框架

## 命题

偶分母分数量子霍尔态可统一描述为复合费米子的拓扑超导体，其边缘理论为 \(so(N)_1 \times u(1)\) 共形场论：

\[
\boxed{
\begin{aligned}
&\text{边缘 CFT}: \; so(N)_1 \times u(1),\quad N = |\mathcal{C}_{cf}| \\[4pt]
&\Delta_{\text{QP}} = \frac{2\nu + N}{8} \quad \text{—— 准粒子隧穿标度维数} \\[4pt]
&\Delta_{\text{ET}} = \frac{1}{\nu} + 1 \quad \text{—— 电子隧穿标度维数（与 N 无关）}
\end{aligned}
}
\]

其中 \(\mathcal{C}_{cf}\) 为复合费米子的 Chern 数，N 为中性 Majorana 费米子边缘模式数。

## 来源追踪
- **TeX 来源**: arXiv:2601.08792, main.tex
- **节 / 定理 / 公式位置**: Sec. 1 (Introduction), Eq. (2.14), Sec. 3 (RG flow), Eq. (3.17)
- **原 TeX 片段**:
```latex
\Delta _{QP} = \frac{2\nu+N}{8}
```
```latex
\Delta_{ET} = \frac{1}{\nu} +1
```

## 形式数据

\[
\begin{aligned}
\text{输入}: &\quad \nu \in \mathbb{Q}_+,\quad N = |\mathcal{C}_{cf}| \in \mathbb{N}_0 \\
\text{输出}: &\quad \text{paired FQH state 的 CFT + 输运标度指数} \\
\text{分类}: &\quad N=0: K=8\;\text{强配对} \\
&\quad N=1: \text{Pfaffian}\;(+1),\;\text{PH-Pfaffian}\;(-1) \\
&\quad N=2: 331\;(+2),\;113\;(-2) \\
&\quad N=3: SU(2)_2\;(+3),\;\text{anti-Pfaffian}\;(-3) \\
&\quad N=4: \text{anti-}331\;(-4),\;\cdots
\end{aligned}
\]

## 规则 / 推导

### 边缘理论（Sec. 2 of 2601.08792）

在 QPC 几何中，上下边缘承载手征相反的模：

\[
\mathcal{S}_0 = \sum_{j=t,b} \int d\tau dx \left[ \frac{1}{4\pi\nu} \partial_x \phi_j (i\partial_\tau \phi_j + s_j v_c \partial_x \phi_j) + \Psi_j^T (-\partial_\tau + i s_j v_n \partial_x) \Psi_j \right]
\]

其中 \(s_t = +1, s_b = -1\)，\(\Psi = (\psi_1, \ldots, \psi_N)^T\) 为 N 个 Majorana 费米子。

### RG 分析（Sec. 3）

准粒子隧穿哈密顿量的标度维数：
\[
H_{\text{QPT}} = \Gamma_{\text{QP}} \, \sigma^\dagger e^{-i\phi/2} \cdot \sigma e^{i\phi/2} \;\longrightarrow\; \Delta_{\text{QP}} = \frac{1}{2\nu} \cdot \left(\frac{1}{2}\right)^2 \cdot 2\nu + \frac{N}{16} \cdot 2 = \frac{2\nu + N}{8}
\]

RG 方程：
\[
\frac{d\Gamma_{\text{QP}}}{d\ell} = (1 - \Delta_{\text{QP}})\Gamma_{\text{QP}}
\]

当 Δ_QP < 1（N < 7 时对 ν < 1 总成立），准粒子隧穿是 relevant 的 → 流向绝缘固定点。

### 强弱对偶（Sec. 4）

通过瞬子气展开和对偶变换，强准粒子隧穿映射到弱电子隧穿：
\[
\mathcal{L}_{\text{dual}} = \mathcal{L}_0 - i y \Psi_t^T \Psi_b \cos\left(\frac{\phi_t - \phi_b}{\nu}\right)
\]

电子隧穿的标度维数对所有 paired states 相同：
\[
\Delta_{\text{ET}} = \frac{1}{\nu} + 1 > 1 \quad (\nu < 1)
\]
→ 电子隧穿总是 irrelevant，绝缘固定点稳定。

## 后果

### 输运标度律

| 能区 | 条件 | 电导 |
|------|------|------|
| 低能 (IR) | V > T | \(G(V) \propto V^{2/\nu}\) |
| 低能 (IR) | T > V | \(G(T) \propto T^{2/\nu}\) |
| 高能 (UV) | V > T | \(\nu\frac{e^2}{h} - G(V) \propto V^{2\Delta_{\text{QP}}-2}\) |
| 高能 (UV) | T > V | \(\nu\frac{e^2}{h} - G(T) \propto T^{2\Delta_{\text{QP}}-2}\) |

**关键**: IR 标度仅依赖 ν（不依赖 N），UV 修正依赖 N → 可通过测量 UV 标度指数反推 N，从而区分 paired states。

### so(N)_1 融合规则（Sec. 3 of 2601.08792）

- **N 奇**: 三个初级场 I, Ψ, σ。融合代数同构于 Ising 模型
- **N 偶 (k = N/2 奇)**: 四个初级场 I, Ψ, σ_+, σ_-。σ_± × σ_± = Ψ, σ_+ × σ_- = I
- **N 偶 (k = N/2 偶)**: 四个初级场 I, Ψ, σ_+, σ_-。σ_± × σ_± = I, σ_+ × σ_- = Ψ（toric code 类）

## 最小例子

**ν = 1/2, Pfaffian (N = 1)**:
- Δ_QP = (2·½ + 1)/8 = 2/8 = 1/4 → relevant
- IR: G ∼ T^4（因为 2/ν = 4）
- UV 修正: νe²/h − G ∼ T^{-3/2}

**ν = 1/2, 331 (N = 2)**:
- Δ_QP = (2·½ + 2)/8 = 3/8 > 1/4
- 与 Pfaffian 的 UV 修正指数不同 → 可实验区分

**ν = 1/2, anti-Pfaffian (N = 3)**:
- Δ_QP = (2·½ + 3)/8 = 4/8 = 1/2
- UV 修正: G ∼ T^{-1}

## 依赖
- [[vison]] — paired states 中的阿贝尔 vison 对应 e^{iϕ/ν}（电荷扇区）
- [[minimal-topological-order]] — ν = 1/2 的四个 Pfaffian 变体映射到 N = ±1, ±3
- [[anyon-braiding]] — so(N)_1 的融合规则决定任意子统计
- [[qpc-transport]] — QPC 几何与输运测量
