#!/usr/bin/env bash

monitor_add() {
if xrandr | grep "$EXTERNAL connected"; then
    xrandr --output $EXTERNAL --mode 1920x1080 --set TearFree on --above eDP

    bspc monitor $EXTERNAL -d 11 12 13 14 15 16 17 18 19 20 
    bspc wm --reorder-monitors eDP $EXTERNAL
fi
}

monitor_remove() {

for desktop in $(bspc query -D -m "$EXTERNAL"); do
    bspc desktop -f $desktop
    for node in $(bspc query -N -d); do
        bspc node --to-monitor eDP
    done
    bspc desktop $desktop --remove
done

bspc monitor $EXTERNAL --remove
xrandr --output $EXTERNAL --off

}

killall polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1;done

for EXTERNAL in {HDMI-A-0,DisplayPort-0}; do
    #echo $EXTERNAL
    if [ $(bspc query -M | wc -l) -eq 1 ] ; then
        #echo "$(bspc query -M | wc -l) monitors found"
        #echo "adding"
        monitor_add
    else
        #echo "$(bspc query -M | wc -l) monitors found"
        #echo "removing"                  
        monitor_remove
    fi
done

if [ $(bspc query -M | wc -l) -eq 1 ]; then
    nohup nitrogen --set-zoom-fill ~/Pictures/Wallpaper/Jyv.png > /dev/null 2>&1
else
nohup nitrogen --set-zoom-fill ~/Pictures/Wallpaper/Jyv2.png > /dev/null 2>&1
fi

nohup /home/yottaphy/.config/polybar/launch.sh > /dev/null 2>&1 &

sleep 20
