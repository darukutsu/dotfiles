#!/bin/bash

#path="$HOME/.config/rofi/myemojis.pango"
theme_applet="$XDG_CONFIG_HOME/rofi/applet.rasi"

## Run
if [ "$1" = "combi" ]; then
  #rofi -modi "combi,emoji,calc" -show "combi"  -emoji-file "$path" -normal-window
  rofi -modi "combi,calc" -show "combi" -combi-modes run,drun #-normal-window
elif [ "$1" = "window" ]; then
  rofi -show window #-normal-window
elif [ "$1" = "hidden-window" ]; then
  rofi_hidden_window
elif [ "$1" = "clipboard" ]; then
  rofi-clipboard
elif [ "$1" = "layout" ]; then
  rofi-bsp-layout $2
elif [ "$1" = "session-save" ]; then
  rofi-bsp-session save
elif [ "$1" = "session-load" ]; then
  rofi-bsp-session load
elif [ "$1" = "screenshot" ]; then
  rofi-applet-screenshot "$theme_applet"
elif [ "$1" = "bitwarden" ]; then
  #bwmenu
  rofi-rbw
elif [ "$1" = "powermenu" ]; then
  rofi-applet-powermenu "$theme_applet"
elif [ "$1" = "sxhkd_help" ]; then
  # TODO: parse multiple files

  #awk '/^[a-z]/ && last {print "<small>",$0,"\t",last,"</small>"} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc |
  #  column -t -s $'\t' |
  #  rofi -dmenu -i -markup-rows -no-show-icons -width 1000 -lines 15 -yoffset 40

  # TODO: make this global, and dynamic
  monitor=$(bspc query -M -m .focused --names)
  resolution=$(xrandr | grep "^$monitor" | sed -E "s/^$monitor connected ([^ ]*).*/\1/; s/([0-9]*)x([0-9]*).*/\1x500+0+\2/")
  width=$(echo "$resolution" | sed -E 's/([0-9]*)x([0-9]*)\+([0-9]*)\+([0-9]*).*/\1/')
  height=$(echo "$resolution" | sed -E 's/([0-9]*)x([0-9]*)\+([0-9]*)\+([0-9]*).*/\2/')
  xoffset=$(echo "$resolution" | sed -E 's/([0-9]*)x([0-9]*)\+([0-9]*)\+([0-9]*).*/\3/')
  yoffset=$(echo "$resolution" | sed -E 's/([0-9]*)x([0-9]*)\+([0-9]*)\+([0-9]*).*/\4/')

  hkhelper.py |
    rofi -dmenu -i -window-title "rofi-help-menu" -markup-rows -no-show-icons \
      -theme-str "window { height: $height; width: $width; x-offset: $xoffset; y-offset: $yoffset; }"

  #sxhkhmenu -o "-theme-str window{height:$height;width:$width;x-offset:$xoffset;y-offset:$yoffset;} -dmenu -i -window-title rofi-help-menu -markup-rows -no-show-icons"
else
  echo "unknown option"
fi
