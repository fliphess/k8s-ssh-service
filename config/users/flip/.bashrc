# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

export PS1='\[\033[01;34m\]\D{%d-%m-%Y} \t \[\033]0;\D{%d-%m-%Y} \h:\w\007\]\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[01;31m\]\[\033[01;32m\] \$ \[\033[00m\]'

# complete things that have been typed in the wrong case
set completion-ignore-case on

# notify when jobs running in background terminate
set -o notify

# no empty completion (bash>=2.04 only)
shopt -s no_empty_cmd_completion

# (core file size) don't want any coredumps
ulimit -S -c 0

# set umask
umask 022
