#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

(sleep 2; polybar mainbar-xmonad) &

#cursor active at boot
xsetroot -cursor_name left_ptr &

# Setting wallpaper
nitrogen --restore &

# Utilities
run nm-applet &
picom -b
/usr/bin/greenclip daemon > /dev/null
exec dunst
#starting user applications at boot time

