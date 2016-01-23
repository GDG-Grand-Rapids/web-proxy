#!/bin/bash
OPTIONS="Update-Conference-Website Update-GDGGR-Website Update-Proxy Update-All Quit"

CONF_WEB_REPO="mccrackend/conference_website"
CONF_WEB_ALIAS="conf_web"
CONF_WEB_PORT="172.17.42.1:3000"

PROXY_REPO="gdggr/web-proxy"
PROXY_ALIAS="proxy"
PROXY_PORT="80"

GDGGR_WEB_REPO="mccrackend/conference_website"
GDGGR_WEB_ALIAS="gdggr_web"
GDGGR_WEB_PORT="172.17.42.1:5000"

function update-container {
  clear
  echo "=====> Updating docker image   =>" $1
  echo "=====> Using a container alias =>" $2
  echo "=====> And running it on port  =>" $3
  echo

  echo "=====>" Tagging current running container image as backup
  docker tag -f $1:latest $1:backup
  docker images

  echo
  echo "=====>" Pulling latest image from docker hub
  docker pull $1

  echo
  echo "=====>" Killing current running container
  docker ps -a
  docker kill $2

  echo
  echo "=====>" Removing killed container
  docker ps -a
  docker rm $2

  echo
  echo "=====>" Starting up the latest container
  docker run --name $2 -p $3:80 -d $1:latest
  docker ps -a
}

function update-conference-website {
  update-container $CONF_WEB_REPO $CONF_WEB_ALIAS $CONF_WEB_PORT
}

function update-gdggr-website {
  update-container $GDGGR_WEB_REPO $GDGGR_WEB_ALIAS $GDGGR_WEB_PORT
}

function update-proxy {
  update-container $PROXY_REPO $PROXY_ALIAS $PROXY_PORT
}

select opt in $OPTIONS; do
  if [ "$opt" = "Update-Conference-Website" ]; then
    update-conference-website
    exit
  elif [ "$opt" = "Update-GDGGR-Website" ]; then
    update-gdggr-website
    exit
  elif [ "$opt" = "Update-Proxy" ]; then
    update-proxy
    exit
  else
    clear
    echo bad option
  fi
done
