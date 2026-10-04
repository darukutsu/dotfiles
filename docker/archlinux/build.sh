#!/bin/sh

# Seed only the corporate trust anchors from the host into the build context.
# The Dockerfile COPYs just this dir and runs update-ca-trust to MERGE them
# with the distro certs (no clobbering of /etc/ssl).
mkdir -p ./etc/ca-certificates/trust-source/anchors
cp -rL /etc/ca-certificates/trust-source/anchors/. ./etc/ca-certificates/trust-source/anchors/

# Seed host pacman config (repos + mirrorlist) and X11 config into the build
# context so the image builds against the same repos/mirrors and Xorg setup.
mkdir -p ./etc/pacman.d ./etc/X11
cp -L /etc/pacman.conf ./etc/pacman.conf
cp -rL /etc/pacman.d/mirrorlist ./etc/pacman.d/mirrorlist
cp -rL /etc/X11/. ./etc/X11/

docker compose build --no-cache
