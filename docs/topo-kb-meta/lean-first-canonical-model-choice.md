# 第一 canonical model 选择说明

## 结论

当前默认的第一批 canonical model 选择是：

- `Z2拓扑序`
- `toric code`

而不是：

- `string-net` 作为第一刀
- Wen 1990 作为第一刀

## 为什么要先写这份说明

如果不把“为什么选它”写死，后面每次继续都会重新讨论：

- 是不是应该先 formalize 最重要的定义层文章
- 是不是应该先做更一般的 `string-net`
- 是不是 `Z2 / toric code` 只是太简单，不够有长期价值

这份文档的作用就是把这些问题一次性压清楚。

## 选择标准

这次判断主要用五个标准：

1. 是否贴合当前 Lean spine
2. 是否有最小而明确的有限数据
3. 是否能切出第一批 article slice
4. 是否能回挂到知识库主线
5. 是否能为后面更高层对象铺路

更通用的规则见：

- [Lean article slice 选择准则](lean-article-slice-rubric.md)
- [Lean 翻译合同](lean-translation-contract.md)

## 候选一：`Z2拓扑序`

### 优势

- 已经有成熟概念卡，而且是 `tex-first`
- 形式数据很清楚：
  - `\{1,e,m,\epsilon\}`
  - `e^2=m^2=1`
  - `e\times m=\epsilon`
  - `M_{e,m}=-1`
  - `GSD(T^2)=4`
- 它天然适合先做有限数据层，而不必先扛完整相位定义
- 它能直接连接：
  - `任意子`
  - `拓扑简并`
  - `toric-code模型`

### 风险

- 如果做得太快，容易把 “概念卡已经清楚” 误判成 “Lean 模型层已经简单”

### 结论

它非常适合作为第一批 canonical model lane 的入口对象。

## 候选二：`toric code`

### 优势

- 它把抽象 anyon 数据和具体 commuting-projector 模型接起来
- 已有概念卡明确列出：
  - `A_s`
  - `B_p`
  - `H_0`
  - 基态空间
  - `GSD(T^2)=4`
  - 字符串算符与 `e/m` 激发
- 它是从“定义层拓扑序”进入“可计算模型层”的最佳落点
- 它能让后续 article slice 不只是纯范畴 toy，而开始接近真实样板模型

### 风险

- 如果第一刀就扛全部哈密顿量与动力学语义，仍然会过重

### 结论

它适合和 `Z2拓扑序` 一起组成第一 canonical model lane：

- `Z2拓扑序` 偏有限数据层
- `toric code` 偏模型实现层

## 候选三：`string-net`

### 优势

- 长期杠杆很大
- 与 `Monoidal / Center / StringNetToy` 这条支线天然相连
- 对未来从具体样板走向更一般构造很关键

### 为什么不当第一刀

- 它虽然有明确输入数据和 pentagon 结构，但抽象层比 `Z2 / toric code` 更高
- 第一刀就做它，容易让 formalization 仍然停在高层接口，而没完成从 toy 到 canonical model 的跨越
- 它更适合作为第二轮对象，在 `Z2 / toric code` 样板跑通后再进入

### 结论

重要，但默认排在第二轮。

## 候选四：Wen 1990

### 优势

- 拓扑序命名与框架化的核心原始文献
- 概念地位最高
- 对知识库主线几乎是根节点

### 为什么不当第一刀

- 它主要处在定义层与解释层
- 它依赖：
  - phase 语言
  - LU / long-range entanglement 等更高层语义
  - 对“相”的物理组织方式的更完整对象化
- 这正是当前 translation contract 明确要求暂缓的区域

### 结论

它应当被保留为第二轮之后的高价值对象，而不是第一批 canonical model。

## 当前默认排序

按当前能力层，推荐顺序是：

1. `Z2拓扑序`
2. `toric code`
3. `string-net`
4. Wen 1990

## 第一批建议切法

### Slice A：`Z2` 有限数据切片

建议先切：

- anyon 集合
- fusion 规则
- `M_{e,m}=-1`

这条切片的好处是：

- 最接近有限数据层
- 最容易跟 translation contract 对齐
- 最适合形成第一批 canonical model scaffolding

### Slice B：`toric code` 模型切片

建议第二步切：

- 稳定子 `A_s, B_p`
- 基态空间条件
- `GSD(T^2)=4`

这条切片的作用是：

- 把抽象 `Z2` 数据重新接回具体模型

### Slice C：连接切片

在 A/B 两条切片初步稳定后，再补：

- `e/m` 与字符串算符
- model 与 anyon 数据的最小对应关系

## 这项选择的长期意义

选择 `Z2 / toric code` 作为第一 canonical model，不只是因为它“容易”。

更重要的是它能同时服务三条长期目标：

- 给 toy 层一个真实下游
- 给 article slice 一条低风险入口
- 给后面的 `string-net` 与 Wen 1990 留出更稳的升级路径

## 当前默认下一步

这份选择说明写出后，最自然的下一步是：

1. 在 `lean-capability-map.md` 基础上确认哪些 toy 将为 `Z2 / toric code` 提供上游接口。
2. 再写一份第一 article slice selection note，把 `Z2` 数据切片与 `toric code` 模型切片明确排序。

## 相关文档

- [Lean 翻译合同](lean-translation-contract.md)
- [Lean article slice 选择准则](lean-article-slice-rubric.md)
- [Lean 第一阶段 12 周执行计划](lean-first-phase-12-week-plan.md)

