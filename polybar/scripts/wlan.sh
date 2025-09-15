#!/bin/sh

if [ "$1" = "power" ]; then
  if nmcli radio wifi | rg disabled; then
    nmcli radio wifi on
  else
    nmcli radio wifi off
  fi
fi

if [ "$1" = "ui" ]; then
  exec kitty --class kitty-float nmtui &
fi

ip=$(nmcli -g IP4.ADDRESS device show wlp1s0 2>/dev/null)
# Show some output when it is
if [ -n "$ip" ]; then
  # Connected to a device
  echo " $ip"
elif [ -n "$(nmcli radio wifi | rg enabled)" ]; then
  echo ""
else
  # Not connected to a device
  echo ''
fi
