# Lean 构建与恢复说明

## 目的

这份文档记录 `archive/lean-sandbox/` 当前可观察到的构建状态、失败层级与恢复顺序。

它不是“曾经 build 过”的历史回忆，而是面向未来复现的运行说明。

在本仓库里，当前文件系统现实比旧文档更优先。
因此如果本说明与旧的 `README.md` 或 `lean-sandbox-plan.md` 冲突，以当前文件系统与新鲜命令输出为准。

## 适用范围

- `archive/lean-sandbox/`
- `lakefile.lean`
- `lean-toolchain`
- `.lake/packages/*`
- `TopoOrder.lean` 与其预期导入的 `TopoOrder/*.lean`

## 当前观测时间

- 本说明基于 2026-04-23 的现场检查。

## 当前现场结论

当前 `lean-sandbox` 的主 blocker 不是 theorem 设计，而是工作树不完整。

更准确地说，当前至少有两层 blocker：

1. `TopoOrder/` 源文件目录缺失。
2. `.lake/packages/mathlib` 处于大面积删除状态。

因此当前不能把这套 sandbox 视为“只差联网拉依赖就能继续 build”的状态。

## 新鲜证据

### 1. `lake build` 的当前失败点

在 `archive/lean-sandbox/` 下运行：

```powershell
& $env:USERPROFILE\.elan\bin\lake.exe build
```

本轮返回的核心错误是：

- `no such file or directory`
- `file: ...\\TopoOrder\\Basic.lean`

这说明当前 build 首先卡在本地缺文件，而不是卡在 Lean 内部证明失败。

### 2. 聚合入口文件存在，但它导入的子模块目录缺失

当前 `TopoOrder.lean` 仍然存在，并显式导入：

- `TopoOrder.Basic`
- `TopoOrder.MonoidalBridge`
- `TopoOrder.BraidedBridge`
- `TopoOrder.CenterBridge`
- `TopoOrder.BraidedRigidBridge`
- `TopoOrder.BraidedDualityToy`
- `TopoOrder.BraidedMonodromyToy`
- `TopoOrder.BubbleAmplitudeToy`
- `TopoOrder.BubbleAgreementToy`
- `TopoOrder.BubbleOrientationToy`
- `TopoOrder.BubbleSlidingToy`
- `TopoOrder.LeftRigidBridge`
- `TopoOrder.RigidBridge`
- `TopoOrder.RigidToy`
- `TopoOrder.StringNetToy`
- `TopoOrder.TraceOrientationToy`
- `TopoOrder.TraceAgreementToy`
- `TopoOrder.TraceCyclicityToy`

但当前目录检查显示：

- `TopoOrder.lean` 存在
- `TopoOrder/` 子目录不存在

因此当前最直接的失败不是 import 名拼错，而是被导入文件整体不在工作树里。

### 2.5. git 历史里并没有 `TopoOrder/` 源文件树

本轮进一步检查：

```powershell
git ls-tree -r --name-only HEAD -- archive/lean-sandbox
git ls-tree -r --name-only a4ae64f -- archive/lean-sandbox
git log --all --full-history --name-status -- archive/lean-sandbox/TopoOrder
```

结果显示：

- 当前 `HEAD` 下，`archive/lean-sandbox/` 只有 5 个文件：
  - `README.md`
  - `TopoOrder.lean`
  - `lake-manifest.json`
  - `lakefile.lean`
  - `lean-toolchain`
- 唯一相关提交 `a4ae64f` 也是这 5 个文件
- git 历史里没有 `archive/lean-sandbox/TopoOrder/Basic.lean` 或整个 `TopoOrder/` 子目录的记录

这说明当前问题不是“这些源码曾经进入仓库、后来又被删掉”，而是它们看起来从来没有被正式 commit 进当前 repo。

### 3. GitHub 连通性在本轮不是主 blocker

本轮执行：

```powershell
git ls-remote https://github.com/leanprover-community/plausible
```

成功返回远端 refs。

这说明：

- “完全连不上 GitHub”不是本轮主问题
- 之前出现过的网络不稳定可以视为历史风险，但不是现在最先要解决的失败层

### 4. `.lake/packages` 当前并不完整

当前 `.lake/packages` 下能看到的目录是：

- `aesop`
- `batteries`
- `Cli`
- `importGraph`
- `LeanSearchClient`
- `mathlib`

