# literature-lab weekday pipeline
# Called by Windows Task Scheduler: literature-lab-weekday
$claude = "C:\Users\TaiS\.local\bin\claude.exe"
$prompt = @'
在 literature-lab 项目里（D:\playground\literature-lab），按 config/topics.json 跑 thesis 和 core 线全流程：search → filter → analyze → correlate → deposit。跳过 interest 线。产出落到 D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\。结束后更新 state/search-log.json 和 state/pipeline-status.json。最后跑 D:\playground\literature-lab\scripts\feishu-push.ps1 推送日报到飞书。
'@
& $claude -p $prompt --add-dir D:\playground --add-dir "D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库" --permission-mode auto --no-session-persistence
