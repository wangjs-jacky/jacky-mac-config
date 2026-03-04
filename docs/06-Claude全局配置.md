# 06 - Claude 全局配置

> 目标：同步 Claude Code 全局 CLAUDE.md 配置文件

## 前置条件

- 已完成 [05 - Skills 同步](./05-Skills同步.md)

---

## 概述

`~/.claude/CLAUDE.md` 是 Claude Code 的全局配置文件，为所有项目提供上下文指导。

### 配置内容

| 章节 | 说明 |
|------|------|
| 用户信息 | GitHub、Obsidian 等个人信息 |
| Skills 配置变量 | 供 skills 读取的路径和密钥 |
| npm 组织配置 | @wangjs-jacky 命名规范 |
| 语言要求 | 强制中文输出 |
| Git 操作配置 | 代理设置 |
| Skills 管理 | jacky-skills 仓库管理 |
| CLI 工具技术栈 | 推荐的依赖库 |
| Obsidian 写作规范 | 笔记模板和风格 |

---

## 完整同步流程

### 步骤一：同步 CLAUDE.md（从本地电脑）

在**本地电脑**执行：

```bash
TARGET_IP="10.18.109.171"

# 同步 CLAUDE.md
scp ~/.claude/CLAUDE.md jacky@$TARGET_IP:~/.claude/CLAUDE.md
```

### 步骤二：验证

```bash
ssh jacky@$TARGET_IP 'cat ~/.claude/CLAUDE.md | head -30'
```

---

## 一键命令（SSH 远程执行）

```bash
TARGET_IP="10.18.109.171"

# 确保 .claude 目录存在
ssh jacky@$TARGET_IP 'mkdir -p ~/.claude'

# 同步 CLAUDE.md
scp ~/.claude/CLAUDE.md jacky@$TARGET_IP:~/.claude/CLAUDE.md

echo "=== CLAUDE.md 同步完成 ==="
ssh jacky@$TARGET_IP 'head -10 ~/.claude/CLAUDE.md'
```

---

## 配置文件模板

如果无法从本地同步，可以使用以下模板：

```markdown
# CLAUDE.md - 全局配置

此文件为 Claude Code 提供全局级别的上下文指导，适用于所有项目。

## 用户信息

- **GitHub 用户名**: wangjs-jacky
- **GitHub 主页**: https://github.com/wangjs-jacky
- **GitHub 项目目录**: /Users/jacky/jacky-github
- **Obsidian 仓库**: /Users/jacky/jacky-github/jacky-obsidian
- **VSCode 插件 Publisher**: jackywjs

### 简写别名

- **ob** = Obsidian

## Skills 配置变量

| 配置变量 | 说明 | 当前值 |
|----------|------|--------|
| `OBSIDIAN_REPO` | Obsidian 仓库路径 | `/Users/jacky/jacky-github/jacky-obsidian` |
| `OBSIDIAN_VAULT_NAME` | Obsidian 仓库名称 | `jacky-obsidian` |
| `OBSIDIAN_REST_API_KEY` | Local REST API 密钥 | `<需要配置>` |
| `OBSIDIAN_SYNC_MODE` | 同步模式（uri/rest） | `rest` |
| `VIDEO2TEXT_REPO` | video2text 项目路径 | `/Users/jacky/jacky-github/jacky-video-to-text` |
| `JACKY_SKILLS_DIR` | jacky-skills 项目路径 | `/Users/jacky/jacky-github/jacky-skills` |

## npm 组织配置

**所有 npm 包必须使用 scoped 命名规范：`@wangjs-jacky/<package-name>`**

- **npm Organization**: `@wangjs-jacky`
- **命名规则**: `@wangjs-jacky/xxxxx`

### 发布注意事项

1. 包名必须以 `@wangjs-jacky/` 开头
2. package.json 中设置 `"publishConfig": { "access": "public" }`
3. 发布前需要登录 npm: `npm login`
4. 发布命令: `npm publish`

## 语言要求

**所有回复必须使用中文。**

## Git 操作配置

当需要执行 Git 推送、拉取等与 GitHub 交互的操作时，**必须先配置代理**后再执行。

\`\`\`bash
# 设置代理
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890

# 操作完成后可取消代理
git config --global --unset http.proxy
git config --global --unset https.proxy
\`\`\`

## Skills 管理

**本地所有开发的 skills 必须使用 jacky-skills 项目管理。**

### 仓库位置

- **Skills 仓库**: `/Users/jacky/jacky-github/jacky-skills`
- **CLI 工具**: `/Users/jacky/jacky-github/jacky-skills-package`

### 常用命令

\`\`\`bash
# 列出已链接的 skills
j-skills link --list

# 列出全局已安装的 skills
j-skills list -g

# 安装 skill 到全局
j-skills install <skill-name> -g
\`\`\`

## CLI 工具技术栈参考

| 类别 | 推荐方案 | 说明 |
|------|----------|------|
| **CLI 框架** | `cac` | 轻量级命令行框架 |
| **Prompt UI** | `@clack/prompts` | Vercel 终端交互库 |
| **颜色/样式** | `picocolors` | 超轻量终端颜色库 |
| **构建工具** | `tsup` | 零配置打包工具 |
| **Git 操作** | `simple-git` | Git 客户端 |
| **Markdown 解析** | `gray-matter` | 解析 Markdown |
| **配置路径** | `xdg-basedir` | 跨平台配置目录 |
| **测试框架** | `vitest` | Vite 生态测试 |

## Obsidian 笔记写作规范

**核心原则：以分享的角度记录，让完全不懂的人也能看懂。**

### 写作风格

1. 假设读者是零基础
2. 使用步骤化表达
3. 提供完整示例

### 笔记结构模板

\`\`\`markdown
# 标题

> 一句话说明这篇笔记解决什么问题

## 一、基础概念
## 二、准备工作
## 三、详细步骤
## 四、常见问题
## 五、参考资料
\`\`\`
```

