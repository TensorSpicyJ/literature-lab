# literature-lab weekday pipeline
$claude = "C:\Users\taish\AppData\Roaming\npm\claude.cmd"
$prompt = @'
鍦?literature-lab 椤圭洰閲岋紙D:\playground\literature-lab锛夛紝鎸?config/topics.json 璺?thesis 鍜?core 绾垮叏娴佺▼锛歴earch 鈫?filter 鈫?analyze 鈫?correlate 鈫?deposit銆傝烦杩?interest 绾裤€?
鍘婚噸瑕佹眰锛?- 鎼滅储鍓嶅厛璇?state/search-log.json 鍜?state/topology-pipeline-status.json锛屾鏌ュ凡鏈夎褰曪紝璺宠繃宸茶浠讳綍绠￠亾鍒嗘瀽杩囩殑璁烘枃
- 鎼滅储鍚庢洿鏂?state/search-log.json锛堣拷鍔犳湰娆℃悳绱㈢殑 arXiv ID 鍜屾爣棰橈級

浜у嚭瑕佹眰锛?- 浜у嚭钀藉埌 D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-姣忔棩鏂囩尞鐭ヨ瘑搴揬
- 缁撴潫鍚庢洿鏂?state/search-log.json 鍜?state/pipeline-status.json
- 鏈€鍚庤窇 D:\playground\literature-lab\scripts\feishu-push.ps1 鎺ㄩ€佹棩鎶ュ埌椋炰功
'@
& $claude -p $prompt --add-dir D:\playground --add-dir "D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-姣忔棩鏂囩尞鐭ヨ瘑搴? --permission-mode bypassPermissions --no-session-persistence
