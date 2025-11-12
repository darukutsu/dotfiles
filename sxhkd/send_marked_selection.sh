#!/bin/sh
#set -x

i=0
for node in $(bspc query -N -n .marked); do
  bspc node $node -n any.!automatic.local
  if [ $((i % 2)) = 0 ]; then
    bspc node $node -p east
  else
    bspc node $node -p south
  fi
  #bspc node $node -g marked=off # this is done implicitly
  i=$((i + 1))
done
bspc node $node -p cancel
