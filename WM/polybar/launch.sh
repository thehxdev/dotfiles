#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
#killall -q polybar

if pgrep polybar >/dev/null 2>&1; then
    pkill polybar
fi

echo "---" | tee -a /tmp/polybar1.log
polybar mainbar-bspwm 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."

# ================================================================= #

# More info : https://github.com/jaagr/polybar/wiki

# Install the following applications for polybar and icons in polybar if you are on ArcoLinuxD
# awesome-terminal-fonts
# Tip : There are other interesting fonts that provide icons like nerd-fonts-complete
# --log=error
# Terminate already running bar instances
#killall -q polybar

## Wait until the processes have been shut down
#while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done
#
#desktop=$(echo $DESKTOP_SESSION)
#count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)
#
#
#case $desktop in
#
#    bspwm|/usr/share/xsessions/bspwm)
#    if type "xrandr" > /dev/null; then
#      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#        MONITOR=$m polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
#      done
#    else
#    polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
#    fi
#    # second polybar at bottom
#    # if type "xrandr" > /dev/null; then
#    #   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#    #     MONITOR=$m polybar --reload mainbar-bspwm-extra -c ~/.config/polybar/config &
#    #   done
#    # else
#    # polybar --reload mainbar-bspwm-extra -c ~/.config/polybar/config &
#    # fi
#    ;;


