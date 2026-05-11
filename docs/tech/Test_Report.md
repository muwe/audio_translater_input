# Audio Translate Input 测试报告

> 全量自动化测试结果，基于纯客户端架构（无服务端依赖）。

**项目**: Audio Translate Input  
**环境**: macOS (`flutter test`)

## 目录
- [1. 执行摘要](#1-执行摘要)
- [2. Flutter 客户端单元测试](#2-flutter-客户端单元测试)
- [3. 测试验收指南](#3-测试验收指南)

---

## 1. 执行摘要

| 测试类别 | 用例数 | 结果 | 耗时 |
|---------|-------|------|------|
| **Flutter 单元测试** | 102 | ✅ **102/102 通过 (100%)** | < 1 秒 |

运行命令：

```bash
cd app_demo && flutter test --reporter expanded
```

---

## 2. Flutter 客户端单元测试 (`/app_demo/test/`)

共计 **3 个测试文件**，完全脱离 UI 和网络依赖。

### 2.1 📊 使用统计数据模型 (`usage_stats_test.dart`) — 多用例

验证 `UsageStats` 和 `DailyUsage` 数据模型：

- **默认值**: 所有字段默认为 0，时间换算（ms → min, sec → min）精度正确。
- **fromRows 单行解析**: 完整数据正确映射到各字段，兼容 `total_translate` / `translate_count` 备用 key。
- **fromRows 多行聚合**: 多行数据正确累加，空列表返回全 0。
- **null 字段容错**: 字段为 null 或完全缺失时默认为 0，不抛出异常。
- **DailyUsage 构造**: 日期、字数、请求数等字段正确读写。

### 2.2 🌐 目标语言映射 (`settings_view_test.dart`) — 多用例

验证 19 种目标语言的配置完整性：

- **Key 完整性**: 所有 19 种语言内部 Key 均有对应的 AI API 语言名称映射。
- **数量一致性**: 映射表数量与语言列表严格相等。
- **i18n JSON 完整性**: 6 个 i18n 文件均包含 `target_languages` 下全部 19 个 key（en, zh_Hans, zh_Hant, ja, ko, fr, de, ru, es, it, pt, nl, ar, tr, sv, hi, th, vi, id）。

### 2.3 🎙️ 其他逻辑测试

覆盖子窗口与主窗口交互的核心业务逻辑，均为纯本地计算，无网络依赖：

| 文件 | 用例数 | 覆盖点 |
|------|-------|--------|
| `vad_detection_test.dart` | 17 | 振幅归一化、语音帧阈值判定、三阈值拦截逻辑 |
| `clipboard_protection_test.dart` | 16 | 空结果保护、时序参数、剪贴板备份还原、API 响应 fallback |
| `main_dashboard_test.dart` | 13 | UsageStats 聚合、时间单位转换、KPI 格式化、StatsPeriod 时间范围 |
| `onboarding_flow_test.dart` | 10 | 步骤结构、页面导航逻辑、权限检查、完成标志 |
| `history_storage_test.dart` | 9 | HistoryItem JSON 序列化、列表增删操作、节省时间计算 |
| `vocabulary_storage_test.dart` | 9 | VocabEntry JSON 序列化、词条列表增删 |
| `widget_test.dart` | 6 | 版本号格式、19 种语言总数验证、映射覆盖率 |

---

## 3. 测试验收指南

```bash
# 运行全量测试
cd app_demo && flutter test --reporter expanded

# 期望结果：All tests passed!
```

边界设计原则：
- 空音频（VAD 拒绝）→ 不触发 AI 调用，静默重置为空闲状态
- API Key 缺失 → 抛出明确异常，错误信息展示在 UI 中
- AI 返回空文本 → fallback 到 ASR 原始文本，不触发空白粘贴

