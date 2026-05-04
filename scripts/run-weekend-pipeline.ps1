# literature-lab weekend topology pipeline
# Called by Windows Task Scheduler: literature-lab-weekend
$claude = "C:\Users\TaiS\.local\bin\claude.exe"
$prompt = @'
在 literature-lab 项目里（D:\playground\literature-lab），搜拓扑序本周新文献。用 config/topology-topics.json。流程：search → analyze（TEX-first，拉 arXiv TeX 源）→ 更新概念空间。产出：新概念/更新概念卡落到 D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库\concepts\，新论文笔记落到 papers\，概念关系更新到 relations/concept-relations.md。按 14-拓扑序学习库 的 formal-kb-rules 标准（公式优先、原子构造、TeX 可追溯）。只处理近 7 天新文献。结束后跑 D:\playground\literature-lab\scripts\feishu-push.ps1 推送日报到飞书。
'@
& $claude -p $prompt --add-dir D:\playground --add-dir "D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库" --add-dir "D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库" --permission-mode auto --no-session-persistence
