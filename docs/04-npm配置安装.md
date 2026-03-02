# 04 - npm 配置安装

> 目标：一键同步 npm 全局环境，包括镜像源配置和全局包

## 前置条件

- 已完成 [02 - 配置 GitHub](./02-配置GitHub.md)

---

## 完整安装流程

### 步骤一：安装 Node.js（nvm）

如果尚未安装 Node.js，先安装 nvm：

```bash
# 安装 nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# 加载 nvm（重新打开终端或执行）
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 安装最新 LTS 版本
nvm install --lts
nvm use --lts

# 验证
node -v
npm -v
```

### 步骤二：克隆配置仓库

```bash
mkdir -p ~/jacky-github
cd ~/jacky-github
git clone https://github.com/wangjs-jacky/jacky-mac-config.git
```

### 步骤三：运行安装脚本

```bash
cd ~/jacky-github/jacky-mac-config/docs/scripts
./setup-npm.sh
```

### 步骤四：设置镜像源

```bash
nrm use taobao
```

### 步骤五：链接 Skills

```bash
# 克隆 jacky-skills 仓库
cd ~/jacky-github
git clone https://github.com/wangjs-jacky/jacky-skills.git

# 批量链接所有 skills
cd ~/jacky-github/jacky-skills
for dir in */; do
  skill_dir="$HOME/jacky-github/jacky-skills/${dir%/}"
  if [ -f "$skill_dir/SKILL.md" ] || [ -f "$skill_dir/skill.md" ]; then
    j-skills link "$skill_dir"
  fi
done

# 验证
j-skills link --list
```

---

## 一键命令（SSH 远程执行）

如果从本地远程配置新电脑：

```bash
# 设置目标电脑 IP
TARGET_IP="10.18.109.171"

# 一键执行（复制整段）
ssh jacky@$TARGET_IP '
# 安装 nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 安装 Node.js
nvm install --lts
nvm use --lts

# 克隆并运行脚本
mkdir -p ~/jacky-github && cd ~/jacky-github
git clone https://github.com/wangjs-jacky/jacky-mac-config.git
cd jacky-mac-config/docs/scripts && ./setup-npm.sh

# 设置镜像源
nrm use taobao

# 克隆并链接 skills
cd ~/jacky-github
git clone https://github.com/wangjs-jacky/jacky-skills.git
cd jacky-skills
for dir in */; do
  skill_dir="$HOME/jacky-github/jacky-skills/${dir%/}"
  if [ -f "$skill_dir/SKILL.md" ] || [ -f "$skill_dir/skill.md" ]; then
    j-skills link "$skill_dir"
  fi
done

echo "=== 安装完成 ==="
node -v
npm list -g --depth=0 | head -5
'
```

---

## 同步内容清单

### 镜像源配置（nrm）

| 源名称 | 地址 | 用途 |
|--------|------|------|
| taobao | https://registry.npmmirror.com/ | 淘宝镜像（默认） |
| npm | https://registry.npmjs.org/ | 官方源 |

**切换镜像源：**

```bash
nrm use taobao  # 切换到淘宝源
nrm use npm     # 切换到官方源
nrm ls          # 查看所有源
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

## 验证安装

```bash
# 检查 Node.js
node -v

# 检查全局包
npm list -g --depth=0

# 检查镜像源
nrm current

# 检查 skills
j-skills link --list
```

---

## 常见问题

### Q: 如何查看当前全局安装的包？

```bash
npm list -g --depth=0
```

### Q: 如何切换镜像源？

```bash
nrm use taobao  # 淘宝源（国内推荐）
nrm use npm     # 官方源
```

### Q: 某个包安装失败怎么办？

单独安装：

```bash
npm install -g <package-name>
```

### Q: j-skills link --all 报错？

`j-skills` 没有 `--all` 参数，需要逐个链接：

```bash
cd ~/jacky-github/jacky-skills
for dir in */; do
  skill_dir="$HOME/jacky-github/jacky-skills/${dir%/}"
  if [ -f "$skill_dir/SKILL.md" ] || [ -f "$skill_dir/skill.md" ]; then
    j-skills link "$skill_dir"
  fi
done
```

---

## 下一步

[05 - 配置开发环境](./05-配置开发环境.md)
