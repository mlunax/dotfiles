if iscmd atuin; then 
  export ATUIN_NOBIND="true"
  bindkey '^r' _atuin_search_widget
  eval "$(atuin init zsh)"
fi
