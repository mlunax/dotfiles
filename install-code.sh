#!/bin/bash
source /etc/lsb-release
if  [ $# -eq 1 ] && [ $1 == "-h" ]; then
    echo https://github.com/tonsky/FiraCode/wiki/VS-Code-Instructions
    exit
fi
if [ 0 -eq $(id -u)  ]; then
    echo Don\'t run this script as root, please.
    echo If it will need permission it will use 'sudo' command.
else 
    if [ $DISTRIB_ID == "ManjaroLinux" ]; then
        sudo pacman -S ttf-fira-code
        yay -S vscodium-bin
        sudo ln -s /usr/bin/vscode /usr/bin/code
        code --install-extension akamud.vscode-theme-onedark
        code --install-extension vscode-icons-team.vscode-icons
    fi
fi