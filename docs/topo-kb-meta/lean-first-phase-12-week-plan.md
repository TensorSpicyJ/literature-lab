# Lean 第一阶段 12 周执行计划

## 目的

这份文档把 [拓扑序 Lean 化长期路线图](lean-formalization-roadmap.md) 的前段，压缩成未来 12 周的一轮执行窗口。

这不是在 12 周内完成整个拓扑序 Lean 化。
它的目标是：

- 把最关键的基础能力补齐
- 把现有 sandbox 变成可持续支撑后续 formalization 的地基
- 让第一条 `canonical model -> article slice` 链真正启动

## 这一轮的总目标

12 周结束时，至少达到下面状态：

1. Lean sandbox 的构建和恢复路径比现在稳定得多。
2. 现有 toy 文件形成一条清晰的 formalization spine。
3. 有一份明确的 physics-to-Lean translation contract。
4. `Z2 / toric code` 被确立为第一批 canonical model。
5. 至少选定并切开一个 article slice，哪怕还未 fully formalize 完成。

## 本轮不追求

- 不在 12 周内冲完整 `fusion / modular / ribbon` 支线
- 不把 Wen 1990 当成第一批必须 formalize 的文章
- 不用“文档很多”替代真正的环境与结构能力

## 节奏设计

这 12 周分成 4 个三周块，每一块都有一个明确主题。

---

## Block 1：Week 1-3

### 主题

先把环境和真实状态看清，不继续在模糊地基上叠新内容。

### 目标

- 弄清当前 sandbox 的真实构建状态
- 写下依赖刷新与恢复路径
- 明确哪些“曾经 build 过”的说法仍然可信，哪些只是历史状态

### 交付物

- 一份 [build / recovery note](lean-build-recovery-note.md)
- 一次新的本机构建状态记录
- 一份当前失败点清单

### 本块完成标准

- 至少知道当前 build 卡在哪里
- 能区分网络依赖问题、缓存问题、Lean 代码问题
- 有一份面向未来自己的恢复说明

### 如果本块失败

后面所有 formalization 工作都降级为“探索”，不应声称进入稳定推进阶段。

---

## Block 2：Week 4-6

### 主题

整理现有 formalization spine，不继续让 toy 以散点方式增长。

### 目标

- 给现有 `.lean` 文件分层
- 建立职责、依赖、边界三张表
- 把“当前已经有什么”说清楚

### 本块重点文件

- `archive/lean-sandbox/TopoOrder/*.lean`
- `archive/lean-sandbox/README.md`
- 新增 capability map / 状态索引类文档

### 交付物

- 一份 capability map
- 一份 toy / bridge / reusable-interface 分类表
- 一份“哪些结论仍然只是 toy”的边界说明

当前对应文档：

- [Lean 能力图谱](lean-capability-map.md)

### 本块完成标准

- 能对每个主要文件回答三件事：
  - 它输入什么结构
  - 它输出什么结论
  - 它为什么还不是更高层理论

### 本块结束后的收益

到这一步，后面再讨论 `pivotal / ribbon / fusion` 时，不会还是在一堆松散 toy 上空转。

---

## Block 3：Week 7-9

### 主题

补“物理语言 -> Lean 语言”的翻译合同，并选定第一批 canonical model。

### 目标

- 写 translation contract
- 写 article-slice rubric
- 确认 `Z2 / toric code` 是第一批模型

### 为什么这一块放在这里

如果没有 Block 2 的 spine 归档，这里写出来的翻译合同会漂浮。
如果没有这块翻译合同，后面的 article slice 选择会非常不稳。

### 交付物

- 一份 [translation contract](lean-translation-contract.md)
- 一份 [article-slice rubric](lean-article-slice-rubric.md)
- 一份 `Z2 / toric code` 作为 first canonical model 的选择说明

当前对应文档：

- [第一 canonical model 选择说明](lean-first-canonical-model-choice.md)

### 本块完成标准

