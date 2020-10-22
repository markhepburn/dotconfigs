# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"            # Note, also need the patched fonts to go with this.
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

if [ -e /home/mark/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mark/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

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
    command-not-found
    direnv
    django
    docker
    dotnet
    encode64
    exercism                    # in custom/ directory
    extract
    fd
    gem
    git
    git-flow
    httpie
    knife
    lein
    mercurial
    mix
    mosh
    node
    nvm
    pip
    rbenv
    ripgrep
    screen
    thefuck
    vagrant
    virtualenv
    virtualenvwrapper
)

source $ZSH/oh-my-zsh.sh

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

# rbenv support (installed via rbenv zsh plugin; will leave commented for now):
# if [ -d "$HOME/.rbenv/bin" ]; then
#     PATH="$HOME/.rbenv/bin:$PATH"
#     eval "$(rbenv init -)"
# fi

# ChefDK... note that this must appear before rbenv!
if [ -d "/opt/chefdk/bin" ]; then
    PATH="/opt/chefdk/bin:$PATH"
fi

export TERM=xterm-256color

if [ -d "$HOME/Vendor/Android/Sdk" ]; then
    export ANDROID_HOME="$HOME/Vendor/Android/Sdk"
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

# CDPATH: https://superuser.com/questions/265547/zsh-cdpath-and-autocompletion
if [ -d "$HOME/Projects/" ]; then
    cdpath=(. ~/Projects/)
fi

# https://superuser.com/a/286713
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %S%d%s

export DOTNET_CLI_TELEMETRY_OPTOUT=1

