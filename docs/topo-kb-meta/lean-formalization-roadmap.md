# 拓扑序 Lean 化长期路线图

## 2026-04-25 checkpoint addendum

The active Lean proof branch is now
`D:\Playground\topological-order-lean` branch
`codex/toric-code-checkpoint`.

Current restore/proof-plan docs:

- `docs/TORIC-CODE-CHECKPOINT.md`
- `docs/FULL-GROUNDSPACE-EQUIVALENCE-SPIKE.md`

`TopoOrder.ToricCode.GroundSpaceEquivalence` has been added with the proved
bridge `vertexStabiliser_apply_boundary`.  The next roadmap node for full
toric-code GSD is `closed_config_decompose_mod_GX`, which should identify
closed configurations modulo `GX` with the two non-contractible loop
readouts.

## 2026-04-25 校正

本路线图中的 `archive/lean-sandbox/` 恢复判断只反映知识库同步面。
真实 Lean 工程已在 `D:\Playground\topological-order-lean` 和 `D:\Playground\worktrees\topological-order-lean\z2-first-slice` 中存在，并且本次复核两处 `lake build` 均通过。

因此，当前路线图的执行焦点应前移到：

- 以 `D:\Playground\topological-order-lean` 作为实现 source of truth；
- 明确哪些 `Z2` / toric-code theorem 已经 Lean 检查；
- 记录 sector/readout 层的 `GSD(T^2)=4` 已在 `TopoOrder/ToricCode/QuantumGroundSpace.lean` 中闭合且无 `sorry`；
- 把 full stabiliser-eigenspace 与 sector space 的线性等价作为后续 strengthening，而不是把 toric-code Lean 化整体视为未开始。

## 目的

这份文档定义 `topological-order-kb` 里 Lean / mathlib 支线的长期方向。

它不是一个短期实验清单，也不是在假装“拓扑序已经有现成总库可用”。
它要回答的是：

- 这条支线最终想服务什么
- 现在真正缺哪些能力
- 应该先 formalize 哪些内容，后 formalize 哪些内容
- 未来 1-3 年内，怎样把零散 toy 积累成一条可复用的 formalization 线路

相关现状见：

- [Lean Sandbox](../archive/lean-sandbox/README.md)
- [Lean Sandbox Plan](lean-sandbox-plan.md)
- [Lean / 范畴论形式化资源](../sources/lean-category-theory-resources.md)
- [拓扑序学习路线](../roadmap/topic-拓扑序学习路线.md)
- [Lean 能力补齐清单](lean-capability-buildout-checklist.md)
- [Lean 第一阶段 12 周执行计划](lean-first-phase-12-week-plan.md)
- [Lean 构建与恢复说明](lean-build-recovery-note.md)
- [Lean 翻译合同](lean-translation-contract.md)
- [Lean article slice 选择准则](lean-article-slice-rubric.md)
- [Lean 能力图谱](lean-capability-map.md)
- [第一 canonical model 选择说明](lean-first-canonical-model-choice.md)
- [第一 article slice 选择说明](lean-first-article-slice-selection.md)
- [Z2 第一切片 formalization sketch](lean-z2-first-slice-formalization-sketch.md)
- [Z2 第一切片 implementation breakdown](lean-z2-first-slice-implementation-breakdown.md)
- [Lean 源码恢复选项](lean-source-recovery-options.md)

## 北极星

这条支线的北极星不是“把整个拓扑序理论一次性 formalize”，而是分三层逐步做到：

1. 把拓扑序知识库里最核心的数学骨架变成可运行的 Lean 结构。
2. 把少数代表性模型或文章切成可验证的 formalization slice。
3. 让 `concepts/`、`papers/`、`roadmap/` 里的关键卡片能明确说清：
   - 哪些结论只是物理解释
   - 哪些已经被整理成数学命题
   - 哪些已经被 Lean 真正检查过

更长远地说，这条支线希望形成一个 durable bridge：

`物理语言 -> 数学结构 -> Lean 命题 -> 回挂知识库`

## 非目标

