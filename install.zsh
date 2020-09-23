#!/usr/bin/env zsh
# env, because some OSes keep zsh in /bin (I'm looking at you, Alpine)
# if [[ "$1" == "update" ]]; then
#   cp .zshrc $HOME
#   if [ -d "${HOME}/.zsh" ]; then
#     rm -r $HOME/.zsh
#   fi
#   cp -r .zsh $HOME
#   exit
# fi
cp .zshrc $HOME
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
cp -r ./.local/bin $HOME/.local
chmod -R +x $HOME/.local/bin
source $HOME/.zshrc
