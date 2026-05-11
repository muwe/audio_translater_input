# IPC 双窗口通信协议参考

Audio Translate Input 主窗口与子窗口（悬浮录音条）之间的进程间通信协议。

## 通道配置

- **通道名称**: `gravity/ipc`（常量 `kIpcChannelName`，定义在 `lib/globals.dart`）
- **传输方式**: `desktop_multi_window` 的 `WindowMethodChannel`
- **模式**: `ChannelMode.bidirectional`
- **隔离性**: 每个窗口运行在独立的 Flutter 引擎 isolate 中。子窗口无法直接访问 SharedPreferences 或发起外部网络请求。

两个窗口以相同方式创建通道：

```dart
final _ipcChannel = const WindowMethodChannel(kIpcChannelName, mode: ChannelMode.bidirectional);
```

## 原生通道（仅主窗口）

主窗口还有一个独立的原生通道，用于与 `AppDelegate.swift` 通信：

```dart
final _fnKeyChannel = const MethodChannel('com.audiotyper.fn_key');
```

该通道在 Swift 和 Dart 之间传递 `fn_down`、`fn_up`、`show_dashboard`、`save_frontmost`、`paste_to_frontmost`、`play_success_sound` 和 `check_accessibility` 消息。主窗口将相关事件通过 IPC 通道转发给子窗口。

---

## 消息：主窗口 --> 子窗口

### `fn_event`

将 Fn 键按下/释放事件从 AppDelegate 经由主窗口转发到子窗口。

| 参数 | 类型 | 说明 |
|------|------|------|
| `method` | `String` | `"fn_down"` 或 `"fn_up"` |
| `isTranslate` | `bool` | 若 Shift 键在 150ms 防抖窗口内被按下则为 `true` |

**发送时机**: 每当 AppDelegate 检测到 Fn 键状态变化时。

**接收方行为**:
- `fn_down` + 空闲/粘贴状态：以润色或翻译模式开始录音
- `fn_down` + 正在润色录音中 + `isTranslate=true`：热切换为翻译模式
- `fn_up` + 录音状态：停止录音并触发上传

### `settings_changed`

通知子窗口用户设置已变更。

| 参数 | 类型 | 说明 |
|------|------|------|
| _（无）_ | -- | -- |

**发送时机**: 当主窗口的 `globalSettingsNotifier` 触发时。

**接收方行为**: 从 SharedPreferences 重新读取快捷键偏好设置并重新注册备用快捷键。

### `update_locale`

向子窗口推送语言区域变更。

| 参数 | 类型 | 说明 |
|------|------|------|
| _（位置参数）_ | `String` | 语言区域名称，如 `"en"`、`"zhHans"`、`"ja"` |

**发送时机**: 当 `globalSettingsNotifier` 触发时（与 `settings_changed` 同时）。

**接收方行为**: 使用匹配的 `AppLocale` 调用 `LocaleSettings.setLocale()` 并重建 UI。

### `status_update`

由 `AudioUploadService`（通过主窗口的 IPC 通道）发送，用于更新悬浮条的视觉状态。

| 参数 | 类型 | 说明 |
|------|------|------|
| `state` | `String` | 取值之一：`"uploading"`、`"processing"`、`"pasting"`、`"done"`、`"idle"`、`"error"` |
| `message` | `String?` | 错误消息（仅在 `state == "error"` 时存在） |
| `text` | `String?` | 结果文本（仅在 `state == "pasting"` 时存在） |
| `asrSec` | `String?` | ASR 耗时秒数（仅在 `state == "pasting"` 时存在） |
| `llmSec` | `String?` | LLM 耗时秒数（仅在 `state == "pasting"` 时存在） |

**发送时机**: 在上传管道的每个阶段。

**接收方行为**:
- `uploading`/`processing`：切换到 `BubbleProcessing` 状态（加载动画）
- `pasting`/`done`/`idle`：切换到 `BubbleIdle`（隐藏胶囊）
- `error`：切换到 `BubbleError`，3 秒后自动清除

---

## 消息：子窗口 --> 主窗口

### `ready`

通知主窗口子窗口已完成初始化。

| 参数 | 类型 | 说明 |
|------|------|------|
| _（无）_ | -- | -- |

