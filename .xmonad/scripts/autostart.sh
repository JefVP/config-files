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
dunst &
# picom --config $HOME/.xmonad/scripts/picom.conf &

#starting user applications at boot time

