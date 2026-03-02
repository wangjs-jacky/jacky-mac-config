#!/bin/bash
#
# Mac mini 服务器 GitHub SSH 配置脚本
# 用途：将本地的 GitHub SSH 配置复制到 Mac mini 服务器
#
# 使用方法：
#   1. 确保本地已有 GitHub SSH 密钥 (~/.ssh/id_rsa)
#   2. 修改下方 SERVER_IP 和 SERVER_USER 变量
#   3. chmod +x setup-github-ssh.sh && ./setup-github-ssh.sh
#

set -e

# ============ 配置区 ============
SERVER_IP="192.168.1.7"
SERVER_USER="jacky"
SERVER_PASSWORD="wangjiahao"

# GitHub 用户信息
GITHUB_USERNAME="wangjs-jacky"
GITHUB_EMAIL="2409277719@qq.com"
# ================================

echo "🚀 开始配置 Mac mini GitHub SSH..."

# 检查本地 SSH 密钥
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "❌ 本地没有找到 SSH 密钥，请先生成"
    exit 1
fi

# 使用 expect 自动化 SSH 操作
expect << EOF
set timeout 60

# 1. 创建 .ssh 目录
puts "\n📁 创建 .ssh 目录..."
spawn ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no ${SERVER_USER}@${SERVER_IP} "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
expect "password:"
send "${SERVER_PASSWORD}\r"
expect eof

# 2. 复制私钥
puts "\n🔑 复制 SSH 私钥..."
spawn scp -o PreferredAuthentications=password -o PubkeyAuthentication=no ~/.ssh/id_rsa ${SERVER_USER}@${SERVER_IP}:~/.ssh/
expect "password:"
send "${SERVER_PASSWORD}\r"
expect eof

# 3. 复制公钥
puts "\n🔓 复制 SSH 公钥..."
spawn scp -o PreferredAuthentications=password -o PubkeyAuthentication=no ~/.ssh/id_rsa.pub ${SERVER_USER}@${SERVER_IP}:~/.ssh/
expect "password:"
send "${SERVER_PASSWORD}\r"
expect eof

# 4. 设置权限、配置 Git、添加 GitHub host key
puts "\n⚙️  配置权限和 Git..."
spawn ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no ${SERVER_USER}@${SERVER_IP} "chmod 600 ~/.ssh/id_rsa && chmod 644 ~/.ssh/id_rsa.pub && chmod 700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null && git config --global user.name '${GITHUB_USERNAME}' && git config --global user.email '${GITHUB_EMAIL}' && echo 'CONFIG_DONE'"
expect {
    "password:" { send "${SERVER_PASSWORD}\r"; exp_continue }
    "CONFIG_DONE" { }
    timeout { puts "❌ 配置超时"; exit 1 }
}
expect eof

# 5. 测试 GitHub 连接
puts "\n🔗 测试 GitHub SSH 连接..."
spawn ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no ${SERVER_USER}@${SERVER_IP} "ssh -T git@github.com 2>&1"
expect "password:"
send "${SERVER_PASSWORD}\r"
expect eof

puts "\n"
EOF

echo ""
echo "✅ 配置完成！"
echo ""
echo "验证方式："
echo "  ssh ${SERVER_USER}@${SERVER_IP} 'git config --global --list | grep user'"
echo "  ssh ${SERVER_USER}@${SERVER_IP} 'ssh -T git@github.com'"
