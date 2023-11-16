#!/usr/bin/env bash

polybar-msg cmd quit

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        # print 'main' if m = 'eDP-1'
        if [ "$m" == "eDP-1" ]; then
            MONITOR=$m polybar --config=~/projects/dotfiles/polybar-config.ini main &> /dev/null | tee -a /tmp/polybar1.log & disown
        else
            MONITOR=$m polybar --config=~/projects/dotfiles/polybar-config.ini attached 2>&1 | tee -a /tmp/polybar1.log & disown
        fi
    done
else
    polybar --config=~/.config/polybar/config.ini example 2>&1 | tee -a /tmp/polybar1.log & disown
fi

# echo "Bars launched..."
