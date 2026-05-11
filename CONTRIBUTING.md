# Contributing to Audio Translate Input

Thank you for your interest in contributing!

## Prerequisites

| Requirement | Version |
|-------------|---------|
| macOS | 10.15 (Catalina) or later |
| Flutter | 3.32.0 |
| Xcode | 15+ |

## Local Setup

### 1. Clone and install dependencies

```bash
git clone https://github.com/your-org/audio-translate-input.git
cd audio-translate-input/app_demo
flutter pub get
```

### 2. Get API keys

Sign up for the AI providers you need:

| Provider | Used for | Sign up |
|----------|----------|---------|
| [Groq](https://console.groq.com) | ASR — US region (whisper-large-v3) | Free tier |
| [OpenRouter](https://openrouter.ai) | LLM — US region (gpt-4o-mini) | Pay-per-use |
| [SiliconFlow](https://cloud.siliconflow.cn) | ASR + LLM — CN region | Free tier |
| OpenAI (optional) | Fallback ASR + LLM | Pay-per-use |

For **US region**: Groq + OpenRouter are required.  
For **CN region**: SiliconFlow alone is sufficient.

### 3. Configure environment

```bash
cp app_demo/.env.example app_demo/.env
# Edit app_demo/.env and fill in your API keys
```

Or launch the app and enter keys in **Settings → API Keys** (takes priority over `.env`, no restart needed).

### 4. Run the app

```bash
cd app_demo
flutter run -d macos
```

Grant **Accessibility** permission when prompted (required for Fn key detection and clipboard paste).

## Project Structure

```
audio-translate-input/
├── app_demo/          # Flutter macOS app
│   └── lib/
│       ├── main.dart                 # Main window (dashboard, IPC hub)
│       ├── floating_window.dart      # Sub-window (recording bar)
│       ├── audio_upload_service.dart # AI pipeline: ASR + LLM + paste
│       ├── settings_view.dart        # Settings (includes API Keys section)
│       └── usage_stats_service.dart  # Local usage stats from history
└── docs/              # Architecture and product documentation
```

See [CLAUDE.md](CLAUDE.md) for a detailed architecture overview.

## Making Changes

### Flutter app

```bash
cd app_demo
flutter test --reporter expanded   # Run all tests
flutter analyze                    # Lint check
flutter run -d macos               # Run in dev mode
```

### i18n strings

After editing source strings in `lib/i18n/`:

```bash
cd app_demo
dart run slang
```

## Pull Request Guidelines

1. **One concern per PR** — bug fixes and features in separate PRs
2. **Tests** — add or update tests for changed behavior
3. **Analyze clean** — `flutter analyze` must pass with no new issues
4. **Describe the why** — PR description should explain motivation, not just what changed
5. **macOS only** — this project targets macOS; do not introduce cross-platform abstractions

## Reporting Issues

Please include:
- macOS version
- Flutter version (`flutter --version`)
- Steps to reproduce
- Expected vs actual behavior
- Relevant log output (run with `flutter run -d macos` and copy console output)

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
