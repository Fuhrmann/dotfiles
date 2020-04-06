#!/bin/sh
count=`ps aux | grep -c ncspot`
if [ $count -eq 1 ]; then
    kitty --title "music" --session $HOME/projetos/dotfiles/dotfiles/config/kitty/ncspot-session.kitty
else
    i3-msg "[title=music] focus"
fi
