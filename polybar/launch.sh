#!/usr/bin/env bash

#Terminate already running bar instances
killall -q polybar

#Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1;done

#Launch bar1 and bar2
externalHDMI=$(xrandr --query | grep 'HDMI-A-0')
if [[ $externalHDMI = *connected* ]]; then
    polybar floatingleft_ext &
    polybar floatingcentre_ext &
    polybar floatingright_ext &
fi

externalDP=$(xrandr --query | grep 'DisplayPort-0')
if [[ $externalDP = *connected* ]]; then
    polybar floatingleft_ext2 &
    polybar floatingcentre_ext2 &
    polybar floatingright_ext2 &
fi


polybar floatingleft &
polybar floatingcentre &
polybar floatingright &


