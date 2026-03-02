#!/bin/bash
#
# 配置本地到 Mac mini 的免密 SSH 登录
# 用途：配置后 SSH/SCP 不需要再输入密码，大幅提升操作速度
#
# 使用方法：
#   chmod +x setup-passwordless-ssh.sh && ./setup-passwordless-ssh.sh
#

set -e

# ============ 配置区 ============
SERVER_IP="192.168.1.7"
SERVER_USER="jacky"
SERVER_PASSWORD="wangjiahao"
# ================================

echo "🚀 配置免密 SSH 登录..."

# 检查本地是否有 SSH 密钥
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo "❌ 本地没有 SSH 公钥，请先生成："
    echo "   ssh-keygen -t ed25519 -C 'your@email.com'"
    exit 1
fi

# 获取本地公钥
LOCAL_PUBKEY=$(cat ~/.ssh/id_rsa.pub)

# 使用 expect 将公钥添加到服务器的 authorized_keys
expect << EOF
set timeout 30

spawn ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no ${SERVER_USER}@${SERVER_IP} "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '${LOCAL_PUBKEY}' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && echo 'KEY_ADDED'"
expect {
    "password:" { send "${SERVER_PASSWORD}\r"; exp_continue }
    "KEY_ADDED" { }
    timeout { puts "❌ 超时"; exit 1 }
}
expect eof
EOF

echo ""
echo "✅ 免密登录配置完成！"
echo ""
echo "测试免密登录："
echo "  ssh ${SERVER_USER}@${SERVER_IP} 'echo 连接成功'"
