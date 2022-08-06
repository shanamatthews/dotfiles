#!/bin/bash

# you must clone your own dotfiles & set up ssh key before this works,
# sorry

DOTFILES_DIR="$HOME/src/git/dotfiles"

# install basic utilities
sudo apt -y update
sudo apt -y install vim
sudo apt -y install gnome-tweaks
sudo apt -y install git
sudo apt -y install curl
sudo apt -y install tmux

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
ln -s "$DOTFILES_DIR"/scripts "$SCRIPTS"
ln -s "$DOTFILES_DIR"/snippets "$SNIPPETS"

# install thefuck
sudo apt install python3-dev python3-pip python3-setuptools
pip3 install thefuck --user
