# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Audio Translate Input is a macOS-only Flutter app that records audio via a system-wide Fn hotkey, transcribes and refines or translates it with AI, and pastes the result into the user's frontmost app. All AI processing happens client-side — the app calls Groq / SiliconFlow / OpenRouter directly via HTTP. No server required.

## Repository Layout

- `app_demo/` — Flutter macOS app (all code lives here)
- `docs/` — Technical documentation (architecture, API, product)
- `scripts/` — Utility scripts

## Build & Run Commands

All Flutter commands run from `app_demo/`:

```bash
cd app_demo
flutter pub get                    # Install dependencies
flutter run -d macos               # Run in dev mode
flutter build macos --release      # Production build
flutter test --reporter expanded   # Run all unit tests
flutter analyze                    # Lint check (flutter_lints)
```

## Architecture: Dual-Window with IPC

The app uses `desktop_multi_window` to run two Flutter windows in separate engine isolates:

**Main Window** (`lib/main.dart`, 800×600) — Dashboard, settings, history. Owns SharedPreferences, audio upload service, tray icon, and hotkey registration. This is the only window that writes to SharedPreferences or calls external APIs.

**Sub-Window** (`lib/floating_window.dart`, 280×90, transparent, always-on-top) — Recording bar with waveform. Handles audio capture and VAD detection. Has NO access to SharedPreferences (isolated engine). All business logic delegates to main window via IPC.

**IPC** — Bidirectional via `WindowMethodChannel('gravity/ipc')`. Channel name defined in `lib/globals.dart` as `kIpcChannelName`.

Key IPC messages:
- Main → Sub: `fn_event`, `settings_changed`, `update_locale`, `status_update`
- Sub → Main: `ready`, `upload_audio`, `save_frontmost`, `check_accessibility`

## Native Layer (macOS)

`macos/Runner/AppDelegate.swift` handles:
- **Fn key detection** with a 150ms debounce window: Fn alone = refine (润色), Fn+Shift within 150ms = translate (翻译)
- **Window activation control** via `MainFlutterWindow.allowActivation` — prevents focus steal during recording
- **Clipboard injection** — saves frontmost app reference, pastes via AppleScript Cmd+V, restores focus

`macos/Runner/MainFlutterWindow.swift` — Custom NSWindow that gates `canBecomeKey`/`canBecomeMain` on the `allowActivation` flag.

## AI Pipeline (client-side)

`lib/audio_upload_service.dart` handles all AI calls directly:

- **US/Global**: Groq Whisper-large-v3 (ASR) → OpenRouter GPT-4o-mini (LLM)
- **China**: SiliconFlow SenseVoiceSmall (ASR) → Qwen2.5-32B (LLM)
- **Fallback**: OpenAI whisper-1 → gpt-4o-mini (if OpenAI key is configured)

API key priority: **Settings (SharedPreferences) > `.env` file**. Users can enter keys in Settings → API Keys without restarting.

## Data Flow Invariants

- **time_saved**: Computed locally in `UsageStatsService` via `_estimateTypingSeconds()`
- **History writes**: Only main window writes to SharedPreferences (sub-window sends `upload_audio` via IPC)
- **Stats**: Local `user_history_list` SharedPreferences → `UsageStatsService.loadAllData()` → in-memory grouping by date → filtered by period

## i18n

Uses `slang` package with strong-typed generated strings in `lib/i18n/`. 6 UI languages: en, zhHans, zhHant, ja, de, es. After editing i18n source strings, regenerate with `flutter pub run build_runner build`.

Locale handling rules:
- Startup matches `AppLocale.values` by loop (not `byName`) — never overwrites saved preference on fallback
- Sub-window receives `update_locale` IPC to stay in sync

## CI/CD

- `.github/workflows/test.yml` — Runs Flutter tests on push/PR to master/main
- `.github/workflows/release.yml` — On `v*` tag: test → build macOS → sign → notarize → GitHub Release

## Key Constraints

- macOS only (platform: `osx '10.15'`), Flutter 3.32.0, Dart ^3.10.7
- Sub-window must never directly access SharedPreferences — always go through IPC
- VAD thresholds: >15% voice frames, >800ms duration, >3KB file size
- `MainFlutterWindow.allowActivation` must be set false before recording to prevent focus steal
- Main branch for PRs is `main`; active development on `master`
