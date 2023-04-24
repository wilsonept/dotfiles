#!/bin/bash

set -u
set -o errexit
set -o pipefail

LOG=/tmp/udev-rules.log

# $POINTER это переменная среды, которая попадает сюда из udev. Что бы эта 
# строка заработала udev должен сформировать строку в формате который 
# понимает xinput со всеми пробелами которые можно увидеть в выводе команды:
#     xinput list
#
# Например:
#     'COMPANY  USB Device '
#
# Так же может понадобиться конкретизировать выборку добавив к названию 
# pointer: или keyboard:
#     pointer:<device name>
echo "Action: $ACTION for $DEVPATH" >> $LOG
echo "Device name: \"$POINTER\"" >> $LOG

# xinput --set-prop <device_id> <param_id> <X 0 0>  <0 Y 0> <0 0 multipiler>
# <device_id> can be the name of the device. Sometimes there are multiple 
# devcies matching one name. To ensure the correct one is selected, please 
# use the device ID, or prefix the device name with 'pointer:' or 'keyboard:'
# as appropriate.
# P.S. default values for multipiler, X and Y is "1"
xinput set-prop "$POINTER" 158 0.35 0 0 0 0.35 0 0 0 1 >> $LOG 2>&1
echo "Result: success"  | tee -a $LOG


# Дополнительно.
# Ссылка на источник про сенс: https://unix.stackexchange.com/questions/90572/how-can-i-set-mouse-sensitivity-not-just-mouse-acceleration
#
# To get your device id use command:
#    xinput list
#
# if you do not have xinput install it:
#    sudo apt install xinput
#
# To get your param id use command:
#    xinput list-props <device_id>

