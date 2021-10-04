#!/bin/bash

BUILTIN="eDP-1"
MONITOR="HDMI-1"

MONITOR_STATUS=$(xrandr | grep ${MONITOR})

# if monitor not connected, go to builtin by default
if [ ! "$(echo ${MONITOR_STATUS} | grep ' connected ')" ]; then
    xrandr --output ${BUILTIN} --auto
    exit 0
else
    # otherwise toggle monitor
    if echo ${MONITOR_STATUS} | grep -q "${MONITOR} connected [0-9]\+x[0-9]\++[0-9]\++[0-9]\+"; then
        MONITOR_ARG="--off"
        BUILTIN_ARG="--auto"
    else
        MONITOR_ARG="--auto"
        BUILTIN_ARG="--off"
    fi
    xrandr --output ${MONITOR} ${MONITOR_ARG} --output ${BUILTIN} ${BUILTIN_ARG}
fi
