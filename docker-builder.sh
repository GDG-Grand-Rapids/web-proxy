#!/bin/bash
echo Building gdggr/web-proxy
docker build -t gdggr/web-proxy .

echo Pushing latest to docker hub
docker push gdggr/web-proxy:latest
