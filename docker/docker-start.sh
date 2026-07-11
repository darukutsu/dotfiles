#!/bin/sh
set -x

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  printf "USAGE: docker-start.sh <COMMAND>
  COMMANDS:
    update-all 		              updates all container and runs them
    update-all-running 		      updates all running container and runs them
    <CONTAINER>	                starts container
    <CONTAINER> update 		      updates container
    <CONTAINER> update-force 		force updates container (stopped ones)
  "
  exit 0
fi

#if ! zpool status docker >/dev/null; then
#  printf "ZFS: docker pool not mounted"
#  exit
#fi

# Use docker compose instead
root=/home/daru/.docker

update_container() {
  # NOTE: updates and runs container

  while ! ping -c1 8.8.8.8; do :; done
  docker-compose -f "$path" down
  # destructive operation be sure you have backup of your data
  docker-compose -f "$path" pull && docker-compose -f "$path" up -d && docker image prune -af
  #docker-compose -f "$path" pull && docker image prune -af && docker-compose -f "$path" up -d
}

case "$1" in
update-all)
  find "$root" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | xargs -I{} "$root"/docker-start.sh {} update-force
  ;;
update-all-running)
  find "$root" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | xargs -I{} "$root"/docker-start.sh {} update
  ;;
*)
  path="$root/$1/docker-compose.yml"
  ;;
esac

case "$2" in
update)
  #if docker ps | grep -i "$1" ||
  state=$(systemctl --user show --property=ActiveState --no-pager --value "$1")
  if [ "$state" = "active" ]; then
    update_container
  fi
  ;;
update-force)
  update_container
  ;;
  #update-force-stop)
  #  update_container
  #;;
*)
  echo "unknown option $2"
  ;;
esac

if [ -z "$2" ]; then
  docker-compose -f "$path" up
fi
