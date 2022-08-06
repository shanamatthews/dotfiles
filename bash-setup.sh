#!/bin/bash

# install basic utilities
sudo apt install vim
sudo apt install gnome-tweaks
sudo apt install git
sudo apt install curl

# make sure the below env vars are set
source ~/.bashrc

# set up directories if they don't exist
mkdir -p "$SCRIPTS"
mkdir -p "$SNIPPETS"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
