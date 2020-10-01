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
    libnss-extrausers \
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

RUN mkdir -p /var/run/sshd \
 && touch /var/log/wtmp \
 && chmod 0664 /var/log/wtmp \
 && rm /etc/ssh/ssh_host* \
 && ssh-keygen -A

COPY config/nsswitch.conf /etc
COPY config/ssh-key-command /usr/local/bin

WORKDIR /home
CMD    ["/usr/sbin/sshd", "-De"]
