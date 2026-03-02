# 04 - npm 配置安装

> 目标：一键同步 npm 全局环境，包括镜像源配置和全局包

## 前置条件

- 已完成 [02 - 配置 GitHub](./02-配置GitHub.md)
- 已安装 Node.js（推荐使用 nvm 管理）

---

## 快速开始

### 一键配置

```bash
# 下载并运行脚本
curl -fsSL https://raw.githubusercontent.com/wangjs-jacky/jacky-mac-config/main/docs/scripts/setup-npm.sh | bash
```

或者手动下载后运行：

```bash
git clone https://github.com/wangjs-jacky/jacky-mac-config.git
cd jacky-mac-config/docs/scripts
./setup-npm.sh
```

---

## 同步内容清单

### 镜像源配置（nrm）

| 源名称 | 地址 | 用途 |
|--------|------|------|
| taobao2 | https://registry.npmmirror.com/ | 淘宝镜像（默认） |
| npm | https://registry.npmjs.org/ | 官方源 |
| DDD | http://192.168.1.100:4873/ | 内网私有源 |
| trip | http://registry.npm.release.ctripcorp.com/ | 携程内网源 |

**切换镜像源：**

```bash
nrm use taobao2  # 切换到淘宝源
nrm use npm      # 切换到官方源
nrm ls           # 查看所有源
```

### 全局 npm 包

#### 核心工具

| 包名 | 说明 |
|------|------|
| `nrm` | 镜像源管理工具 |
| `corepack` | 包管理器管理（pnpm/yarn） |
| `npm` | npm 最新版 |

#### 开发工具

| 包名 | 说明 |
|------|------|
| `vsce` | VSCode 插件发布工具 |
| `generator-code` | VSCode 插件脚手架 |
| `yo` | Yeoman 脚手架 |
| `create-jmi` | 脚手架工具 |
| `0x` | Node.js 火焰图性能分析 |

#### AI/自动化工具

| 包名 | 说明 |
|------|------|
| `agent-browser` | 浏览器自动化 |
| `playwright` | 浏览器自动化测试 |
| `@midscene/cli` | AI 测试工具 |
| `@fission-ai/openspec` | OpenAPI 工具 |
| `happy-coder` | AI 编码助手 |
| `opencode-ai` | OpenCode AI |
| `@z_ai/coding-helper` | AI 编码助手 |
| `openclaw` | OpenClaw |
| `cc-glm-switch` | Claude Code GLM 切换 |
| `specify-cli` | Specify CLI |

#### 个人开发工具

| 包名 | 说明 |
|------|------|
| `@wangjs-jacky/glm-coding-plan-statusline` | GLM Coding Plan 状态栏 |
| `@wangjs-jacky/m3u8-dl` | M3U8 视频下载 |
| `@wangjs-jacky/video2text` | 视频转文字 |
| `j-skills` | Skills 管理工具 |
| `jacky-proxy` | 代理工具 |

---

## 本地开发工具

以下工具已发布到 npm，脚本会自动安装：

| 包名 | 说明 |
|------|------|
| `@wangjs-jacky/glm-coding-plan-statusline` | GLM Coding Plan 状态栏 |
| `@wangjs-jacky/m3u8-dl` | M3U8 视频下载 |
| `@wangjs-jacky/video2text` | 视频转文字 |
| `j-skills` | Skills 管理工具 |
| `jacky-proxy` | 代理工具 |

### jacky-skills 仓库

脚本会自动克隆 `jacky-skills` 仓库到 `~/jacky-github/jacky-skills`。

安装完成后，链接 skills：

```bash
cd ~/jacky-github/jacky-skills
j-skills link --all
```

---

## 常见问题

### Q: 如何查看当前全局安装的包？

```bash
npm list -g --depth=0
```

### Q: 如何切换镜像源？

```bash
nrm use taobao2  # 淘宝源（国内推荐）
nrm use npm      # 官方源
```

### Q: 某个包安装失败怎么办？

单独安装：

```bash
npm install -g <package-name>
```

### Q: 如何添加自定义镜像源？

```bash
nrm add <name> <url>
# 例如：nrm add company http://npm.company.com/
```

---

## 下一步

[05 - 配置开发环境](./05-配置开发环境.md)
