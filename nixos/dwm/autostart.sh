#! /usr/bin/env sh

killall volumeicon

pulseaudio --start 
$HOME/.config/dwm/bar/dwm_bar.sh &
nitrogen --restore &
xrdb ~/.Xresources &
nm-applet &
/run/current-system/sw/bin/emacs --daemon &
flameshot &
sleep 1; exec volumeicon &

