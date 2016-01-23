# Web-Proxy
Reverse proxy nginx dockerfile for our DO host.

This docker container needs to be running on the DO droplet!

All traffic is routed to the proxy and sent to the right website depending on its respective domain name.

Image is maintained in docker hub here: https://hub.docker.com/r/gdggr/web-proxy/

# Management
 All management of running docker containers on the droplet will use droplet-manager.sh.

## ioextendedgr.com will run on port `3000`

## gdggr.org will run on port `5000`

## gioapi.gdggr.org will run on port `7000`

# Utils

## droplet-manager.sh
Management script for the droplet. Allows for updating individual applications or updating everything and getting it running.

### Usage
```$ ./droplet-manager.sh```

## docker-builder.sh
Docker Hub doesn't have automated builds for the GDGGR organization (only your personal account I guess).  This makes the build and push consistent to the different repos.

## start-docker-machine.sh
Best way to use docker on a Mac: https://docs.docker.com/engine/installation/mac/

It's pretty annoying to remember to do these commands when you want to start docker-machine.. This handles that.
