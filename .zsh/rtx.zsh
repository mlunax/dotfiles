export RTX_SHELL=zsh

rtx() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command /home/lunax/.cargo/bin/rtx
    return
  fi
  shift

  case "$command" in
  deactivate|shell)
    eval "$(/home/lunax/.cargo/bin/rtx "$command" "$@")"
    ;;
  *)
    command /home/lunax/.cargo/bin/rtx "$command" "$@"
    ;;
  esac
}

_rtx_hook() {
  trap -- '' SIGINT;
  eval "$("$HOME/.cargo/bin/rtx" hook-env -s zsh)";
  trap - SIGINT;
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_rtx_hook]+1}" ]]; then
  precmd_functions=( _rtx_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_rtx_hook]+1}" ]]; then
  chpwd_functions=( _rtx_hook ${chpwd_functions[@]} )
fi