alias \
    wget='wget -c' \
    zshrc='source ~/.zshrc' \
    dps='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"' \
    c='docker-compose' \
    lla='ls -lha' \
    cp='cp -iv' \
    rm='rm -iv' \
    mv='mv -iv' \
    mkd="mkdir -pv" \
    c_buildkit="COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1" \
    ytv="youtube-dl -f bestvideo" \
    smpv="mpv --profile=svp --script-opts=socketPath=/tmp/mpvsocket "
