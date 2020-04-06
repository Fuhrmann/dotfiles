#!/bin/sh
count=`ps aux | grep -c ncspot`
if [ $count -eq 1 ]; then
    alacritty --title musica -e ~/.cargo/bin/ncspot
else
    i3-msg "[title=musica] focus"
fi
