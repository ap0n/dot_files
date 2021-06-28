#!/bin/bash

usage() {
   echo "Usage: kblights [0|1|2]"
   echo "   0 - off"
   echo "   1 - medium"
   echo "   2 - full"
}

if [ "$#" -ne 1 ];then
   usage
   exit 1
fi

sudo echo "$1" > /sys/class/leds/tpacpi\:\:kbd_backlight/brightness
