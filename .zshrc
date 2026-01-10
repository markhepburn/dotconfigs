# OVERVIEW: This should mostly be ohmyzsh plugins, aliases, and other settings.
# Environment variables should mostly go in .zprofile

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
    extract
    fzf
    fzf-marks                   # https://github.com/urbainvaes/fzf-marks
    git
    git-flow
    httpie
    jj
    jq                          # https://github.com/reegnz/jq-zsh-plugin
    knife
    lein
    mise
    mix
    mosh
    node
    pip
    rust
    thefuck
    uv
    vagrant
    virtualenv
    virtualenvwrapper
    # zsh-aliases-exa
    zsh-aliases-lsd
)

# https://megamorf.gitlab.io/2021/04/21/add-zsh-autocompletion-to-bitwarden-cli/
# Disabled because it takes ages to run!
# eval "$(bw completion --shell zsh); compdef _bw bw;"

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

alias bat=batcat                # bat is in apt now, but renamed to avoid a conflict
alias cat=bat

chpwd_source_vars() {
    if [[ -s "$PWD/.set_env" ]] ; then
        source "$PWD/.set_env"
    fi
}
chpwd_functions=(${chpwd_functions[@]} "chpwd_source_vars")

# # https://github.com/natethinks/jog
# # See `man zshcontrib` for details
# function zshaddhistory() {
# 	echo "${1%%$'\n'}|${PWD}   " >> ~/.zsh_history_ext
# }

# # CDPATH: https://superuser.com/questions/265547/zsh-cdpath-and-autocompletion
# if [ -d "$HOME/Projects/" ]; then
#     cdpath=(. ~/Projects/)
# fi

# https://superuser.com/a/286713
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %S%d%s

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# [ -f "/home/mark/.ghcup/env" ] && source "/home/mark/.ghcup/env" # ghcup-env

# Option: replace docker with (root-less) podman
# Ref https://codepre.com/en/use-docker-compose-con-podman-para-orquestar-contenedores-en-fedora-linux.html
# alias docker=podman
# for docker-compose:
export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock

EAT_SHELL_INTEGRATION_DIR=$(ls -d ~/.emacs.d/elpa/eat-*/integration)
[ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
  source "$EAT_SHELL_INTEGRATION_DIR/zsh"

# https://github.com/astral-sh/uv/issues/1910#issuecomment-1963047776
uvsh() {
    local venv_name=${1:-'.venv'}
    venv_name=${venv_name//\//} # remove trailing slashes (Linux)
    venv_name=${venv_name//\\/} # remove trailing slashes (Windows)

    local venv_bin=
    if [[ -d ${WINDIR} ]]; then
        venv_bin='Scripts/activate'
    else
        venv_bin='bin/activate'
    fi

    local activator="${venv_name}/${venv_bin}"
    echo "[INFO] Activate Python venv: ${venv_name} (via ${activator})"

    if [[ ! -f ${activator} ]]; then
        echo "[ERROR] Python venv not found: ${venv_name}"
        return
    fi

    # shellcheck disable=SC1090
    . "${activator}"
}

# https://news.ycombinator.com/item?id=35256206
# atuin + fzf integration:
atuin-setup() {
    if ! which atuin &> /dev/null; then return 1; fi
    # bindkey '^E' _atuin_search_widget

    export ATUIN_NOBIND="true"
    eval "$(atuin init zsh)"
    fzf-atuin-history-widget() {
        local selected num
        setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null

        # local atuin_opts="--cmd-only --limit ${ATUIN_LIMIT:-5000}"
        local atuin_opts="--cmd-only"
        local fzf_opts=(
            --height=${FZF_TMUX_HEIGHT:-40%}
            --tac
            "-n2..,.."
            --tiebreak=index
            "--query=${LBUFFER}"
            "+m"
            "--bind=ctrl-d:reload(atuin search $atuin_opts -c $PWD),ctrl-r:reload(atuin search $atuin_opts)"
        )

        selected=$(
            eval "atuin search ${atuin_opts} -c $PWD" |
                fzf "${fzf_opts[@]}"
                )
        local ret=$?
        if [ -n "$selected" ]; then
            # use += to insert at current pos instead of replacing
            LBUFFER="${selected}"
        fi
        zle reset-prompt
        return $ret
    }
    zle -N fzf-atuin-history-widget
    bindkey '^R' fzf-atuin-history-widget
}
# atuin-setup
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
