---
entry_mode: formal
formalization_status: complete
tex_trace_status: verified
source_mode: tex-first
topic: 拓扑序
aliases: [vison, 粘子]
status: formal
created: 2026-05-05
tex_source: arXiv:2505.14767 (Hall.tex)
updated_by: []
---

# Vison

## 命题

分数量子霍尔系统中，Hall 电导率 σ_H = p/q（p, q 互质）蕴含存在一个特殊的阿贝尔任意子 v，称为 **vison**，满足：

\[
\boxed{h(v) = \frac{1}{2}\sigma_H,\quad Q(v) = \sigma_H,\quad B(v, a) = Q(a) \bmod 1\;\; \forall a}
\]

vison 生成一个 one-form 对称群 \(\mathcal{V}^{s,r} = \{1, v, v^2, \ldots, v^{s-1}\}\)，其中 s = qℓ 为群阶，r = pℓ 为反常参数。

## 来源追踪
- **TeX 来源**: arXiv:2505.14767, Hall.tex
- **文件 / 压缩包**: `/tmp/tex-2505.14767/Hall.tex`
- **节 / 定理 / 公式位置**: Sec. 2.2 "Flux threading argument", Eq. (2.13)
- **原 TeX 片段**:
```latex
{\big(h(v),Q(v)\big)\sim\left( \frac12\sigma_H, \sigma_H\right)\,,
}
```
```latex
B(v,a)=Q(a) \mod 1\,.
```

## 形式数据

\[
\begin{aligned}
\text{输入}: &\quad \sigma_H = p/q \in \mathbb{Q} \quad (p,q \text{ 互质}) \\
\text{输出}: &\quad v \in \mathcal{A},\quad h(v) = \sigma_H/2,\quad Q(v) = \sigma_H \\
& \quad B(v,a) = Q(a) \bmod 1 \quad \forall \text{ anyon } a
\end{aligned}
\]

vison 是阿贝尔的：\(v \times a\) 对所有 a 产生单一 anyon。其 n 次融合给出 \(v^n\)，自旋由齐次二次型决定：
\[
h(v^n) = n^2 h(v) \bmod 1
\]

## 规则 / 推导

### flux threading 论证（Sec. 2.2 of 2505.14767）

1. 在环形几何中缓慢穿入磁通 Φ(t)，产生径向电场 E，驱动 Hall 电流 \(I_r = \sigma_H (d\Phi/dt)/2\pi\)
2. 穿过 ΔΦ = 2π 后，系统回到初始组态（至多差一个大规范变换），但内孔累积了电荷 σ_H
3. 绝热演化在远离边缘处保留局部基态 → 最终态相当于在内边缘产生了携带电荷 σ_H 的准粒子——即 vison v
4. 将另一任意子 a 绕 vison 一周：Aharonov-Bohm 相 = Q(a)，同时等于编织相 B(v,a)，故 B(v,a) = Q(a) mod 1
5. 设 a = v：\(B(v,v) = \sigma_H \bmod 1\)，非零分数部分 → v 有非平庸任意子统计 → 分数 σ_H 必然蕴含拓扑序

### 拓扑自旋

假设连续旋转对称性，角动量变化：
\[
\frac{dL_z}{dt} = \frac{\sigma_H}{8\pi^2}\frac{d}{dt}(\Phi^2) \Rightarrow \Delta L_z = \sigma_H/2
\]
对一般格点系统有严格推导（Kapustin 2020），结果一致：\(h(v) = \sigma_H/2\)

## 后果

1. **分数 σ_H ⇒ 拓扑序**：只要 Hall 电导是分数的，低能理论必然包含非平庸任意子，不可能有平凡基态
2. **电荷的分数部分由 vison 完全确定**：任何激发 a 的电荷模 1 等于 B(v, a)
3. **vison 的群阶 s 是 q 的倍数**：为确保 \(v^s = 1\)（透明玻色子），必须有 s = qℓ
4. **最小性条件 ℓ = 1 定义 mTO**：极小拓扑序中 vison 群阶正好是 q

## 最小例子

**Laughlin ν = 1/3 态**: σ_H = 1/3 → h(v) = 1/6, Q(v) = 1/3。
vison = e^{iϕ/3} 准粒子（q = 3, s = 3, \(\mathcal{V}^{3,1}\)）。融合规则：v³ = 1。vison 的编织相 B(v, v) = 1/3 mod 1。

**Moore-Read ν = 1/2 态**: σ_H = 1/2 → h(v) = 1/4, Q(v) = 1/2。
vison 是阿贝尔部分中的电荷 e/2 准粒子。s = 2q = 4（vison 群阶大于 q，因为有非阿贝尔扇区）。

## 依赖
- [[minimal-topological-order]] — vison 的群阶 s = q 是 mTO 定义的核心
- [[anyon-braiding]] — 编织相定义
- [[U(1)-symmetry-enrichment]] — U(1) 对称性富化下的电荷分配
