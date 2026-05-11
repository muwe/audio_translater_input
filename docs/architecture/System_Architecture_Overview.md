# 系统架构总览

Audio Translate Input macOS 语音输入应用的高层架构。

## 全栈概览

本应用为**纯客户端架构**，无后端服务器、无 Supabase、无 Edge Function。所有 AI 调用（ASR 语音识别 + LLM 润色/翻译）均直接从 Flutter 主窗口发起，经由 HTTPS 请求至各 AI 服务商 API。

```
┌─────────────────────────────────────────────────────────────────────┐
│                          macOS 宿主环境                              │
│                                                                     │
│  ┌──────────────────────┐    ┌──────────────────────────────────┐  │
│  │   AppDelegate.swift  │    │       Flutter 引擎（主窗口）      │  │
│  │                      │    │                                    │  │
│  │  - Fn 键监听         │    │  main.dart (_AppRootState)         │  │
│  │  - 150ms 防抖        │◄──►│  - AudioUploadService             │  │
│  │  - save_frontmost    │    │  - 直接调用 AI API (Dio)          │  │
│  │  - paste_to_frontmost│    │  - 仪表盘 UI                      │  │
│  │  - 剪贴板注入        │    │  - SharedPreferences（唯一写入方）│  │
│  │  - play_success_sound│    │  - 托盘图标                       │  │
│  └──────────────────────┘    │  - IPC 中枢                       │  │
│           ▲                  └────────────────┬───────────────────┘  │
│           │                                   │                      │
│           │ MethodChannel                     │ WindowMethodChannel   │
│           │ (com.audiotyper.fn_key)           │ (gravity/ipc)        │
│           │                                   │                      │
│           │                  ┌────────────────▼───────────────────┐  │
│           │                  │    Flutter 引擎（子窗口）           │  │
│           │                  │                                     │  │
│           │                  │  floating_window.dart               │  │
│           │                  │  - 录音条（280x90）                │  │
│           │                  │  - 音频采集（record 包）           │  │
│           │                  │  - VAD 检测                        │  │
│           │                  │  - 波形可视化                      │  │
│           │                  │  - 备用快捷键（F5/F6）             │  │
│           │                  └────────────────────────────────────┘  │
└───────────┼─────────────────────────────────────────────────────────┘
            │
            │  HTTPS（直接调用，无代理）
            ▼
┌─────────────────────────────────────────────────────────────────────┐
│                         AI 服务商（外部）                            │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │  ASR 语音识别                                                │   │
│  │  US 节点: Groq  whisper-large-v3                            │   │
│  │  CN 节点: SiliconFlow  FunAudioLLM/SenseVoiceSmall          │   │
│  │  灾备:    OpenAI  whisper-1                                  │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │  LLM 润色 / 翻译                                             │   │
│  │  US 节点: OpenRouter  openai/gpt-4o-mini                    │   │
│  │  CN 节点: SiliconFlow  Qwen/Qwen2.5-32B-Instruct            │   │
│  │  灾备:    OpenAI  gpt-4o-mini                                │   │
│  └─────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

## 双窗口架构

Audio Translate Input 通过 `desktop_multi_window` 运行两个独立的 Flutter 引擎 isolate：

```
┌────────────────────────────────┐    ┌─────────────────────────────┐
│       主窗口（800x600）        │    │   子窗口（280x90）          │
│                                │    │   透明、始终置顶             │
│  职责：                        │    │                             │
│  - 仪表盘 / 历史 / 统计       │    │  职责：                     │
│  - 设置面板（API Key 配置）   │    │  - 录音条 UI                │
│  - AudioUploadService          │    │  - 音频采集 + VAD           │
│    （直接 HTTP 调用 AI API）   │    │  - 波形动画                 │
│  - SharedPreferences（唯一     │    │  - 胶囊显示/隐藏动画       │
│    写入方）                    │    │  - 备用快捷键处理           │
│  - 托盘图标 + 菜单             │    │                             │
│  - Fn 键中继（原生通道）       │    │  无法访问：                 │
│  - IPC 中枢                    │    │  - SharedPreferences（隔离）│
│                                │    │  - AI API（无 Key）         │
│  WindowMethodChannel ◄─────────────►  WindowMethodChannel         │
│  (gravity/ipc)                 │    │  (gravity/ipc)              │
└────────────────────────────────┘    └─────────────────────────────┘
```

**为什么需要两个窗口？** 子窗口是一个透明的、始终置顶的覆盖层，用于显示录音指示器，同时不会抢占用户最前端应用的焦点。主窗口负责处理所有业务逻辑、数据持久化和 AI API 调用。

## 数据流：从录音到粘贴

```
1. 用户按下 Fn 键
   │
   ▼
