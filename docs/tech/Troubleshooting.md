# 故障排查指南

开发、构建或运行 Audio Translate Input 时常见的问题。

---

## 1. Fn 热键不工作

### 辅助功能权限未授予

Audio Translate Input 使用 `NSEvent.addGlobalMonitorForEvents` 在系统范围内检测 Fn 键按压。macOS 要求应用具有**辅助功能**权限才能正常工作。

**症状：** 按下 Fn 无反应。悬浮条从不出现。

**诊断：** 启动时，子窗口通过 IPC 调用 `check_accessibility`，该方法调用 `AppDelegate.swift`（第 67 行）中的 `AXIsProcessTrustedWithOptions`。如果权限被拒绝，悬浮条显示错误消息 5 秒后返回空闲状态。

**修复方法：**
1. 打开 **系统设置 > 隐私与安全性 > 辅助功能**。
2. 找到 `Audio Translate Input.app`（开发模式下为 `Runner.app`），开启开关。
3. 如果应用未出现在列表中，点击 `+` 按钮手动添加。
4. 开启后重启应用。macOS 会缓存权限状态。

> **开发者提示：** 使用不同代码签名构建新版本时，macOS 可能会撤销之前的权限条目。需要重新授权。

### 焦点抢占防护阻止事件

录音期间，`MainFlutterWindow.allowActivation` 被设为 `false`，以防止应用从用户的前台应用抢占焦点。此标志在 Fn 释放 2 秒后恢复（见 `AppDelegate.swift` 第 181 行）。如果因崩溃或异常状态导致标志卡在 `false`，主窗口将无法成为关键窗口或主窗口。

**症状：** 录音结束后仪表盘窗口无响应。点击 Dock 图标无反应。

**修复方法：** 重启应用。`allowActivation` 标志在启动时重置为 `true`。调试时检查 `applicationShouldHandleReopen`，它在发送 `show_dashboard` 前显式设置 `allowActivation = true`。



---

## 2. 剪贴板粘贴不工作

### AppleEvents / 自动化权限

Audio Translate Input 使用 AppleScript 粘贴结果：`tell application "System Events" to keystroke "v" using command down`。这需要对 System Events 的**自动化**权限。

**症状：** 录音和处理成功，但结果未粘贴。Console.app 显示 `"AppleScript Cmd+V failed"` 以及沙盒或权限错误。

**修复方法：**
1. 打开 **系统设置 > 隐私与安全性 > 自动化**。
2. 确保 Audio Translate Input 有控制 **System Events** 的权限。
3. 如果未列出，系统应在首次粘贴尝试时提示。如果没有提示，尝试重置自动化权限：`tccutil reset AppleEvents com.example.audiotranslateinput`。

### 前台应用检测失败

按下 Fn 时，`AppDelegate.swift` 保存 `NSWorkspace.shared.frontmostApplication`（第 122 行）。如果 Audio Translate Input 自身在前台（如用户在仪表盘获得焦点时按了 Fn），则回退到第一个可见的常规激活策略应用（第 126-130 行）。

**症状：** 结果粘贴到错误的应用或 Audio Translate Input 自身的窗口中。

**修复方法：** 确保按 Fn 前另一个应用在前台。子窗口在录音开始时也会通过 IPC 发送 `save_frontmost` 作为二次捕获。

---

## 3. 音频录制问题

### 麦克风权限

**症状：** 录音开始（悬浮条出现）但立即转为显示麦克风权限消息的错误状态。

**诊断：** `_startRecording` 调用 `_audioRecorder.hasPermission()`。如果被拒绝，显示 `t.status.mic_permission` 3 秒。

**修复方法：** 在 **系统设置 > 隐私与安全性 > 麦克风** 中授予麦克风权限。

### VAD 拒绝所有音频

如果 VAD 持续拒绝录音，可能是环境过于安静或麦克风增益过低。

**阈值**（见 `floating_window.dart` 第 567 行）：
- 语音帧比例必须 >= 15%（`activeRatio < 0.15`）
- 文件大小必须 >= 3000 字节（`fileSize < 3000`）
- 时长必须 >= 800ms（`recordingDurationMs < 800`）

**诊断：** 查找 `[VAD]` 日志行。第 564 行会打印确切的值：文件大小、时长和活跃比例。

**修复方法：** 靠近麦克风说话。检查系统设置 > 声音 > 输入，验证选择了正确的输入设备且输入电平适当。

---

## 4. AI API 错误

### API Key 缺失或无效

应用直接从客户端调用 AI 提供商 API，需要配置正确的 Key：
- `GROQ_API_KEY`（美国区域，ASR whisper-large-v3）
- `OPENROUTER_API_KEY`（美国区域，LLM gpt-4o-mini）
- `SILICONFLOW_API_KEY`（中国区域，ASR SenseVoice + LLM Qwen2.5）
- `OPENAI_API_KEY`（可选，回退）

