#!/bin/sh

# Ask fcitx5 what the current input method is.
# -n prints the name of the active input method, e.g.:
#   "keyboard-us" or "pinyin" or similar.

name=$(fcitx5-remote -n 2>/dev/null)

if [ -z "$name" ]; then
    # fcitx5 not running or couldn't get state
    echo "--"
    exit 0
fi

case "$name" in
    *pinyin*|*Pinyin*)
        echo "%{F#FF0000}CN%{F-}"
        ;;
    *keyboard*|*us*)
        echo "EN"
        ;;
    *)
        # fallback: show raw name if it's something else
        echo "$name"
        ;;
esac

