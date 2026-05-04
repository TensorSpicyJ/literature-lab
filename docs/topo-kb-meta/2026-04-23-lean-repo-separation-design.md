# Lean 仓库拆分设计稿

## 目的

这份设计稿定义 `topological-order-kb` 与新的 `topological-order-lean` 之间的长期分工。

它要解决的不是一个单次 build 错误，而是一个已经暴露出来的结构性问题：

- 同步盘适合长期知识资产
- 但不适合承载 Lean 工程的依赖树、缓存、编译产物与实验性源码工作树

因此，这份设计稿的核心目标是：

- 让知识库继续保持可恢复、可写作、可学习
- 让 Lean 工程进入一个更稳定、更可复现的本地开发环境
- 让两者之间有清晰、低成本、长期可维护的回写关系

## 结论

采用两个独立仓库：

1. `14-拓扑序学习库`
   - 继续作为长期知识库主仓库
   - 继续位于同步盘
2. `topological-order-lean`
   - 作为独立 Lean 工程仓库
   - 不放在同步盘
   - 也维护自己的 GitHub 私有仓库

默认本地路径采用：

- 知识库：
  `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库`
- Lean 工程：
  `D:\Playground\topological-order-lean`

## 为什么要这样拆

### 当前问题不是偶然脏状态，而是介质不匹配

已经确认的现象包括：

- `TopoOrder/` 源文件树缺失
- `.lake/packages/mathlib` 工作树异常
- `.trace` / `setup.json` 指向旧路径
- 旧构建痕迹与当前工作树现实不一致

这些都说明：Lean 工程层放在同步盘目录里，长期风险明显高于普通 Markdown 笔记层。

### 知识库和工程工作树需要不同稳定性模型

知识库需要的是：

- 可读
- 可链接
- 可回写
- 可长期积累

Lean 工程需要的是：

- 可编译
- 可缓存
- 可重建
- 可安全修改依赖与构建目录

这两类需求放在同一目录里，会不断彼此伤害。

## 设计原则

### 1. 单一职责

- `topological-order-kb` 负责知识网络
- `topological-order-lean` 负责形式化工程

### 2. 单点工程真相

所有 Lean 源码、构建、依赖与恢复流程，都以 `topological-order-lean` 为唯一工程真相。

### 3. 阶段性回写，而不是逐 commit 镜像

知识库 repo 不镜像 Lean 工程的小步迭代。
它只接收阶段性、解释层、里程碑级回写。

### 4. 桥接明确

每个重要 Lean 进展，都应能明确回挂到：

- concept card
- paper note
- roadmap 节点

但这种回挂发生在知识层，而不是把 `.lean` 源码直接塞回知识库。

## 两个仓库的职责

## A. `14-拓扑序学习库`

### 保留内容

- `concepts/`
- `papers/`
- `roadmap/`
- `relations/`
- `sources/`
- Lean 路线图、恢复说明、切片选择等解释层文档

### 不再承载的内容

- 正在维护的 `.lean` 源码树
- `.lake/`
- build 缓存
- dependency worktree
- 实验性 theorem/proof 调整

### 角色定位

它仍然是学习主仓库。
Lean 支线在这里的存在方式，是：

- 作为知识结构的一条长期支撑线
- 而不是作为真正跑编译的工程目录

## B. `topological-order-lean`

### 承载内容

- `lakefile.lean`
- `lean-toolchain`
- `.lean` 源文件
- tests / smoke scripts
- build / recovery 文档
- article slice 实现
- canonical model 实现

### 默认目录职责

建议起步结构：

