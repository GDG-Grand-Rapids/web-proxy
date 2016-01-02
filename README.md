# web-proxy
Reverse proxy nginx dockerfile for our DO host.

This docker container needs to be running on the DO droplet via:
`docker run --name proxy -p 80:80 -d gdggr/web-proxy:0.0.1`

All traffic is routed to the proxy and sent to the right website depending on its respective domain name.

Image is maintained in docker hub here: https://hub.docker.com/r/gdggr/web-proxy/

* docker build -t gdggr/web-proxy .
* docker tag [image id] gdggr/web-proxy:[version]
* docker push gdggr/web-proxy:[version]
* Login to DO host
* docker pull gdggr/web-proxy:[version]
* docker run --name proxy -p 80:80 -d gdggr/web-proxy:[version]

## ioextendedgr.com will run on port `3000`
`docker run --name io-site -p 3000:80 -d mccrackend/conference_website:latest`

## gdggr.org will run on port `5000`
`docker run --name gdggr-site -p 5000:80 -d gdggr/website:latest`

# Utils

## droplet-manager.sh
Management script for the droplet. Allows for updating individual applications or updating everything and getting it running.

## docker-builder.sh
Docker Hub doesn't have automated builds for the GDGGR organization (only your personal account I guess).  This makes the build and push consistent to the different repos.

## start-docker-machine.sh
Best way to use docker on a Mac: https://docs.docker.com/engine/installation/mac/

It's pretty annoying to remember to do these commands when you want to start docker-machine.. This handles that.
