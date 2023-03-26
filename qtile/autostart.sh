#!/usr/bin/env bash

nitrogen --restore &
picom --backend glx &
nm-applet &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 &
setxkbmap -layout 'us,ir' -option 'grp:alt_shift_toggle' &
xset r rate 220 30 &
xfce4-power-manager &
xrdb /home/hx/.Xresources
#/usr/bin/emacs --daemon &
#volumeicon &
#flameshot &
#lxsession &
