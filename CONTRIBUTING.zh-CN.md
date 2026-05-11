# 贡献指南 — Audio Translate Input

感谢你对本项目的关注！

## 前置条件

| 要求 | 版本 |
|------|------|
| macOS | 10.15 (Catalina) 及以上 |
| Flutter | 3.32.0 |
| Xcode | 15+ |

## 本地配置

### 1. 克隆并安装依赖

```bash
git clone https://github.com/your-org/audio-translate-input.git
cd audio-translate-input/app_demo
flutter pub get
```

### 2. 获取 API Key

注册所需的 AI 服务商：

| 服务商 | 用途 | 注册 |
|--------|------|------|
| [Groq](https://console.groq.com) | ASR — 美国区域（whisper-large-v3） | 免费套餐 |
| [OpenRouter](https://openrouter.ai) | LLM — 美国区域（gpt-4o-mini） | 按量计费 |
| [SiliconFlow](https://cloud.siliconflow.cn) | ASR + LLM — 中国区域 | 免费套餐 |
| OpenAI（可选） | 回退 ASR + LLM | 按量计费 |

**美国区域**：需要 Groq + OpenRouter。  
**中国区域**：仅 SiliconFlow 即可。

### 3. 配置环境变量

```bash
cp app_demo/.env.example app_demo/.env
# 编辑 app_demo/.env，填入你的 API Key
```

或在启动应用后通过 **设置 → API Keys** 直接输入（优先级高于 `.env`，无需重启）。

### 4. 运行应用

```bash
cd app_demo
flutter run -d macos
```

首次启动时请授予**辅助功能**权限（Fn 键检测和剪贴板粘贴所必需）。

## 项目结构

```
audio-translate-input/
├── app_demo/          # Flutter macOS 应用
│   └── lib/
│       ├── main.dart                 # 主窗口（仪表盘、IPC 中枢）
│       ├── floating_window.dart      # 子窗口（录音条）
│       ├── audio_upload_service.dart # AI 管道：ASR + LLM + 粘贴
│       ├── settings_view.dart        # 设置面板（含 API Keys 区域）
│       └── usage_stats_service.dart  # 从本地历史记录计算用量统计
└── docs/              # 架构与产品文档
```

详细架构说明请参阅 [CLAUDE.md](CLAUDE.md)。

## 进行修改

### Flutter 应用

```bash
cd app_demo
flutter test --reporter expanded   # 运行所有测试
flutter analyze                    # Lint 检查
flutter run -d macos               # 开发模式运行
```

### i18n 字符串

编辑 `lib/i18n/` 目录下的源文件后，运行以下命令重新生成强类型 Dart 代码：

```bash
cd app_demo
dart run slang
```

## Pull Request 规范

1. **单一关注点** — bug 修复与功能开发分开提 PR
2. **测试** — 为变更的行为添加或更新测试用例
3. **分析无误** — `flutter analyze` 不得引入新问题
4. **说明原因** — PR 描述应阐明动机，而非仅描述改了什么
5. **macOS 专属** — 本项目面向 macOS，不要引入跨平台抽象

## 问题反馈

提交 Issue 时请包含：

- macOS 版本
- Flutter 版本（`flutter --version`）
- 复现步骤
- 预期行为与实际行为
- 相关日志输出（运行 `flutter run -d macos` 并复制控制台输出）

## 许可证

提交贡献即表示你同意以 [MIT 许可证](LICENSE) 授权你的贡献。
