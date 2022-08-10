#!/bin/bash

# you must clone your own dotfiles & set up ssh key before this works,
# sorry

DOTFILES_DIR="$HOME/src/git/dotfiles"

# link dotfiles

# don't fuck up your zshrc backup if you're running this again
ZSHRCBACKUP="$HOME/.zshrcbackup"

if [ ! -f "$ZSHRCBACKUP" ]; then
    mv ~/.zshrc ~/.zshrcbackup
fi

ln -s "$DOTFILES_DIR"/.zshrc ~/.zshrc
ln -s "$DOTFILES_DIR"/.vimrc ~/.vimrc
ln -s "$DOTFILES_DIR"/.tmux.conf ~/.tmux.conf
ln -s "$DOTFILES_DIR"/aliases.zsh ~/aliases.zsh

# install homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

# install utilities I want
brew install tmux
brew install glow
brew install thefuck

# clone dotfiles
# TBD

# make sure the below env vars are set
source ~/.zshrc

# set up directories if they don't exist
mkdir -p $(dirname "$SCRIPTS")

# if you run this a second time you'll get weird nested scripts &
# snippets dirs...
ln -s "$DOTFILES_DIR"/scripts $(dirname "$SCRIPTS")

# not sure why this works?
ln -s "$DOTFILES_DIR"/snippets "$SNIPPETS"

mkdir -p "$HOME/.vim/.undo/"
mkdir -p "$HOME/.vim/.backup/"
mkdir -p "$HOME/.vim/.swp/"

## config git
git config --global user.name "Shana Matthews"
git config --global user.email shana.l.matthews@gmail.com

