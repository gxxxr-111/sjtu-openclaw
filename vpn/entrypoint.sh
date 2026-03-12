#!/bin/bash
set -e

# 读取VPN密码
PASSWORD=$(cat /run/secrets/sjtu_password)

# 替换用户名占位符
sed -i "s/%SJTU_USERNAME%/${SJTU_USERNAME}/g" /etc/ipsec.conf

# 生成密钥文件
cat > /etc/ipsec.secrets << EOF
"${SJTU_USERNAME}" : EAP "${PASSWORD}"
EOF
chmod 600 /etc/ipsec.secrets

# 启动并连接VPN
ipsec start
sleep 3
ipsec up sjtu-student
echo "✅ SJTU VPN connected"

# 监控VPN状态，断连自动重连
while true; do
    sleep 60
    ipsec status sjtu-student | grep -q "ESTABLISHED" || {
        echo "⚠️ VPN dropped, reconnecting..."
        ipsec up sjtu-student
    }
done