#!/bin/sh
#set -x

dropname="$1"
wid=$(xdotool search --classname "$dropname")

if [ -s "/tmp/$dropname" ]; then
  wid=$(head -n1 "/tmp/$dropname")

  # removes file if window was destroyed
  # or when node was marked (thus normal state)
  if ! bspc query -N -n $wid || { bspc query -N -n $wid.marked && bspc node $wid -g marked=off; }; then
    rm "/tmp/$dropname"
    exit
  fi
fi

if [ -z "$wid" ] && echo "$dropname" | grep kitty; then
  kitty --hold --class="$dropname" "$XDG_CONFIG_HOME/sxhkd/unmap.sh" "$dropname"
elif [ -z "$wid" ]; then
  # currently only focused window is supported
  # maybe later will figure out how to send all marked to 1 node
  # and then operate over multiple marked nodes
  touch "/tmp/$dropname"
  # FIX: we cannot directly determine which node is marked
  bspc query -N -n focused.marked | tail -n1 >"/tmp/$dropname"
  bspc node "$(head -n1)" -g marked=off
else
  if bspc node "$wid".!hidden -g hidden=on; then
    :
  else
    bspc node "$wid".hidden -g hidden=off -d any.active -f
  fi
fi
