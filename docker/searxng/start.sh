#!/bin/sh
set -x

#PORT=8080
#
#docker run -a STDOUT --rm \
#  -p ${PORT}:8080 \
#  --name=searxng -v "${PWD}/searxng:/etc/searxng" \
#  -e "BASE_URL=http://localhost:$PORT/" \
#  -e "INSTANCE_NAME=daru-localhost-instance" \
#  searxng/searxng

# Use docker compose instead
path="/home/daru/.docker/searxng/compose.yaml"
if [ -n "$1" ]; then
  while ! ping -c1 8.8.8.8; do :; done
  docker stop searxng
  docker-compose -f "$path" pull && docker-compose -f "$path" up -d && docker image prune -af
else
  docker-compose -f "$path" up
fi
