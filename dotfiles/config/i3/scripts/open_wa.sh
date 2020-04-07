#!/bin/sh
window=`xdotool search -classname web.whatsapp.com`
if [ -n "${window}" ]; then
    i3-msg "[instance=web.whatsapp.com window_role=pop-up] focus" 
else
    google-chrome --app=https://web.whatsapp.com
fi

