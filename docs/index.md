# Mac 工作站配置手册

欢迎！这里记录了我配置新 Mac Mini/Studio 的完整步骤。

## 开始之前

确保你有：
- 一台新 Mac Mini/Studio（已开机、已完成初始设置）
- 一台本地 Mac（用于远程连接）
- 两者在同一个局域网内

## 配置步骤

1. [SSH 远程连接](./01-SSH远程连接.md)
2. [配置 GitHub](./02-配置GitHub.md)
3. Qv2ray 安装（待完成）
4. [npm 配置安装](./04-npm配置安装.md)
5. [Skills 同步](./05-Skills同步.md)
6. [Claude 全局配置](./06-Claude全局配置.md)
7. [软件同步](./07-软件同步.md)
8. 配置开发环境（待完成）

## 配套脚本

| 脚本 | 说明 |
|------|------|
| `scripts/setup-passwordless-ssh.sh` | 配置免密 SSH 登录 |
| `scripts/setup-github-ssh.sh` | 配置 GitHub SSH 密钥 |
| `scripts/setup-npm.sh` | npm 全局环境一键安装 |
| `scripts/setup-claude-skills.sh` | Claude Code Skills 同步 |

## 快速配置（远程一键执行）

从本地电脑远程配置新电脑：

```bash
# 设置目标 IP
TARGET_IP="10.18.109.171"

# 一键配置（复制整段执行）
ssh jacky@$TARGET_IP '
# 安装 nvm 和 Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts && nvm use --lts

# 克隆配置仓库
mkdir -p ~/jacky-github && cd ~/jacky-github
git clone https://github.com/wangjs-jacky/jacky-mac-config.git
git clone https://github.com/wangjs-jacky/jacky-skills.git

# 运行安装脚本
cd jacky-mac-config/docs/scripts
./setup-npm.sh
./setup-claude-skills.sh

# 设置镜像源
nrm use taobao

# 链接 j-skills
cd ~/jacky-github/jacky-skills
for dir in */; do
  skill_dir="$HOME/jacky-github/jacky-skills/${dir%/}"
  if [ -f "$skill_dir/SKILL.md" ] || [ -f "$skill_dir/skill.md" ]; then
    j-skills link "$skill_dir"
  fi
done

echo "=== 配置完成 ==="
node -v
npm list -g --depth=0 | wc -l
ls ~/.claude/skills/ | wc -l
'
```

**注意**：以下内容需要从本地同步：
```bash
# 1. 同步社区 Skills
rsync -avz ~/.agents/skills/ jacky@$TARGET_IP:~/.agents/skills/

# 2. 同步 CLAUDE.md
ssh jacky@$TARGET_IP 'mkdir -p ~/.claude'
scp ~/.claude/CLAUDE.md jacky@$TARGET_IP:~/.claude/CLAUDE.md
```
