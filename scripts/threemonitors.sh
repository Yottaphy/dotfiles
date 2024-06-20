#!/bin/sh

xrandr --newmode "1920x1200"  193.25  1920 2056 2256 2592  1200 1203 1209 1245 -hsync +vsync
xrandr --addmode DisplayPort-2 1920x1200                                                    
xrandr --output DisplayPort-2 --mode 1920x1200 --set TearFree on --left-of eDP          
xrandr --output DisplayPort-1 --mode 1920x1080 --set TearFree on --left-of DisplayPort-2
bspc monitor eDP -d 21 22 23 24 25 26 27 28 29 30         
bspc monitor DisplayPort-2 -d 11 12 13 14 15 16 17 18 19 20
bspc monitor DisplayPort-1 -d 1 2 3 4 5 6 7 8 9 10         
bspc wm --reorder-monitors DisplayPort-1 DisplayPort-2 eDP

$HOME/.config/polybar/launch.sh

