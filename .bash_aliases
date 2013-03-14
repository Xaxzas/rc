# ~/.bash_aliases: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'

alias diff='colordiff'              # requires colordiff package
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias nano='nano -w'
alias ping='ping -c 4'
alias ..='cd ..'
alias pgrep='ps aux | grep $1'
alias reboot='sudo reboot'
alias halt='sudo halt'

alias pac="sudo pacman -S"		    # default action - install one or more packages
alias pacs="sudo pacman -Ss"		# '[s]earch' - search for a package using one or more keywords
alias pacu="sudo pacman -Syu"		# '[u]pdate' - upgrade all packages to their newest version
alias sysctl="systemctl"
alias sysctle="systemctl enable"
alias sysctlr="systemctl restart"