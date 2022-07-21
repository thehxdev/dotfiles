#! /usr/bin/env bash

killall volumeicon

pulseaudio --start 
$HOME/.dwm/bar/dwm_bar.sh &
nitrogen --restore &
xrdb ~/.Xresources &
nm-applet &
/run/current-system/sw/bin/emacs --daemon &
flameshot &
sleep 1; exec volumeicon &

