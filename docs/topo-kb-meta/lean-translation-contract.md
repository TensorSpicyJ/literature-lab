# Lean 翻译合同

## 目的

这份文档规定 `topological-order-kb` 中的物理叙述，怎样诚实地翻译成 Lean 工件。

它的作用不是把所有内容都推进形式化，而是稳定回答三个问题：

- 这句话应该翻成 `structure`、`theorem`、`def`，还是只保留成解释
- 哪些物理定义当前还不适合直接进 Lean
- article slice 该如何选，不至于一上来就挑错对象

## 核心原则

### 1. 先分层，再翻译

任何待 formalize 的内容，先强制拆成三层：

- 物理叙述层
- 数学结构层
- Lean 工件层

如果一条句子连数学结构层都还没切清楚，就不该直接进入 Lean。

### 2. 不允许“物理直觉直接坍缩成 theorem”

下面这类跳跃默认不允许：

`物理直观成立 -> 直接写 theorem 壳`

中间至少要经过：

- 明确对象是什么
- 假设是什么
- 输出是什么
- 它依赖哪层结构

### 3. Lean 工件必须比原句更精确，而不是更模糊

如果翻译后的 Lean 目标比原句更含混，例如：

- 对象类型不清
- 假设不清
- 只是把英文句子换成 Lean 名字

那这不算 formalization，只算伪形式化。

## 当前允许的 Lean 工件类型

### A. `structure` / 接口层

适用于：

- 需要显式记录数据、操作与相容性条件
- 后续多个 toy 或 theorem 会复用同一个接口

典型例子：

- `MonoidalCategory`
- `BraidedCategory`
- rigid 相关接口
- `ClosureAgreementCategory`
- `TraceAgreementCategory`

判断标准：

- 这不是单次结论，而是后续多个命题的公共输入

### B. `theorem` / 命题层

适用于：

- 在明确假设下可表达为等式、交换图、自然性、退化、循环性等可检查结论

典型例子：

- symmetric 极限下顺时针与逆时针 toy 闭环相等
- `compositeBubble C f g = compositeBubble C g f`
- left / right trace candidate 在某结构下相等

判断标准：

- 输入结构明确
- 结论形式清楚
- 不依赖口头图像才能懂它在说什么

### C. `def` / 规范化命名层

适用于：

- 一个对象已经存在，但需要稳定命名、归一化符号或提炼中间量

典型例子：

- `closureScalar`
- `traceScalar`
- 规范化的 monodromy 写法

判断标准：

- 它主要解决“如何在 Lean 里稳定叫这件事”，不是在声明新的深层结构

### D. example / toy / canonical model

适用于：

- 用具体样板测试结构与定理接口

当前分两类：

- toy：结构上最小、物理语义刻意压缩
- canonical model：最小但真实的代表性模型

当前默认：

- `BraidedDualityToy`、`BubbleSlidingToy` 等属于 toy
- `Z2 / toric code` 是下一阶段想进入的 canonical model

### E. explanation-only

适用于：

- 当前仍高度依赖物理图像、研究语言或未 formalize 的语义背景

这类内容可以保留在知识库中，但当前不强行翻成 Lean。

## 当前不适合直接 formalize 的句子类型

### 1. 相位定义层的大句子

例如：

- “拓扑序就是 gapped long-range entanglement 的 LU 等价类”

这类句子很重要，但它们现在仍然牵涉：

- 量子相空间语义
- LU 等价的完整环境
- gapped / phase / long-range entanglement 的正式对象化

因此当前默认保留在 concept / paper 层，不直接变成 first-wave Lean 定义。

### 2. 高度依赖连续场论或路径积分语义的句子

例如：

- 需要完整泛函积分语义才能精确解释的陈述
- 当前还没有稳定离散化或范畴化桥接的低能有效理论句子

### 3. 主要在做物理解释而不是结构陈述的句子

例如：

- bulk-boundary 图像解释
- 实验语境中的可观测后果叙述
- “为什么这个概念重要”的教学性段落

它们重要，但不该伪装成 theorem。

## 翻译决策树

遇到一条待 formalize 的句子，默认按下面顺序判断：

### Step 1：它是在说数据，还是在说结论？

- 如果是在定义可复用数据与相容性条件，优先考虑 `structure`
- 如果是在说明确结论，继续下一步

