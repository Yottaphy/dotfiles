#!/bin/bash

#echo -e "cancel\nshutdown\nreboot" | dmenu -fn 'UbuntuMono Nerd Font:style=Bold' -h 20 -l 3 -nb "#1d1f21" -nf "#fba922" -sb "#fba922" -sf "#1d1f2" 

selection=$(echo -e "cancel\nlogout\nreboot\nshutdown" | rofi -dmenu -theme "/home/yottaphy/.config/rofi/themes/yquit.rasi") 

#-fn 'UbuntuMono Nerd Font:style=Bold' -h 20 -l 3 | xargs )

if [[ $selection = "logout" ]]; then
   bspc quit
elif [[ $selection = "shutdown" ]]; then
   poweroff
elif [[ $selection = "reboot" ]]; then
   reboot
else exit
fi

