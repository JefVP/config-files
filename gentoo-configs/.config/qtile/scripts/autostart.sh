#!/bin/sh
#
function run {
	if ! pgrep $1 ;
	then
		$@&
	fi
}

#sleep 2; 

xrandr -s 1920x1080 # set resolution for VM
xsetroot -cursor_name left_ptr & #Cursor
nitrogen --restore & #Wallpaper
# run nm-applet & # network manager tray icon, disabled because of dhcpd
# picom -b # Disabled because it crashes my Virtual Machines.
dbus-launch dunst &
