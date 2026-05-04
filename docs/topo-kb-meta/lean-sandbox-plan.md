# Lean Sandbox Plan

## Goal

给这个拓扑序学习库配一个真实可运行的 Lean / mathlib 试验环境，用来建立：

`物理语言 -> 范畴论语言 -> Lean 语言`

这条桥接能力，而不只是停留在“知道有哪些库”。

## Why A Sandbox

- 本仓库的主结构仍然是 `concepts/`、`papers/`、`roadmap/`、`relations/` 这套知识网络
- Lean 工程会带来 `.lake/`、build 缓存、toolchain 与实验代码，不适合直接摊在知识库主目录里
- 因此更稳的方案是把形式化工作收束在 `archive/lean-sandbox/`

## Verified Status

截至 2026-03-25，已经确认：

- `elan`、`lean`、`lake` 可在本机使用
- `archive/lean-sandbox/` 已经是一个真实的 Lean 项目
- 下面这些 mathlib 入口已经通过本地编译验证：
  - `Mathlib.CategoryTheory.Monoidal.Category`
  - `Mathlib.CategoryTheory.Monoidal.Braided.Basic`
  - `Mathlib.CategoryTheory.Monoidal.Center`
  - `Mathlib.CategoryTheory.Monoidal.Rigid.Basic`
  - `Mathlib.CategoryTheory.Monoidal.Rigid.Braided`
- 本项目自己的 bridge / toy 文件已经可以通过 `lake build`：
  - `TopoOrder/Basic.lean`
  - `TopoOrder/MonoidalBridge.lean`
  - `TopoOrder/BraidedBridge.lean`
  - `TopoOrder/CenterBridge.lean`
  - `TopoOrder/LeftRigidBridge.lean`
  - `TopoOrder/RigidBridge.lean`
  - `TopoOrder/BraidedRigidBridge.lean`
  - `TopoOrder/BraidedDualityToy.lean`
  - `TopoOrder/BraidedMonodromyToy.lean`
  - `TopoOrder/BubbleAmplitudeToy.lean`
  - `TopoOrder/BubbleAgreementToy.lean`
  - `TopoOrder/BubbleOrientationToy.lean`
  - `TopoOrder/BubbleSlidingToy.lean`
  - `TopoOrder/TraceOrientationToy.lean`
  - `TopoOrder/TraceAgreementToy.lean`
  - `TopoOrder/TraceCyclicityToy.lean`
  - `TopoOrder/RigidToy.lean`
  - `TopoOrder/StringNetToy.lean`

## Current Project Files

- `archive/lean-sandbox/lakefile.lean`
- `archive/lean-sandbox/lake-manifest.json`
- `archive/lean-sandbox/lean-toolchain`
- `archive/lean-sandbox/TopoOrder.lean`
- `archive/lean-sandbox/TopoOrder/Basic.lean`
- `archive/lean-sandbox/TopoOrder/MonoidalBridge.lean`
- `archive/lean-sandbox/TopoOrder/BraidedBridge.lean`
- `archive/lean-sandbox/TopoOrder/CenterBridge.lean`
- `archive/lean-sandbox/TopoOrder/LeftRigidBridge.lean`
- `archive/lean-sandbox/TopoOrder/RigidBridge.lean`
- `archive/lean-sandbox/TopoOrder/BraidedRigidBridge.lean`
- `archive/lean-sandbox/TopoOrder/BraidedDualityToy.lean`
- `archive/lean-sandbox/TopoOrder/BraidedMonodromyToy.lean`
- `archive/lean-sandbox/TopoOrder/BubbleAmplitudeToy.lean`
- `archive/lean-sandbox/TopoOrder/BubbleAgreementToy.lean`
- `archive/lean-sandbox/TopoOrder/BubbleOrientationToy.lean`
- `archive/lean-sandbox/TopoOrder/BubbleSlidingToy.lean`
- `archive/lean-sandbox/TopoOrder/TraceOrientationToy.lean`
- `archive/lean-sandbox/TopoOrder/TraceAgreementToy.lean`
- `archive/lean-sandbox/TopoOrder/TraceCyclicityToy.lean`
- `archive/lean-sandbox/TopoOrder/RigidToy.lean`
- `archive/lean-sandbox/TopoOrder/StringNetToy.lean`

## What The Current Version Does

