#!/bin/bash
#bash hosts.sh domain.pl serwer.lh.pl
if [ $# -eq 2 ]; then
   DOMAIN=$1
   SERWER=$2
else
echo "DOMAIN:"
read DOMAIN
echo "SERWER:"
read SERWER
fi
IP=`dig +short A $SERWER | tr -d '\n'`
echo "$IP $DOMAIN www.$DOMAIN" | tee -a /etc/hosts
