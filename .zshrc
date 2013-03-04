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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow mercurial lein command-not-found django extract pip screen knife)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Alias for SAP usage; assumes that launch.ica has been downloaded:
alias sap="/usr/lib/ICAClient/wfica ~/Downloads/launch.ica"

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

# locally-installed cabal binaries:
if [ -d "$HOME/.cabal/bin" ]; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

# include oracle client (sqlplus):
PATH=$PATH:/opt/oracle/product/11.2.0/client_1/
