#!/bin/bash

# you must clone your own dotfiles & set up ssh key before this works,
# sorry

DOTFILES_DIR="$HOME/src/git/dotfiles"

# install basic utilities
sudo apt-get -y update
sudo apt-get -y install vim
sudo apt-get -y install gnome-tweaks
sudo apt-get -y install git
sudo apt-get -y install curl
sudo apt-get -y install tmux

# install glow bc I'm extra
echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install glow

# clone dotfiles
# TBD

# make sure the below env vars are set
source ~/.bashrc

# symlink dotfiles

# don't fuck up your bashrc backup if you're running this again
BASHRCBACKUP="$HOME/.bashrcbackup"

if [ ! -f "$BASHRCBACKUP" ]; then
    mv ~/.bashrc ~/.bashrcbackup
fi

ln -s "$DOTFILES_DIR"/.bashrc ~/.bashrc
ln -s "$DOTFILES_DIR"/.vimrc ~/.vimrc
ln -s "$DOTFILES_DIR"/.tmux.conf ~/.tmux.conf

# set up directories if they don't exist
# if you run this a second time you'll get weird nested scripts &
# snippets dirs...
ln -s "$DOTFILES_DIR"/scripts "$SCRIPTS"
ln -s "$DOTFILES_DIR"/snippets "$SNIPPETS"

mkdir -p "$HOME/.vim/.undo/"
mkdir -p "$HOME/.vim/.backup/"
mkdir -p "$HOME/.vim/.swp/"

# install thefuck
sudo apt install python3-dev python3-pip python3-setuptools
pip3 install thefuck --user

