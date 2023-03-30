#!/usr/bin/env bash

VIMRC_FILE_URL=""

function install_vimplug() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function configure_vim() {
}
