#!/bin/sh

while true; do
    wl-paste | xclip -selection clipboard
    xclip -selection clipboard -o | wl-copy
    sleep 0.5
done
