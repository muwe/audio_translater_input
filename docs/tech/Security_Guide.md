# 安全加固指南

Audio Translate Input 项目的安全实践与注意事项。

---

## 调试日志保护

客户端中所有敏感的调试日志都使用 `kDebugMode` 保护，确保在 Release 构建中不会泄露凭证、令牌或个人身份信息。

### 调试日志规则

**规则：** 对于可能包含敏感数据的消息，永远不要使用裸露的 `print()` 或 `stderr.writeln()`。始终用 `if (kDebugMode)` 包装：

```dart
if (kDebugMode) {
  developer.log(msg, name: 'Upload');
}
```

**注意：** 子窗口（`floating_window.dart`）使用裸露的 `print()` 记录操作状态日志（如 "fn_down received"）。这些消息不包含敏感数据，仅记录状态转换和 VAD 指标。


---

## API Key 安全

应用直接从客户端调用 AI 提供商 API，API Key 存储在两个位置：

1. **`app_demo/.env`**（本地开发）— 通过 `flutter_dotenv` 加载，已在 `.gitignore` 中排除，**绝不能提交到代码仓库**。
2. **SharedPreferences**（Settings → API Keys 输入）— 存储在 macOS 应用沙盒中，仅当前用户可读。

**规则：**
- 永远不要将 AI 提供商 API Key 硬编码在源代码中。
- `app_demo/.env` 已被 `.gitignore` 排除，但 `.env.example` 仅包含占位符，可以提交。
- CI/CD 流水线中 AI Key 无需配置（构建和测试不调用 AI API）。

**密钥列表：**
- `GROQ_API_KEY` — Groq Whisper ASR（美国区域）
- `OPENROUTER_API_KEY` — OpenRouter LLM（美国区域）
- `SILICONFLOW_API_KEY` — SiliconFlow ASR + LLM（中国区域）
- `OPENAI_API_KEY` — 可选回退


---

## macOS Entitlements

两个构建配置（Debug + Release）的权限声明完全一致：

| Entitlement | 值 | 说明 |
|-------------|-----|------|
| `com.apple.security.app-sandbox` | `false` | 沙盒关闭——Fn 键 EventTap 和 AppleScript 剪贴板注入需要在沙盒外运行 |
| `com.apple.security.network.client` | `true` | 允许出站 HTTPS 调用 AI 服务商 API |
| `com.apple.security.device.audio-input` | `true` | 允许访问麦克风录音 |
| `com.apple.security.automation.apple-events` | `true` | 允许通过 AppleScript 向前台应用发送 Cmd+V |

**注意事项：**
- `com.apple.developer.applesignin` 权限**不存在**——本应用无账号体系，无 Apple 登录、无 Google 登录，无任何第三方鉴权。
- 沙盒关闭是设计权衡：macOS 严格沙盒会阻断低级键盘监听和跨进程剪贴板注入，而这两个功能是 Fn 热键工作的核心前提。

---

## 待办事项汇总

| 事项 | 优先级 | 状态 |
|------|----------|--------|
| 审计所有 `print()` 调用是否存在 PII 泄露 | 低 | 持续进行 |