- 至少能拿一个已有 toy，示范“物理语句如何落成 Lean 命题”
- 至少能说明为什么 `Z2 / toric code` 比 Wen 1990 更适合第一批样板

### 本块结束后的收益

到这一步，formalization 不再只是“看到什么就写什么”，而是开始有统一筛选标准。

---

## Block 4：Week 10-12

### 主题

把第一批模型层与文章切片真正启动，而不是只停留在方法论。

### 目标

- 为 `Z2 / toric code` 建最小模型层组织
- 从一篇相关材料里切出第一条 article slice
- 把这个切片挂回知识库主线

### 第一批默认候选

- `Z2拓扑序`
- `toric code`
- `双编织 / monodromy / closed worldline` 相关切片

### 交付物

- 一个最小模型层文件或文件组设计
- 一份 [first article slice note](lean-first-article-slice-selection.md)
- 一条从 concept card / paper / roadmap 回挂到 Lean 的样板链

### 本块完成标准

- 至少完成一条“不是纯 toy，而是面向 canonical model / article slice”的实际入口
- 即便证明未完全写完，也已经把对象、边界、依赖和验收条件切清楚

### 本块结束后的收益

到 12 周结束时，这条支线就不再只是“有长期愿景”，而是已经形成第一条可继续扩展的执行轨道。

---

## 每周节奏建议

为避免 12 周计划变成口号，建议保持固定节奏：

### 每周固定动作

- 1 次环境/构建检查
- 1 次知识库-Lean 对齐检查
- 1 次状态文档更新

### 每两周固定动作

- 1 次阶段复盘：
  - 哪个能力 lane 真正补上了
  - 哪个 lane 只是写了文档但没形成复用能力

### 每三周固定动作

- 做一次 block closeout，决定是继续推进还是回头补缺口

## 这一轮的关键决策门槛

### Gate 1：Week 3 末

问题：

- 构建复现 lane 是否已经比起点更稳定？

若否：

- Block 2 不应全面展开，应继续停留在环境与恢复层

### Gate 2：Week 6 末

问题：

- sandbox spine 是否已经被系统化表达？

若否：

- 不应急着开模型层；否则后面会建立在模糊对象上

### Gate 3：Week 9 末

问题：

- 是否已经有 translation contract 和 canonical model 选择？

若否：

- Week 10-12 不该贸然开始 article slice

### Gate 4：Week 12 末

问题：

- 是否已经形成第一条真实的 model/article-slice 入口？

若是：

- 下一轮可考虑更明确的 formalization implementation plan

若否：

- 下一轮继续补能力，不要虚报“已经进入高层 formalization”

## 这 12 周最值得防的偏差

### 偏差 1：继续堆 toy

风险：

- 看起来很忙，但没有形成长期骨架

纠偏：

- 每新增一个 toy，都要回答它是否补了某项 capability lane

### 偏差 2：过早追高层名词

风险：

- 把 `fusion / modular / ribbon` 当作进度感来源

纠偏：

- 除非前置 gate 已过，否则这些主题只允许做 feasibility note

### 偏差 3：只写文档不留验证

风险：

- 文档变多，但能力没有真正变稳

纠偏：

- 每个 block 都必须留下至少一份可验证工件

### 偏差 4：把 Wen 1990 当成第一刀

风险：

- 抽象度太高，容易把翻译规约和模型层问题一次性放大

纠偏：

- 第一刀默认坚持 `Z2 / toric code`

## 12 周结束后的默认下一步

如果这一轮按预期完成，下一轮默认进入：

- canonical model 的更实质 formalization
- first article slice 的真正实现
- capability map 与状态登记机制的常态化维护

如果这一轮只完成了一半，也没关系。
但判断标准必须诚实：

- 补上了什么能力
- 哪些还没补上
- 为什么还不能进入更高层 formalization

## 本轮默认结论

这 12 周最重要的不是“证明更多定理”，而是把下面这件事做成：

`sandbox 能稳定复现 + spine 被系统化 + 翻译规约成形 + 第一批模型被选定`

只要这四件事成立，后面的 Lean 化才有真正的长期增长空间。
