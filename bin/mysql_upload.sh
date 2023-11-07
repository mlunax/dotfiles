#!/bin/bash
if [ $# -le 2 ]; then
  echo $0 "db&user_name" "serwer_address" "sql_dump_path"
  exit
fi
name=$1
filename=$3
serwer=$2
mysql -h $serwer -u $name $name -vp < $filename
