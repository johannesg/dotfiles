#!/bin/bash

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

[ ! -d ~/.lein ] && mkdir ~/.lein
[ ! -d ~/.config ] && mkdir ~/.config
[ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/bashrc" ~/.bashrc
ln -sfv "$DOTFILES_DIR/bashrc" ~/.bash_profile

# ln -sfv "$DOTFILES_DIR/gitconfig" ~/.gitconfig
ln -sfv "$DOTFILES_DIR/gitignore_global" ~/.gitignore_global
ln -sfv "$DOTFILES_DIR/agignore" ~/.agignore
ln -snfv "$DOTFILES_DIR/vim" ~/.vim
ln -sfv "$DOTFILES_DIR/vimrc" ~/.vimrc
ln -snfv "$DOTFILES_DIR/emacs.d" ~/.emacs.d
ln -sfv "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf
ln -snfv "$DOTFILES_DIR/tmux" ~/.tmux
ln -snfv "$DOTFILES_DIR/i3" ~/.i3

ln -sfv "$DOTFILES_DIR/lein/profiles.clj" ~/.lein/profiles.clj
ln -sfv "$DOTFILES_DIR/shell/liquidpromptrc" ~/.config/liquidpromptrc

$DOTFILES_DIR/powerline-fonts/install.sh

if [ "$(uname)" == "Darwin" -a -f "$DOTFILES_DIR/install.osx.sh" ]; then
    source "$DOTFILES_DIR/install.osx.sh"
fi