2. AppDelegate.swift 检测到 Fn keyDown
   - 启动 150ms 防抖计时器
   - 若 Shift 在 150ms 内按下 → isTranslate = true
   - 通过原生 MethodChannel 发送 fn_down
   │
   ▼
3. 主窗口（_initFnKeyChannel）接收 fn_down
   - 通过 IPC 转发为 fn_event {method: fn_down, isTranslate}
   │
   ▼
4. 子窗口（_initIpc）接收 fn_event
   - 通过 IPC 发送 save_frontmost（主窗口转发至 AppDelegate）
   - 开始音频录制（record 包，AAC-LC 32kbps）
   - 显示胶囊并执行进入动画
   - 开始振幅监测用于波形显示 + VAD
   │
   ▼
5. 用户释放 Fn 键
   │
   ▼
6. AppDelegate → 主窗口 → 子窗口（fn_event {fn_up}）
   - 停止录音
   - 执行 VAD 检测：>15% 语音帧、>800ms、>3KB
   - 若未通过 → 静默丢弃，返回空闲状态
   │
   ▼
7. 子窗口通过 IPC 发送 upload_audio
   {audioPath, mode, recordingDurationMs}
   │
   ▼
8. 主窗口：AudioUploadService.handleUpload()
   - 读取设置（targetLang、serverRegion 等）
   - 解析 API Key（SharedPreferences 优先，其次 .env）
   - 向子窗口发送 status_update {uploading}
   │
   ▼
9. ASR 阶段（AudioUploadService._transcribeAudio）
   - CN 节点: POST https://api.siliconflow.cn/v1/audio/transcriptions
             模型: FunAudioLLM/SenseVoiceSmall，过滤 Emoji
   - US 节点: POST https://api.groq.com/openai/v1/audio/transcriptions
             模型: whisper-large-v3
   - 灾备:    POST https://api.openai.com/v1/audio/transcriptions
             模型: whisper-1
   - 向子窗口发送 status_update {processing}
   │
   ▼
10. LLM 阶段（AudioUploadService._runLLM）
    - CN 节点: POST https://api.siliconflow.cn/v1/chat/completions
              模型: Qwen/Qwen2.5-32B-Instruct
    - US 节点: POST https://openrouter.ai/api/v1/chat/completions
              模型: openai/gpt-4o-mini
    - 灾备:    POST https://api.openai.com/v1/chat/completions
              模型: gpt-4o-mini
    - LLM 失败时降级为直接返回 ASR 原始文本
    │
    ▼
11. 主窗口接收结果
    - 将精炼文本写入剪贴板
    - 向子窗口发送 status_update {pasting}
    - 通过原生通道调用 paste_to_frontmost
      （AppDelegate 恢复已保存的应用，通过 AppleScript 发送 Cmd+V）
    - 播放成功提示音
    - 将历史记录保存到 SharedPreferences
    - 延迟 1000ms 后恢复剪贴板原内容
    - 刷新使用统计（UsageStatsService）
    - 向子窗口发送 status_update {done}
    │
    ▼
12. 子窗口隐藏胶囊 → BubbleIdle
```

## 关键设计决策

1. **纯客户端 AI 调用**: 所有 ASR 和 LLM 请求均由主窗口的 `AudioUploadService` 直接发出，无需任何后端服务或代理。API Key 存储在本地（SharedPreferences 或 .env 文件）。

2. **子窗口隔离**: 子窗口运行在独立的引擎 isolate 中，无法直接访问 SharedPreferences 或 AI API。所有数据操作都通过 IPC 委托给主窗口处理，避免竞态条件，确保单一数据源。

3. **防止焦点抢占**: 录音开始前将 `MainFlutterWindow.allowActivation` 设为 `false`。自定义 NSWindow 根据此标志控制 `canBecomeKey`/`canBecomeMain`，使主窗口永远不会抢占用户当前活跃应用的焦点。

4. **客户端统计计算**: 使用统计（`UsageStatsService`）完全从本地 SharedPreferences 历史数据中计算，无需服务端参与。

5. **区域感知路由**: `AudioUploadService` 根据用户配置的 `serverRegion`（`us` 或 `cn`）选择 ASR 和 LLM 提供商，针对延迟进行优化，并在失败时自动降级至 OpenAI 灾备。

6. **VAD 门控**: 录音必须通过三项阈值检测才能触发 API 调用：>15% 语音帧、>800ms 时长、>3KB 文件大小。防止误触产生无效请求和不必要的 API 费用。
