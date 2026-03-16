#!/bin/sh

# docker does not follow symlinks
#ln -s /etc/ssl ./ssl
#ln -s /etc/ca-certificates ./ca-certificates

if ! [ -d ssl ]; then
  cp -rL /etc/ssl ./ssl
  cp -rL /etc/ca-certificates ./ca-certificates
fi

docker compose build --no-cache
