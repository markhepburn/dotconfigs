# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

[ -f "/home/mark/.ghcup/env" ] && source "/home/mark/.ghcup/env" # ghcup-env

if [ -d "$HOME/Vendor/Android/Sdk" ]; then
    export ANDROID_HOME="$HOME/Vendor/Android/Sdk" # Deprecated now
    export ANDROID_SDK_ROOT="$ANDROID_HOME"
    PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
fi

if [ -d "$HOME/bin/_installs/flutter" ]; then
    PATH="$PATH:$HOME/bin/_installs/flutter/bin"
    export CHROME_EXECUTABLE=$(which chromium)
fi

export PATH

export SSH_AUTH_SOCK=/run/user/$UID/keyring/ssh

# for Emacs:
export LD_LIBRARY_PATH=~/Projects/tree-sitter

export TERM=xterm-256color

export DOTNET_CLI_TELEMETRY_OPTOUT=1
