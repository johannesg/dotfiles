# If not running interactively, don't do anything

[ -z "$PS1" ] && return

# Shell

if [ -n "$ZSH_VERSION" ]; then
   SHELL_ZSH=true
   SHELL_BASH=false
elif [ -n "$BASH_VERSION" ]; then
   SHELL_BASH=true
   SHELL_ZSH=false
fi

# OS

if [ "$(uname -s)" = "Darwin" ]; then
    OS="OSX"
else
    OS=`uname -s`
fi

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)

READLINK=$(which greadlink || which readlink)
if $SHELL_BASH; then
    CURRENT_SCRIPT=${BASH_SOURCE}
else
    CURRENT_SCRIPT=${0}
fi

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
    SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
    DOTFILES_DIR=$(dirname ${SCRIPT_PATH})
elif [ -d "$HOME/.dotfiles" ]; then
    DOTFILES_DIR="$HOME/.dotfiles"
else
    echo "Unable to find dotfiles, exiting."
    return # `exit 1` would quit the shell itself
fi


source $DOTFILES_DIR/.aliases
source $DOTFILES_DIR/.profile
source $DOTFILES_DIR/.path

# Clean up

unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE

# Export

export SHELL_BASH SHELL_ZSH OS DOTFILES_DIR

