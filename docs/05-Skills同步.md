# 05 - Skills 同步

> 目标：同步 Claude Code 全局技能包到新电脑

## 前置条件

- 已完成 [04 - npm 配置安装](./04-npm配置安装.md)
- 已安装 j-skills 并链接 jacky-skills 仓库

---

## 概述

Claude Code Skills 分为两类：

| 类型 | 存放位置 | 同步方式 |
|------|----------|----------|
| 个人 Skills | `~/jacky-github/jacky-skills/` | git clone + j-skills link |
| 社区 Skills | `~/.agents/skills/` | rsync 从本地同步 |

同步后的符号链接结构：

```
~/.claude/skills/
├── agent-browser -> ~/.agents/skills/agent-browser
├── bilibili-to-obsidian -> ~/jacky-github/jacky-skills/bilibili-to-obsidian
├── claude-monitor -> ~/jacky-github/jacky-skills/claude-monitor
└── ...
```

---

## 完整同步流程

### 步骤一：确保 jacky-skills 已克隆并链接

```bash
# 克隆仓库（如未克隆）
cd ~/jacky-github
git clone https://github.com/wangjs-jacky/jacky-skills.git

# 链接所有 skills
cd jacky-skills
for dir in */; do
  skill_dir="$HOME/jacky-github/jacky-skills/${dir%/}"
  if [ -f "$skill_dir/SKILL.md" ] || [ -f "$skill_dir/skill.md" ]; then
    j-skills link "$skill_dir"
  fi
done

# 验证
j-skills link --list
```

### 步骤二：同步社区 Skills（从本地电脑）

在**本地电脑**执行：

```bash
# 设置目标 IP
TARGET_IP="10.18.109.171"

# 同步 .agents/skills
rsync -avz ~/.agents/skills/ jacky@$TARGET_IP:~/.agents/skills/
```

### 步骤三：运行 Skills 同步脚本

在**新电脑**执行：

```bash
cd ~/jacky-github/jacky-mac-config/docs/scripts
./setup-claude-skills.sh
```

### 步骤四：验证

```bash
# 检查 Claude Code Skills
ls -la ~/.claude/skills/

# 统计数量
ls ~/.claude/skills/ | wc -l
```

---

## 一键命令（SSH 远程执行）

从本地电脑一键同步：

```bash
TARGET_IP="10.18.109.171"

# 1. 同步社区 Skills
rsync -avz ~/.agents/skills/ jacky@$TARGET_IP:~/.agents/skills/

# 2. 运行同步脚本
ssh jacky@$TARGET_IP '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

cd ~/jacky-github/jacky-mac-config/docs/scripts
./setup-claude-skills.sh

echo "=== Skills 同步完成 ==="
ls ~/.claude/skills/ | wc -l
'
```

---

## Skills 清单

### 个人 Skills（jacky-skills）

| Skill | 说明 |
|-------|------|
| `agent-browser-troubleshooting` | agent-browser 故障排查 |
| `bilibili-to-obsidian` | B站视频提取到 Obsidian |
| `claude-monitor` | Claude Code 会话监控 |
| `config-obsidian` | Obsidian 同步配置 |
| `creator-skills` | Skills 创建工具 |
| `fix-neat-video` | 修复 Neat 下载视频 |
| `github-repo-publish` | GitHub 仓库发布 |
| `long-running-agent` | 长时间运行 Agent |
| `video-to-text` | 视频转文字 |

### 社区 Skills（.agents/skills）

| Skill | 说明 |
|-------|------|
| `agent-browser` | 浏览器自动化 CLI |
| `find-skills` | 发现和安装 Skills |
| `tauri-v2` | Tauri v2 跨平台开发 |
| `vercel-composition-patterns` | React 组合模式 |
| `vercel-react-best-practices` | React/Next.js 性能优化 |
| `vercel-react-native-skills` | React Native 最佳实践 |
| `web-design-guidelines` | Web 设计指南 |

---

## 常见问题

### Q: 为什么社区 Skills 需要 rsync？

社区 Skills 来源各异（手动创建、从其他地方安装等），没有统一的 git 仓库管理，所以直接从本地同步最可靠。

### Q: 如何添加新的个人 Skill？

```bash
# 1. 在 jacky-skills 仓库创建目录
cd ~/jacky-github/jacky-skills
mkdir my-new-skill
echo "# My New Skill" > my-new-skill/SKILL.md

# 2. 链接到全局
j-skills link ~/jacky-github/jacky-skills/my-new-skill

# 3. 运行同步脚本
cd ~/jacky-github/jacky-mac-config/docs/scripts
./setup-claude-skills.sh
```

### Q: Skill 链接断了怎么办？

```bash
# 重新运行同步脚本
./setup-claude-skills.sh
```

### Q: 如何查看所有已启用的 Skills？

```bash
# Claude Code 启动时会显示
# 或查看符号链接
ls -la ~/.claude/skills/
```

---

## 下一步

[06 - 配置开发环境](./06-配置开发环境.md)
