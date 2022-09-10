#!/usr/bin/env bash

#Terminate already running bar instances
killall -q polybar

#Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1;done

#Launch bar1 and bar2
polybar floatingleft &
polybar floatingcentre &
polybar floatingright &

external=$(xrandr --query | grep 'HDMI-A-0')
if [[ $external = *connected* ]]; then
    polybar floatingleft_ext &
    polybar floatingcentre_ext &
    polybar floatingright_ext &
fi
