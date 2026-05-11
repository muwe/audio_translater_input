# 环境变量与 API Key 配置

> 本应用为纯客户端架构，所有 AI 调用均从 Flutter 客户端直接发出。API Key 由用户自行提供，支持两种配置方式：设置面板（优先）和 `.env` 文件（备用）。

## 目录
- [1. 概述](#1-概述)
- [2. API Key 一览](#2-api-key-一览)
- [3. 配置方式一：设置面板（推荐）](#3-配置方式一设置面板推荐)
- [4. 配置方式二：`.env` 文件](#4-配置方式二env-文件)
- [5. 优先级规则](#5-优先级规则)
- [6. 各节点所需 Key](#6-各节点所需-key)
- [7. GitHub Actions Secrets](#7-github-actions-secrets)
- [8. 安全等级](#8-安全等级)

---

## 1. 概述

本应用不依赖后端服务器，所有 AI 请求（ASR 语音识别 + LLM 润色/翻译）均由客户端直接调用第三方 API。用户需要自行注册并获取以下服务商的 API Key，然后通过设置面板或 `.env` 文件进行配置。

---

## 2. API Key 一览

| 变量名 | 用途 | 节点 | 获取方式 |
|--------|------|------|---------|
| `GROQ_API_KEY` | Groq ASR（whisper-large-v3） | US | [console.groq.com](https://console.groq.com) |
| `OPENROUTER_API_KEY` | OpenRouter LLM（openai/gpt-4o-mini） | US | [openrouter.ai/keys](https://openrouter.ai/keys) |
| `SILICONFLOW_API_KEY` | 硅基流动 ASR + LLM（SenseVoiceSmall + Qwen2.5-32B） | CN | [cloud.siliconflow.cn](https://cloud.siliconflow.cn) |
| `OPENAI_API_KEY` | OpenAI 灾备（whisper-1 + gpt-4o-mini） | 全球 | [platform.openai.com](https://platform.openai.com) |

---

## 3. 配置方式一：设置面板（推荐）

打开应用主窗口 → **设置（Settings）** → **API Keys** 区域，将对应 Key 填入输入框后保存。

- Key 保存在本地 `SharedPreferences` 中，Key 名称分别为：
  - `groq_api_key`
  - `openrouter_api_key`
  - `siliconflow_api_key`
  - `openai_api_key`
- 此方式无需重启应用，下次录音时立即生效。
- Key 仅存储于本机，不会上传至任何服务器。

---

## 4. 配置方式二：`.env` 文件

在 `app_demo/` 目录下创建 `.env` 文件（已在 `.gitignore` 中排除），按如下格式填写：

```dotenv
GROQ_API_KEY=gsk_xxxxxxxxxxxx
OPENROUTER_API_KEY=sk-or-xxxxxxxxxxxx
SILICONFLOW_API_KEY=sk-xxxxxxxxxxxx
OPENAI_API_KEY=sk-xxxxxxxxxxxx
```

`.env` 文件在应用启动时由 `flutter_dotenv` 读取加载。此方式适合开发调试，或不方便通过 UI 配置的场景。

---

## 5. 优先级规则

**SharedPreferences（设置面板）> `.env` 文件**

`_ApiKeyService` 类实现此逻辑：先读 SharedPreferences，有值则使用；若为空则回退到 `.env` 文件中对应的环境变量。

```
Key 解析顺序：
  prefs.getString('groq_api_key')  →  有值则使用
        ↓ 为空
  dotenv.env['GROQ_API_KEY']       →  有值则使用
        ↓ 为空
  null（触发 fallback 至 OpenAI，或报错提示用户配置 Key）
```

---

## 6. 各节点所需 Key

| 节点（serverRegion 设置） | 必需 Key | 可选 Key（灾备） |
|--------------------------|---------|----------------|
| US（默认） | `GROQ_API_KEY` + `OPENROUTER_API_KEY` | `OPENAI_API_KEY` |
| CN | `SILICONFLOW_API_KEY` | `OPENAI_API_KEY` |
| 任意节点（建议配置） | — | `OPENAI_API_KEY`（两级灾备兜底） |

> `OPENAI_API_KEY` 为可选项，但强烈建议配置。它是 ASR 和 LLM 的最终灾备，在主服务商不可用时保障业务连续性。

---

## 7. GitHub Actions Secrets

CI/CD 流水线（`test.yml` / `release.yml`）仅需以下 Secret 用于 Flutter 单元测试和 macOS 构建签名：

| Secret 名 | 用途 | 用于哪个 Workflow |
|-----------|------|------------------|
| `CERTIFICATE_P12_BASE64` | macOS 代码签名证书（Base64 编码的 .p12） | `release.yml` |
| `CERTIFICATE_PASSWORD` | 证书密码 | `release.yml` |
| `KEYCHAIN_PASSWORD` | 临时 Keychain 密码 | `release.yml` |
| `CODE_SIGN_IDENTITY` | 签名身份字符串（如 `Developer ID Application: ...`） | `release.yml` |
| `DEVELOPMENT_TEAM` | Apple Developer Team ID | `release.yml` |
| `APPLE_ID` | Apple 公证账号（Apple ID 邮箱） | `release.yml` |
| `APPLE_APP_PASSWORD` | 应用专用密码（App-specific password） | `release.yml` |
| `APPLE_TEAM_ID` | Developer Team ID（用于公证） | `release.yml` |

> AI 服务商 API Key 不需要配置为 GitHub Secret——CI 不执行真实 AI 调用，Flutter 单元测试完全本地运行。

---

## 8. 安全等级

| 等级 | 变量 | 泄露影响 |
|------|------|---------|
| 🔴 极高 | `CERTIFICATE_P12_BASE64`、`CODE_SIGN_IDENTITY` | 可冒名发布签名 macOS 应用 |
| 🟠 高 | `OPENAI_API_KEY` | 可能产生大量 API 费用 |
| 🟡 中 | `GROQ_API_KEY`、`OPENROUTER_API_KEY`、`SILICONFLOW_API_KEY` | 可能产生 API 费用，服务商有限额保护 |

Key 存储安全建议：
- 设置面板中的 Key 存储于 macOS `SharedPreferences`（App 沙箱内），仅本机可读。
- `.env` 文件已加入 `.gitignore`，切勿提交至代码仓库。

