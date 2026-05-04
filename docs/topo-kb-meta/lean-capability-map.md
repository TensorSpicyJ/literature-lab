# Lean 能力图谱

## 目的

这份文档把 `archive/lean-sandbox/` 里已经出现过的 Lean 能力，整理成一张可恢复的 capability map。

它服务三个目的：

- 说明每个 `.lean` 文件理论上负责什么
- 说明它回挂到知识库里的哪个概念节点
- 明确当前哪些判断来自真实源文件，哪些只是来自历史文档与聚合入口

## 重要状态说明

截至 2026-04-23，当前工作树里：

- `TopoOrder.lean` 存在
- `TopoOrder/` 子目录缺失
- `lake build` 当前直接卡在缺 `TopoOrder/Basic.lean`

因此，这份 map 目前是一个 **带证据分层的恢复型地图**，而不是“逐文件重新验收后的最终地图”。

这份文档里的能力条目主要来自三类证据：

1. 当前仍存在的 `TopoOrder.lean` import 列表
2. `archive/lean-sandbox/README.md` 中对各文件职责的说明
3. `lean-sandbox-plan.md` 中的历史性构建与能力说明

此外，本轮还多了一条关键迁移证据：

4. 当前 `.trace` / `setup.json` 指向旧路径 `13-拓扑序学习库`

只要 `TopoOrder/` 源文件树尚未恢复，就不把下面内容误写成“本轮重新核验过的逐文件源码事实”。

## 证据等级

- `E1`: 当前工作树里能直接看到的文件或命令输出
- `E2`: 当前工作树中的历史文档说明
- `E3`: 旧 build 痕迹中的迁移线索
- `E4`: 历史性自述，需要未来重新核验

## 主干分层

当前可以把这条 Lean spine 暂时分成四层：

1. foundation bridges
2. exchange / monodromy toys
3. bubble / closure / trace-like toys
4. model-facing toy

## 模块地图

| Module | Layer | Intended Role | Knowledge-Base Anchor | Evidence | Current Status |
| --- | --- | --- | --- | --- | --- |
| `TopoOrder/Basic.lean` | foundation bridge | `monoidal` 基础入口 | `张量范畴` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/MonoidalBridge.lean` | foundation bridge | 把物理语言压到 `MonoidalCategory` | `张量范畴`、`string-net凝聚` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/BraidedBridge.lean` | foundation bridge | 把交换/编织语言压到 `BraidedCategory` | `编织张量范畴`、`任意子` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/CenterBridge.lean` | foundation bridge | 提供 `Drinfeld center` 入口 | `Drinfeld中心`、`string-net凝聚` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/LeftRigidBridge.lean` | foundation bridge | 左对偶、左向 cup/cap、left adjoint mate | `刚性张量范畴` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/RigidBridge.lean` | foundation bridge | 右对偶、cup/cap、adjoint mate | `刚性张量范畴` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/BraidedRigidBridge.lean` | foundation bridge | braided 与单侧 rigid 间的桥 | `编织张量范畴`、`刚性张量范畴` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/BraidedDualityToy.lean` | exchange toy | “生成 pair、交换一次、再湮灭” | `交换统计的定向性` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/BraidedMonodromyToy.lean` | exchange toy | pair monodromy 与 monodromy bubble | `双编织` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/BubbleAmplitudeToy.lean` | bubble/trace toy | 局域态射闭合成 `𝟙 ⟶ 𝟙` 的最小 bubble 振幅 | `闭合世界线振幅` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/BubbleAgreementToy.lean` | bubble/trace toy | `left/right closure` 一致性接口 | `左右闭合一致性` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/BubbleOrientationToy.lean` | bubble/trace toy | 左右两种 identity bubble 的拆分 | `左右闭合振幅` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/BubbleSlidingToy.lean` | bubble/trace toy | 插入如何滑到对偶腿，形成 cyclicity 前驱 | `对偶传输`、`闭合振幅的循环性` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/TraceOrientationToy.lean` | bubble/trace toy | `f : X ⟶ X` 的 left/right trace-like 候选 | `左右迹候选` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/TraceAgreementToy.lean` | bubble/trace toy | `TraceAgreementCategory` 与 `traceScalar` | `左右迹候选`、`左右闭合一致性` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/TraceCyclicityToy.lean` | bubble/trace toy | trace-like cyclicity 的最小版本 | `闭合振幅的循环性`、`左右迹候选` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/RigidToy.lean` | duality toy | 从粒子/反粒子图像出发的最小 duality toy | `刚性张量范畴`、`任意子` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |
| `TopoOrder/StringNetToy.lean` | model-facing toy | 从 `string-net` 概念卡翻译出的第一 toy formalization | `string-net凝聚` | `E1+E2+E3` | 当前工作树缺失源文件；旧 build 痕迹表明它曾存在 |

## 当前最可信的能力判断

在不重新看到每个源文件的前提下，当前最可信的判断是：

### 已经明确存在过的能力层

- `monoidal` 入口层
- `braided` 入口层
- `center` 入口层
- rigid / duality 入口层
- exchange / monodromy toy 层
- bubble / closure / trace-like toy 层
- `string-net` 的第一 toy formalization

### 还不能声称已经稳定存在的能力层

- `pivotal`
- `spherical`
- `ribbon`
- `fusion category`
- `modular tensor category`
- `anyon condensation`
- 完整 canonical model 层

## 当前能力边界

基于现有证据，当前 Lean 支线最合理的边界应写成：

- 已经能够组织 `monoidal -> braided -> rigid -> center`
- 已经能够把 exchange / monodromy / bubble / trace-like 的最小关系写成 toy
- 尚不能诚实地说已经进入完整高层拓扑序结构
- 尚没有恢复出可直接重编译的当前源码工作树
- 当前源码恢复更像“迁移残缺后的恢复问题”，而不是普通 build 失败

## 对知识库主线的意义

这张图谱说明：

- `concepts/` 中范畴论支撑层不是空想，它已经有过 Lean 落点
- 但这些落点当前应被视为“待恢复、待复核的真实支线”，不是本轮已经重新 build 通过的现成基线

## 当前最自然的下一步

能力图谱写出之后，下一步不该再泛泛说“Lean 这边已经有不少东西”。
更准确的默认动作是：

1. 先恢复 `TopoOrder/` 源文件树。
2. 源文件树恢复后，逐项把上表里的 `Current Status` 从“缺失源文件”改成“已重见源码 / 已重新 build / 仍待核验”。

## 相关文档

- [Lean 构建与恢复说明](lean-build-recovery-note.md)
- [Lean 能力补齐清单](lean-capability-buildout-checklist.md)
- [Lean Sandbox Plan](lean-sandbox-plan.md)
