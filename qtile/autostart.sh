#!/usr/bin/env bash

nitrogen --restore &
picom --backend glx &
nm-applet &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 &
setxkbmap -layout 'us,ir' -option 'grp:alt_shift_toggle' &
xset r rate 220 30 &
xfce4-power-manager &
flameshot &
xrdb /home/hx/.Xresources
xfce4-clipman &
blueman-applet &
#volumeicon &
#lxsession &
