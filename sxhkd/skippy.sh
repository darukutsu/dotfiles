#!/bin/sh

activating=0

wids=$(xdotool search --class skippy-xd)
for wid in $wids; do
  mapstate=$(xwininfo -id $wid | grep Map)
  if echo "$mapstate" | grep "IsViewable"; then
    activating=1
  fi
done

if [ $activating -eq 0 ]; then
  touch /tmp/skip-expose
  skippy-xd --expose
  rm /tmp/skip-expose
fi

if [ $activating -eq 1 ]; then
  focused_desktop=$(xdotool get_desktop)

  if [ -f /tmp/skip-expose ]; then
    skippy-xd --expose --toggle
    mv /tmp/skip-expose /tmp/skip-paging
    desktop=$(skippy-xd --paging --toggle)

    if [ "$focused_desktop" != "$desktop" ]; then
      skippy-xd --desktop "$desktop"
    fi
    rm /tmp/skip-paging
  elif [ -f /tmp/skip-paging ]; then
    skippy-xd --paging --toggle
    mv /tmp/skip-paging /tmp/skip-expose
    skippy-xd --expose
    rm /tmp/skip-expose
  fi
fi
