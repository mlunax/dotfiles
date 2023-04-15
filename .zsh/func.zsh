# Turn control+z into a toggle switch
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