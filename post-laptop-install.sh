#!/usr/bin/env bash
scripts_path_prefix="./.local/.scripts"
laptop_scripts=("touchpad.sh")
for i in ${laptop_scripts[@]}; do
	path="$scripts_path_prefix/$i"
	if [ -f $path ]; then
		cp -iv $path $HOME/$path	
	fi
done
