#!/bin/bash

: "${BAT_TMP:=/tmp/batterytmp}"
: "${THRESHOLD:=15}"

let bat="$(acpi -b | awk -F, '{print gensub(/^.|.$/,"","g",$2)}')"
if [[ -f "$BAT_TMP" ]]; then
        ((bat > THRESHOLD)) && rm -f "$BAT_TMP"
else
        ((bat <= THRESHOLD)) && {
                notify-send -u critical "WARNING: low battery"
                touch "$BAT_TMP"
        }
fi

echo "$bat%"
