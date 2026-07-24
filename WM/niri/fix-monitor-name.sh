#!/usr/bin/env sh

NIRI_CONFIG="~/.config/niri/config.kdl"
sed -i \
    "s/eDP-[0-9]/$(niri msg outputs | grep -Pio 'eDP-[0-9]')/g" \
    "$NIRI_CONFIG"
