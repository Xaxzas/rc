#!/bin/bash
################################################################################
# rc files by XenGi                                                            #
# =================                                                            #
# use preinstall.sh to install needed packages                                 #
# see all files on github: https://github.com/XenGi/rc                         #
#                                                                              #
# ~/.bashrc: executed by bash(1) for non-login shells.                         #
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)     #
# for examples                                                                 #
################################################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Helper scripts
# You may want to put all your additions into a separate file like
# ~/.bash_scripts, instead of adding them here directly.
if [[ -f ~/.bash_scripts ]] ; then
    source ~/.bash_scripts
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [[ -n "$force_color_prompt" ]] ; then
    if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null ; then
	    # We have color support; assume it's compliant with Ecma-48
	    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	    # a case would tend to support setf rather than setaf.)
	    color_prompt=yes
    else
	    color_prompt=
    fi
fi

# setup of PS1 and PS2 with fancy colors if you enabled color_prompt
if [[ "$color_prompt" = yes ]] ; then
    # backup of original prompt
    #PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

    # blue theme
    DARKCOLOR="\[\e[0;34m\]"
    LIGHTCOLOR="\[\e[1;34m\]"

    # other colors
    WHITE="\[\e[1;37m\]"
    CLEARCOLOR="\[\e[0m\]"

    # prompt
    PS1="\n$DARKCOLOR\342\224\214\342\224\200$LIGHTCOLOR[\$(get_battery)$LIGHTCOLOR]$DARKCOLOR\342\224\200$LIGHTCOLOR[$WHITE\t$LIGHTCOLOR]$DARKCOLOR\342\224\200$LIGHTCOLOR[$WHITE\$(chop_dir)$LIGHTCOLOR]$DARKCOLOR\n\342\224\224\342\224\200$LIGHTCOLOR[$WHITE$?$LIGHTCOLOR]$DARKCOLOR\342\224\200$LIGHTCOLOR[$WHITE\$(get_proxy)$LIGHTCOLOR]$DARKCOLOR\342\224\200$LIGHTCOLOR[$WHITE\u$LIGHTCOLOR@$WHITE\h$LIGHTCOLOR]$DARKCOLOR\342\224\200>$CLEARCOLOR "
    PS2="\342\224\200>"
else
    PS1='[\u@\h : \W]\$ '
    PS2='> '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to [user@host : dir]
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;[\u@\h: \w]\a\]$PS1"
        ;;
    *)
        ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [[ -f ~/.bash_aliases ]] ; then
    source ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]] ; then
    source /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]] ; then
    source /etc/bash_completion
  fi
fi

# completion for sudo and man
complete -cf sudo
complete -cf man

# auto cd into folders
shopt -s autocd

# set standard editor
export EDITOR="nano"

# expand path to user bin dir
export PATH="~/bin":$PATH

# add android sdk and ndk to PATH
if [[ -d /opt/android-sdk ]] ; then
    export ANDROID_SDK="/opt/android-sdk"
    export PATH="$ANDROID_SDK/tools":$PATH
    export PATH="$ANDROID_SDK/platform-tools":$PATH
fi

if [[ -d /opt/android-ndk ]] ; then
    export ANDROID_NDK="/opt/android-ndk"
    export PATH="$ANDROID_NDK":$PATH
    export PATH="$ANDROID_NDK/prebuilt/linux-x86/bin":$PATH
    export PATH="$ANDROID_NDK/toolchains/arm-linux-androideabi-4.7/prebuilt/linux-x86/bin":$PATH
fi

# add Pygame subset for Android to PATH
if [[ -d /opt/pgs4a ]] ; then
    export PATH="/opt/pgs4a":$PATH
fi

# display system information
if [[ "`get_distribution`" == "raspbian" ]] ; then
    rpi_motd
elif [[ "`get_distribution`" != "unknown" ]] ; then
    archey
fi