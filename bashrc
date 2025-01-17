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

# Clean up

unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE

# Export

export SHELL_BASH SHELL_ZSH OS DOTFILES_DIR
export VISUAL=vim
export EDITOR="$VISUAL"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
# shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# up & down map to history search once a command has been started.
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

function _export_path {
    [[ -d $1 ]] && export PATH=$1:$PATH
}

_export_path "$HOME/.local/bin"

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#http://unix.stackexchange.com/questions/12107/how-to-unfreeze-after-accidentally-pressing-ctrl-s-in-a-terminal
stty -ixon
#stty stop undef

function _include {
    [[ -s $1 ]] && source $1
}

# Nodejs
if [ -d $HOME/.nvm ]; then
    export NVM_DIR=$HOME/.nvm
    _include "$NVM_DIR/nvm.sh"           # This loads nvm
    _include "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

source $DOTFILES_DIR/aliases
source $DOTFILES_DIR/functions

if [ $OS = "OSX" ]; then
    source $DOTFILES_DIR/osx
fi
 
# source $DOTFILES_DIR/shell/liquidprompt/liquidprompt

source $DOTFILES_DIR/prompt
source $DOTFILES_DIR/brewrc

# The next line updates PATH for the Google Cloud SDK.
# _include "$HOME/.local/google-cloud-sdk/path.bash.inc"

# The next line enables shell command completion for gcloud.
# _include "$HOME/.local/google-cloud-sdk/completion.bash.inc"

_include "$HOME/.asdf/asdf.sh"
_include "$HOME/.asdf/completions/asdf.bash"


#if [ -d $HOME/.cargo ]; then
#  _export_path "$HOME/.cargo/bin"
#  source <(rustup completions bash)
#fi

# Go etc
export GOPATH=~/.gocode
_export_path "/usr/local/go/bin"
_export_path "${GOPATH//://bin:}/bin"
_export_path "/usr/local/heroku/bin"
# _export_path "$HOME/.local/maven/bin"
_export_path "$HOME/.cargo/bin"
_export_path "$HOME/.krew/bin"

unset -f _include
unset -f _export_path

[ -s $HOME/.env ] && . $HOME/.env

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# complete -C /usr/bin/terraform terraform

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# bun
export BUN_INSTALL="$HOME/.bun"
[ -s "$BUN_INSTALL/bin/bun" ] && export PATH=$BUN_INSTALL/bin:$PATH

