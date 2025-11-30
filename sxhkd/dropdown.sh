#!/bin/sh
#set -x

dropname="$1"
wid=$(xdotool search --classname "$dropname")

if [ -s "/tmp/$dropname" ]; then
  wid=$(tail -1 "/tmp/$dropname")

  # removes file if window was destroyed
  if ! bspc query -N -n $wid; then
    while read -r node; do
      bspc node $node -g sticky=off -g hidden=off
    done <"/tmp/$dropname"
    rm "/tmp/$dropname"
  fi
  exit
fi

if [ -z "$wid" ] && echo "$dropname" | grep kitty; then
  kitty --hold --class="$dropname" "$XDG_CONFIG_HOME/sxhkd/unmap.sh" "$dropname"
elif [ -z "$wid" ]; then
  touch "/tmp/$dropname"
  bspc monitor -a tmp
  i=0
  for node in $(bspc query -N -n .marked | tee "/tmp/$dropname"); do
    bspc node $node -d tmp

    if [ $((i % 2)) = 0 ]; then
      bspc node $node -p east
    else
      bspc node $node -p south
    fi

    #bspc node $node -g marked=off # this is done implicitly
    i=$((i + 1))
  done
  bspc node $node -p cancel
  parent=$(bspc query -N $(tail -1 "/tmp/$dropname") -n @parent)
  echo "$parent" >>"/tmp/$dropname"
  bspc node $parent -g hidden=off -g sticky=on
  bspc desktop tmp -r
else
  if bspc query -N -n "$wid".!hidden.!local; then
    bspc node "$wid" -d focused -f
  elif bspc node "$wid".!hidden -g hidden=on -g sticky=on; then
    :
  else
    bspc node "$wid".hidden -g hidden=off -g sticky=off -d any.active -f
  fi
fi
