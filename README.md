# Audio Translate Input

A macOS voice input app that records audio via a system-wide Fn hotkey, transcribes and refines or translates it with AI, and pastes the result into your frontmost application. **No server required** — all AI processing runs client-side using your own API keys.

## Features

- **Voice-to-text input** -- press Fn to record, release to transcribe and paste
- **Two modes** -- Fn alone for refinement (润色), Fn+Shift for translation (翻译)
- **19 target languages** for translation output
- **6 UI languages** -- English, Simplified Chinese, Traditional Chinese, Japanese, German, Spanish
- **Dynamic Island-style** floating recording bar with live waveform
- **Voice Activity Detection** -- automatically discards silence and accidental triggers
- **Region-aware ASR pipeline** -- routes to Groq (US) or SiliconFlow (CN) based on your selection
- **Usage stats and history** -- tracks time saved, character counts, and session history (stored locally)

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Client | Flutter 3.32.0 (macOS only, Dart ^3.10.7) |
| Native | Swift (AppDelegate — Fn key detection, clipboard injection) |
| ASR | Groq Whisper-large-v3 (US), SiliconFlow SenseVoice (CN), OpenAI Whisper (fallback) |
| LLM | OpenRouter GPT-4o-mini (US), SiliconFlow Qwen2.5-32B (CN), OpenAI (fallback) |
| i18n | slang (strong-typed, code-generated) |

## Quick Start

### Prerequisites

- macOS 10.15+
- Flutter 3.32.0+
- Xcode with macOS development tools
- API keys from at least one AI provider (see below)

### 1. Get API Keys

Sign up for the providers you need:

| Provider | Used for | Sign up |
|----------|----------|---------|
| [Groq](https://console.groq.com) | ASR — US region | Free tier |
| [OpenRouter](https://openrouter.ai) | LLM — US region | Pay-per-use |
| [SiliconFlow](https://cloud.siliconflow.cn) | ASR + LLM — CN region | Free tier |
| OpenAI (optional) | Fallback ASR + LLM | Pay-per-use |

For **US region**: you need Groq + OpenRouter.  
For **CN region**: SiliconFlow alone is sufficient.

### 2. Configure environment

```bash
cp app_demo/.env.example app_demo/.env
# Edit app_demo/.env and fill in your API keys
```

Alternatively, enter keys directly in **Settings → API Keys** after launching the app (no restart required, takes priority over `.env`).

### 3. Build and Run

```bash
cd app_demo
flutter pub get                    # Install dependencies
flutter run -d macos               # Run in dev mode
flutter build macos --release      # Production build
flutter test --reporter expanded   # Run all unit tests
flutter analyze                    # Lint check
```

Grant **Accessibility** permission when prompted (required for Fn key detection and clipboard paste).

## Project Structure

```
.
├── app_demo/                        Flutter macOS app
│   ├── lib/
│   │   ├── main.dart                Main window (dashboard, IPC hub)
│   │   ├── floating_window.dart     Sub-window (recording bar, audio capture)
│   │   ├── globals.dart             Shared enums, notifiers, IPC channel name
│   │   ├── audio_upload_service.dart AI pipeline (ASR + LLM) + paste + history
│   │   ├── main_dashboard.dart      Dashboard UI (stats, history, settings)
│   │   ├── settings_view.dart       Settings panel (includes API Keys section)
│   │   ├── usage_stats_service.dart  Usage statistics (computed from local history)
│   │   └── i18n/                    Generated i18n strings (slang)
│   └── macos/Runner/
│       ├── AppDelegate.swift        Fn key detection, clipboard, window control
│       └── MainFlutterWindow.swift  Focus-steal prevention (allowActivation gate)
├── docs/                            Documentation
│   ├── architecture/                System and client architecture
│   └── tech/                        Technical guides (deploy, i18n, ASR, etc.)
├── scripts/                         Utility scripts
└── .github/workflows/               CI/CD (test + release)
```

## Documentation

### Architecture
- [Client Architecture](docs/architecture/Client_Architecture.md)
- [System Architecture Overview](docs/architecture/System_Architecture_Overview.md)
- [IPC Protocol Reference](docs/architecture/IPC_Protocol_Reference.md)

### Technical Guides
- [ASR & Transcoding Integration](docs/tech/ASR_Transcoding_Integration.md)
- [Deployment Guide](docs/tech/Deployment_Guide.md)
- [Environment Variables](docs/tech/Environment_Variables.md)
- [Multilingual i18n](docs/tech/Multilingual_i18n.md)
- [VAD Algorithm](docs/tech/VAD_Algorithm.md)
- [Security Guide](docs/tech/Security_Guide.md)
- [Test Report](docs/tech/Test_Report.md)
- [Troubleshooting](docs/tech/Troubleshooting.md)
- [CI/CD Workflow](docs/tech/CI_CD_Workflow.md)

## CI/CD

- **test.yml** — Runs Flutter tests on push/PR to master/main
- **release.yml** — On `v*` tag: test → build + sign + notarize macOS → create GitHub Release

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup, PR guidelines, and how to report issues.

## License

[MIT](LICENSE)