### Step 2：它的输入和假设是否已经清楚？

- 若清楚，可考虑 `theorem`
- 若不清楚，先拆成更小的前置定义或中间命题

### Step 3：它是否只是在稳定命名？

- 若是，优先做 `def`

### Step 4：它是否仍然主要依赖物理解释？

- 若是，保留为 explanation-only

### Step 5：它是 toy，还是 canonical model？

- 若只是测试结构接口，进 toy
- 若它对应真实而最小的物理样板，进 canonical model lane

## 当前默认映射示例

### 示例 1：二维交换的方向性

物理句子：

- “在 braided 而非 symmetric 情形里，顺时针与逆时针交换不应先验相同”

当前合适翻译：

- 数学结构层：braided category 中两种不同闭环过程
- Lean 工件层：toy 级闭环态射与其在 symmetric 极限下的比较 theorem

不该直接翻成：

- “任意子的交换有方向” 这种没有明确对象与假设的 theorem 壳

### 示例 2：双编织 / monodromy

物理句子：

- “生成 pair、插入一次完整 monodromy、再湮灭”

当前合适翻译：

- 一个由 braiding 复合出来的具体 morphism
- 在 bubble 闭合下形成 toy 结论

对应：

- `BraidedMonodromyToy`

### 示例 3：左右迹候选

物理句子：

- “同一个 endomorphism 的闭合振幅可以有 left / right 两个候选”

当前合适翻译：

- 两个显式定义的 bubble map
- 若加入一致性假设，再得到 `TraceAgreementCategory`

这类句子最适合拆成：

- `def`
- `structure`
- `theorem`

而不是一步到位假装已有标准 trace。

### 示例 4：`Z2` / toric code

物理句子：

- “有四类 anyon，融合规则像 `Z2 × Z2`，在 `T^2` 上基态简并为 4”

当前合适翻译：

- canonical model lane
- 先组织有限数据层
- 再挑其中一条命题链 formalize

这说明它不该先被当成 explanation-only，也不该直接拿来代替高层相位定义。

### 示例 5：拓扑序的定义层总述

物理句子：

- “拓扑序不是局域序参量，而是长程纠缠相”

当前合适翻译：

- 先保留在 concept / roadmap 层
- 等 LU / entanglement / phase 的对象化条件成熟，再考虑更强 formalization

## article slice 的最低要求

一个合格的 article slice，至少应满足：

- 含有 1-3 条明确主命题，而不是整篇平铺
- 其输入结构与当前 spine 有交集
- 能回挂到现有 concept card
- 不需要一次性 formalize 整套高层物理语义
- 有明确的成功/失败边界

更详细的筛选规则见：

- [Lean article slice 选择准则](lean-article-slice-rubric.md)

## 当前推荐的第一批翻译对象

### 第一梯队

- `双编织`
- `闭合 worldline 振幅`
- `左右闭合 / 左右迹候选`
- `cyclicity / sliding`

原因：

- 它们已经和现有 sandbox spine 紧密相连

### 第二梯队

- `Z2拓扑序`
- `toric code`

原因：

- 它们适合作为 canonical model lane 的第一批对象

### 第三梯队

- `string-net`
- `Drinfeld center`

原因：

- 长期价值高，但适合放在 toy 与 canonical model 之间进一步桥接

### 暂缓梯队

- Wen 1989 / 1990 定义层文章
- 拓扑纠缠熵完整证明
- `fusion / modular / ribbon` 全套高层结构

## 当前默认禁令

在下面条件未满足前，默认不要做：

- 没有 translation contract 就开始高风险 formalization
- 没有 canonical model lane 就直接挑定义层文章
- 用“把物理术语翻成 Lean 名字”代替真正结构化翻译

## 这份合同服务什么

这份文档服务于：

- [Lean 能力补齐清单](lean-capability-buildout-checklist.md) 中的 Lane C
- [Lean 第一阶段 12 周执行计划](lean-first-phase-12-week-plan.md) 中的 Block 3
- 后续 `lean-capability-map.md` 与模型层/文章切片选择

## 当前默认下一步

有了这份合同后，最自然的下一步是：

1. 写 [Lean article slice 选择准则](lean-article-slice-rubric.md)
2. 用它比较 `Z2 / toric code`、`string-net`、Wen 1990 三类候选的第一刀优先级

