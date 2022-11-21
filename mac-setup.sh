#!/bin/bash

# you must clone your own dotfiles & set up ssh key before this works,
# sorry

# clone dotfiles
# TBD

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
    source "$HOME/.zshrc"
else
    brew update
fi

# unfuck mac's bash version
brew install bash

# install utilities I want
brew install tmux
brew install glow
brew install thefuck

brew install ponysay
brew install fortune

brew install tree
brew install pyenv
brew install autoenv
brew install pandoc
brew install ripgrep
brew install fd
brew install browser-sync

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

# ----------------------------------- add z ----------------------------------
git clone git@github.com:rupa/z.git "$HOME/src/git/z"


# ------------------------------- install langs ------------------------------

# have to install go from a download: https://go.dev/doc/install

# add if statement for go being installed

go get github.com/rwxrob/cmdbox-pomo/pomo

# node & npm
# install nvm first
# https://github.com/nvm-sh/nvm#installing-and-updating
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