**发送时机**: 仅一次，在 `initState()` 中 IPC 和快捷键设置完成后。

**接收方行为**: 设置 `_subWindowReady = true`。在此标志设置前，主窗口不会转发 `fn_event` 消息。

### `upload_audio`

将已完成的录音发送到主窗口，由主窗口负责上传、转录、粘贴和历史记录存储。

| 参数 | 类型 | 说明 |
|------|------|------|
| `audioPath` | `String` | `.m4a` 文件的绝对路径 |
| `mode` | `String` | `"refine"` 或 `"translate"` |
| `recordingDurationMs` | `int` | 录音时长（毫秒） |

**发送时机**: 录音停止且通过 VAD 验证后（>15% 语音帧、>800ms 时长、>3KB 文件大小）。

**接收方行为**: 委托给 `AudioUploadService.handleUpload()` 处理，该服务直接调用 AI 服务商 API（ASR 语音识别 + LLM 润色/翻译），将结果写入剪贴板并通过 AppleScript 粘贴，保存历史记录，并将 `status_update` 消息发回。

### `save_frontmost`

请求主窗口保存当前最前端应用程序的引用（在录音抢占焦点之前）。

| 参数 | 类型 | 说明 |
|------|------|------|
| _（无）_ | -- | -- |

**发送时机**: 在 `_startRecording()` 开始时，录音启动之前。

**接收方行为**: 通过 `_fnKeyChannel.invokeMethod('save_frontmost')` 转发至 AppDelegate。

### `check_accessibility`

检查应用是否具有 macOS 辅助功能权限。

| 参数 | 类型 | 说明 |
|------|------|------|
| _（无）_ | -- | -- |

**返回值**: `bool` —— 已授权为 `true`，否则为 `false`。

**发送时机**: 子窗口初始化期间发送一次。

**接收方行为**: 通过 `_fnKeyChannel.invokeMethod('check_accessibility')` 转发至 AppDelegate 并返回结果。

---

## 时序图

### 录音流程（Fn 键）

```
AppDelegate        主窗口             子窗口             AI 服务商
    |                   |                   |                   |
    |-- fn_down ------->|                   |                   |
    |   (原生通道)      |-- fn_event ------>|                   |
    |                   |   {fn_down}       |                   |
    |                   |<- save_frontmost--|                   |
    |<- save_frontmost--|  (子窗口发起，主窗口经原生通道转发)   |
    |                   |                   |                   |
    |                   |                   | [开始录音]        |
    |                   |                   |                   |
    |-- fn_up --------->|                   |                   |
    |                   |-- fn_event ------>|                   |
    |                   |   {fn_up}         |                   |
    |                   |                   | [停止录音]        |
    |                   |                   | [VAD 检测]        |
    |                   |                   |                   |
    |                   |<- upload_audio ---|                   |
    |                   |   {path, mode}    |                   |
    |                   |-- status_update ->|                   |
    |                   |   {uploading}     |                   |
    |                   |                   |                   |
    |                   |-- ASR POST ----------------------->|
    |                   |<- 识别文本 ----------------------------|
    |                   |-- LLM POST ----------------------->|
    |                   |<- 润色/翻译结果 -----------------------|
    |                   |                   |                   |
    |                   |-- status_update ->|                   |
    |                   |   {pasting}       |                   |
    |<- paste_to_front--|                   |                   |
    |   (剪贴板+Cmd+V)  |                   |                   |
    |                   |-- status_update ->|                   |
    |                   |   {done}          |                   |
```

### 设置同步流程

```
主窗口                             子窗口
    |                               |
    | [用户修改设置]                |
    |                               |
    |-- update_locale ------------->|
    |   "zhHans"                    | [setLocale()]
    |                               |
    |-- settings_changed ---------->|
    |                               | [重新注册快捷键]
```

### 错误流程

```
主窗口                             子窗口
    |                               |
    |<- upload_audio ---------------|
    |                               |
    |-- status_update ------------->|
    |   {uploading}                 |
    |                               |
    | [AI API 调用失败]            |
    |                               |
    |-- status_update ------------->|
    |   {error, message}            | [显示错误 3 秒]
    |                               | [自动清除回空闲]
```
