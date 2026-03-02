#!/bin/bash

# ========================================
# Claude Code Skills 同步脚本
# ========================================

set -e

echo "=========================================="
echo "  Claude Code Skills 同步"
echo "=========================================="

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SKILLS_DIR="$HOME/.claude/skills"
JACKY_SKILLS="$HOME/jacky-github/jacky-skills"

# 创建 skills 目录
mkdir -p "$SKILLS_DIR"

# ----------------------------------------
# 从 jacky-skills 链接的 skills
# ----------------------------------------
echo -e "${YELLOW}链接 jacky-skills 中的 skills...${NC}"

JACKY_SKILLS_LIST=(
    "agent-browser-troubleshooting"
    "bilibili-to-obsidian"
    "claude-monitor"
    "config-obsidian"
    "creator-skills"
    "fix-neat-video"
    "github-repo-publish"
    "long-running-agent"
    "m3u8-dl"
    "ob-summary"
    "video-to-text"
)

for skill in "${JACKY_SKILLS_LIST[@]}"; do
    src="$JACKY_SKILLS/$skill"
    dest="$SKILLS_DIR/$skill"

    if [ -d "$src" ]; then
        if [ -L "$dest" ] || [ -d "$dest" ]; then
            rm -rf "$dest"
        fi
        ln -s "$src" "$dest"
        echo "  ✓ $skill"
    else
        echo "  ✗ $skill (源目录不存在)"
    fi
done

# ----------------------------------------
# 从 .agents/skills 链接的（j-skills install -g 安装）
# ----------------------------------------
echo ""
echo -e "${YELLOW}安装社区 skills...${NC}"

AGENTS_SKILLS=(
    "agent-browser"
    "find-skills"
    "tauri-v2"
    "vercel-composition-patterns"
    "vercel-react-best-practices"
    "vercel-react-native-skills"
    "web-design-guidelines"
)

for skill in "${AGENTS_SKILLS[@]}"; do
    src="$HOME/.agents/skills/$skill"
    dest="$SKILLS_DIR/$skill"

    # 如果 .agents/skills 中存在，直接链接
    if [ -d "$src" ]; then
        if [ -L "$dest" ] || [ -d "$dest" ]; then
            rm -rf "$dest"
        fi
        ln -s "$src" "$dest"
        echo "  ✓ $skill"
    else
        echo "  - $skill (需要手动安装: j-skills install $skill -g)"
    fi
done

# ----------------------------------------
# 完成
# ----------------------------------------
echo ""
echo "=========================================="
echo -e "${GREEN}  Skills 同步完成！${NC}"
echo "=========================================="
echo ""
echo "已安装的 skills："
ls -la "$SKILLS_DIR" | grep -E "^l|^d" | grep -v "^\." | awk '{print "  " $NF}'
