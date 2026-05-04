# 第一 article slice 选择说明

## 结论

如果当前只选一个默认的第一 article slice，推荐选择：

- `Z2拓扑序` 的有限数据切片

具体优先形式是：

1. anyon 集合 `\{1,e,m,\epsilon\}`
2. fusion 规则
3. 最小互绕数据 `M_{e,m}=-1`

而不是优先选择：

- `toric code` 的完整模型切片
- `string-net` 的 pentagon 切片
- Wen 1990 的定义层切片

## 为什么还要再写这一份

前一份 [第一 canonical model 选择说明](lean-first-canonical-model-choice.md) 已经回答了“先选哪类模型”。

这份文档进一步回答：

- 在这个 canonical model 里，第一刀到底先切哪一段
- 哪一条主命题链最适合成为第一批 article slice

## 当前候选切片

### Candidate A：`Z2` 有限数据切片

来源：

- [Z2拓扑序](../concepts/Z2拓扑序.md)
- [2003 Kitaev](../papers/2003-Kitaev-fault-tolerant-quantum-computation-by-anyons.md)
- [2008 Nayak et al.](../papers/2008-Nayak-non-Abelian-anyons-topological-quantum-computation.md)

候选主链：

- anyon 类型集合
- fusion 规则
- mutual statistics 的最小数据

### Candidate B：`toric code` 稳定子切片

来源：

- [toric-code模型](../concepts/toric-code模型.md)
- [2003 Kitaev](../papers/2003-Kitaev-fault-tolerant-quantum-computation-by-anyons.md)

候选主链：

- `A_s`
- `B_p`
- 基态空间条件
- `GSD(T^2)=4`

### Candidate C：monodromy / bubble / trace-like 切片

来源：

- 当前 `lean-sandbox` spine
- [双编织](../concepts/双编织.md)
- [闭合世界线振幅](../concepts/闭合世界线振幅.md)
- [左右迹候选](../concepts/左右迹候选.md)

候选主链：

- pair monodromy
- bubble amplitude
- trace-like cyclicity

### Candidate D：`string-net` pentagon 切片

来源：

- [string-net凝聚](../concepts/string-net凝聚.md)
- [2005 Levin-Wen](../papers/2005-Levin-Wen-string-net-condensation.md)

候选主链：

- 输入数据
- `F`-symbols
- pentagon 相容性

### Candidate E：Wen 1990 定义层切片

来源：

- [1990 Wen](../papers/1990-Wen-topological-orders-in-rigid-states.md)

候选主链：

- topological order 的定义层陈述
- 与局域序参量的区分
- 拓扑简并与 Berry phase 的框架作用

## 比较结果

### Candidate A：`Z2` 有限数据切片

**优点**

- 结构最干净
- 数据有限
- 最接近 canonical model 的第一步
- 与知识库概念卡高度对齐
- 不要求先 formalize 完整哈密顿量或高层相位定义

**风险**

- 如果贪多，容易在第一刀就把 `GSD`、BF 场论和模型语义全带进来

**判断**

- 最适合作为第一 article slice

### Candidate B：`toric code` 稳定子切片

**优点**

- 模型感更强
- 直接把抽象 anyon 数据接回具体格点模型
- 长期价值很高

**风险**

- 比 `Z2` 有限数据切片多出模型层负担
- 第一刀就切它，容易把证明对象和物理语义一起拉进来

**判断**

- 适合作为第二 article slice，而不是第一刀

### Candidate C：monodromy / bubble / trace-like 切片

**优点**

- 和现有 toy spine 最贴合
- 如果源码恢复，它是最快能重启的结构线

**风险**

- 它更像“结构支线验证”，而不是 canonical model article slice
- 对长期知识库的模型层推进不如 `Z2 / toric code` 直接

**判断**

- 非常适合作为并行的结构验证线
- 但如果只能选一个“第一 article slice”，优先级仍低于 `Z2` 有限数据

### Candidate D：`string-net` pentagon 切片

**优点**

- 长期杠杆高
- 对未来进入更一般拓扑相构造非常关键

**风险**

- 第一刀就做它，仍然太高层
- 更容易停在抽象接口，而不是形成最小可复用样板

**判断**

- 适合作为第二轮对象

### Candidate E：Wen 1990 定义层切片

**优点**

- 概念地位最高

**风险**

- 当前 translation contract 已明确它属于高风险定义层对象
- 容易把未 formalize 的相位语义一次性带入

**判断**

- 不适合作为第一 article slice

## 当前默认排序

当前推荐顺序：

1. `Z2` 有限数据切片
2. `toric code` 稳定子切片
3. monodromy / bubble / trace-like 切片
4. `string-net` pentagon 切片
5. Wen 1990 定义层切片

## 为什么第一刀不是 `toric code`

很多时候会直觉上认为 `toric code` 更“真实”，所以应该先做。

当前不这么选的原因是：

- `toric code` 切片比 `Z2` 有限数据切片多带了一层模型语义
- 第一刀更适合先得到一条极小但稳定的 canonical model 样板
- 先把 `Z2` 有限数据层做出来，再把它接回 `toric code`，路径更稳

## 为什么第一刀也不是 monodromy / bubble

虽然它们和当前 toy spine 更贴合，但它们更像：

- 结构验证线
- bridge 验证线

而不是知识库里“第一 canonical model article slice”。

因此当前建议是双线并行，但角色不同：

- `Z2` 有限数据切片：第一 canonical model article slice
- monodromy / bubble 切片：第一结构验证支线

## 建议的最小切法

第一刀默认只切到下面程度：

- 定义四类 anyon
- 定义 fusion 规则
- 写出最小 mutual statistics 数据

先不把下面内容一起扛进来：

- BF 场论
- genus \(g\) 上完整简并公式
- 完整 `toric code` 稳定子模型
- 更高层 category-theoretic 封装

## 当前默认下一步

如果继续往前推进，下一份最自然的文档是：

- [`Z2` 第一切片的 formalization sketch](lean-z2-first-slice-formalization-sketch.md)

它应当写清：

- 输入数据
- 目标 Lean 工件类型
- 预期 theorem/def 边界
- 需要复用哪些上游 toy/bridge

## 相关文档

- [第一 canonical model 选择说明](lean-first-canonical-model-choice.md)
- [Lean 翻译合同](lean-translation-contract.md)
- [Lean article slice 选择准则](lean-article-slice-rubric.md)
- [Z2 第一切片 formalization sketch](lean-z2-first-slice-formalization-sketch.md)
