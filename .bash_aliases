#!/bin/bash
################################################################################
# rc files by XenGi                                                            #
# =================                                                            #
# use preinstall.sh to install needed packages                                 #
# see all files on github: https://github.com/XenGi/rc                         #
#                                                                              #
# ~/.bash_aliases: executed by bash(1) for non-login shells.                   #
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)     #
# for examples                                                                 #
################################################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -a'
alias lal='ls -lah'

# secure some commands
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'

# change standard behavier of standard tools
alias diff='colordiff'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias nano='nano -w'
alias ping='ping -c 4'
alias ..='cd ..'
alias pgrep='ps aux | grep $1'
alias reboot='sudo reboot'
alias halt='sudo halt'

# use own dede for dd
alias dd='dede'

# pacman and systemctl aliases for archlinux
if [[ "`get_distribution`" -eq "archlinux" ]] ; then
    alias pacman='pacman-color'
    alias pac='sudo pacman -S'
    alias pacs='sudo pacman -Ss'
    alias pacu='sudo pacman -Syu'
    alias sysctl='sudo systemctl'
    alias sysctle='sudo systemctl enable'
    alias sysctlr='sudo systemctl restart'
elif [[ "`get_distribution`" == "debian" ]] || [[ "`get_distribution`" == "raspbian" ]] ; then
    alias agu='sudo apt-get update'
    alias agug='sudo apt-get upgrade'
    alias agud='sudo apt-get dist-upgrade'
fi