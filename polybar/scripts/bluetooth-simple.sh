#!/bin/sh

# make bluetooth click to on/off  maybe also connect
#
# Check if a device is connected by bluetooth using bluetoothctl

if [ "$1" = "power" ]; then
  if bluetoothctl show | rg 'Powered: no'; then
    bluetoothctl power on
  else
    bluetoothctl power off
  fi
fi

if [ "$1" = "ui" ]; then
  exec kitty --class kitty-float bluetuith &
fi

name=$(bluetoothctl info | rg Name | sed 's/Name: \(.*\)/\1/' | tr -d '\t')
battery=$(bluetoothctl info | rg "Battery Percentage" | sed 's/Battery .* \(.*\)/\1/' | tr -d '\t')

# Show some output when it is
if [ -n "$name" ]; then
  # Connected to a device
  echo " $battery$name"
elif [ -n "$(bluetoothctl show | rg 'Powered: yes')" ]; then
  echo ""
else
  # Not connected to a device
  echo ''
fi
