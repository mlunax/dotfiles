#!/bin/bash
source /etc/lsb-release
if  [ $# -eq 1 ] && [ $1 == "-h" ]; then
    exit
fi
if [ 0 -eq $(id -u)  ]; then
    echo Don\'t run this script as root, please.
    echo If it will need permission it will use 'sudo' command.
else
    if [ $DISTRIB_ID == "ManjaroLinux" ]; then
      install_command='pacman -S --needed'
      echo Install bat
	    sudo $install_command bat
	    echo Install kak
	    sudo $install_command kakoune
	    echo Install Alacritty
	    sudo $install_command alacritty
	    echo Install HTTPie
	    sudo $install_command httpie
    fi
fi

