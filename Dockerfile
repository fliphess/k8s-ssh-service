FROM python:3.8-slim-buster
MAINTAINER Mintlab Devops <ops@mintlab.nl>

EXPOSE 22

RUN apt-get update \
 && apt-get install -y \
    awscli \
    bash \
    bash-completion \
    ca-certificates \
    curl \
    dnsutils \
    iputils-ping \
    jq \
    keychain \
    openssh-server \
    procps \
    psmisc \
    rsync \
    screen \
    ssh \
    telnet \
    time \
    traceroute \
    wget \
    zip \
    zsh \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

RUN mkdir -p /var/run/sshd /etc/ssh/authorized_keys \
 && chmod 0751 /etc/ssh/authorized_keys \
 && touch /var/log/wtmp \
 && chmod 0664 /var/log/wtmp \
 && rm /etc/ssh/ssh_host* \
 && ssh-keygen -A

COPY config/sshd_config /etc/ssh/sshd_config
COPY config/user-config.json /usr/local/etc
COPY config/user-config.py /usr/local/bin
RUN python /usr/local/bin/user-config.py /usr/local/etc/user-config.json

WORKDIR /home
CMD    ["/usr/sbin/sshd", "-De"]