- 把 string-net 这一线先落到 `MonoidalCategory`
- 把 non-Abelian anyon / braiding 这一线先落到 `BraidedCategory`
- 把 doubled phase / Drinfeld center 这一线先落到 `Center`
- 把 duality、反粒子、evaluation / coevaluation 落到 `RigidCategory` 的左右对偶接口
- 把 braided + 单侧 rigid 自动升级为双侧 rigid 的桥显式写成 Lean 定理
- 把“生成 pair、交换一次、再湮灭”的最小闭环过程写成 Lean 里的 toy 态射，并在 symmetric 极限下比较顺/逆时针交换
- 把 `β_(X,X*) ≫ β_(X*,X)` 组织成 pair monodromy，并把“插入一次完整 monodromy 再湮灭”的 bubble 写成 Lean toy
- 在 symmetric 极限下，证明 pair monodromy 退化为恒等，monodromy bubble 退化回普通 pair bubble
- 把对象线上的 endomorphism `f : X ⟶ X` 闭合成 bubble amplitude `𝟙_ C ⟶ 𝟙_ C`
- 证明 identity bubble 与 plain pair bubble / clockwise exchange loop 对齐，并在 symmetric 极限下把 monodromy-decorated bubble 压回 identity bubble
- 把“left / right closure 相等”包装成自定义最小结构 `ClosureAgreementCategory`，并在其上定义 `closureScalar`
- 把 left / right closure 两种最自然的 identity bubble 分别定义出来，并看清它们什么时候才会相等
- 把任意 endomorphism `f : X ⟶ X` 的闭合振幅进一步拆成 `leftTraceBubble` / `rightTraceBubble` 两个方向版本，并看清 identity closure 只是它们在 `f = 𝟙_X` 的特例
- 在 symmetric 极限下，证明 left / right trace candidates 一致；再把这种一致性打包成自定义最小结构 `TraceAgreementCategory`，并在其上定义 `traceScalar`
- 把已有的 `compositeBubble_cyclic` 重新翻译成 `rightTraceBubble` 的 cyclicity，并在 `TraceAgreementCategory` 下进一步推广成 `leftTraceBubble` 与 `traceScalar` 的 cyclicity
- 证明同一个闭合 bubble 里的局域插入可以通过 dual transport 从粒子腿滑到对偶腿，因此得到当前最小的 trace-like 滑移性质
- 把二步过程 `X --f--> Y --g--> X` 的 bubble 显式改写成对偶腿上的 `g*` 再 `f*`，把“反序滑移”固定成可复用 toy 接口
- 进一步证明 `compositeBubble C f g = compositeBubble C g f`，把最小 cyclicity 真正落成 Lean 定理

## What The Current Version Does Not Do

- 还没有把 `fusion category -> modular tensor category -> anyon condensation -> topological order` 整条链完整形式化
- 还没有承诺把具体拓扑序模型直接写成现成 Lean 主模块
- 当前版本的目标是“把基础结构层真的跑通”，而不是“假装已经有完整拓扑序库”

## Proven Workflow On This Machine

在 `archive/lean-sandbox/` 目录中运行：

```powershell
& $env:USERPROFILE\.elan\bin\lake.exe build
```

如需刷新依赖，则运行：

```powershell
& $env:USERPROFILE\.elan\bin\lake.exe update
```

本机上需要额外注意：

- 首次在 `D:\BaiduSyncdisk\...` 这种同步目录里抓取较大体积 GitHub 依赖时，`git fetch` 或 `lake update` 可能被同步程序或网络状态打断
- 一旦 `.lake/packages` 与 `mathlib` cache 预热完成，这个 sandbox 就进入可稳定增量使用的状态
- 在本机上，缓存预热后的再次 `lake build` 已经验证可以快速完成

## Immediate Next Lean Tasks

1. 往 braided-rigid 之后继续推进，但不预设 `fusion / modular / ribbon / pivotal` 在 mathlib 里已有成熟现成层；先辨认哪些接口可直接复用、哪些需要自建最小桥
2. 在 `TraceOrientationToy.lean`、`TraceAgreementToy.lean`、`TraceCyclicityToy.lean` 与 `BubbleSlidingToy.lean` 的基础上继续推进，重点辨认：从“左右迹候选是否一致”与“最小 cyclicity”共同出发，还差哪些额外数据才能诚实过渡到更标准的 `pivotal / spherical / ribbon` 语言
3. 在 `concepts/` 与 `papers/` 中继续把“编织、刚性、monodromy、闭合 worldline、左右迹候选、中心、凝聚”的概念链和 Lean 落点对齐

## Connection Back To The Knowledge Base

- [张量范畴](../concepts/张量范畴.md) 对应 `MonoidalCategory`
- [编织张量范畴](../concepts/编织张量范畴.md) 对应 `BraidedCategory`
- [刚性张量范畴](../concepts/刚性张量范畴.md) 对应 rigid 结构
- [左右迹候选](../concepts/左右迹候选.md) 对应当前 braided-rigid 阶段的 left / right trace-like candidates
- [Drinfeld中心](../concepts/Drinfeld中心.md) 对应 `Center`
- [string-net凝聚](../concepts/string-net凝聚.md) 是“模型输入怎样映射到范畴结构”的第一张主线卡
- [非阿贝尔任意子](../concepts/非阿贝尔任意子.md) 是“编织 / 融合 / 对偶怎样回到物理图像”的第一张主线卡
- [任意子凝聚](../concepts/任意子凝聚.md) 标出当前 Lean 能力边界与中期目标

## References

- [Lean / 范畴论形式化资源](../sources/lean-category-theory-resources.md)
- [Topological Order Master Index](../indexes/master-index.md)
- [Lean Sandbox](../archive/lean-sandbox/README.md)
- [拓扑序 Lean 化长期路线图](lean-formalization-roadmap.md)
