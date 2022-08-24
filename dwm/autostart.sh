#! /usr/bin/env bash

#killall volumeicon &
killall -q pulseaudio 

$HOME/.dwm/bar/dwm_bar.sh &
nitrogen --restore &
xrdb ~/.Xresources &
#nm-applet &
picom --experimental-backend &
xfce4-power-manager &
setxkbmap -layout "us,ir" -option "caps:escape,grp:alt_shift_toggle" &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 &
/usr/bin/emacs --daemon &
thunar --daemon &
sleep 1; pulseaudio --start &
#sleep 1; exec volumeicon &

# exports
export TERMINFO=/usr/share/terminfo/ &
export PATH="/opt/sublime_text/:$PATH" &
export PATH="$HOME/.cargo/bin/:$PATH" &
export PATH="$HOME/.anaconda3/bin/:$PATH" &
export PATH="$HOME/.emacs.d/bin/:$PATH" &
export PATH="$HOME/.ghcup/bin/:$PATH" &
export PATH="$HOME/.zls/:$PATH" &
export PATH="$HOME/.local/bin/:$PATH" &

