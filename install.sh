#!/bin/bash

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/bash_profile" ~/.bash_profile
ln -sfv "$DOTFILES_DIR/bashrc" ~/.bashrc
ln -sfv "$DOTFILES_DIR/gitconfig" ~/.gitconfig
ln -sfv "$DOTFILES_DIR/gitignore_global" ~/.gitignore_global
ln -sfv "$DOTFILES_DIR/agignore" ~/.agignore
ln -sfv "$DOTFILES_DIR/vim" ~/.vim
ln -sfv "$DOTFILES_DIR/vimrc" ~/.vimrc
ln -sfv "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf
ln -sfv "$DOTFILES_DIR/tmux" ~/.tmux

$DOTFILES_DIR/powerline-fonts/install.sh

if [ "$(uname)" == "Darwin" -a -f "$DOTFILES_DIR/install.osx.sh" ]; then
    source "$DOTFILES_DIR/install.osx.sh"
fi
