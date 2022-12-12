#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybar1.log

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --config=~/.config/polybar/config.ini example 2>&1 | tee -a /tmp/polybar1.log & disown
    done
else
    polybar --config=~/.config/polybar/config.ini example 2>&1 | tee -a /tmp/polybar1.log & disown
fi

# echo "Bars launched..."
