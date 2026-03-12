# 基础镜像：Ubuntu 24.04 LTS
FROM ubuntu:24.04

# 安装StrongSwan及依赖插件，清理apt缓存减小镜像体积
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        strongswan \
        strongswan-swanctl \
        curl \
        libstrongswan-extra-plugins \
        libcharon-extra-plugins \
        libcharon-extauth-plugins \
        libstrongswan-standard-plugins && \
    rm -rf /var/lib/apt/lists/*

# 重置并导入系统信任证书到StrongSwan证书目录
RUN rm -f /etc/ipsec.d/cacerts/* && \
    ln -s /etc/ssl/certs/* /etc/ipsec.d/cacerts/

# 复制配置文件到容器对应目录
COPY ipsec.conf /etc/ipsec.conf
COPY revocation.conf /etc/strongswan.d/charon/revocation.conf
COPY entrypoint.sh /entrypoint.sh

# 赋予启动脚本执行权限
RUN chmod +x /entrypoint.sh

# 容器启动命令
CMD ["/entrypoint.sh"]