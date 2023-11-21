export RTX_SHELL=zsh
RTX_BIN_PATH=$(whereis rtx | cut -d ':' -f2 | xargs)
if iscmd rtx; then
  rtx() {
    local command
    command="${1:-}"
    if [ "$#" = 0 ]; then
      command $RTX_BIN_PATH
      return
    fi
    shift

    case "$command" in
    deactivate|shell)
      eval "$($RTX_BIN_PATH "$command" "$@")"
      ;;
    *)
      command $RTX_BIN_PATH "$command" "$@"
      ;;
    esac
  }

  _rtx_hook() {
    trap -- '' SIGINT;
    eval "$("$RTX_BIN_PATH" hook-env -s zsh)";
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
fi
