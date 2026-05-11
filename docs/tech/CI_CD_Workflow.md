# CI/CD 持续集成与发布流程

本文档描述了 Audio Translate Input 项目中自动化测试、构建签名和发布的 GitHub Actions 工作流。

## 分支策略

| 分支 | 角色 |
|--------|------|
| `master` | 活跃开发分支。日常提交在此。 |
| `main` | 稳定分支。Pull Request 目标分支。 |

两个分支在 push 和 PR 事件时均触发测试工作流。发布由向任一分支推送版本标签触发。

---

## 流水线总览

```
测试工作流（test.yml）:
    push / PR → flutter-tests

发布工作流（release.yml）:
    v* 标签 → test → build（编译+签名+公证） → release（GitHub Release）
```

---

## 测试工作流（`.github/workflows/test.yml`）

**名称：** Flutter Tests

### 触发条件

| 触发方式 | 条件 |
|---------|-----------|
| `push` | 推送到 `master` 或 `main` |
| `pull_request` | 目标为 `master` 或 `main` |
| `workflow_dispatch` | 手动触发 |

### 任务

#### `flutter-tests` — Flutter 单元测试与组件测试

**运行环境：** `macos-latest`
**工作目录：** `app_demo/`

步骤：
1. 检出代码仓库。
2. 设置 Flutter 3.32.0（stable 通道，启用缓存）。
3. `flutter pub get` — 安装依赖。
4. `flutter test --reporter expanded` — 运行所有 102 个单元测试，详细输出。
5. 生成 GitHub Step Summary，标明通过/失败状态（即使测试失败也会运行）。

> 所有测试均为本地运行，无需网络请求，无需 API Key，无外部依赖。

---

## 发布工作流（`.github/workflows/release.yml`）

**名称：** Release Build

### 触发条件

通过推送匹配 `v*` 的 Git 标签触发（如 `v1.0.0`、`v2.1.0-beta`）。

### 流水线概览

发布流水线包含三个串行阶段：

```
test → build → release
```

### 任务

#### 阶段 1：`test` — 发布前测试

**运行环境：** `macos-latest`

在任何构建之前运行完整 Flutter 测试套件：

1. Flutter 单元测试（在 `app_demo/` 中运行 `flutter test --reporter expanded`）。

测试必须全部通过，否则后续阶段不会启动。

#### 阶段 2：`build` — 编译、签名与公证

**运行环境：** `macos-latest`
**依赖：** `test`

1. 设置 Flutter 3.32.0。
2. 在 `app_demo/` 中运行 `flutter build macos --release`。
3. 导入 Developer ID 证书到临时 Keychain。
4. 对 `.app` 包执行代码签名（`codesign --deep --sign "Developer ID Application: ..."`）。
5. 将 `.app` 包打包为 `Audio Translate Input-macOS-<tag>.zip`。
6. 提交至 Apple 公证服务（`xcrun notarytool submit`）并等待结果。
7. 钉入公证票据（`xcrun stapler staple`）。
8. 上传签名公证后的 ZIP 为构建产物（`macos-build`）。

**所需 Secrets：**

| Secret | 用途 |
|--------|------|
| `CERTIFICATE_P12_BASE64` | Developer ID 证书（Base64 编码的 .p12） |
| `CERTIFICATE_PASSWORD` | 证书密码 |
| `KEYCHAIN_PASSWORD` | 临时 Keychain 密码 |
| `CODE_SIGN_IDENTITY` | 签名身份字符串（如 `Developer ID Application: ...`） |
| `DEVELOPMENT_TEAM` | Apple Developer Team ID |
| `APPLE_ID` | Apple 公证账号（Apple ID 邮箱） |
| `APPLE_APP_PASSWORD` | 应用专用密码（App-specific password） |
| `APPLE_TEAM_ID` | Developer Team ID（用于公证） |

#### 阶段 3：`release` — 创建 GitHub Release

**运行环境：** `ubuntu-latest`
**依赖：** `build`
**权限：** `contents: write`

1. 从阶段 2 下载 `macos-build` 产物。
2. 使用 `softprops/action-gh-release@v2` 创建 GitHub Release：
   - **Release 名称：** `Audio Translate Input <tag>`（如 "Audio Translate Input v1.0.0"）。
   - **正文：** 包含变更日志占位符和下载说明的模板。
   - **附件：** 已签名公证的 `Audio Translate Input-macOS-<tag>.zip`。
   - **预发布：** 如果标签包含 `beta` 或 `alpha`，自动标记为预发布。
   - **草稿：** `false`（立即发布）。

---

## 如何创建发布

1. 确保所有更改已提交并推送到 `master`（或 `main`）。

2. 更新 `app_demo/pubspec.yaml` 中的版本号。

3. 为提交打上版本标签：
   ```bash
   git tag v1.2.0
   git push origin v1.2.0
   ```

4. 发布工作流自动触发。在 GitHub Actions 选项卡中监控进度（整个流程约需 10–15 分钟，主要时间在 Apple 公证）。

5. 工作流完成后：
   - GitHub Release 出现在 **Releases** 下，附带已签名公证的 macOS ZIP 文件。
   - 用户下载 ZIP，解压后可直接运行，无需手动绕过 Gatekeeper。

6. 编辑 GitHub Release 以填写变更日志。

### 预发布 / Beta

要创建预发布，请在标签名称中包含 `beta` 或 `alpha`：

```bash
git tag v1.3.0-beta.1
git push origin v1.3.0-beta.1
```

这会自动将 GitHub Release 标记为预发布。

---

## 所需 GitHub Secrets

| Secret | 使用者 | 用途 |
|--------|---------|---------|
| `CERTIFICATE_P12_BASE64` | release（build 阶段） | Developer ID 代码签名证书（Base64 编码的 .p12） |
| `CERTIFICATE_PASSWORD` | release（build 阶段） | 证书密码 |
| `KEYCHAIN_PASSWORD` | release（build 阶段） | 临时 Keychain 密码 |
| `CODE_SIGN_IDENTITY` | release（build 阶段） | 签名身份字符串 |
| `DEVELOPMENT_TEAM` | release（build 阶段） | Apple Developer Team ID |
| `APPLE_ID` | release（build 阶段） | Apple 公证账号 |
| `APPLE_APP_PASSWORD` | release（build 阶段） | 应用专用密码 |
| `APPLE_TEAM_ID` | release（build 阶段） | Developer Team ID（用于公证） |

无需配置任何后端服务 Secret——所有 AI API Key 由用户在应用 Settings 面板或 `.env` 文件中自行配置，不经过 CI/CD 流水线。
