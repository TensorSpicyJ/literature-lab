# Engineering Constraints

本文档记录系统搭建过程中踩过的坑和最终形成的工程约束。改配置时参考。

## 定时任务

### 架构

```
Windows Task Scheduler
  └─ "C:\Program Files\Git\bin\bash.exe" -c "/d/playground/literature-lab/scripts/run-*.sh"
       └─ claude -p "中文prompt" --add-dir ...
            └─ search → filter → analyze → correlate → deposit
                 └─ feishu-push.ps1 → 飞书卡片
```

### 为什么用 bash 而不是 PowerShell

- Task Scheduler 环境不加载用户 PATH，找不到 `claude` 命令 → 必须用完整路径 `C:\Users\taish\AppData\Roaming\npm\claude.cmd`
- 含中文的 `.ps1` 文件在 Task Scheduler 环境下解析失败（编码问题）→ 用 `.sh` + bash
- `.cmd` 批处理文件在 Task Scheduler 环境下中文参数编码也出问题 → 排除
- Git Bash (`C:\Program Files\Git\bin\bash.exe`) 是目前唯一稳定方案

### 任务列表

| 任务名 | 日程 | 脚本 | 线 |
|--------|------|------|-----|
| `literature-lab-weekday` | 周一至五 08:57 | `run-weekday.sh` | thesis+core |
| `literature-lab-topology` | 周一三五 09:02 | `run-topology.sh` | 拓扑序精读 |
| `literature-lab-weekly-synthesis` | 周六 09:05 | `run-weekly-synthesis.sh` | 周度综述 |

### 时间错开原因

weekday 和 topology 都打 arXiv API，同时触发会限流。topology 延后 5 分钟。

### 手动触发调试

```bash
schtasks /run /tn literature-lab-weekday
```

触发后等 15-20 分钟（claude 管线执行耗时），用以下命令查结果：
```bash
schtasks /query /tn literature-lab-weekday /v /fo LIST
```
- Last Result 0 = 成功
- Last Result 267009 = 仍在运行中（不是失败）

## 文件编码

### 铁律

- **含中文的文件绝不能用 Write 工具创建** — 编码会损坏
- 含中文的脚本用 bash heredoc (`cat << 'EOF'`) 写入
- bash heredoc 输出编码取决于系统 locale，中文 Windows 上通常是 GBK
- 手动执行 `.sh` 脚本从 bash 终端走编码正常；不要让 Task Scheduler 直接调 `.ps1` 含中文

### feishu-push.ps1 的编码历史

该文件经历多次编码损坏，最终方案：
1. `git checkout` 恢复原始版本（编码正确）
2. 用 Edit 工具精准修改（Edit 工具保留原文件编码）
3. 最终通过 PowerShell 原生的 `Out-File -Encoding UTF8` 重写，加 BOM

## 飞书卡片

### JSON 2.0 Schema（必须）

```json
{
  "msg_type": "interactive",
  "card": {
    "schema": "2.0",
    "header": {"title": {...}, "template": "blue"},
    "body": {"elements": [...]}
  }
}
```

- `schema: "2.0"` 不写则表格、列表等不渲染
- `elements` 必须在 `body` 下

### 支持的元素

| 元素 | 可用？ | 备注 |
|------|--------|------|
| `markdown` | ✅ | 支持表格、`<font>`、`<text_tag>`、`<hr>` |
| `hr` | ✅ | 独立分割线元素 |
| `div` + `standard_icon` | ✅ | 图标标题，token 需 `_outlined` 或 `_filled` 后缀 |
| `button` (link) | ✅ | `url` 属性（不是 `link_url`） |
| `column_set` / `column` | 未验证 | 之前报错，可能不支持 |
| `note` | ❌ | webhook 机器人不支持 |
| `collapsible_panel` | ❌ | webhook 机器人不支持 |
| `img` | 未测 | — |

### 图标 token（已验证可用）

格式：`{name}_outlined` 或 `{name}_filled`

| token | 颜色 | 用途 |
|-------|------|------|
| `lamp_outlined` | turquoise | 今日结论 |
| `book-open_outlined` | blue | 必看论文 |
| `info_outlined` | grey | 背景/前沿跟踪 |
| `academic-cap_outlined` | green | 对 thesis 的直接用处 |
| `folder_outlined` | grey | 当日沉淀 |
| `right_outlined` | blue | 下一步 |

### Header 颜色逻辑

- 含 Nature/Science/PRL/PRX → `template: "red"`
- 全部 arXiv → `template: "yellow"`
- 其他 → `template: "blue"`

### 手机端适配

- **表格在手机上不自适应**，长内容被截断 → 改为 `**字段名** 内容` 分行格式
- 论文之间加 `<hr>` 分割线，否则视觉上连成一片
- `<text_tag>` 彩色药丸标签在手机上渲染正常

### 按钮生成条件

- 状态字段含 `10.XXXX/...`（DOI）→ "查看原文" 按钮，链接 `https://doi.org/...`
- 状态字段含 `arXiv:XXXX.XXXXX` 或 `arXiv preprint (XXXX.XXXXX)` → "查看原文" 按钮，链接 `https://arxiv.org/abs/...`
- 按钮属性用 `url` 不是 `link_url`

### PowerShell 序列化坑

- `ConvertTo-Json` 在 PowerShell 5 上会把单元素数组展平为对象
- 解决：`ConvertTo-Json -InputObject @($Elements)`（不是管道 `$Elements | ConvertTo-Json`）

## 排期原则

- topology 线 09:02（比 weekday 晚 5 分钟），避免 arXiv API 限流
- 周度综述 09:05（周六，两条线都跑完后再汇总）
- weekday 和 topology 在周一/三/五同时触发，但时间错开

## 去重机制

- 两条线搜索前互查对方的状态文件
  - weekday 读 `state/search-log.json` + `state/topology-pipeline-status.json`
  - topology 读 `state/search-log.json` + `state/pipeline-status.json`
- 飞书推送去重：`state/sent-reports.json` 记录 SHA256 指纹
- 推送失败不存指纹，下次重试

## 临时文件清理

测试卡片产生的 daily markdown 文件需要手动清理，否则累积在 `sent-reports.json` 中占用指纹空间。测试完后立即删除。
