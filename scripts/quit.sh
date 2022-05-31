#!/bin/bash

#echo -e "cancel\nshutdown\nreboot" | dmenu -fn 'UbuntuMono Nerd Font:style=Bold' -h 20 -l 3 -nb "#1d1f21" -nf "#fba922" -sb "#fba922" -sf "#1d1f2" 

selection=$(echo -e " \tcancel\n \tlogout\n 累\treboot\n 襤\tpower" | rofi -dmenu -theme "/home/yottaphy/.config/rofi/themes/yquit.rasi")

echo $selection
#-fn 'UbuntuMono Nerd Font:style=Bold' -h 20 -l 3 | xargs )

if [[ $selection = *"logout"* ]]; then
   bspc quit
elif [[ $selection = *"power"* ]]; then
   shutdown now
elif [[ $selection = *"reboot"* ]]; then
   reboot
else exit
fi

