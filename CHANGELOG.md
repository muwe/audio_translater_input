# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-17

### Added
- 🎤 核心录音→润色→上屏功能
- 🌐 20 种语言翻译支持（含 Auto 智能检测）
- ⏱️ 使用量统计仪表盘 (Dashboard)
- 📊 历史记录面板（按时间段筛选 + KPI 卡片）
- 🌍 6 种 UI 语言（EN/简中/繁中/日/德/西）
- ⚙️ 设置面板（快捷键/语言/区域/字体/开机启动）
- 🎨 4 步新手引导向导 (Onboarding)
- 📈 `usage_records` 使用量跟踪 + `daily_usage_summary` 聚合视图

### Infrastructure
- Supabase Edge Function (`audio-process`) 双节点路由
  - US: Groq Whisper-large-v3 + OpenRouter GPT-4o-mini
  - CN: SiliconFlow SenseVoiceSmall + Qwen2.5-32B
  - Fallback: OpenAI whisper-1 + gpt-4o-mini
- GitHub Actions CI/CD
  - `test.yml`: 每次 Push/PR 自动运行 Flutter 测试
  - `release.yml`: Tag 触发 → 测试 → 编译 → Release → 部署

### Testing
- ✅ 65 个 Flutter 单元测试
- ✅ 24 个 Edge Function API 测试
- ✅ 6 个 pgTAP 数据库测试
- 总计 **95/95 全部通过**

### Documentation
- 16 份项目文档（产品 3 + API 1 + 技术 12）
