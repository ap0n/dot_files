#!/bin/sh
p=$(powerprofilesctl get)
case "$p" in
    performance) icon="" ;;
    balanced)    icon="" ;;
    power-saver) icon="" ;;
    *)           icon="" ;;
esac
printf '{"text":"%s","class":"%s","tooltip":"Power profile: %s"}
' "$icon" "$p" "$p"