而 manifest 中还列出了：

- `plausible`
- `proofwidgets`
- `Qq`

这说明当前 package state 处于一种“部分存在、部分刚开始补拉、整体不稳定”的状态。

### 5. `mathlib` 不是轻微 dirty，而是大面积删除

当前执行：

```powershell
git -C '.lake\\packages\\mathlib' status --short
```

返回的是大面积 `D` 状态，而不是少量噪声文件变动。

统计结果：

- `deleted_count=8222`

这说明当前 `.lake/packages/mathlib` 很可能本身也是不完整工作树，而不只是“有一点本地修改”。

### 6. 当前 build 痕迹指向旧路径 `13-拓扑序学习库`

本轮检查 `setup.json` 与 `.trace` 时，出现了一个关键线索：

- `archive/lean-sandbox/.lake/build/ir/TopoOrder/*.setup.json`
- `archive/lean-sandbox/.lake/build/lib/lean/TopoOrder/*.trace`

里面记录的实际编译路径不是当前的 `14-拓扑序学习库`，而是：

- `D:\\BaiduSyncdisk\\code\\OB_NOTE\\MY NOTE\\13-拓扑序学习库\\archive\\lean-sandbox\\...`

尤其像：

- `TopoOrder.BraidedMonodromyToy`
- `TopoOrder.BubbleSlidingToy`
- `TopoOrder.TraceAgreementToy`

这些模块的 `setup.json` / `.trace` 都明确引用了旧路径下的 `.olean` 或 `.lean`。

这说明当前 `14` 目录里的 `.lake/build` 更像是**从旧路径遗留/迁移过来的构建痕迹**，而不是在当前工作树里完整重建出来的产物。

### 7. `.gitignore` 不是导致源码缺席的直接原因

当前 `.gitignore` 主要忽略的是：

- `.lake/`
- `build/`
- `.lean/`

并没有专门忽略：

- `archive/lean-sandbox/TopoOrder/`
- `*.lean`

因此不能把“源码没进仓库”简单归因于 `.gitignore`。

### 8. 旧路径现在也只剩残留壳，不是完整恢复源

进一步检查：

- `D:\\BaiduSyncdisk\\code\\OB_NOTE\\MY NOTE\\13-拓扑序学习库` 仍然存在
- 但它当前只有 `archive/lean-sandbox/.lake/`
- 也没有现成的 `archive/lean-sandbox/TopoOrder/` 源文件树

因此旧路径提供的是**来源线索**，不是现成恢复副本。

### 9. 当前 `.olean` 还不能直接作为声明勘探底座

本轮做了一个不落文件的 import smoke：

```powershell
import TopoOrder.TraceAgreementToy
#check TraceAgreementCategory
#check traceScalar
```

结果没有直接卡在 `TopoOrder.TraceAgreementToy.olean` 自己，而是报：

- `Mathlib.CategoryTheory.Monoidal.Category.olean` does not exist

这说明：

- 当前 `TopoOrder/*.olean` 虽然存在
- 但它们依赖的 `mathlib` build 产物层也已经不完整

因此现在不能把现有 `.olean` 视为“已经可用的声明级恢复底座”。
它们仍然有线索价值，但还不够支撑稳定的 declaration-level introspection。

### 10. 当前连非破坏性的 cache 恢复都过不去

本轮进一步测试：

```powershell
& $env:USERPROFILE\.elan\bin\lake.exe exe cache get
```

没有进入正常的 cache 补全流程，而是直接报：

- `Cache/Main.lean` does not exist

路径是：

- `.lake/packages/mathlib/Cache/Main.lean`

这说明当前 `mathlib` 的问题不是“少几个 build 产物”，而是 package 工作树本身已经不完整到无法正常运行 cache 工具。

因此当前 package 层状态应理解为：

- **源码树损坏**
- 而不只是 **编译缓存缺失**

### 11. 即使补齐健康 package 层，当前 `TopoOrder/*.olean` 仍不可直接导入

本轮又做了一个更强的 smoke：

- 在临时目录中成功拉起健康 package 层
- `mathlib/Cache/Main.lean` 存在
- `lake exe cache get` 成功完成

随后把当前 `14-拓扑序学习库` 下的 `TopoOrder/*.olean` 接到这套健康 package 层上做导入测试：

```powershell
import TopoOrder.TraceAgreementToy
#check TraceAgreementCategory
#check traceScalar
```

