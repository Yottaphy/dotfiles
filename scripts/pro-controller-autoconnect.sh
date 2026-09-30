#!/bin/bash

MAC="48:A5:E7:49:E4:4D"

sleep 5

CONNECTED=$(bluetoothctl info $MAC | grep "Connected: yes")
if [ -z "$CONNECTED" ]; then
    bluetoothctl connect $MAC
fi
