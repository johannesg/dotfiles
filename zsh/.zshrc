# export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters
# load zgenom

if [ ! -d "${HOME}/.zgenom" ]; then
  git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then
    echo "Creating a zgenom save"

    zgenom load zsh-users/zsh-completions
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load zsh-users/zsh-syntax-highlighting

    zgenom save
     # Compile your zsh files
    zgenom compile "$HOME/.zshrc"
fi

# set the location and filename of the history file
export HISTFILE="$HOME/.zsh_history"

# set the maximum number of lines to be saved in the history file
export HISTSIZE="10000"
export SAVEHIST="$HISTSIZE"

# Share history in every terminal session
setopt SHARE_HISTORY
# append new history entries to the history file
setopt APPEND_HISTORY
# save each command to the history file as soon as it is executed
setopt INC_APPEND_HISTORY
# ignore recording duplicate consecutive commands in the history
setopt HIST_IGNORE_DUPS
# ignore commands that start with a space in the history
setopt HIST_IGNORE_SPACE


# enable auto completions
autoload -Uz compinit && compinit
# arrow driven completions
zstyle ':completion:*' menu select


# source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#
# search history using Up and Down keys
# >>> up arrow | down arrow
# bindkey "^[[A" history-beginning-search-backward
# bindkey "^[[B" history-beginning-search-forward
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char-or-list
# bindkey "^[[A" up-line-or-history
# bindkey "^[[B" down-line-or-history

alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls -G'
alias lsa='ls -lah'

function _export_path {
    [[ -d $1 ]] && export PATH=$1:$PATH
}

_export_path "$HOME/.local/bin"

[[ -f $HOME/.env ]] && source $HOME/.env

unset -f _export_path

eval "$(starship init zsh)"
