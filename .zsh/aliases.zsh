alias \
    wget='wget -c' \
    zshrc='source ~/.zshrc' \
    dps='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"' \
    c='docker compose' \
    lla='ls -lha' \
    cp='cp -iv' \
    rm='rm -iv' \
    mv='mv -iv' \
    mkd="mkdir -pv" \
    c_buildkit="COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1" \
    ytv="youtube-dl -f bestvideo" \
    smpv="mpv --profile=svp --script-opts=socketPath=/tmp/mpvsocket " \
    discord-stream="doas modprobe v4l2loopback video_nr=15;nohup ffmpeg -hide_banner -loglevel error -f x11grab -r 30 -s 1920x1080 -i :0+1440,0 -pix_fmt yuv420p -f v4l2 /dev/video15&; disown" \
    screen-stream="discord-stream" \
    vim="nvim" \
    swap-ytmpv-profiles="sed -i 's/mpv-yt/mpv-yt-inactive/g' ~/.config/mpv/mpv.conf && sed -i 's/mpv-yt-inactive-inactive/mpv-yt/g' ~/.config/mpv/mpv.conf; grep -1 mpv-yt ~/.config/mpv/mpv.conf" 
