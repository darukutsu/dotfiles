#!/bin/sh

if ! [ -d ./etc/ssl ]; then
  cp -rL /etc/ssl ./etc/ssl
  cp -rL /etc/ca-certificates ./etc/ca-certificates
fi

if docker compose build --no-cache; then
  docker create --name temp archlinux

  docker cp temp:/usr/. ./usr
  docker cp temp:/etc/. ./etc

  docker rm temp
fi
