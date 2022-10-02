#!/bin/bash

# Set ctrl+shift to toggle between RU and US
setxkbmap 'us,ru' -option grp:ctrl_shift_toggle

# Remap Caps_Lock with Escape
xmodmap ~/.config/i3/keybindings -display :0

