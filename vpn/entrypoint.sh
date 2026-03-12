#!/bin/bash
set -e

echo "==> Reading credentials..."
PASSWORD=$(cat /run/secrets/sjtu_password)

# 写入用户名
sed -i "s/PLACEHOLDER_USERNAME/${SJTU_USERNAME}/g" /etc/ipsec.d/sjtu.conf

# 写入密钥
cat > /etc/ipsec.secrets << EOF
"${SJTU_USERNAME}" : EAP "${PASSWORD}"
EOF
chmod 600 /etc/ipsec.secrets

echo "==> Starting strongswan..."
ipsec start
sleep 3

echo "==> Reloading config..."
ipsec reload
sleep 1

echo "==> Connecting to SJTU VPN..."
ipsec up sjtu-student

echo "==> VPN connected."

# 保持运行，定期检查 VPN 状态
while true; do
    sleep 60
    ipsec status sjtu-student | grep -q "ESTABLISHED" || {
        echo "==> VPN dropped, reconnecting..."
        ipsec up sjtu-student
    }
done