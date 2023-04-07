#!/usr/bin/env zsh
# env, because some OSes keep zsh in /bin (I'm looking at you, Alpine)

install() {
  # screw you coreutils install and your ugly messages
  command install -Dv $@ | grep -v removed
}

cp -v .zshrc $HOME
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "[*] Installing OMZsh"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
if [ ! -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo
  echo "[*] Installing powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi
if [ -d "${HOME}/.zsh" ]; then
  echo
  echo "[*] Deleting old .zsh/"
  rm -rf $HOME/.zsh
fi
cp -rv .zsh/ $HOME
if [ -n "${devTools}" ]; then
  sed -i "s%export devTools=\"\"%export devTools=\"$devTools\"%g" $HOME/.zsh/env.zsh
fi
if [ -n "${GOPATH}" ]; then
  sed -i "s%\# export GOPATH=\"\"%export GOPATH=\"$GOPATH\"%g" $HOME/.zsh/env.zsh
fi
if [ -n "${ANDROID_SDK_ROOT}" ]; then
  sed -i "s%\# export ANDROID_SDK_ROOT=\"\"%export ANDROID_SDK_ROOT=\"$ANDROID_SDK_ROOT\"%g" $HOME/.zsh/env.zsh
fi
if [ -n "${NPM_CONFIG_PREFIX}" ]; then
  sed -i "s%\# export NPM_CONFIG_PREFIX=\"\"%export NPM_CONFIG_PREFIX=\"$NPM_CONFIG_PREFIX\"%g" $HOME/.zsh/env.zsh
fi
cp -v .tmux.conf ~/.tmux.conf 

echo
echo "[*] installing config files"
install -m644 .zshrc -t "$HOME"
find config -type f | while read file; do
	install $file $(echo $file | sed "s|config|$HOME/.config|")
done

echo 
echo "[*] installing executables"

find bin -type f | while read -r file; do
	install $file $(echo $file | sed "s|bin|$HOME/.local/bin|")
done


source $HOME/.zshrc
