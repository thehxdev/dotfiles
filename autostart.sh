#! /usr/bin/env bash

setxkbmap -option "caps:escape" &
xset r rate 220 30 &
#/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh &
#thunar --daemon &
#xfdesktop &
#/usr/bin/emacs --daemon &
#nitrogen --restore &
#picom --experimental-backend &
#lxsession &
#volumeicon &
#nm-applet &
#flameshot &
#xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 &
#setxkbmap -layout 'us,ir' -option 'grp:alt_shift_toggle' &
#xfce4-clipman &
#pulseaudio --start &
#./.config/dwm/dwm-bar/dwm_bar.sh &      # For DWM status-bar

#export QT_QPA_PLATFORMTHEME="qt5ct"
#export EDITOR=/usr/bin/nvim
#export BROWSER=/usr/bin/firefox
#export PATH="/opt/sublime_text/:$PATH" &
export TERMINFO=/usr/share/terminfo/ &
export PATH="$HOME/.cargo/bin/:$PATH" &
export PATH="$HOME/.anaconda3/bin/:$PATH" &
export PATH="$HOME/.emacs.d/bin/:$PATH" &
export PATH="$HOME/.ghcup/bin/:$PATH" &
export PATH="$HOME/.zls/:$PATH" &
export PATH="$HOME/.local/bin/:$PATH" &
export PATH="$HOME/.bun/bin/:$PATH" &
#export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
#export NIX-PROFILES="/nix/var/nix/profiles/default $HOME/.nix-profile"

killall -w -q pulseaudio; pulseaudio --start &

