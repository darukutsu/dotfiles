#!/bin/sh

pkgs_chaotic=$(pacman -Slq chaotic-aur)
pkgs_ignored=$(sed -ne '/^IgnorePkg/ s/IgnorePkg = *//p' /etc/pacman.conf | tr ' ' '\n')
pkgs_native_stripped=$(printf "%s\n%s\n%s" "$(pacman -Quenq)" "$pkgs_ignored" "$pkgs_ignored" | sort | uniq -c | sed -nE '/^ *1/ s/^ *1 (.*)/\1/p')
# we want 2 times chaotic to cancel out
pkgs_native_upgradable=$(printf "%s\n%s\n%s" "$pkgs_native_stripped" "$pkgs_chaotic" "$pkgs_chaotic" | sort | uniq -c | sed -nE '/^ *1/ s/^ *1 (.*)/\1/p')
pkgs_aur_upgradable=$(yay -Qum 2>/dev/null)
pkgs_chaotic_upgradable=$(printf "%s\n%s" "$pkgs_native_stripped" "$pkgs_chaotic" | sort | uniq -c | sed -nE '/^ *2/ s/^ *2 (.*)/\1/p')

#if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then updates_arch=0; fi
updates_arch=$(printf "%s" "$pkgs_native_upgradable" 2>/dev/null | grep -cE '.+$')
updates_aur=$(printf "%s\n%s" "$pkgs_aur_upgradable" "$pkgs_chaotic_upgradable" 2>/dev/null | grep -cE '.+$')
updates_zfs=$(yay -Qu 2>/dev/null | grep -c 'zfs-linux')

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
