# Paper Radar — 2026-05-05

> 全流程 thesis + core 线
> 产出路径: /home/claude/literature-lab/outputs/

---

## 一、本次覆盖主题

| 主题 | 优先级 | 搜索命中 | 进入短名单 |
|------|--------|----------|-----------|
| LSCO单层 | thesis | 6 | 0 (无符合条件的近期论文) |
| 超导二极管/隧道结 | thesis | 10 | 2 |
| 超导磁性材料 | thesis | 5 | 1 |
| 铜基超导 | core | 8 | 2 |

---

## 二、短名单 (5篇)

### 1. 超导二极管/隧道结

**A. Signatures of time-reversal-symmetry breaking in multiband 2H-TaS2 revealed by zero-field Josephson nonreciprocity**
- arXiv:2605.00477 (2026-05-01)
- Margineda, Caldevilla-Asenjo, Yerin, Gobbi et al. (CIC nanoGUNE / CFM-MPC CSIC-EHU)
- η ≈ 3%, 零场 SDE — 首次在非中心对称 TMD vdW 结中系统排除了界面、应变、透明度驱动机制，提出 interband scattering 驱动的 s+is' TRSB 多带超导态模型
- 实验+理论，TeX 已读
- 来源状态: arXiv (未正式发表)
- 与 TS 课题关系: 二极管效应新机制，直接关联 Chap_Diode

**B. High efficiency superconducting diode effect in a gate-tunable double-loop SQUID**
- arXiv:2512.14909 (2025-12-16, v1 2026-01-06)
- Gibbons, Zhang, Manfra et al. (Purdue / Microsoft Quantum)
- η = −54% 到 +47%，SQUID 基 SDE 的效率纪录。双环 SQUID + 每支路两个门极可调 JJ，独立控制谐波分量与振幅
- 实验，TeX 已读
- 来源状态: arXiv (未正式发表)
- 与 TS 课题关系: 高效率 SDE 实现方案，可引为二极管章节的实验标杆

### 2. 超导磁性材料

**C. Composite antiferromagnetic and orbital order with altermagnetic properties at a cuprate/manganite interface**
- arXiv:2404.19410, PNAS Nexus 3(4), pgae100 (2024)
- Sarkar, Capu, Bernhard et al.
- RIXS 发现 cuprate/manganite 界面 CuO2 层的 J 从 ~130 meV 被压制到 ~70 meV，伴随轨道序形成的 altermagnetic 态
- 实验 (RIXS)，已发表在 PNAS Nexus
- 来源状态: published
- 与 TS 课题关系: 唯一满足 thesis-extract 条件的论文，直接关联 Chap_Magnetic

### 3. 铜基超导 (core)

**D. Hidden Universal Metal in Cuprate Superconductors**
- arXiv:2604.10133 (2026-04-11)
- Lee, Haase (Univ. Leipzig)
- NMR 弛豫数据分析揭示所有铜基超导体共享同一 universal metal: 1/T1⊥ Tc ≈ 25/Ks。Tc 以上为 strange metal 区，弛豫 anisotropy 与 Tc_max 直接相关
- 理论/数据分析，TeX 已读
- 来源状态: arXiv (未正式发表)

**E. Ultrafast decoupling of the pseudogap from superconductivity in a pressurized cuprate**
- arXiv:2604.10207 (2026-04-11)
- Meng, Mao, Zhou, Wang et al.
- 超快光谱 + 高压 (≤37 GPa): pseudogap 的 T* 随压力单调上升但 ΔPG 被压制，Tc 和 ΔSC 走 dome 形 —— 赝能隙与超导独立演化
- 实验，PDF 已读
- 来源状态: arXiv (未正式发表)

---

## 三、LSCO 单层方向备注

本次搜索未发现符合 quality threshold 的近期 LSCO 论文。最近相关论文为:
- "Ultrathin Limit on the Anisotropic Superconductivity of Single-Layered Cuprate Films" — Feng et al., Chin. Phys. Lett. 41, 027401 (2024): LSCO 膜在 2 个单胞 (~2.6 nm) 厚度下仍超导
- "Emergent Coherence at the Edge of Magnetism: Low-Doped La2-xSrxCuO4+delta Revisited" — arXiv:2602.04452 (2026-02): 低掺杂 LSCO 的逾渗超导

---

## 四、来源雷达概览

| Paper | 来源 | 质量 | 建note |
|-------|------|------|--------|
| 2605.00477 TaS2 SDE | TeX 全文 | 高 — 实验+理论自洽 | ✓ |
| 2512.14909 SQUID diode | TeX 全文 | 高 — 实验标杆 | ✓ |
| 2404.19410 Altermagnetic IF | PDF + published | 高 — 已发表 PNAS Nexus | ✓ |
| 2604.10133 Universal Metal | TeX 全文 | 高 — 系统性 NMR 分析 | ✓ |
| 2604.10207 Pressurized PG | PDF + 摘要 | 中 — PDF only | ✓ |

---

## 五、本次未覆盖

- 拓扑序 (interest): 本次仅跑 thesis+core 线，未覆盖
- LSCO 超薄膜: 近期无符合阈值的新论文
- 飞书推送: Linux 环境无此能力，跳过

---

## 六、后续行动

- 2404.19410 已写入 for-thesis/（唯一满足 published + thesis 条件的论文）
- 所有 5 篇已建 paper notes
- 建议下次跑拓扑序 interest 线 (search → analyze → deposit)
