alias \
    wget='wget -c' \
    zshrc='source ~/.zshrc' \
    dps='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"' \
    lla='ls -lha' \
    cp='cp -iv' \
    rm='rm -iv' \
    mv='mv -iv' \
    mkd="mkdir -pv" \
    smpv="mpv --profile=svp --script-opts=socketPath=/tmp/mpvsocket " \
    vim="nvim" \
    swap-ytmpv-profiles="sed -i 's/mpv-yt/mpv-yt-inactive/g' ~/.config/mpv/mpv.conf && sed -i 's/mpv-yt-inactive-inactive/mpv-yt/g' ~/.config/mpv/mpv.conf; grep -1 mpv-yt ~/.config/mpv/mpv.conf" \
    ga='git add' \
    gap='git add --patch' \
    gc='git commit' \
    gd='git diff' \
    gdc='git diff --cached' \
    gl='git lg' \
    gp='git push' \
    gres='git restore' \
    gs='git status' \
    gst='git stash' \
    hx='helix' \
    sudo='doas'

alias history='fc -l 0'
alias ytdlp='yt-dlp `xclip -o`'
alias 'sudo -i'='sudo su -' 
alias 'cls'='clear'
