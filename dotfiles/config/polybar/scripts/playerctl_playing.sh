
#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo " $(playerctl -i chrome metadata artist) - $(playerctl -i chrome metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl -i chrome metadata artist) - $(playerctl -i chrome metadata title)"
elif [ "$player_status" = "Stopped" ]; then
		mpd_current=$(mpc current 2> /dev/null)
		if [[ $(echo "$mpd_current" | wc -l) -gt 0 ]]; then
		    echo " $mpd_current"
    fi
fi