至少在中期内，这条支线不把下面几件事当成默认目标：

- 不追求“整篇文章原样 Lean 化”
- 不假装 `fusion / modular / ribbon / anyon condensation / topological order` 已经有现成主库
- 不把所有物理直觉都硬翻成 Lean 语句
- 不把知识库主线改造成以 Lean 工程为中心的 repo
- 不为了形式化而牺牲物理图像与阅读路线

## 长期原则

### 1. 地基优先，不抢高层名词

只要 `monoidal / braided / rigid / center` 这一层还没有被稳定吃透，就不急着追 `modular tensor category` 一类更高层结构。

### 2. 切片优先，不整篇硬上

形式化单位默认是 article slice，而不是 full paper。
一篇文章里通常只挑一条最硬、最干净、最可验证的命题链先做。

### 3. 三层分离

每次推进都要显式区分三层：

- 物理叙述层
- 数学结构层
- Lean 工件层

不能把“物理上直观成立”直接当成“Lean 里已经有合适命题”。

### 4. 诚实记录边界

如果某个结论目前只是 toy、只在 symmetric 极限成立、或者还停留在结构接口层，就明确写成 toy、极限结论、或接口结论，不提前声称“已得到完整理论”。

### 5. 知识库与 Lean 工程双向同步

Lean 文件不能脱离知识库独立生长。
每一个值得保留的 Lean 切片，都应当能回挂到：

- 一个 roadmap 节点
- 至少一个 concept card
- 至少一个 paper 或书目入口

## 当前能力盘点

截至当前，已经有的能力是：

- `mathlib4` 可直接提供 `monoidal / braided / rigid / center` 入口
- 本地已有真实 sandbox，而不是空目录
- 已有一批可运行的 bridge / toy：
  - `BraidedDualityToy`
  - `BraidedMonodromyToy`
  - `BubbleAmplitudeToy`
  - `BubbleAgreementToy`
  - `BubbleOrientationToy`
  - `BubbleSlidingToy`
  - `TraceOrientationToy`
  - `TraceAgreementToy`
  - `TraceCyclicityToy`
  - `StringNetToy`
- 知识库已经开始把这些 Lean 落点显式写回学习路线

这意味着现在的真实阶段不是“是否能开始”，而是“如何把已有 toy 组织成长期可扩展的正式支线”。

## 关键能力缺口

### A. 构建复现能力缺口

当前最现实的缺口不是定理本身，而是 reproducibility。

本轮检查里：

- `lake build` 没有稳定通过
- 失败点落在 GitHub 依赖拉取，而不是 Lean 文件本身
- `git ls-remote https://github.com/leanprover-community/plausible` 也连不上

这说明现在缺的是“新机器 / 新缓存 / 依赖失效后还能重新站起来”的能力。

### B. 数学地基缺口

当前可直接复用的重心仍是：

- `monoidal`
- `braided`
- `rigid`
- `center`

而下面这些层还不能默认视为现成：

- `pivotal`
- `spherical`
- `ribbon`
- `fusion category`
- `modular tensor category`
- `condensable algebra`
- `anyon condensation`

### C. 物理到 Lean 的翻译规约缺口

现在还缺一份稳定的翻译合同，明确区分：

- 什么样的物理句子应该翻成 structure
- 什么样的句子应该翻成 theorem
- 什么样的句子只适合留在 concept card 里当解释
- 什么样的“定义”本质上还只是研究语言，不适合当前阶段 formalize

### D. 模型层缺口

目前 toy 层已经有了，但“最小具体模型层”还不够稳。
尤其缺少可复用的：

- anyon 类型数据表示
- fusion table 表示
- braiding / monodromy 数据表示
- `Z2` / toric code 的最小结构化封装

### E. 升阶规则缺口

还缺一条明确的 escalation rule：

`toy -> canonical model -> article slice -> higher abstraction`

如果没有这条规则，后面很容易在 toy 和高层抽象之间来回跳，积不成体系。

### F. 验证与状态登记缺口

现在也还缺一份长期状态表，能稳定回答：

