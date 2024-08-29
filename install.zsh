#!/usr/bin/env zsh
# env, because some OSes keep zsh in /bin (I'm looking at you, Alpine)

if [ "$ZSH_EVAL_CONTEXT" = "toplevel" ]; then
	echo "[!] this script is meant to be sourced"
	echo "source install.zsh" > /dev/stdin
	exit 1
fi

iscmd() {
        command -v "$1" > /dev/null
}

for cmd in curl git sed install find; do
  if ! command -v $cmd >/dev/null; then
    echo "[!] $cmd not found"
    exit 1
  fi
done

set -e

# migrate legacy
mkdir -p "$HOME"/.config/zsh
touch "$HOME"/.config/zsh/local.zsh
if [ -d "$HOME"/.zsh-custom ]; then
	for file in "$HOME"/.zsh-custom/*; do
		echo "# $file" >> "$HOME"/.config/zsh/local.zsh
		cat "$file" >> "$HOME"/.config/zsh/local.zsh
		echo "" >> "$HOME"/.config/zsh/local.zsh
		rm "$file"
	done
	rmdir "$HOME"/.zsh-custom
fi

install() {
  # screw you coreutils install and your ugly messages
  command install -Dv $@ | grep -v removed
}

plugins_dir="$HOME/.local/share/zsh-plugins"
plugins_git="
  https://github.com/zsh-users/zsh-syntax-highlighting
  https://github.com/zsh-users/zsh-autosuggestions
"

os_id="$( . /etc/os-release && echo "$ID" )"

if [ "$(id -u)" != 0 ]; then
    if command -v doas >/dev/null; then
      elevate=doas
    elif command -v sudo >/dev/null; then
      elevate=sudo
    else
      echo "[!] cannot install zsh plugins system-wide"
      elevate=:
    fi
fi

cp -v .zshrc $HOME
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
if [ -n "${NOTICA_URL}" ]; then
  sed -i "s%\# export NOTICA_URL=\"\"%export NOTICA_URL=\"$NOTICA_URL\"%g" $HOME/.zsh/env.zsh
fi
if [ -n "${ANDROID_SDK_ROOT}" ]; then
  sed -i "s%\# export ANDROID_SDK_ROOT=\"\"%export ANDROID_SDK_ROOT=\"$ANDROID_SDK_ROOT\"%g" $HOME/.zsh/env.zsh
fi
if [ -n "${NPM_CONFIG_PREFIX}" ]; then
  sed -i "s%\# export NPM_CONFIG_PREFIX=\"\"%export NPM_CONFIG_PREFIX=\"$NPM_CONFIG_PREFIX\"%g" $HOME/.zsh/env.zsh
fi

echo
echo "[*] installing homedir files"
find homedir -type f |while read -r file; do
	install $file $(echo $file | sed "s|homedir|$HOME|")
done

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

for plugin in $=plugins_git; do
    name="${plugin/*\//}"

    if [ ! -d "$plugins_dir/$name" ]; then
      echo "[*] installing $name locally"
      git clone --depth=1 "$plugin" "$plugins_dir/$name"
    else
      echo "[+] $name installed already"
    fi
  done

unfunction install
