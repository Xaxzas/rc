# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Helper scripts
# You may want to put all your additions into a separate file like
# ~/.bash_scripts, instead of adding them here directly.
if [ -f ~/.bash_scripts ]; then
    . ~/.bash_scripts
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

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    DARKBLUE="\[\e[0;34m\]"
    BLUE="\[\e[1;34m\]"
    WHITE="\[\e[1;37m\]"
    CLEARCOLOR="\[\e[0m\]"
    PS1="\n$DARKBLUE\342\224\214\342\224\200$BLUE[\$(get_battery)$BLUE]$DARKBLUE\342\224\200$BLUE[$WHITE\t$BLUE]$DARKBLUE\342\224\200$BLUE[$WHITE\$(chop_dir)$BLUE]$DARKBLUE\n\342\224\224\342\224\200$BLUE[$(if [[ $? == 0 ]]; then echo "\[\033[01;32m\]\342\234\223"; else echo "\[\033[01;31m\]\342\234\227"; fi)$BLUE]$DARKBLUE\342\224\200$BLUE[$WHITE\u$BLUE@$WHITE\h$BLUE]$DARKBLUE\342\224\200>$CLEARCOLOR "
    PS2="\342\224\200>"
else
    PS1='[\u@\h \W]\$ '
    PS2='> '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
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

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# completion for sudo and man
complete -cf sudo
complete -cf man

# exporting things

export EDITOR="nano"

export PATH=~/bin:$PATH
export ANDROID_SDK=/opt/android-sdk
export ANDROID_NDK=/opt/android-ndk
if [[ -d $ANDROID_SDK ]] ; then
    export PATH=$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH
fi
if [[ -d $ANDROID_NDK ]] ; then
    export PATH=$ANDROID_NDK:$ANDROID_NDK/prebuilt/linux-x86/bin:$ANDROID_NDK/toolchains/arm-linux-androideabi-4.7/prebuilt/linux-x86/bin:$PATH
fi

# auto cd into folders
shopt -s autocd

# display system information
if [[ "`get_distribution`" == "archlinux" ]] ; then
    archey
elif [[ "`get_distribution`" == "debian" ]] ; then
    # run some debian specific info tool
    echo "no info"
fi