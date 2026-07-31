#!/usr/bin/env sh

sed -i "s/eDP-[0-9]/$(niri msg outputs | grep -Pio 'eDP-[0-9]')/g" ~/.config/niri/config.kdl
