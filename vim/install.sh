#!/usr/bin/env bash

SERVER_VIMRC_FILE_URL="https://raw.githubusercontent.com/thehxdev/dotfiles/main/vim/server-vimrc"
VIMRC_FILE_URL="https://raw.githubusercontent.com/thehxdev/dotfiles/main/vim/vimrc"


function check_vim() {
    if [[ !command -q vim ]]; then
        echo "vim is not installed"
        exit 1
    fi
}

function check_curl() {
    if [[ !command -q curl ]]; then
        echo "curl is not installed"
        exit 1
    fi
}

function install_vimplug() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function configure_server_vim() {
    curl -fLo ~/.vimrc ${SERVER_VIMRC_FILE_URL}
}

function configure_vim() {
    curl -fLo ~/.vimrc ${VIMRC_FILE_URL}
}

function main() {
    check_vim
    check_curl

    echo -e "========================="
    echo -e "1) server configuration"
    echo -e "2) desktop configuration"
    echo -e "3) exit"
    echo -e "========================="
    
    echo -Een "Your Option: "
    read -rp user_option

    case $user_option in
        1)
            install_vimplug
            configure_server_vim
            ;;
        2)
            install_vimplug
            configure_vim
            ;;
        3)
            echo "exit..."
            exit 0
            ;;
        *)
            echo -e "wrong option"
            exit 1
            ;;
    esac

}

main
