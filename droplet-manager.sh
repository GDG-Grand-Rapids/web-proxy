#!/bin/bash
OPTIONS="Update-Conference-Website Update-GDGGR-Website Update-Proxy Update-Gio-Rest Update-Gio-Db Update-Web-Hook Quit"

CONF_WEB_REPO="mccrackend/conference_website"
CONF_WEB_ALIAS="conf_web"
CONF_WEB_PORT="172.17.42.1:3000"

PROXY_REPO="gdggr/web-proxy"
PROXY_ALIAS="proxy"
PROXY_PORT="80"

GDGGR_WEB_REPO="jwill824/gdg_webapp"
GDGGR_WEB_ALIAS="gdggr_web"
GDGGR_WEB_PORT="172.17.42.1:5000"

GIO_REST_REPO="gdggr/gio-rest"
GIO_REST_ALIAS="gio-rest"
GIO_REST_PORT="172.17.42.1:7000"

GIO_DB_REPO="gdggr/gio-db"
GIO_DB_ALIAS="gio-db"
GIO_DB_PORT="172.17.42.1:5432"

WEB_HOOK_REPO="jwill824/web-hook"
WEB_HOOK_ALIAS="web-hook"
WEB_HOOK_PORT="172.17.42.1:9000"

function update-container {
  clear
  echo "=====> Updating docker image   =>" $1
  echo "=====> Using a container alias =>" $2
  echo "=====> And running it on port  =>" $3
  echo

  echo "=====>" Tagging current running container image as backup
  epochDate=$(date +%s)
  docker tag -f $1:latest $1:backup-$epochDate
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
}

function run-web-site {
  echo
  echo "=====>" Running the latest container as a web site
  docker run --name $2 -p $3:80 -d $1:latest
  docker ps -a
}

function run-web-hook {
  echo
  echo "=====>" Running the latest container as the python web-hook
  docker run --name $2 -p $3:5000 -d $1:latest
  docker ps -a
}

function run-rest-api {
  echo
  echo "=====>" Running the latest rest api container
  docker run --name $2 -it --link $4:$4 -p $3:8080 -d $1:latest
  docker ps -a
}

function run-db {
  echo
  echo "=====>" Running the latest db container
  docker run --name $2 -p $3:5432 -d $1:latest
  docker ps -a
}

function update-conference-website {
  update-container $1 $2 $3
  run-web-site $1 $2 $3
}

function update-gdggr-website {
  update-container $1 $2 $3
  run-web-site $1 $2 $3
}

function update-proxy {
  update-container $1 $2 $3
  run-web-site $1 $2 $3
}

function update-gio-rest {
  update-container $1 $2 $3
  run-rest-api $1 $2 $3 $4
}

function update-gio-db {
  update-container $1 $2 $3
  run-db $1 $2 $3
}

function update-web-hook {
  update-container $1 $2 $3
  run-web-hook $1 $2 $3
}

select opt in $OPTIONS; do
  if [ "$opt" = "Update-Conference-Website" ]; then
    update-conference-website $CONF_WEB_REPO $CONF_WEB_ALIAS $CONF_WEB_PORT
    exit
  elif [ "$opt" = "Update-GDGGR-Website" ]; then
    update-gdggr-website $GDGGR_WEB_REPO $GDGGR_WEB_ALIAS $GDGGR_WEB_PORT
    exit
  elif [ "$opt" = "Update-Proxy" ]; then
    update-proxy $PROXY_REPO $PROXY_ALIAS $PROXY_PORT
    exit
  elif [ "$opt" = "Update-Gio-Rest" ]; then
    update-gio-rest $GIO_REST_REPO $GIO_REST_ALIAS $GIO_REST_PORT $GIO_DB_ALIAS
    exit
  elif [ "$opt" = "Update-Gio-Db" ]; then
    update-gio-db $GIO_DB_REPO $GIO_DB_ALIAS $GIO_DB_PORT
    exit
  elif [ "$opt" = "Update-Web-Hook" ]; then
    update-web-hook $WEB_HOOK_REPO $WEB_HOOK_ALIAS $WEB_HOOK_PORT
    exit
  elif [ "$opt" = "Quit" ]; then
    exit
  else
    clear
    echo bad option
  fi
done
