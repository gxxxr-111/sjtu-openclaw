FROM node:22-slim

# Debian tsinghua mirrors
RUN printf 'Types: deb\nURIs: http://mirrors.tuna.tsinghua.edu.cn/debian\nSuites: bookworm bookworm-updates bookworm-backports\nComponents: main contrib non-free non-free-firmware\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg\n\nTypes: deb\nURIs: http://mirrors.tuna.tsinghua.edu.cn/debian-security\nSuites: bookworm-security\nComponents: main contrib non-free non-free-firmware\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg\n' \
    > /etc/apt/sources.list.d/debian.sources

RUN apt-get update && apt-get install -y --no-install-recommends git npm openssh-client ca-certificates curl iputils-ping && rm -rf /var/lib/apt/lists/*

RUN npm config set registry https://registry.npmmirror.com && git config --global url."https://github.com/".insteadOf "ssh://git@github.com/" && git config --global url."https://".insteadOf git://

RUN npm install -g openclaw

CMD ["openclaw"]