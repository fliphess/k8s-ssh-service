FROM debian:buster
MAINTAINER Flip Hess <flip@fliphess.com>

## Expose ssh port
EXPOSE 22

## Install packages
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
    moreutils \
    net-tools \
    netcat \
    nmap \
    openssh-server \
    pg-activity \
    pgbadger \
    pgtop \
    postgresql-client-common \
    postgresql-client \
    procps \
    psmisc \
    pspg \
    readline-common \
    rsync \
    screen \
    ssh \
    telnet \
    time \
    traceroute \
    vim \
    wget \
    zip \
    zsh \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

## Configure locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && dpkg-reconfigure --frontend=noninteractive locales \
 && update-locale LANG=en_US.UTF-8

## Set locale environment vars
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

## Create required files for sshd to start
RUN mkdir -p /var/run/sshd \
 && touch /var/log/wtmp \
 && chmod 0664 /var/log/wtmp \
 && rm /etc/ssh/ssh_host* \
 && ssh-keygen -A \
 && rm /etc/ssh/ssh_host*.pub

## Copy configuration files and scripts
COPY config/nsswitch.conf /etc
COPY config/hosts.deny /etc
COPY config/ssh-key-command /usr/local/bin
COPY config/create-home /usr/local/bin
COPY config/users /etc/users

## Configure pam to run a script on SSH login (used for homedir creation)
RUN bash -c 'echo "session optional pam_exec.so seteuid /usr/local/bin/create-home" >> /etc/pam.d/sshd'

## Set permissions on the scripts that ssh executes
RUN chmod 0755 /usr/local/bin/ssh-key-command /usr/local/bin/create-home \
 && chown root:root /usr/local/bin/ssh-key-command /usr/local/bin/create-home

WORKDIR /home
CMD ["/usr/sbin/sshd", "-De"]

