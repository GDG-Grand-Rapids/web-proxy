#!/bin/bash
OPTIONS="Update-Conference-Website Update-GDGGR-Website Update-Proxy Update-All Quit"

CONFERENCE_WEB_REPO="mccrackend/conference_website"
GDGGR_WEB_REPO="gar"
PROXY_REPO="gdggr/web-proxy"

function update-conference-website {
  echo "Updating docker image for" $CONFERENCE_WEB_REPO
}

function update-gdggr-website {
  echo Under construction. This option is not ready yet.
}

function update-proxy {
  echo "Updating docker image for" $PROXY_REPO
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
