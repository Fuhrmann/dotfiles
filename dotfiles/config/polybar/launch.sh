#!/usr/bin/env bash

# Terminate running instances
killall -q polybar

# Wait for the processes shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch
polybar main -c ~/.config/polybar/config.ini &
