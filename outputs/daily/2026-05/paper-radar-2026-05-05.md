# 📡 每日文献雷达 — 2026-05-05 (下午轮)

> 全流程 thesis + core 线，第二轮运行。
> 覆盖：LSCO单层 / 超导二极管 / 超导磁性材料 / 铜基超导
> 上午轮已覆盖 5 篇 (2605.00477, 2512.14909, 2404.19410, 2604.10133, 2604.10207)，本轮发现 5 篇新文献。

---

## 一、本轮高信号

### 1. 强关联驱动零场 Josephson 二极管效应 ⭐⭐⭐
- arXiv:2604.14045 | Sun, Zhang, He (USTC Hefei)
- 2026-04-15 | cond-mat.supr-con
- **核心发现：** Hubbard U 强关联 + 奇数电子数 → 自发 TRSB → φ-junction → **零场 JDE**，无需磁序或显式对称破缺。SOC 仅破 SU(2) 不决定极性。微小 Zeeman 场可实现可控高效率 JDE（增强来自磁性关联）。
- **与 TS 课题：** 二极管线新机制。与 2605.00477（multiband TRSB）互补——强关联 vs 多带效应作为零场 SDE 的两个独立起源。可检预测：φ-junction 态随机极性翻转。
- **来源：** TeX 全文
- **状态：** arXiv

### 2. 平面 JJ 各向异性超导二极管效应 ⭐⭐⭐
- arXiv:2604.17594 | Chilampankunnel Prasannan, Pekerten, Alashkar, Matos-Abiague
- 2026-04-19 | cond-mat.supr-con
- **核心发现：** Rashba + Dresselhaus SOC planar JJ 的 SDE 磁/晶各向异性全分析。对称性条件（Table I）预测 SDE 抑制方向，可实验检验。栅压在纯 Rashba 下也可实现低场极性反转。窄结解析模型将 SDE 各向异性追溯至 Fermi 面畸变和各向异性 Cooper 对动量。
- **与 TS 课题：** 二极管线对称性框架。Table I 的抑制条件可用于诊断 SOC 在 SDE 中的作用。与 2512.14909 互补——前者框架，后者器件。
- **来源：** TeX 全文
- **状态：** arXiv

### 3. 涡旋宇称控制的 Corbino 拓扑 Josephson 结二极管 ⭐⭐
- arXiv:2601.14384 | Park et al. (Harvard / Weizmann / Princeton / NIMS)
- 2026-01-20 | cond-mat.supr-con
- **核心发现：** 3DTI Corbino 结上偶-奇 JDE——二极管极性随 enclosed 涡旋数宇称交替。石墨烯 Corbino 和 3DTI 线结均无此效应 → 拓扑超导 Andreev 束缚态拓扑的直接体现，与非 Abel 任意子相关。
- **与 TS 课题：** 二极管 + 拓扑交叉方向。
- **来源：** TeX 未获取（超时），arXiv 摘要 + WebSearch
- **状态：** arXiv | ⚠️ 待获取全文（实验论文，需 PDF 方可建 note）

### 4. 铜基超导体赝能隙与凝聚——NMR 位移 ⭐⭐⭐
- arXiv:2604.19215 | Lee, Haase (Univ. Leipzig)
- 2026-04-21 | cond-mat.supr-con
- **核心发现：** 系统分析 ~40 种铜基 NMR 数据。Cu 位移解耦为 A 自旋（3d 各向异性）和 B 自旋（4s 各向同性）。B-spin DOS 随掺杂降低而下降，x≈0.20 为变化率转折点。赝能隙 = Tc 处位移展宽（非弛豫展宽）。凝聚三斜率对应可能的配对对称性混合。最优 Tc 需 A/B 匹配。
- **与 TS 课题：** 铜基线。与 2604.10133（同一组，Cu 弛豫分析）互补构成完整 NMR 现象学。B-spin DOS 变化与 2604.10207 的 ΔPG 压力演化可对话。
- **来源：** TeX 全文
- **状态：** arXiv

### 5. 自旋条纹无序 → 奇异金属 + 费米弧 ⭐⭐⭐
- arXiv:2507.06309v4 | Zhang, Bultinck (Ghent Univ.)
- 2026-04-22 | cond-mat.str-el
- **核心发现：** 电势无序 + 自旋条纹 → SDW 玻璃态 → 涌现 Ising 自由度 → QCP 由 Patel et al. (Science 2023) 奇异金属普适理论描述。Monte Carlo 显示 AFM 关联长度仅 4-5 晶格常数即可产生清晰的费米弧。
- **与 TS 课题：** 统一奇异金属线性-T 电阻 + 费米弧——铜基两大核心问题。Ising 自由度赝能隙微观图像。
- **来源：** TeX 全文
- **状态：** arXiv

---

## 二、全日本日汇总

| 主题 | 上午轮 | 下午轮（本轮） | 合计新文献 |
|------|--------|---------------|----------|
| 超导二极管 (thesis) | 2605.00477, 2512.14909 | 2604.14045, 2604.17594, 2601.14384 | 5 |
| 超导磁性 (thesis) | 2404.19410 | — | 1 |
| 铜基超导 (core) | 2604.10133, 2604.10207 | 2604.19215, 2507.06309 | 4 |
| LSCO单层 (thesis) | — | — | 0 |

---

## 三、论文笔记

上午轮已建 5 篇 note。本轮新建 4 篇：
- [[papers/2604.14045-correlation-zero-field-jde]]
- [[papers/2604.17594-anisotropic-sde-planar-jj]]
- [[papers/2604.19215-nmr-pseudogap-cuprates]]
- [[papers/2507.06309-strange-metal-spin-stripes]]

仅雷达：2601.14384（实验论文，TeX 未获取，待 PDF）

---

## 四、跨轮关联

- **2604.14045 ↔ 2605.00477**：零场 SDE 的两个独立机制——强关联 φ-junction vs multiband TRSB s+is'
- **2604.17594 ↔ 2512.14909**：SDE 对称性框架 ↔ 高效器件实现
- **2604.19215 ↔ 2604.10133**：同组互补——NMR 位移 vs 弛豫
- **2507.06309 ↔ 2604.10133 + 2604.10207**：奇异金属微观模型 ↔ NMR 两分量图像 + 赝能隙压力演化

---

## 五、for-thesis

本轮无新增（全 arXiv 预印本）。上午轮已提取 2404.19410（published, PNAS Nexus）。

---

## 六、趋势
1. 零场 JDE 机制进入多机制竞争阶段——强关联 / multiband / 手性反铁磁，今年已 3 个独立提案
2. NMR 现象学系统化——Lee & Haase 组两篇互补论文可能成为铜基新基准
3. 奇异金属理论趋同——场论 + 数值计算逼近同一图像
4. LSCO 超薄方向持续贫瘠——建议拓展搜索策略
