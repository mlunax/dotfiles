autoload -Uz compinit && compinit

if type "kubectl" > /dev/null; then
  source <(kubectl completion zsh)
fi 