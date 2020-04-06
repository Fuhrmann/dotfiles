#!/usr/bin/env bash

# Terminate running instances
killall -q polybar

# Wait for the processes shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch
if type "xrandr"; then
  export TRAYPOS = right
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main -c ~/.config/polybar/config.ini &
    unset TRAYPOS
  done
else
  polybar --reload main -c ~/.config/polybar/config.ini & 
fi
