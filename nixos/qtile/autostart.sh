#! /run/current-system/sw/bin/sh
killall volumeicon

nitrogen --restore &
pulseaudio --start &
nm-applet &
lxsession &
/run/current-system/sw/bin/emacs --daemon &
sleep 2; flameshot &
volumeicon &
