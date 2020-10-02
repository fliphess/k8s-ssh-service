FROM debian:buster
MAINTAINER Mintlab Devops <ops@mintlab.nl>

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

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
    locales \
    openssh-server \
    procps \
    psmisc \
    readline-common \
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

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && dpkg-reconfigure --frontend=noninteractive locales \
 && update-locale LANG=en_US.UTF-8

RUN mkdir -p /var/run/sshd \
 && touch /var/log/wtmp \
 && chmod 0664 /var/log/wtmp \
 && rm /etc/ssh/ssh_host* \
 && ssh-keygen -A

COPY config/nsswitch.conf /etc
COPY config/ssh-key-command /usr/local/bin

RUN chmod 0755 /usr/local/bin/ssh-key-command \
 && chown root:root /usr/local/bin/ssh-key-command

WORKDIR /home
CMD    ["/usr/sbin/sshd", "-De"]
