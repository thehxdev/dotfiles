#! /usr/bin/env bash
nitrogen --restore &
picom --experimental-backend &
volumeicon &
nm-applet &
/usr/bin/emacs --daemon &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 &
flameshot &
lxsession &
setxkbmap -layout 'us,ir' -option 'grp:alt_shift_toggle' &
