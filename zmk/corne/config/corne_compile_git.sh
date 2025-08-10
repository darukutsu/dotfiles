#!/bin/sh

# I run this script from "$HOME"/.config/zmk/zmk/app
# build/left build/right should be renamed to abs path
# to be able to run from anywhere...i guess
#
# Only left side is enough for keymap changes, flash both if there are conf changes involving both
#HOME=/home/daru

# Initial setup
# pip3 install --user -r zephyr/scripts/requirements.txt
# OR
## python -m venv /venv/dir ##
# python -m venv python-dep
# python-dep/bin/pip3 install -r zephyr/scripts/requirements.txt
#
# if on ArchLinux sudenly stops working probably python broke, you just need to reinstall

# comment or set to main to chose your desired build
version=v0.3

# comment to disable
is_keymap_drawer=yes
is_display=yes

# uncomment to clean build
#pristine=-p

printf "would you like to update? y/N: "
read -r update_repo
if [ $update_repo = 'y' ]; then
  git checkout main
  git pull
fi

if [ -z $version ] || [ $version = "main" ]; then
  git checkout main
fi

source "$HOME"/.config/zmk/zmk/python-dep/bin/activate

## in zmk dir after init
printf "would you like to update build tools? y/N: "
read -r update_build
if [ $update_build = 'y' ]; then
  west update
fi

if [ -n "$is_display" ]; then
  #ldshield="corne_left nice_view_adapter nice_view"
  #rdshield="corne_right nice_view_adapter nice_view"
  ldshield="corne_left nice_view_adapter dongle_display_view_pro_micro"
  rdshield="corne_right"
else
  ldshield="corne_left"
  rdshield="corne_right"
fi

#-DZMK_EXTRA_MODULES="$HOME/.config/zmk/corne/config"
sed "/# corne_left/,/# corne_left/d" "$HOME/.config/zmk/corne/config/corne_left.conf" >"$HOME/.config/zmk/corne/config/corne_right.conf"

west build $pristine -b nice_nano_v2 -d build/left -- -DSHIELD="$ldshield" -DZMK_CONFIG="$HOME/.config/zmk/corne/config" &&
  cp -f "$HOME"/.config/zmk/zmk/app/build/left/zephyr/zmk.uf2 zmk_left.uf2

west build $pristine -b nice_nano_v2 -d build/right -- -DSHIELD="$rdshield" -DZMK_CONFIG="$HOME/.config/zmk/corne/config" &&
  cp -f "$HOME"/.config/zmk/zmk/app/build/right/zephyr/zmk.uf2 zmk_right.uf2

# generate using keymap-drawer layout svg
if [ -n "$is_keymap_drawer" ]; then
  keymap_drawer_conf=~/.config/zmk/corne/config/keymap_drawer_conf.yaml
  keymap_conf=~/.config/zmk/corne/config/corne.keymap
  keymap_yaml=~/.config/zmk/corne/config/corne.yaml
  svg_out=~/.config/zmk/corne/config/pics/corne.keymap.svg

  keymap -c "$keymap_drawer_conf" parse -z "$keymap_conf" -o "$keymap_yaml"
  keymap -c "$keymap_drawer_conf" draw -o "$svg_out" "$keymap_yaml"
  #keymap -c "$keymap_drawer_conf" parse -z corne.keymap | keymap -c "$keymap_drawer_conf" draw -o $svg_out -
fi

flashing_time=8
printf "flash left side? y/N: "
read -r lflash
if [ $lflash = 'y' ]; then
  echo "you got $flashing_time secs..."
  sleep $flashing_time && cp zmk_left.uf2 /run/media/daru/NICENANO
fi

printf "flash right side? y/N: "
read -r rflash
if [ $rflash = 'y' ]; then
  echo "you got $flashing_time secs..."
  sleep $flashing_time && cp zmk_right.uf2 /run/media/daru/NICENANO
fi
