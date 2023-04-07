#!/bin/bash
fileName=/tmp/touchpad
id=$(xinput | grep TouchPad |grep -Poh '(?<=id\=)[0-9]+')
if [[ ! -f $fileName ]]; then
   echo "$id" > $fileName 
   xinput --disable $id
   notify-send "Touchpad disabled" -t 1000 -u low
else
  xinput --enable $(cat $fileName)
  rm $fileName
  notify-send "Touchpad enabled" -t 1000 -u low
fi
