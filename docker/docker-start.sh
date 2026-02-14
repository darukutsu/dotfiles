#!/bin/sh
set -x

#if ! zpool status docker >/dev/null; then
#  printf "ZFS: docker pool not mounted"
#  exit
#fi

# Use docker compose instead
root=/home/daru/.docker
path="$root/$1/docker-compose.yml"
if [ "$2" = "all" ]; then
  find "$root" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | xargs -I{} "$root"/docker-start.sh {} update
elif [ -n "$2" ]; then
  while ! ping -c1 8.8.8.8; do :; done
  if docker ps | grep -i "$1" || [ "$3" = "force" ]; then # don't update stopped containers
    #docker stop "$1"
    docker-compose -f "$path" down
    # destructive operation be sure you have backup of your data
    #docker rm -f $()
    docker-compose -f "$path" pull && docker-compose -f "$path" up -d && docker image prune -af
    #docker-compose -f "$path" pull && docker image prune -af && docker-compose -f "$path" up -d
  fi
else
  docker-compose -f "$path" up
fi
