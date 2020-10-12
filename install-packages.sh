#!/bin/bash
source /etc/lsb-release
function echoGreen(){
  echo -e "\e[32m"$1"\e[0m"
}
if  [ $# -eq 1 ] && [ $1 == "-h" ]; then
    exit
fi
if [ 0 -eq $(id -u)  ]; then
    echo Don\'t run this script as root, please.
    echo If it will need permission it will use 'sudo' command.
else
    if [ $DISTRIB_ID == "ManjaroLinux" ]; then
      install_command='pacman -S --needed'
      echoGreen "Installing bat"
	    sudo $install_command bat
	    echoGreen "Installing kak"
	    sudo $install_command kakoune
	    echoGreen "Installing Alacritty"
	    sudo $install_command alacritty
	    echoGreen "Installing HTTPie"
	    sudo $install_command httpie
    fi
fi