**症状：** 录音后显示错误提示，日志中出现 `HTTP 401` 或 `HTTP 403`。

**修复方法：** 在 `app_demo/.env` 中填写 Key，或在 **Settings → API Keys** 中输入（Settings 优先级更高）。确认 Key 对应正确的提供商（Groq Key 以 `gsk_` 开头，OpenRouter Key 以 `sk-or-v1-` 开头）。

### 区域路由

应用根据 **Settings → 服务器区域** 选择 ASR+LLM 提供商组合：
- `us`：Groq（ASR）+ OpenRouter（LLM）
- `cn`：SiliconFlow（ASR + LLM）

**症状：** 中国用户使用美国区域时体验到高延迟或 Key 无效。

**修复方法：** 在 Settings 中将区域切换为 `cn`，并确保已配置 `SILICONFLOW_API_KEY`。该值存储在 SharedPreferences 中，键为 `server_region`。

### 请求超时

`AudioUploadService` 中的 Dio 客户端设有 30 秒连接超时、120 秒接收超时。

**症状：** 偶发的 "processing" 状态异常长，最终显示超时错误。

**修复方法：** 检查网络连接和 AI 提供商服务状态。Groq 等提供商偶有限流（429），此时可切换区域或等待后重试。

---

## 5. 构建失败

### Bundle ID 不匹配

应用的 Bundle Identifier 为 `com.example.audiotranslateinput`。以下位置必须一致：
- `macos/Runner.xcodeproj/project.pbxproj`（PRODUCT_BUNDLE_IDENTIFIER）
- `macos/Runner/Info.plist`
- Apple Developer 配置文件

**症状：** 代码签名失败。

### 权限声明

应用在 `Runner.entitlements` 中需要以下权限：
- `com.apple.security.app-sandbox`（如需辅助功能，开发时可设为 `NO`）
- `com.apple.security.device.audio-input`（麦克风）
- `com.apple.security.network.client`（出站网络）
- `com.apple.security.automation.apple-events`（用于粘贴的 System Events）

**症状：** 运行时沙盒违规错误，或应用因代码签名错误在启动时崩溃。

### 配置文件

Release 构建的配置文件必须包含麦克风和辅助功能权限（`NSMicrophoneUsageDescription`、`NSAppleEventsUsageDescription`）。权限声明缺失会导致运行时沙盒拒绝，静默失败。

---

## 6. 子窗口 IPC 错误

### CHANNEL_LIMIT_REACHED

`desktop_multi_window` 对活跃方法通道的数量有内部限制。如果子窗口被反复创建和销毁（如开发中的热重启），通道池可能耗尽。

**症状：** IPC 调用抛出 `PlatformException`，消息包含 "CHANNEL_LIMIT"，或子窗口无法发送 `ready`。

**修复方法：** 完全重启应用（冷启动）。开发时，测试子窗口相关更改时优先使用 `flutter run` 而非反复热重启。

### 引擎句柄无效

子窗口运行在独立的 Flutter 引擎隔离进程中。如果主窗口在子窗口引擎已被释放后（如关闭期间）尝试发送 IPC 消息，调用会因无效句柄错误而失败。

**症状：** 应用关闭期间出现 `[IPC] Failed to send ready signal` 或方法调用错误日志。

**修复方法：** 这在关闭期间通常是无害的。如果在正常操作期间发生，检查 `main.dart` 中的子窗口创建是否在主窗口发送 `fn_event` 消息前完成。子窗口在初始化时发送 `ready` IPC 信号；主窗口应等待此信号后再转发 Fn 事件。

---

## 7. 输入框不接受键盘输入

### KeyDownEvent 与全局热键监听冲突

`hotkey_manager` 插件在操作系统级别注册全局热键（默认为 F5/F6），拦截键盘事件。在极少数情况下，Flutter 的 `HardwareKeyboard` 事件处理可能与文本输入框冲突，特别是当 `FocusNode` 管理较复杂时。

**症状：** 在 TextField 组件（如登录邮箱输入框、设置输入框）中输入时，某些按键被丢失或输入框完全不响应键盘输入。

**诊断：** 这通常发生在：
1. 组件树中更上层的 `KeyDownEvent` 监听器在 TextField 接收事件前消费了该事件。
2. TextField 的 `FocusNode` 将焦点丢失给竞争的焦点作用域。

**修复方法：**
- 确保没有父级组件的 `Focus` 或 `RawKeyboardListener` 对可打印字符返回 `KeyEventResult.handled`。
- 悬浮条的热键注册使用操作系统级别的 `hotkey_manager`，不应干扰 Flutter 的文本输入。如果出现干扰，验证热键仅在子窗口进程中注册，未在主窗口中重复注册。
- 作为临时解决方案，在 TextField 获得焦点时临时取消注册热键。
