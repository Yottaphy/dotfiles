#!/bin/sh
 
YAD_WIDTH=300 # 222 is minimum possible value
YAD_HEIGHT=220 # 193 is minimum possible value
 
case "$1" in
--popup)
 
yad --calendar  --show-weeks --fixed --close-on-unfocus --no-buttons --posx=835 --posy=40\
--title="calendar" --borders=0 >/dev/null &
;;
*)
echo "  "`date +%a`" "`date +%d`" "`date +%b` " "`date +%H`":"`date +%M` 
;;
esac
