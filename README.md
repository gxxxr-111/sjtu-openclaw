# sjtu-openclaw

本项目将 OpenClaw 容器化，并内置交大 VPN 连接，开箱即用，无需手动配置网络环境。

## 快速开始

### 1. 克隆项目仓库

```bash
git clone https://github.com/gxxxr-111/sjtu-openclaw.git
cd sjtu-openclaw
```

### 2. 交大账号信息配置

```bash
cp .env.example .env
```

打开 `.env` 文件，替换为你的 jAccount 账号：

```bash
SJTU_USERNAME=你的交大jAccount账号
```

写入 jAccount 密码（权限仅当前用户可读）

```bash
mkdir secrets
echo "你的交大jAccount密码" > secrets/sjtu_password.txt
chmod 600 secrets/sjtu_password.txt
```

### 3. 启动并初始化 OpenClaw

```bash
docker compose up -d
docker exec -it sjtu-openclaw openclaw setup
```

### 4. 开放网关至局域网

进入容器终端：

```bash
docker exec -it sjtu-openclaw bash
```

执行以下指令开放局域网访问（安全优于 `0.0.0.0`，仅同网段设备可访问）：

```bash
openclaw config set gateway.bind lan
```

### 5. 启动 UI 面板并完成设备配对

1. 若已退出容器终端，重新进入：

```bash
docker exec -it sjtu-openclaw bash
```

2. 启动 Dashboard（不自动打开浏览器）：

```bash
openclaw dashboard --no-open
```

> 提示：执行后会输出 Dashboard URL（含 Token），复制该链接在浏览器打开即可进入 UI 面板。

此时 `Dashboard URL` 是一个带 `token` 并基于 `127.0.0.1` 的连接，点击后即可进入 UI 面板，但还需添加许可。

3. 查看待配对设备的请求 ID：

```bash
openclaw devices list
```

> 示例输出：RequestID: abc123 | Device: iPhone | IP: 192.168.1.105

4. 批准设备访问许可（替换 `<RequestID>` 为实际编号）：

```bash
openclaw devices approve <RequestID>
```

### 6. 进一步的配置

在 `bash` 中执行：

```bash
openclaw onboard --install-daemon
```

- 交大模型 API 基础地址：`https://models.sjtu.edu.cn/api/v1`
- API 规范：`Anthropic-compatible endpoint`，自动检测应匹配此规范。

更多配置可参考 [OpenClaw 官方仓库](https://github.com/openclaw/openclaw).

### 7. 注意事项

- `secrets/sjtu_password.txt` 已在 `.gitignore` 中，请勿手动提交；
- VPN 会在断线后自动重连；
- OpenClaw 配置存储在 Docker volume openclaw-data 中，重建容器不会丢失。