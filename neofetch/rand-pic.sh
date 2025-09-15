#!/bin/sh
#set -x

dir="$XDG_CONFIG_HOME/neofetch"
imagesource='image_source="$XDG_CONFIG_HOME/neofetch/pic'

#image="lum-tr.png"
image=$(ls "$dir/pic" | shuf -n 1)

sed -i "s|$imagesource.*|$imagesource/$image\"|" "$dir/config.conf"
