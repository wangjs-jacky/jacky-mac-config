#!/bin/bash

# ========================================
# npm 全局环境一键配置脚本
# ========================================

set -e

echo "=========================================="
echo "  npm 全局环境配置脚本"
echo "=========================================="

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 检查 Node.js 是否已安装
if ! command -v node &> /dev/null; then
    echo -e "${RED}错误: Node.js 未安装，请先安装 Node.js${NC}"
    exit 1
fi

echo -e "${GREEN}当前 Node 版本: $(node -v)${NC}"
echo -e "${GREEN}当前 npm 版本: $(npm -v)${NC}"
echo ""

# ----------------------------------------
# 步骤一：安装 nrm 并配置镜像源
# ----------------------------------------
echo -e "${YELLOW}[1/3] 配置 nrm 镜像源管理工具...${NC}"

if ! command -v nrm &> /dev/null; then
    echo "安装 nrm..."
    npm install -g nrm
else
    echo "nrm 已安装，跳过"
fi

# 添加自定义镜像源
echo "配置自定义镜像源..."

# 淘宝新源
nrm add taobao2 https://registry.npmmirror.com/ 2>/dev/null || true

# 公司/内网源（根据需要取消注释）
# nrm add DDD http://192.168.1.100:4873/ 2>/dev/null || true
# nrm add trip http://registry.npm.release.ctripcorp.com/ 2>/dev/null || true

# 设置默认源为淘宝（国内速度更快）
nrm use taobao2

echo -e "${GREEN}nrm 配置完成${NC}"
echo ""

# ----------------------------------------
# 步骤二：安装全局 npm 包
# ----------------------------------------
echo -e "${YELLOW}[2/3] 安装全局 npm 包...${NC}"

# 核心工具
CORE_PACKAGES=(
    "nrm"                    # 镜像源管理
    "corepack"               # 包管理器管理
    "npm"                    # npm 最新版
)

# 开发工具
DEV_PACKAGES=(
    "vsce"                   # VSCode 插件发布工具
    "generator-code"         # VSCode 插件脚手架
    "yo"                     # Yeoman 脚手架
    "create-jmi"             # 脚手架工具
    "0x"                     # Node.js 性能分析
)

# AI/自动化工具
AI_PACKAGES=(
    "agent-browser"          # 浏览器自动化
    "playwright"             # 浏览器自动化
    "@midscene/cli"          # AI 测试
    "@fission-ai/openspec"   # OpenAPI 工具
    "happy-coder"            # AI 编码助手
    "opencode-ai"            # OpenCode AI
    "@z_ai/coding-helper"    # AI 编码助手
    "openclaw"               # OpenClaw
    "cc-glm-switch"          # Claude Code GLM 切换
    "specify-cli"            # Specify CLI
)

# 个人开发工具（已发布到 npm）
PERSONAL_PACKAGES=(
    "@wangjs-jacky/glm-coding-plan-statusline"  # GLM Coding Plan 状态栏
    "@wangjs-jacky/m3u8-dl"                     # M3U8 视频下载
    "@wangjs-jacky/video2text"                  # 视频转文字
    "j-skills"                                   # Skills 管理工具
    "jacky-proxy"                                # 代理工具
)

# 安装函数
install_packages() {
    local category="$1"
    shift
    local packages=("$@")

    echo ""
    echo "安装 ${category}..."
    for pkg in "${packages[@]}"; do
        echo "  - $pkg"
    done

    npm install -g "${packages[@]}"
}

# 安装各类包
install_packages "核心工具" "${CORE_PACKAGES[@]}"
install_packages "开发工具" "${DEV_PACKAGES[@]}"
install_packages "AI/自动化工具" "${AI_PACKAGES[@]}"
install_packages "个人开发工具" "${PERSONAL_PACKAGES[@]}"

echo -e "${GREEN}全局包安装完成${NC}"
echo ""

# ----------------------------------------
# 步骤三：克隆 jacky-skills 仓库
# ----------------------------------------
echo -e "${YELLOW}[3/3] 克隆 jacky-skills 仓库...${NC}"

JACKY_GITHUB="$HOME/jacky-github"
SKILLS_REPO="$JACKY_GITHUB/jacky-skills"

if [ -d "$SKILLS_REPO" ]; then
    echo "jacky-skills 仓库已存在，跳过克隆"
else
    echo "创建目录 $JACKY_GITHUB"
    mkdir -p "$JACKY_GITHUB"

    echo "克隆 jacky-skills 仓库..."
    git clone https://github.com/wangjs-jacky/jacky-skills.git "$SKILLS_REPO"

    echo -e "${GREEN}jacky-skills 克隆完成${NC}"
fi

echo ""
echo "链接 skills 到全局："
echo "  cd $SKILLS_REPO && j-skills link --all"

# ----------------------------------------
# 完成
# ----------------------------------------
echo ""
echo "=========================================="
echo -e "${GREEN}  npm 环境配置完成！${NC}"
echo "=========================================="
echo ""
echo "已安装的全局包："
npm list -g --depth=0
echo ""
echo "当前镜像源："
nrm current
