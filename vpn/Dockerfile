FROM ubuntu:24.04

# Ubuntu 24.04 arm64 换清华源（新格式 ubuntu.sources）
RUN if [ "$(dpkg --print-architecture)" = "arm64" ]; then  \
      printf 'Types: deb\nURIs: http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports\nSuites: noble noble-updates noble-backports\nComponents: main restricted universe multiverse\nSigned-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg\n\nTypes: deb\nURIs: http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports\nSuites: noble-security\nComponents: main restricted universe multiverse\nSigned-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg\n' > /etc/apt/sources.list.d/ubuntu.sources; \
    else \
      printf 'Types: deb\nURIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu\nSuites: noble noble-updates noble-backports\nComponents: main restricted universe multiverse\n\nSigned-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg\n\nTypes: deb\nURIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu\nSuites: noble-security\nComponents: main restricted universe multiverse\nSigned-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg\n' > /etc/apt/sources.list; \
    fi

RUN apt-get update && apt-get install -y --no-install-recommends strongswan strongswan-swanctl curl ca-certificates libstrongswan-extra-plugins libcharon-extra-plugins libcharon-extauth-plugins libstrongswan-standard-plugins && update-ca-certificates && rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/ipsec.d/cacerts/* && find /etc/ssl/certs -name "*.pem" -exec ln -s {} /etc/ipsec.d/cacerts/ \;

RUN echo "include /etc/ipsec.d/*.conf" > /etc/ipsec.conf

COPY ipsec.conf /etc/ipsec.d/sjtu.conf
COPY revocation.conf /etc/strongswan.d/charon/revocation.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]