```text
topological-order-lean/
|- TopoOrder/                # Lean 源码
|- docs/                     # 工程设计、恢复、证明状态
|- lakefile.lean
|- lean-toolchain
`- README.md
```

### 角色定位

它是工程真相仓库，不是学习主仓库。
所有“代码到底现在是什么状态”，以这里为准。

## 同步规则

采用：

- Lean 工程单点真相
- 知识库阶段性回写

### Lean repo 里记录什么

- proof 级技术状态
- 依赖/构建问题
- theorem 命名与组织
- article slice 的实现细节
- canonical model 的代码设计

### 知识库 repo 里回写什么

- 选定了哪个 canonical model
- 选定了哪个 article slice
- 哪条概念卡现在有了明确 Lean 落点
- 哪条高层路线的能力边界发生变化
- build/recovery 状态发生阶段变化

### 明确不回写什么

- tactic 微调
- 重命名小改动
- proof script 局部重排
- package/cache 噪声
- 未改变理解边界的普通小修

## 旧 `archive/lean-sandbox/` 的处理方式

当前建议是：

- 将其视为 **历史性残留与线索层**
- 不再把它当作未来长期开发目录

它保留的价值是：

- 文档说明
- 旧模块名
- 旧 build 痕迹
- 恢复线索

它不再承担的角色是：

- 活跃开发
- 稳定构建
- 新 theorem 落地

也就是说：

- `archive/lean-sandbox/` 留在知识库 repo 中
- 但只作为 archive / recovery context
- 新的 Lean 工程从 `topological-order-lean` 开始

## 迁移策略

建议分四步走。

### Phase 1：冻结知识库侧 Lean 工程目录

目标：

- 停止把 `archive/lean-sandbox/` 当作活跃工程
- 明确它是 archive/recovery lane

产物：

- 一份边界说明
- 从路线图链接到新 Lean repo 设计

### Phase 2：创建新 Lean 仓库

目标：

- 在 `D:\Playground\topological-order-lean` 初始化全新 Lean 工程
- 建立 Git 本地仓库
- 建立 GitHub 私有仓库

产物：

- 干净可控的 `lake` 项目
- 不受同步盘干扰的 package/build 环境

### Phase 3：迁移“知识”，不是迁移“损坏状态”

目标：

- 从知识库 repo 迁移的是：
  - 路线图
  - capability map
  - 切片选择
  - translation contract
- 不是把当前损坏的 `.lake` 与残缺工作树直接搬过去

产物：

- 新 Lean repo 的 README / docs 中明确挂接知识库

### Phase 4：重新启动 Lean 支线

目标：

- 在新仓库里从干净环境重新建立：
  - foundation spine
  - canonical model lane
  - article slice lane

默认第一目标仍然是：

- `Z2 / toric code`

## 长期工作流

未来默认工作流：

1. 在知识库里选定问题与切片。
2. 在 Lean repo 里实现与验证。
3. 当理解边界发生变化时，回写知识库。

这意味着两边的节奏不同：

- 知识库是慢变量
- Lean 工程是快变量

## 风险与缓解

### 风险 1：两边信息漂移

缓解：

- 只允许阶段性回写
- 不做逐次镜像
- 每次回写都必须指向 Lean repo 中的明确对象

### 风险 2：知识库看不到工程进展

缓解：

- 在知识库里保留阶段性里程碑页
- 保留到 Lean repo 的清晰入口

### 风险 3：Lean repo 变成孤立工程

缓解：

- 所有 article slice 都必须回挂 concept / paper / roadmap
- 不允许脱离知识库路线独立生长

### 风险 4：试图把旧损坏状态直接搬迁

缓解：

- 明确规定迁移“设计与路线”，不迁移“损坏的工作树状态”

## 默认建议

默认建议不是：

- 修补当前同步盘里的 Lean 工程

而是：

- 让知识库回到知识库角色
- 让 Lean 工程进入新的独立仓库

这是当前最符合长期眼光的选择。

## 需要用户确认后的下一步

这份设计稿确认后，下一步应进入 implementation planning，而不是直接动手。

计划应至少覆盖：

- 新 Lean repo 的初始化步骤
- GitHub 私有仓库建立步骤
- 知识库 repo 中旧 sandbox 的冻结方式
- 两仓之间的链接与回写规则落盘
- 第一批迁入 `topological-order-lean` 的设计文档与切片文档

