#!/bin/sh
#TODO: rework with picom if implemented
#https://github.com/yshui/picom/issues/43

focused_monitor=$(bspc query -M -m .focused --names)
zoom_var="BSPWM_ZOOM_$focused_monitor"
zoom="$zoom_var"

if [ "$1" = "in" ]; then
  zoom=$(echo "$zoom" | awk '{ sum = $1-0.1} END { print sum }')
elif [ "$1" = "out" ]; then
  zoom=$(echo "$zoom" | awk '{ sum = $1+0.1} END { print sum }')
elif [ "$1" = "reset" ]; then
  zoom=1.0
  #xrandr --output "$focused_monitor" --transform none
fi

xrandr --output "$focused_monitor" --scale "$zoom"

export "$zoom_var=$zoom"
