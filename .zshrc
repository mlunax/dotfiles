# --- 1. Fast Command Checking ---
# Replaces 'iscmd' with a zsh-native check that doesn't fork a process
iscmd() { (( $+commands[$1] )) }

export TERM="xterm-256color"
export OTHER=$HOME/.zsh
export ZSH=$HOME/.oh-my-zsh
export DISABLE_AUTO_UPDATE=true

# --- 2. Optimized Prompt ---
if iscmd starship; then
    # Cache starship init to a file if it feels slow, 
    # but --print-full-init is generally okay.
    source <(starship init zsh --print-full-init)
else
    setopt promptsubst
    __ptrc_prompt() {
        local c_green=$'%{\x1b[32m%}' c_blue=$'%{\x1b[34m%}' c_reset=$'%{\x1b[0m%}'
        local c_red=$'%{\x1b[31m%}' c_cyan=$'%{\x1b[36m%}'
        local hostprefix=""
        [[ -n "$SSH_TTY" ]] && hostprefix="${c_red}${USER}${c_reset}@${c_cyan}${HOST} "
        echo "${hostprefix}${c_blue}%~ ${c_green}>$c_reset "
    }
    export PS1='$(__ptrc_prompt)'
fi

# --- 3. Path & Environment ---
typeset -U path # Ensure PATH only has unique entries
path=("$HOME/.local/bin" $path)
[[ -d "$HOME/.local/go" ]] && export GOPATH=$HOME/.local/go

if [[ "$(uname)" == "Darwin" ]]; then
    export GPG_TTY=$(tty)
    # Note: ssh-add can be slow; consider moving to a lazy load if needed
    ssh-add --apple-load-keychain -q 2>/dev/null
    
    # Podman Optimization
    if [[ -x "/opt/podman/bin/podman" ]]; then
        path=("/opt/podman/bin" $path)
    fi
else
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi

# --- 4. Completion Engine (Run once, run fast) ---
# Check if cache needs rebuilding (every 24h) or use a static file
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi

# Podman Completion (Static Check)
if iscmd podman; then
    if [[ -f "$HOME/.zsh/completions/_podman" ]]; then
        fpath=($HOME/.zsh/completions $fpath)
    else
        # Only eval if we absolutely have to
        eval "$(podman completion zsh)"
    fi
fi

# --- 5. External Tool Inits (The Lag Makers) ---
# Use static sourcing where possible
iscmd zoxide && eval "$(zoxide init zsh)"
iscmd fzf && source <(fzf --zsh)

# Mise: Do not activate on every shell load if you don't need it immediately
# Use your 'actmise' function or only eval if a local config exists
if iscmd mise; then
    actmise() { eval "$(mise activate zsh)" }
fi

# --- 6. Aliases & Functions ---
alias ls='ls --color=auto'
alias ll='ls -la'
alias l.='ls -d .* --color=auto'
alias gp='git push'
alias sudo='sudo '
alias c='docker-compose'

# Smart Docker/Podman Aliasing
if ! iscmd docker-compose; then alias c='docker compose'; fi
if ! iscmd docker && iscmd podman; then
    alias docker='podman'
    alias c='podman-compose'
fi

# --- 7. Plugins ---
# Load these last to ensure they don't slow down the UI rendering
[[ -d /usr/share/zsh/plugins ]] && p_dir="/usr/share/zsh/plugins" || p_dir="$HOME/.local/share/zsh-plugins"

source "$p_dir/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
source "$p_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null