结果报错：

- `TraceAgreementToy.olean` `incompatible header`

这说明当前限制又前进了一步：

- 问题不只是 package 层坏
- 当前 `TopoOrder` 编译产物自身也不能被当成稳定可导入工件

因此目前真正还可信的 artifact 线索，主要剩下：

- `TopoOrder.lean`
- `.trace`
- `setup.json`
- 文档中的职责描述

## 当前失败层级排序

按优先级排序，当前最真实的 blocker 是：

### Blocker 1：`TopoOrder/` 本地源文件缺失

这是当前第一层问题。
只要这一层不解决，继续讨论 theorem 设计、mathlib 版本升级、甚至 package 完整性，都不会直接恢复 build。

### Blocker 2：`.lake/packages/mathlib` 工作树异常

即使 `TopoOrder/` 源文件被恢复，如果 `mathlib` 仍然处于 8000+ 删除状态，后续构建也高度可疑。

### Blocker 3：依赖抓取与网络稳定性

这一层仍值得记住，但它在本轮已经退居次要。
当前不应再把“网络可能有问题”误判为唯一原因。

### Blocker 4：sandbox 迁移不完整

基于本轮新证据，一个更接近根因的说法是：

- 当前 `14-拓扑序学习库` 中的 Lean sandbox 很可能只迁入了
  - 聚合入口
  - toolchain / manifest
  - 旧的 build 痕迹
- 但没有把 `TopoOrder/` 源文件树一起形成正式、可恢复的 repo 状态

这意味着后续恢复工作应当按“迁移残缺”来处理，而不是按“普通 build 失败”来处理。

### Blocker 5：artifact salvage 目前也受 package 损坏限制

即使暂时不恢复源码、只想先利用 `.olean/.trace` 做声明级勘探，也会立刻遇到：

- `mathlib` `.olean` 缺失

所以当前恢复链路里，package 层损坏不仅影响 build，也限制了“先从编译产物反推源码”的可行性。

### Blocker 6：非破坏性 package rehydrate 当前无效

本轮已经验证：

- `lake exe cache get` 也会因为 `mathlib/Cache/Main.lean` 缺失而失败

所以当前不能把“先跑一遍 cache get”当成现实的 package 修复路线。

### Blocker 7：现有 `TopoOrder` `.olean` 可能已损坏或不可兼容

即使在独立临时目录中把 package 层恢复到健康状态，当前 `TopoOrder/*.olean` 仍然报：

- `incompatible header`

因此当前 Option B 的可用资产应降级理解为：

- 主要可用于模块名、依赖关系、旧路径来源线索
- 不能默认可用于声明级导入与直接 `#check`

## 对旧文档状态的修正

下面这些说法应暂时视为历史性状态，而不是当前真相：

- “本目录下的 bridge 与 toy 文件可以通过 `lake build`”
- “`TopoOrder/*.lean` 已经在当前工作树里可直接 build”

这些说法可能曾经成立，但当前文件系统现实已经不支持直接沿用。

因此：

- `lean-sandbox-plan.md` 更适合看作“曾验证过的目标形态与计划说明”
- 本文才是当前恢复工作的起点说明

## 推荐恢复顺序

### Step 1：先恢复 `TopoOrder/` 源文件树

优先检查：

- 它是否仍在 git 历史里
- 是否在另一台机器或旧工作树里存在
- 是否在 Obsidian / 同步空间历史中可恢复
- 是否只是在当前工作树中遗漏，而并非真正删除

目前这一组检查已经部分完成，结论是：

- 不在当前 repo 的 git 历史里
- 当前 `13` 路径也没有现成副本
- 但 build 痕迹强烈表明它曾在 `13-拓扑序学习库` 路径下真实存在过

因此下一步最应优先争取的是：

- 同步盘历史版本
- 旧机器或旧工作树
- 任何离线备份/导出副本

在确认这一步之前，不建议先升级 toolchain，也不建议先调 theorem。

### Step 2：确认恢复后的源树与 `TopoOrder.lean` 导入列表一致

最少要对齐：

