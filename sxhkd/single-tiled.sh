#!/bin/sh
#set -x

is_multiple=1
bspc subscribe node_geometry | while read -r _; do
  if [ "$(bspc query -N -n .local.tiled | wc -l)" = 1 ]; then
    #bspc config border_width 0
    bspc config window_gap 0
    is_multiple=0
  elif [ $is_multiple = "0" ]; then
    # reload borders if new tiled window appears
    #bspc config border_width 3
    bspc config window_gap 12
    is_multiple=1
  fi
done 1>&2 >/dev/null &
