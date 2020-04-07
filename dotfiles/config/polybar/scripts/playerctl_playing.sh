
#!/bin/sh

player_status=$(playerctl -i chrome status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo " $(playerctl -i chrome metadata artist) - $(playerctl -i chrome metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl -i chrome metadata artist) - $(playerctl -i chrome metadata title)"
fi
