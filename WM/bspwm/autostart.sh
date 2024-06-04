#!/usr/bin/env bash

nitrogen --restore &
#picom --backend glx &
nm-applet &
#xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 &
setxkbmap -layout 'us,ir' -option 'eurosign:e,caps:escape,grp:alt_shift_toggle' &
xset r rate 220 30 &
xfce4-power-manager &
flameshot &
#xrdb /home/hx/.Xresources
if ! pgrep clipman >/dev/null 2>&1; then
    xfce4-clipman &
fi
#blueman-applet &
#blueberry-tray &
#volumeicon &
#lxsession &
