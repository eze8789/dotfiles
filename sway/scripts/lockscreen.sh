#!/bin/sh
# Times the screen off and puts it to background
swayidle \
    timeout 10 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' &
# Locks the screen immediately
swaylock -i /home/linuxin/Pictures/Wallpapers/m0yg1m8ikoax.jpg -e
# Kills last background task so idle timer doesn't keep running
kill %%
