# literature-lab enhanced topology pipeline
$claude = "C:\Users\taish\AppData\Roaming\npm\claude.cmd"
$prompt = @'
鍦?literature-lab 椤圭洰閲岋紙D:\playground\literature-lab锛夛紝鎸?config/topology-topics.json 璺戞嫇鎵戝簭绮捐娴佺▼锛歴earch 鈫?filter 鈫?analyze 鈫?correlate 鈫?deposit銆?
鍘婚噸瑕佹眰锛?- 鎼滅储鍓嶅厛璇?state/search-log.json 鍜?state/pipeline-status.json锛屾鏌ュ凡鏈夎褰曪紝璺宠繃宸茶 thesis/core 绠￠亾鍒嗘瀽杩囩殑璁烘枃
- 鎼滅储鍚庢洿鏂?state/search-log.json锛堣拷鍔犳湰娆℃悳绱㈢殑 arXiv ID 鍜屾爣棰橈級

绮捐瑕佹眰锛?- search 鎼滆繎 7 澶╂柊鏂囩尞
- filter 涓ユ牸绛涢€夛紝鍙寫 1-2 绡囨渶鏈変环鍊肩殑锛屼紭鍏?Nature/Science/PRL/PRX/PRB 绛夌骇鍒?- analyze TEX-first锛屾湁 arXiv ID 浼樺厛鎷?TeX 婧愶紝鎻愬彇鏍稿績鍏紡銆佹瀯閫犮€佸畾鐞嗭紝涓嶅仛娉涙硾鎽樿
- correlate 鍏宠仈鍒扮幇鏈夋蹇电┖闂达紙D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-鎷撴墤搴忓涔犲簱\concepts\ 鍜?relations/concept-relations.md锛夛紝鏍囨敞鏂版蹇点€佷慨姝ｆ棫姒傚康銆佹柊澧炲叧绯?- deposit 浜у嚭锛?  - 鏂?鏇存柊姒傚康鍗?鈫?D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-鎷撴墤搴忓涔犲簱\concepts\
  - 璁烘枃绗旇 鈫?D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-鎷撴墤搴忓涔犲簱\papers\
  - 姒傚康鍏崇郴 鈫?D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-鎷撴墤搴忓涔犲簱\relations\concept-relations.md
  - 鍚屾椂鍐欎竴浠芥棩鎶ュ埌 D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-姣忔棩鏂囩尞鐭ヨ瘑搴揬daily\

鐘舵€佹洿鏂拌姹傦細
- 鏇存柊 state/topology-pipeline-status.json锛宱utput_path 蹇呴』鍐欐垚 Windows 璺緞
- 鏇存柊 state/search-log.json

鎸?formal-kb-rules 鏍囧噯锛堝叕寮忎紭鍏堛€佸師瀛愭瀯閫犮€乀eX 鍙拷婧級銆傜粨鏉熷悗璺?D:\playground\literature-lab\scripts\feishu-push.ps1 鎺ㄩ€佹棩鎶ュ埌椋炰功銆?'@
& $claude -p $prompt --add-dir D:\playground --add-dir "D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-姣忔棩鏂囩尞鐭ヨ瘑搴? --add-dir "D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-鎷撴墤搴忓涔犲簱" --permission-mode bypassPermissions --no-session-persistence
