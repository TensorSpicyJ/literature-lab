# Lean 能力补齐清单

## 目的

这份清单把 [拓扑序 Lean 化长期路线图](lean-formalization-roadmap.md) 里提到的能力缺口，拆成可检查的 buildout lanes。

它不是 full implementation plan，也不是逐日任务表。
它的作用是回答：

- 现在到底缺哪些能力
- 每一项能力补到什么程度才算“够用”
- 哪些能力必须先补，哪些可以晚一点补
- 应该留下什么证据，避免以后重复判断

## 使用方式

- 把每个能力 lane 当成一个独立的建设对象
- 每次推进时，不只写“做了什么”，还要写“这一项能力现在是否真正可复用”
- 如果某项 lane 没过完成标准，不要假装已经可以往更高层推进

## 优先级说明

- `Now`: 不补会直接卡住当前 Lean 支线
- `Next`: 不会立刻卡死，但会阻碍第一批 formalization slice
- `Later`: 只有前两层稳定后才值得推进

---

## Lane A：构建复现能力

**Priority:** `Now`

**为什么重要**

当前最实际的风险不是定理太难，而是环境不稳定。
只要 `lake build` 在依赖刷新、缓存失效、或 GitHub 网络抖动时会失真，后面的 formalization 都没有长期可信度。

**当前缺口**

- 新依赖抓取会卡在 GitHub
- `lake build` 不是当前轮次里可稳定复现的流程
- 缺少明确的本地恢复步骤

**完成标准**

- [ ] 能明确区分“环境失败”和“Lean 证明失败”
- [ ] 有固定的 toolchain / dependency pin 策略
- [ ] 有网络异常时的恢复步骤
- [ ] 至少完成一次“从需要拉依赖到成功 build”的可记录复现
- [ ] 相关说明写回知识库，而不只停在聊天里

**应留下的证据**

- 一份 [build / recovery 说明](lean-build-recovery-note.md)
- 一次成功复现的命令记录
- 对依赖失败点的归因说明

**没过线时禁止做的事**

- 不把新的高层结构作为主战场
- 不把失败归咎于 theorem design，除非已排除环境问题

---

## Lane B：formalization spine 归档能力

**Priority:** `Now`

**为什么重要**

当前 sandbox 已经有一串 toy，但还缺少系统化骨架。
如果这层不整理清楚，后面很容易重复写相似接口。

**当前对象**

- `Basic`
- `MonoidalBridge`
- `BraidedBridge`
- `CenterBridge`
- `LeftRigidBridge`
- `RigidBridge`
- `BraidedRigidBridge`
- `BraidedDualityToy`
- `BraidedMonodromyToy`
- `Bubble*`
- `Trace*`
- `StringNetToy`

**完成标准**

- [ ] 每个 `.lean` 文件都有一句清楚的职责定义
- [ ] 每个文件都能说明输入结构和输出结论
- [ ] 已明确哪些文件是 bridge，哪些是 toy，哪些是 candidate reusable interface
- [ ] 已形成依赖顺序，而不是平铺列表
- [ ] 至少有一份 capability map 文档记录这条 spine

**应留下的证据**

- 一份 [capability map](lean-capability-map.md)
- 一份依赖关系说明
- 一份“哪些结论仍是 toy”列表

**没过线时禁止做的事**

- 不大规模扩展高层术语
- 不用孤立 toy 冒充可复用主接口

---

## Lane C：物理到 Lean 的翻译规约

**Priority:** `Now`

**为什么重要**

这条 lane 决定知识库里的物理叙述，怎样诚实地落到 Lean。
没有翻译规约，后面每次 formalize 都会重新争论“这句话到底该怎么写”。

**当前缺口**

- 缺少从 concept card 到 Lean 命题的稳定映射规则
- 缺少“结构 / 命题 / 注释”三类边界
- 缺少 article slice 的筛选标准

**完成标准**

- [ ] 明确区分 structure、theorem、notation note、physics explanation
- [ ] 明确哪些物理定义当前不适合直接 formalize
- [ ] 明确什么样的文章内容算合格 article slice
- [ ] 至少拿一个现有 toy 反推演示这套翻译规则

**应留下的证据**

- 一份 [translation contract](lean-translation-contract.md)
- 一份 [article-slice rubric](lean-article-slice-rubric.md)
- 至少一个示例：概念卡 -> Lean 语句映射

