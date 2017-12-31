#!/bin/bash
set -x
set -euvo pipefail
IFS=$'\n\t'

ROOTPATH=/mnt/ext/home_meteor/var/www/rocket.chat
PM2FILE=pm2.json
if [ "$1" == "development" ]; then
  ROOTPATH=/mnt/ext/home_meteor/var/www/rocket.chat.dev
  PM2FILE=pm2.dev.json
fi

cd $ROOTPATH
curl -fSL "https://github.com/haopf/Rocket.Chat.git" -o rocket.chat.tgz
tar zxf rocket.chat.tgz  &&  rm rocket.chat.tgz
cd $ROOTPATH/bundle/programs/server
cnpm install --cache-min 9999999
pm2 startOrRestart $ROOTPATH/current/$PM2FILE
