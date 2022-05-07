# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"            # Note, also need the patched fonts to go with this.
ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="robbyrussell"
# others: jreese, lukerandall, af-magic, agnoster (powerline)

# This prevents the "user@host" bit in the agnoster theme:
DEFAULT_USER=$USER

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# virtualenvwrapper integration; plugin doesn't work on its own (fails sourcing bash completion):
export WORKON_HOME=~/.virtualenvs
mkdir -p $WORKON_HOME
PATH="/usr/share/virtualenvwrapper/:$PATH"

alias mkvirtualenv3="mkvirtualenv --python=`which python3`"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    aws
    asdf
    command-not-found
    direnv
    docker
    dotnet
    encode64
    exercism                    # in custom/ directory
    extract
    fd
    fzf
    git
    git-flow
    httpie
    knife
    lein
    mercurial
    mix
    mosh
    node
    pip
    ripgrep
    rust
    screen
    thefuck
    vagrant
    virtualenv
    virtualenvwrapper
    # zsh-aliases-exa
    zsh-aliases-lsd
)

# https://megamorf.gitlab.io/2021/04/21/add-zsh-autocompletion-to-bitwarden-cli/
eval "$(bw completion --shell zsh); compdef _bw bw;"

source $ZSH/oh-my-zsh.sh

# Enable loading of bash-style autocomplete:
autoload -U +X bashcompinit && bashcompinit

source /etc/bash_completion.d/azure-cli

# Fix the ctrl-T binding in favour of the existing one:
bindkey "^T" transpose-chars

# Customize to your needs...

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# options for `less': Respectively, include more detail in the prompt;
# display colours properly; and just dump output to console rather
# than paging if it's less than a page (with --quit-if-one-screen/-X
# being needed to prevent a subsequent redraw erasing the contents
# again).
# export LESS="-M -R -F -X"
export LESS="--LONG-PROMPT --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
export PAGER="/usr/bin/less"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias ip='ip --color'

# Custom scripts:
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# pip --user, etc:
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# locally-installed cabal binaries:
if [ -d "$HOME/.cabal/bin" ]; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

# ChefDK
if [ -d "/opt/chefdk/bin" ]; then
    PATH="/opt/chefdk/bin:$PATH"
fi

export TERM=xterm-256color

if [ -d "$HOME/Vendor/Android/Sdk" ]; then
    export ANDROID_HOME="$HOME/Vendor/Android/Sdk" # Deprecated now
    export ANDROID_SDK_ROOT="$ANDROID_HOME"
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

if [ -d "$HOME/Vendor/flutter" ]; then
    export PATH="$PATH:$HOME/Vendor/flutter/bin"
fi

export GOPATH=~/src/gopath
export PATH=$GOPATH:$GOPATH/bin:$PATH

chpwd_source_vars() {
    if [[ -s "$PWD/.set_env" ]] ; then
        source "$PWD/.set_env"
    fi
}
chpwd_functions=(${chpwd_functions[@]} "chpwd_source_vars")

# https://github.com/natethinks/jog
# See `man zshcontrib` for details
function zshaddhistory() {
	echo "${1%%$'\n'}|${PWD}   " >> ~/.zsh_history_ext
}

# # CDPATH: https://superuser.com/questions/265547/zsh-cdpath-and-autocompletion
# if [ -d "$HOME/Projects/" ]; then
#     cdpath=(. ~/Projects/)
# fi

# https://superuser.com/a/286713
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %S%d%s

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f "/home/mark/.ghcup/env" ] && source "/home/mark/.ghcup/env" # ghcup-env

# Option: replace docker with (root-less) podman
# Ref https://codepre.com/en/use-docker-compose-con-podman-para-orquestar-contenedores-en-fedora-linux.html
# alias docker=podman
# for docker-compose:
# export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