**没过线时禁止做的事**

- 不直接 formalize 高风险定义层文章
- 不把大段物理解释直接转成“似乎像 theorem”的代码壳

---

## Lane D：最小模型层表达能力

**Priority:** `Next`

**为什么重要**

toy 层能说明方向，但不能替代 canonical model。
如果没有最小模型层，formalization 会一直停在“抽象结构很漂亮，但还没碰真实样板”。

**第一批候选**

- `Z2 topological order`
- `toric code`

**完成标准**

- [ ] 能表示最小 anyon 数据
- [ ] 能表示 fusion rules
- [ ] 能表示最小 braiding / monodromy 数据
- [ ] 能把至少一个知识库概念卡和模型层代码一一对应
- [ ] 至少完成一个“模型层而非 toy 层”的 Lean 样板

**应留下的证据**

- 一个模型层命名与数据组织方案
- 一份对应知识库概念卡的映射说明
- 一份 [第一 canonical model 选择说明](lean-first-canonical-model-choice.md)
- 至少一个通过 build 的模型层文件

**没过线时禁止做的事**

- 不过早跳到 `modular tensor category`
- 不把 toy 的成功误判为模型层已经稳定

---

## Lane E：article slice 能力

**Priority:** `Next`

**为什么重要**

真正让 Lean 支线与知识库主线发生长期耦合的，不是单个 toy，而是 article slice。

**完成标准**

- [ ] 能从一篇文章中选出一条适合 formalize 的命题链
- [ ] 能写清楚支撑定义、边界、依赖概念卡
- [ ] 能把该切片挂回 `roadmap/`、`papers/`、`concepts/`
- [ ] 至少完成一个切片样板

**第一批优先来源**

- `Z2 / toric code` 相关文章
- `双编织 / monodromy / closed worldline` 相关概念文
- `string-net` 的局部结构切片

**应留下的证据**

- 一份 [slice selection note](lean-first-article-slice-selection.md)
- 一份 [article-slice rubric](lean-article-slice-rubric.md)
- 一篇成功样板的入口链接

**没过线时禁止做的事**

- 不把整篇文章当作第一批 formalization 单位
- 不先选 Wen 1990 这种高抽象定义层文章当入门样板

---

## Lane F：验证与状态登记能力

**Priority:** `Next`

**为什么重要**

只要没有稳定状态表，后面就会反复问同样的问题：
“这个文件到底已经证明了什么？”

**完成标准**

- [ ] 有一份状态表记录 `.lean` 文件 -> 结论 -> 边界
- [ ] 有一份知识库映射表记录 concept / paper -> Lean 工件
- [ ] 能清楚标出“通过 build”“只存在设计”“等待翻译”“等待模型层”这几类状态

**应留下的证据**

- capability map
- progress board 或状态索引
- 至少一次更新示例

**没过线时禁止做的事**

- 不声称某条线“已经做过”而没有对应文件或状态记录

---

## Lane G：高层结构预备能力

**Priority:** `Later`

**候选主题**

- `pivotal`
- `spherical`
- `ribbon`
- `fusion category`
- `modular tensor category`

**为什么暂时靠后**

这些主题重要，但它们不该抢在构建复现、spine 归档、翻译规约、最小模型层之前。

**完成标准**

- [ ] 至少有一份 feasibility note 说明哪一条值得开
- [ ] 已明确复用现有接口与必须自建的边界
- [ ] 不是因为术语吸引力，而是因为前置能力确实到位才推进

---

## 建议推进顺序

默认顺序：

1. Lane A：构建复现
2. Lane B：spine 归档
3. Lane C：翻译规约
4. Lane D：最小模型层
5. Lane E：article slice
6. Lane F：状态登记
7. Lane G：高层结构预备

说明：

- Lane F 可以从一开始就顺手建，但它真正有价值要等 Lane B-D 有了明确对象之后。
- Lane G 不是被否定，而是被有意推迟。

## 当前默认判断

如果当前只做一个能力闭环，最值得先补的是：

`构建复现 + spine 归档 + 翻译规约`

原因：

- 这三项一旦不稳，后面的所有“模型层”与“文章切片”都会变成脆弱的一次性尝试。
- 这三项一旦稳住，`Z2 / toric code` 的第一批 formalization 就有了真实落地面。
