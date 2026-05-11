#!/bin/sh

if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
  updates_arch=0
fi

packages=$(yay -Qum 2>/dev/null)
updates_aur=$(printf "$packages" 2>/dev/null | grep -ce '.*\?$')
#updates_aur=$(paru -Qum 2> /dev/null | wc -l)
#updates_aur=$(cower -u 2> /dev/null | wc -l)
#updates_aur=$(trizen -Su --aur --quiet | wc -l)
#updates_aur=$(pikaur -Qua 2> /dev/null | wc -l)
#updates_aur=$(rua upgrade --printonly 2> /dev/null | wc -l)
updates_zfs=$(printf $packages 2>/dev/null | grep -c 'zfs-linux')

#if ! updates_flatpak=$(flatpak remote-ls --updates); then
#  updates_flatpak=0
#fi

updates=$((updates_arch + updates_aur + updates_zfs))

if [ "$updates" -gt 0 ]; then
  echo "$updates_arch $updates_aur $updates_zfs"
  #
else
  echo ""
  #echo ""
fi
