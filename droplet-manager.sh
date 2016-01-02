#!/bin/bash
OPTIONS="Update-Conference-Website Update-GDGGR-Website Update-Proxy Update-All Quit"
select opt in $OPTIONS; do
  if [ "$opt" = "Update-Proxy" ]; then
    echo done
    exit
  elif [ "$opt" = "Hello" ]; then
    echo Hello World
  else
    clear
    echo bad option
  fi
done


function update-proxy {
  
}
