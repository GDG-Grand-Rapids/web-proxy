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

## gio-db will run on port `5432`

# Utils

## droplet-manager.sh
Management script for the droplet. Allows for updating individual containers or updating everything and getting it running. Use this tool to do any "normal" pulls or restarts of a particular container.  It will attempt to backup, pull _latest_ tag, stop, kill, and run the container with all the pre-defined parameters.

### Usage
```$ ./droplet-manager.sh```

To test things locally using this script, you still need to update the constants for the port numbers.  It's set specifically to the IP:PORT of the DO droplet right now for reverse proxy purposes and could be enhanced to have a --testing mode someday if necessary.

## docker-builder.sh
Docker Hub doesn't have automated builds for the GDGGR organization (only your personal account I guess).  This makes the build and push consistent to the different repos.

## start-docker-machine.sh
Best way to use docker on a Mac: https://docs.docker.com/engine/installation/mac/

It's pretty annoying to remember to do these commands when you want to start docker-machine.. This handles that, but you still have to manually run the `eval "$(docker-machine env default)"` bit when it prompts.
