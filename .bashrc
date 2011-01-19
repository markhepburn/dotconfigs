# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|screen)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# hep016 21/04/08; git completion
if [ -f ~/bin/git-completion.bash ]; then
    . ~/bin/git-completion.bash
fi


# options for `less': Respectively, include more detail in the prompt;
# display colours properly; and just dump output to console rather
# than paging if it's less than a page (with --quit-if-one-screen/-X
# being needed to prevent a subsequent redraw erasing the contents
# again).
# export LESS="-M -R -F -X"
export LESS="--LONG-PROMPT --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
export PAGER="/usr/bin/less"


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# include oracle client (sqlplus):
PATH=$PATH:/usr/lib/oracle/xe/app/oracle/product/10.2.0/client/scripts/

# autojump support:
if [ -f ~/src/elisp/j/j.sh ]; then
    . ~/src/elisp/j/j.sh
fi

# "compleat" (http://github.com/mbrubeck/compleat)
# . ~/src/haskell/compleat/compleat_setup

# http://www.shellarchive.co.uk/content/emacs_tips.html#export-variables-to-emacs
function export_emacs {
    if [ "$(emacsclient -e t)" != 't' ]; then
        return 1
    fi
    for name in "${@}"; do
        value=$(eval echo \"\$${name}\")
        emacsclient -e "(setenv \"${name}\" \"${value}\")" >/dev/null
    done
}


function fix_ssh_agent() {
    SSHAGENTPID=`ps -eo pid,cmd | grep ssh-agent | grep -v grep |sed 's/^ *//' | cut -f1 -d' '`
    if [ -z "$SSHAGENTPID" ]; then
        echo "Can't find a running instance of ssh-agent."
        exit -1
    fi
    SOCKFILE=`ls /tmp/keyring-*/socket.ssh | head -1`
    if [ -z "$SOCKFILE" ]; then
        echo "Can't find an auth socket."
        exit -2
    fi
    export SSH_AGENT_PID=$SSHAGENTPID
    export SSH_AUTH_SOCK="$SOCKFILE"
    unset SSHAGENTPID
    unset SOCKFILE
}

function canonicalise {
    local dirpart=`dirname $1`
    cd $dirpart && pwd -P
}
# used in scripts, so we export this:
export -f canonicalise

export PATH

