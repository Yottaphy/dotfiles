#!/bin/bash
while sleep 5; do
	read -r status capacity < <(acpi -b | awk -F'[,:%]' '{print $2, $3}')
	if [ "$status" = Discharging ] && [ "$capacity" -lt 5 ] && [ "$critbatnotsent" != yes ]; then
		critbatnotsent=yes
		mpv --no-config /usr/local/share/ding.mp3; notify-send --app-name='Battery level critically low!' 'Suspending in 60 seconds.' &
	    sleep 60; read -r status capacity < <(acpi -b | awk -F'[,:%]' '{print $2, $3}')
	    if [ "$status" = Discharging ]; then
            systemctl suspend
        fi
    elif [ "$status" = Discharging ] && [ "$capacity" -lt 15 ] && [ "$lowbatnotsent" != yes ]; then
		lowbatnotsent=yes
		mpv --no-config /usr/local/share/ding.mp3; notify-send --app-name='Battery low!' 'Plug in your charger now.' &
	elif [ "$status" = Charging ] || [ "$capacity" -ge 15 ]; then
		lowbatnotsent=no
		critbatnotsent=no
	fi
done
