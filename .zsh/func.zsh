# Turn control+z into a toggle switch
source $OTHER/env.zsh

ctrlz() {
    if [[ $#BUFFER == 0 ]]; then
          fg >/dev/null 2>&1 && zle redisplay
    else
          zle push-input
   fi
}
zle -N ctrlz
bindkey '^Z' ctrlz

squash() {
	mksquashfs "$1" "$1.zst.sfs" -comp zstd -Xcompression-level 15
}

escfpath(){
  printf "%q\n" "$(realpath "$1")"
}

if [[ ! -z "NOTICA_URL" ]]; then
  notica() { curl --data "d:$*" "$NOTICA_URL" ; }
fi