---

## 需要手动配置的项目

同步后需要手动修改的配置：

| 配置项 | 说明 |
|--------|------|
| `OBSIDIAN_REST_API_KEY` | Obsidian REST API 密钥（每台电脑不同） |
| 路径中的用户名 | `/Users/jiashengwang/` → `/Users/jacky/` |

---

## 常见问题

### Q: 为什么不用 rsync 同步？

CLAUDE.md 是单文件，scp 更简单直接。

### Q: 配置文件不生效怎么办？

确保文件路径正确：`~/.claude/CLAUDE.md`，然后重启 Claude Code。

### Q: 如何查看当前配置是否生效？

Claude Code 启动时会显示 `Contents of ~/.claude/CLAUDE.md`，表示已加载。

### Q: SSH 远程启动 Claude 报 ECONNREFUSED 错误怎么办？

**问题现象**：通过 SSH 远程启动 `cc` 时报错 `API Error: Unable to connect to API (ECONNREFUSED)`，但屏幕共享打开终端启动正常。

**根本原因**：`~/.config/zsh/zshrc` 中的 proxy alias 配置了错误的代理端口。

**排查步骤**：

```bash
# 1. 检查 debug 日志
tail -100 ~/.claude/debug/latest | grep -i error

# 2. 检查代理端口是否监听
nc -zv 127.0.0.1 7890   # ClashX HTTP 代理
nc -zv 127.0.0.1 10802  # 系统代理
nc -zv 127.0.0.1 10888  # SOCKS5 代理

# 3. 检查系统代理配置
scutil --proxy
```

**解决方案**：

1. 修改 `~/.config/zsh/zshrc` 中的 proxy alias，使用正确的代理端口：

```bash
# 查看当前配置
grep 'proxy' ~/.config/zsh/zshrc

# 修复端口（假设系统代理是 10802）
sed -i '' 's/127.0.0.1:7890/127.0.0.1:10802/g' ~/.config/zsh/zshrc
```

2. 杀掉残留进程并重启：

```bash
# 杀掉所有 claude 进程
pkill -f 'claude'
pkill -f 'happy-coder'

# 重新加载配置
source ~/.zshrc

# 重新启动
cc
```

**端口对照表**：

| 端口 | 用途 | 软件 |
|------|------|------|
| 7890 | HTTP 代理 | ClashX |
| 10802 | HTTP/HTTPS 代理 | Surge/ClashX Pro |
| 10888 | SOCKS5 代理 | Surge/ClashX Pro |

---

## 下一步

[07 - 配置开发环境](./07-配置开发环境.md)
