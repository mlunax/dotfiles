# opencode completion — lazy-loaded
# Sourced from ~/.zshrc. Defers compdef registration until compinit is ready,
# and defines the real completion function only on first use.

_opencode_lazy_stub() {
  _opencode_yargs_completions() {
    local reply
    local si=$IFS
    IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "${words[@]}"))
    IFS=$si
    [[ ${#reply} -gt 0 ]] && _describe 'values' reply || _default
  }
  compdef _opencode_yargs_completions opencode
  _opencode_yargs_completions "$@"
}

autoload -Uz add-zsh-hook
_opencode_register() {
  (( $+functions[compdef] )) || return
  compdef _opencode_lazy_stub opencode
  add-zsh-hook -d precmd _opencode_register
  unset -f _opencode_register
}
add-zsh-hook precmd _opencode_register
