#!/bin/bash
#set -x

wid=$(xdotool search --classname "$1")

bspc subscribe node_focus | while read -a line; do
  node_id=$(printf "%d" "${line[3]}")
  if [ "$node_id" -ne "$wid" ] && bspc query -N -n "$wid.!tiled.!marked"; then
    bspc node "$wid" -g hidden=on -g sticky=on
  fi
done 1>&2 >/dev/null &
