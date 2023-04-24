#!/bin/bash

set -u
set -o errexit
set -o pipefail

LOG=/tmp/xkb.log

if [[ ! $DISPLAY ]];then
    DISPLAY=':0' 
fi

if [[ ! $XAUTHORITY ]];then
    XAUTHORITY=~/.Xauthority 
fi

# Wait a bit for XServer initialization
sleep 5

# LANGUAGES='us,ru,tr'
# LANGUAGES='us,ru'

# Set ctrl+shift to toggle between RU and US
# setxkbmap 'us,ru' -option grp:lctrl_lshift_toggle
# setxkbmap $LANGUAGES -option grp:rctrl_lshift_toggle

# Remap things =====================================
echo Remap the keys according to the configuration file | tee -a $LOG
xkbcomp ~/.config/i3/keyboard_layout.xkb $DISPLAY | tee -a $LOG

echo Remap Caps_Lock with Escape |  tee -a $LOG
xmodmap ~/.config/i3/keybindings -display $DISPLAY -verbose | tee -a $LOG