- 哪个 `.lean` 文件证明了什么
- 它依赖哪些 mathlib 接口
- 它对应知识库里的哪张 concept card
- 它仍然没有覆盖什么

## 长期阶段划分

### Phase 0：环境与复现稳定化

目标：
- 把“本机曾经编过”变成“现在可复现地编过”

核心产物：
- 稳定的 `lake build` 路径
- 依赖刷新策略
- 网络失败时的缓存 / 备份 / 镜像说明

完成标志：
- 在清缓存或新依赖场景下，也能恢复可编译状态
- 能明确区分“环境失败”和“证明失败”

这一阶段不追求新增物理定理。

### Phase 1：地基整理与接口归档

目标：
- 把现有 sandbox 从“若干能跑的 toy”整理成连续的 formalization spine

核心对象：
- `MonoidalBridge`
- `BraidedBridge`
- `CenterBridge`
- `LeftRigidBridge`
- `RigidBridge`
- `BraidedRigidBridge`
- `Bubble*`
- `Trace*`

核心产物：
- 一份 capability map
- 一份从 knowledge-base 概念卡到 `.lean` 文件的映射表
- 一份 toy 层依赖顺序与语义边界说明

完成标志：
- 能清楚回答每个 toy 的输入结构、输出结论、适用边界

### Phase 2：最小模型层

目标：
- 从纯 toy 推进到最小而真实的 canonical model

首选对象：
- `Z2 topological order`
- `toric code`

优先 formalize 的内容：
- anyon 集合
- fusion 规则
- mutual statistics / monodromy 的最小表达
- `GSD(T^2)=4` 这类有限数据层结果

暂不默认 formalize 的内容：
- 完整哈密顿量动力学语义
- 所有凝聚态物理解释
- 与实验现象的整套桥接

完成标志：
- 知识库里至少有一条“概念卡 -> Lean 文件 -> 可检查命题”的完整样板链

### Phase 3：第一批文章切片

目标：
- 不再只 formalize 概念卡，而开始 formalize 代表性文章中的局部命题链

优先级建议：

1. `toric code / Z2` 样板文章
2. `双编织 / monodromy / 闭合 worldline` 相关切片
3. `string-net` 的结构化切片

这一阶段的单位不是 full paper，而是：

- 一篇文章
- 一条主命题链
- 一组支撑定义
- 一组 Lean 可检查结论

完成标志：
- 至少完成 1-2 个 article slice，且它们共享前面阶段积累的基础接口，而不是各写各的孤立代码

### Phase 4：高层结构预备层

目标：
- 在不冒进的前提下，为更高层拓扑序语言预备接口

候选方向：
- `pivotal`
- `spherical`
- `ribbon`
- `fusion category`
- `modular tensor category`

这里的重点不是立刻做完，而是先澄清：

- 哪些已经能靠 mathlib 或现有接口接进去
- 哪些必须自建最小桥
- 哪些还不值得现在开坑

完成标志：
- 至少对一条高层结构线给出诚实的 feasibility 判断，而不是只列术语

### Phase 5：研究级支线选择

只有当前四阶段稳定之后，才考虑更高风险主题：

- `anyon condensation`
- `Drinfeld center` 到 doubled phase 的更强桥接
- Wen 早期“拓扑序定义层”文章的定向 formalization
- `topological entanglement entropy`

这一阶段的原则是：

- 只做少量代表性问题
- 不把整条研究前沿都拉进来
- 每次只开一个高风险支线

## 文章与主题优先级

### 第一优先级：结构最干净、最靠近现有 toy 的题目

- 交换方向
- 双编织 / monodromy
- 闭合 worldline 振幅
- 左右闭合与左右迹候选
- cyclicity / sliding

理由：
- 它们最接近现有 sandbox
- 已有 bridge，可连续推进
- 容易形成可重复模板

### 第二优先级：最小具体模型

- `Z2拓扑序`
- `toric code`

理由：
- 它们是拓扑序里最适合第一批结构化 formalization 的样板
- 既不只是抽象范畴，也不需要一上来背完整物理系统

