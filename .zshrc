if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
export OTHER=$HOME/.zsh
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="powerlevel10k/powerlevel10k"
source $OTHER/powerlevel_settings.sh
# source $ZSH/oh-my-zsh.sh

#COMPLETION_WAITING_DOTS="false"

plugins=(git docker docker-compose virtualenv)


export EDITOR=nvim
#export JAVA_HOME=
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

for f in $OTHER/*.zsh; do
  if [ -f $f ]; then
    source $f
  fi
done

# Turn control+z into a toggle switch
ctrlz() {
    if [[ $#BUFFER == 0 ]]; then
          fg >/dev/null 2>&1 && zle redisplay
    else
          zle push-input
   fi
}
zle -N ctrlz
bindkey '^Z' ctrlz

if [ -d "$HOME/.zsh-custom" ]; then
  for f in $HOME/.zsh-custom/*; do
    if [ -f $f ]; then
      source $f
    fi
  done
fi
source $ZSH/oh-my-zsh.sh
# autoload -Uz compinit && compinit -i
