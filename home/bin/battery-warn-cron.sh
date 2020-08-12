#!/bin/bash

threshold=50
musicPID=""

check() {
    status=$(cat /sys/class/power_supply/BAT0/status)
    if [ "$status" != "Charging" ]; then
        capacity=$(cat /sys/class/power_supply/BAT0/capacity)
        if (("$capacity" <= "$threshold")); then
            if [ -z $musicPID ]; then
                cvlc --play-and-exit ~/Music/final_countdown.mp3 &>/dev/null &
                musicPID=$!
            fi
            dunstify --urgency=critical "battery low < ${threshold} %"
        fi
    else
        if [ -z $musicPID ]; then
            kill $musicPID
            musicPID=""
        fi
    fi
}

while true; do
    check
    sleep 1
done