### 第三优先级：string-net 与中心语言

- `string-net`
- `Drinfeld center`

理由：
- 这是把“局域输入”与“编织输出”接起来的自然桥
- 但比 `Z2 / toric code` 更适合放在第二轮，而不是第一刀

### 第四优先级：Wen 1989/1990 定义层文章

理由：
- 概念上最重要
- 但形式化难度高，不适合当第一批样板
- 应该等前面的结构层、模型层、article-slice 机制成熟后再进

### 暂缓优先级：纠缠熵、K 矩阵、FQH 有效理论

理由：
- 这些题目重要，但更依赖量子信息线、场论线或连续模型语言
- 目前不应抢在 category / model 支线之前

## 未来 12 周的推荐焦点

如果按“长期眼光但不失推进感”的标准，未来一轮最值得做的是：

1. 先补复现能力，而不是继续堆 toy。
2. 写一份“物理命题如何翻成 Lean 命题”的 translation contract。
3. 把 `Z2 / toric code` 选成第一批 canonical model。
4. 用它产出第一条 article-slice 模板。
5. 只有在这之后，才评估是否值得正式开 `pivotal / ribbon / fusion` 支线。

## 需要新增的 durable 文档

为避免以后重复摸索，长期建议至少维持下面几类文档：

- [Lean 能力补齐清单](lean-capability-buildout-checklist.md)
  - 记录能力缺口、完成标准与优先级
- [Lean 第一阶段 12 周执行计划](lean-first-phase-12-week-plan.md)
  - 记录当前执行窗口的节奏与 gate
- [Lean 构建与恢复说明](lean-build-recovery-note.md)
  - 记录当前 sandbox 的新鲜构建状态与恢复顺序
- [Lean 翻译合同](lean-translation-contract.md)
  - 记录物理语句到 Lean 工件的翻译规则
- [Lean article slice 选择准则](lean-article-slice-rubric.md)
  - 记录第一批文章切片的筛选标准
- [Lean 能力图谱](lean-capability-map.md)
  - 记录现有 `.lean` 文件分别覆盖什么，以及当前哪些判断仍待源文件恢复后重核
- [第一 canonical model 选择说明](lean-first-canonical-model-choice.md)
  - 固定第一批模型层优先级，避免后面反复改选题
- [第一 article slice 选择说明](lean-first-article-slice-selection.md)
  - 固定第一刀切哪一条命题链，避免后面反复改切法

这三类文档的作用不是增加文档数量，而是降低未来 restart 成本。

## 风险与暂停条件

当出现下面任一情况时，应暂停扩展高层目标，先回头补能力：

- `lake build` 不可复现
- 新的 Lean 文件无法明确挂回知识库主线
- article slice 仍然依赖大量口头解释，无法切成机器可检命题
- 高层术语已经开始增长，但底层接口仍然不稳定
- 证明工作开始反复卡在“其实缺的是翻译规约”

## 长远成功标准

### 1 年内

- sandbox 稳定
- 现有 toy 结构被整理成连续主线
- `Z2 / toric code` 至少形成一条标准样板
- 至少完成 1 个 article slice

### 2 年内

- article slice 不再是孤例，而形成一个小组合
- 能明确区分 structural lane 与 model lane
- 可以诚实地评估 `pivotal / ribbon / fusion` 哪条值得继续

### 3 年内

- 知识库具备一条真正 durable 的 Lean 支线
- 后续若再碰 Wen、string-net、anyon condensation 等主题，不需要重头搭环境与语言
- 形式化不再只是“附属实验”，而成为知识库里一个可复用的长期支撑层

## 当前推荐决策

如果现在只允许做一个默认选择，我建议是：

- 第一条 canonical model 选 `Z2拓扑序 / toric code`
- 第一批 article slice 选“最靠近 monodromy / worldline / toric code 的结构化命题链”
- Wen 1990 留到第二轮之后

这条路线的好处是：

- 最符合现有 sandbox 的积累
- 最容易形成复用模板
- 既有长期价值，也不会在第一步就把风险拉满