- `Basic.lean`
- `MonoidalBridge.lean`
- `BraidedBridge.lean`
- `CenterBridge.lean`
- `LeftRigidBridge.lean`
- `RigidBridge.lean`
- `BraidedRigidBridge.lean`
- `BraidedDualityToy.lean`
- `BraidedMonodromyToy.lean`
- `BubbleAmplitudeToy.lean`
- `BubbleAgreementToy.lean`
- `BubbleOrientationToy.lean`
- `BubbleSlidingToy.lean`
- `TraceOrientationToy.lean`
- `TraceAgreementToy.lean`
- `TraceCyclicityToy.lean`
- `RigidToy.lean`
- `StringNetToy.lean`

### Step 3：再判断 `.lake/packages/mathlib` 是否需要重建

如果源树恢复后，`mathlib` 仍然保持大面积删除状态，就应当把 package layer 视为第二层恢复对象。

更稳妥的原则是：

- 先确认缺的不是本仓库自有源文件
- 再判断 `.lake` 是否需要整体重建

### Step 3.5：不要把旧 build 痕迹当成可恢复源码

当前 `.trace` 与 `setup.json` 很有价值，因为它们能提供：

- 旧路径线索
- 模块名
- 依赖顺序

但它们不等于源码本身。

因此：

- 可把它们用作“恢复线索”
- 不应把它们误当成“已经足够恢复完整 Lean 项目”

### Step 3.6：在走 artifact-guided 恢复前，先确认 package 层是否可读

如果后续要走“build 痕迹引导恢复”路线，还需要额外确认：

- `mathlib` 及依赖包的 `.olean` 层是否可恢复到可导入状态

否则即使 `TopoOrder/*.olean` 还在，也难以稳定利用它们做更细的声明级勘探。

### Step 3.6.5：再确认 `TopoOrder` `.olean` 自身是否可读

即使 package 层恢复成功，也还要额外确认：

- `TopoOrder/*.olean` 本身没有 header 损坏或兼容性问题

当前这一步已经给出负面结果，因此后续 artifact-guided 恢复要默认以：

- `trace/setup/json + 文档说明`

为主，而不是以 `.olean` 反射为主。

### Step 3.7：如果未来要修 package 层，需视为单独恢复动作

当前证据表明：

- package 层本身可能需要 fresh clone / clean rehydrate

这已经不是“顺手补几个缓存文件”的级别，而是单独的恢复动作。

在当前用户边界下，这一步不应被悄悄当作普通小修执行。

### Step 4：恢复后重新执行最小验证

恢复后的最小验证顺序应是：

```powershell
git status --short
Get-ChildItem TopoOrder
& $env:USERPROFILE\.elan\bin\lake.exe build
```

只有重新跑出新的结果，才能更新“当前可构建”的判断。

## 当前不建议做的事

- 不建议现在升级 Lean `v4.28.0 -> 新版本`
- 不建议在缺失 `TopoOrder/` 的状态下继续新增 theorem 文件
- 不建议把当前失败直接归因为网络
- 不建议把旧的“已 build”描述继续当作当前真相
- 不建议把 `.trace/.setup.json` 当作现成源码替代物
- 不建议把当前 `.olean` 误判为“已经可直接做声明恢复的稳定底座”
- 不建议把 `lake exe cache get` 视为当前可行的无痛恢复路线
- 不建议把当前 `TopoOrder/*.olean` 误判为“只要包层健康就能直接导入”

## 恢复完成的最小验收条件

只有当下面条件同时满足时，才可以把 Lane A 视为初步过线：

- `TopoOrder/` 源文件树已恢复
- `mathlib` package 不再处于大面积删除状态
- `lake build` 能重新给出可解释结果
- 恢复步骤已写回知识库

## 与长期路线图的关系

这份说明服务于：

- [Lean 能力补齐清单](lean-capability-buildout-checklist.md) 中的 Lane A：构建复现能力
- [Lean 第一阶段 12 周执行计划](lean-first-phase-12-week-plan.md) 中的 Block 1：环境与真实状态澄清

## 下一步默认动作

如果继续推进，本说明之后最自然的下一步是：

1. 先定位 `TopoOrder/` 缺失文件的恢复来源。
2. 再补一份 [Lean 翻译合同](lean-translation-contract.md)，让后续 formalization 不因语言混乱而继续漂移。

而在本轮新增证据下，这里的“恢复来源”应默认优先理解为：

- 外部历史版本或备份
- 其次才是基于 build 痕迹的半手工重建

更系统的选项比较见：

- [Lean 源码恢复选项](lean-source-recovery-options.md)
