#! /usr/bin/env sh

killall volumeicon

$HOME/.config/dwm/bar/dwm_bar.sh &
pulseaudio --start &
nitrogen --restore &
xrdb ~/.Xresources &
nm-applet &
/run/current-system/sw/bin/emacs --daemon &
sleep 1; volumeicon &
flameshot &

