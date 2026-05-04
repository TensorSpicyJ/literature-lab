# Lean article slice 选择准则

## 目的

这份文档规定：在 `topological-order-kb` 里，什么样的文章切片值得成为第一批 Lean formalization 对象。

它不回答“哪篇文章更重要”，而回答：

- 哪个切片更适合当前能力层
- 哪个切片能最大化长期复用
- 哪个切片最不容易把支线带偏

## 核心原则

第一批 formalization 的单位不是 full paper，而是 article slice：

- 一条主命题链
- 少量支撑定义
- 明确的输入结构
- 明确的停止边界

如果一个对象无法切成这样的最小单元，它就不适合当第一刀。

## 五个筛选维度

### 1. 结构贴合度

问题：

- 它是否直接复用当前已有的 `monoidal / braided / rigid / center / bubble / trace` spine？

高分对象：

- monodromy
- bubble
- trace-like
- braided-rigid 过渡

低分对象：

- 需要一整套尚未建立的高层结构才说得清的对象

### 2. 模型具体度

问题：

- 它是否有一个最小、清楚、有限的数据表达？

高分对象：

- `Z2 topological order`
- `toric code`
- 有限 anyon 数据

低分对象：

- 完整相位定义
- 强依赖连续场论语义的对象

### 3. 语义压缩难度

问题：

- 它是否能在不严重失真的情况下压缩成 Lean 可检查命题？

高分对象：

- 等式
- 交换关系
- 自然性
- 退化关系
- 有限数据的一致性结论

低分对象：

- 教学叙事为主的段落
- 需要长段物理解释才站得住的总述

### 4. 长期复用价值

问题：

- 做完这个 slice 后，是否能让后续 2-3 个对象更容易 formalize？

高分对象：

- 能反复复用的 bridge/interface
- canonical model 的最小样板

低分对象：

- 只对单篇文章特有、难复用的局部技巧

### 5. 源追踪清晰度

问题：

- 它是否能清楚回挂到 concept / paper / roadmap 三层？

高分对象：

- 已有概念卡和明确阅读入口的对象

低分对象：

- 目前只在聊天或零散草稿里出现的对象

## 一票否决条件

只要满足下面任一条件，就不适合作为第一批 article slice：

- 需要完整 `fusion / modular / ribbon` 层才有意义
- 需要完整 LU / phase / long-range entanglement 语义才有意义
- 主要价值在物理图像解释，而不是结构命题
- 切不出 1-3 条主命题链
- 不能明确挂回知识库主线

## 第一批优先级建议

### Tier 1：最适合作为第一刀

- `双编织 / monodromy`
- `闭合 worldline 振幅`
- `左右闭合 / 左右迹候选`
- `cyclicity / sliding`
- `Z2 / toric code` 的最小有限数据层

原因：

- 最贴合现有 spine
- 最容易形成模板
- 失败成本最低

### Tier 2：适合作为第二轮

- `string-net`
- `Drinfeld center` 相关切片
- `Z2 / toric code` 的更深一层结构组织

原因：

- 长期杠杆大
- 但比 Tier 1 更依赖前置稳定性

### Tier 3：先保留，不作为首刀

- Wen 1989 / 1990 定义层文章
- 拓扑纠缠熵完整证明
- anyon condensation 的第一批 formalization

原因：

- 重要，但不适合当前能力层

## 当前默认排序

如果现在必须选一个首刀对象，推荐顺序是：

1. `Z2 / toric code` 的最小结构化切片
2. `monodromy / bubble / trace-like` 中与现有 toy 最贴合的一条
3. `string-net` 的局部结构切片
4. Wen 1990

## 切片写法要求

一个真正准备进入 Lean 的 article slice，至少要写清：

- 来源文章
- 所属 concept card
- 主命题链
- 输入结构
- 当前不覆盖什么
- 为什么它适合现在做

## 与其他文档的关系

本准则应与下面两份文档一起使用：

- [Lean 翻译合同](lean-translation-contract.md)
- [Lean 第一阶段 12 周执行计划](lean-first-phase-12-week-plan.md)

