# Audio Translate Input

一款 macOS 语音输入应用。通过全局 Fn 快捷键录制音频，调用 AI 进行转录润色或翻译，并将结果自动粘贴到当前前台应用。**无需服务器** — 所有 AI 处理均在客户端完成，使用你自己的 API Key。

## 功能特性

- **语音转文字输入** — 按住 Fn 开始录音，松开即转录并粘贴
- **两种模式** — 单按 Fn 润色（refine），Fn+Shift 翻译（translate）
- **19 种翻译目标语言**
- **6 种 UI 界面语言** — 英语、简体中文、繁体中文、日语、德语、西班牙语
- **Dynamic Island 风格**悬浮录音条，实时波形显示
- **语音活动检测（VAD）** — 自动丢弃静音和误触发
- **按区域路由的 ASR 管道** — 根据所选区域路由至 Groq（美国）或 SiliconFlow（中国）
- **用量统计与历史记录** — 本地存储节省时间、字符数及会话历史

## 技术栈

| 层级 | 技术 |
|------|------|
| 客户端 | Flutter 3.32.0（macOS 专属，Dart ^3.10.7） |
| 原生层 | Swift（AppDelegate — Fn 键检测、剪贴板注入） |
| ASR | Groq Whisper-large-v3（美国区域）、SiliconFlow SenseVoice（中国区域）、OpenAI Whisper（回退） |
| LLM | OpenRouter GPT-4o-mini（美国区域）、SiliconFlow Qwen2.5-32B（中国区域）、OpenAI（回退） |
| 国际化 | slang（强类型、代码生成） |

## 快速开始

### 前置条件

- macOS 10.15+
- Flutter 3.32.0+
- Xcode（含 macOS 开发工具）
- 至少一个 AI 服务商的 API Key（见下方）

### 1. 获取 API Key

注册所需的服务商：

| 服务商 | 用途 | 注册 |
|--------|------|------|
| [Groq](https://console.groq.com) | ASR — 美国区域 | 免费套餐 |
| [OpenRouter](https://openrouter.ai) | LLM — 美国区域 | 按量计费 |
| [SiliconFlow](https://cloud.siliconflow.cn) | ASR + LLM — 中国区域 | 免费套餐 |
| OpenAI（可选） | 回退 ASR + LLM | 按量计费 |

**美国区域**：需要 Groq + OpenRouter。  
**中国区域**：仅 SiliconFlow 即可。

### 2. 配置环境变量

```bash
cp app_demo/.env.example app_demo/.env
# 编辑 app_demo/.env，填入你的 API Key
```

也可以在启动应用后通过 **设置 → API Keys** 直接输入（优先级高于 `.env`，无需重启）。

### 3. 构建与运行

```bash
cd app_demo
flutter pub get                    # 安装依赖
flutter run -d macos               # 开发模式运行
flutter build macos --release      # 生产构建
flutter test --reporter expanded   # 运行所有单元测试
flutter analyze                    # Lint 检查
```

首次启动时请授予**辅助功能**权限（Fn 键检测和剪贴板粘贴所必需）。

## 项目结构

```
.
├── app_demo/                        Flutter macOS 应用
│   ├── lib/
│   │   ├── main.dart                主窗口（仪表盘、IPC 中枢）
│   │   ├── floating_window.dart     子窗口（录音条、音频采集）
│   │   ├── globals.dart             共享枚举、通知器、IPC 通道名
│   │   ├── audio_upload_service.dart AI 管道（ASR + LLM）+ 粘贴 + 历史记录
│   │   ├── main_dashboard.dart      仪表盘 UI（统计、历史、设置）
│   │   ├── settings_view.dart       设置面板（含 API Keys 区域）
│   │   ├── usage_stats_service.dart  用量统计（从本地历史记录计算）
│   │   └── i18n/                    生成的 i18n 字符串（slang）
│   └── macos/Runner/
│       ├── AppDelegate.swift        Fn 键检测、剪贴板、窗口控制
│       └── MainFlutterWindow.swift  焦点抢占防护（allowActivation 门控）
├── docs/                            文档
│   ├── architecture/                系统与客户端架构
│   └── tech/                        技术指南（部署、i18n、ASR 等）
├── scripts/                         工具脚本
└── .github/workflows/               CI/CD（测试 + 发布）
```

## 文档

### 架构
- [客户端架构](docs/architecture/Client_Architecture.md)
- [系统架构总览](docs/architecture/System_Architecture_Overview.md)
- [IPC 协议参考](docs/architecture/IPC_Protocol_Reference.md)

### 技术指南
- [ASR 与转码集成](docs/tech/ASR_Transcoding_Integration.md)
- [部署指南](docs/tech/Deployment_Guide.md)
- [环境变量说明](docs/tech/Environment_Variables.md)
- [多语言与国际化](docs/tech/Multilingual_i18n.md)
- [VAD 算法](docs/tech/VAD_Algorithm.md)
- [安全指南](docs/tech/Security_Guide.md)
- [测试报告](docs/tech/Test_Report.md)
- [故障排查](docs/tech/Troubleshooting.md)
- [CI/CD 工作流](docs/tech/CI_CD_Workflow.md)

## CI/CD

- **test.yml** — 在 push/PR 到 master/main 时运行 Flutter 测试
- **release.yml** — 在 `v*` 标签触发时：测试 → 构建 + 签名 + 公证 macOS → 创建 GitHub Release

## 贡献

请参阅 [CONTRIBUTING.zh-CN.md](CONTRIBUTING.zh-CN.md) 了解开发环境配置、PR 规范及问题反馈方式。

## 许可证

[MIT](LICENSE)
