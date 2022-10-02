#!/bin/bash

# Повышает или понижает громкость текущего аудио устройства.

# Повышение громкости:
#    volmgr.sh up
# Понижение громкости:
#    volmgr.sh down


# Устройство отбирается верхней строкой вывода команды.
sink=`pactl list sinks | head -1 | awk -F'#' '{print $2}'`

echo "Setting volume 5% $1"

if [[ $1 = "up" ]]; then
		pactl set-sink-volume $sink +5%
elif [[ $1 = "down" ]]; then
		pactl set-sink-volume $sink -5%
fi

