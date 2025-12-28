#!/bin/sh

sxcs | while read -r color; do
  notify-send -a "sxcs" -t 5000 "Color Picker" "$color"
  echo "$color" | xclip -selection clipboard
done
