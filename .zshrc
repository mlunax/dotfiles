DISABLE_AUTO_UPDATE=true

iscmd() {
	command -v "$1" > /dev/null
}

export TERM="xterm-256color"
export OTHER=$HOME/.zsh
export ZSH=$HOME/.oh-my-zsh

if iscmd starship; then
	source <(starship init zsh --print-full-init)
else
  export ZSH_THEME="powerlevel10k/powerlevel10k"
  source $OTHER/powerlevel_settings.sh
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

source $ZSH/oh-my-zsh.sh

plugins=(git docker docker-compose virtualenv)

## History file configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000000
SAVEHIST=10000000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

if iscmd helix; then
  export EDITOR=helix
elif iscmd nvim; then
  export EDITOR=nvim
else 
  export EDITOR=vim
fi

alias c='docker-compose'

if ! iscmd docker-compose; then
	alias c='docker compose'
fi

if ! iscmd docker && iscmd podman; then
	alias docker='podman'
	alias c='podman-compose'
fi

if iscmd google-chrome-stable; then
  export BROWSER=google-chrome-stable
fi

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

for f in $OTHER/*.zsh; do
  if [ -f $f ]; then
    source $f
  fi
done

if [ -d "$HOME/.zsh-custom" ]; then
  for f in $HOME/.zsh-custom/*; do
    if [ -f $f ]; then
      source $f
    fi
  done
fi

DISABLE_MAGIC_FUNCTIONS=true
# autoload -Uz compinit && compinit -i
source $OTHER/func.zsh
