#!/bin/sh

if [ $(pamixer --get-mute) = true ]; then
  muted="Muted "
fi

volume=$(pamixer --get-volume)
dunstify -e -u low -a "changevolume" -h int:value:"$volume" ""$muted"Volume: ${volume}%" -t 1000
