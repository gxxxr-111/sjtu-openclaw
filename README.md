# sjtu-openclaw

本项目将 OpenClaw 容器化，并内置交大 VPN 连接，开箱即用，无需手动配置网络环境。

## 快速开始

### 1. 克隆项目
```bash
git clone https://github.com/gxxxr-111/sjtu-openclaw.git
cd sjtu-openclaw
```

### 2. 填写账号信息

```bash
cp .env.example .env
```

编辑 `.env`:

```bash
SJTU_USERNAME=你的交大账号
```

写入密码：
```bash
echo "你的交大密码" > secrets/sjtu_password.txt
chmod 600 secrets/sjtu_password.txt
```

### 3. 配置 OpenClaw

```bash
docker compose up -d vpn
docker exec -it sjtu-openclaw openclaw setup
```

### 4. 启动

```bash
docker compose up -d
docker logs -f sjtu-openclaw
```

### 5. 开放端口

```bash
docker exec -it sjtu-openclaw bash
```

在打开的 `bash` 中输入指令：

```bash
openclaw config set gateway.bind lan
```

### 6. 打开 UI 面板设置与设备配对

```bash
docker exec -it sjtu-openclaw bash
```

在打开的 `bash` 中输入指令：

```bash
openclaw dashboard --no-open
```

在 `bash` 中查看请求连接的设备：

```bash
openclaw devices list
```

许可请求码：

```bash
openclaw devices approve <RequestID>
```

### 7. 进一步的配置

在 `bash` 中执行：

```bash
openclaw onboard --install-daemon
```

涉及到模型时，交大 API Base URL 为 `https://models.sjtu.edu.cn/api/v1`

API 规范为 `Anthropic-compatible endpoint`，Auto Detect 结果应当与之一致。

更多配置方法，请参考 https://github.com/openclaw/openclaw.

### 8. 注意事项

- `secrets/sjtu_password.txt` 已在 `.gitignore` 中，请勿手动提交；
- VPN 会在断线后自动重连；
- OpenClaw 配置存储在 Docker volume openclaw-data 中，重建容器不会丢失。