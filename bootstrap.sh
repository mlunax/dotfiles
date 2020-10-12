#!/usr/bin/env bash

# git pull origin master;

function doIt() {
    rsync --exclude ".git/" \
            --exclude ".github/" \
            --exclude "bootstrap.sh" \
            --exclude "install.zsh" \
            --exclude "install-code.sh" \
            --exclude "install-packages.sh" \
            -avh --no-perms . ~;
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
    if [ ! -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel9k" ]; then
        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    fi
    if [ -d "${HOME}/.zsh" ]; then
        rm -rf $HOME/.zsh
    fi
        cp -r .zsh/ $HOME
    if [ -n "${devTools}" ]; then
        sed -i "s%export devTools=\"\"%export devTools=\"$devTools\"%g" $HOME/.zsh/env.zsh
    fi
    if [ -n "${GOPATH}" ]; then
        sed -i "s%\#export GOPATH=\"\"%export GOPATH=\"$GOPATH\"%g" $HOME/.zsh/env.zsh
    fi
    if [ -n "${ANDROID_SDK_ROOT}" ]; then
        sed -i "s%\#export ANDROID_SDK_ROOT=\"\"%export ANDROID_SDK_ROOT=\"$ANDROID_SDK_ROOT\"%g" $HOME/.zsh/env.zsh
    fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
  source $HOME/.zshrc
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
