#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

(sleep 2; polybar mainbar-xmonad) &
(sleep 2; polybar mainbar-xmonad-extra) &

#cursor active at boot
xsetroot -cursor_name left_ptr &

# Setting wallpaper
nitrogen --restore &

# Utilities
run nm-applet &
picom -b
/usr/bin/greenclip daemon > /dev/null
dbus-launch dunst &
#starting user applications at boot time

