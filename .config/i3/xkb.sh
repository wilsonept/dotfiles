#!/bin/bash

LANGUAGES = 'us,ru,tr'

# Set ctrl+shift to toggle between RU and US
#setxkbmap 'us,ru' -option grp:lctrl_lshift_toggle
setxkbmap $LANGUAGES -option grp:rctrl_lshift_toggle

# Remap things =====================================
# Remap the keys according to the configuration file.
xkbcomp ~/.config/i3/keyboard_layout.xkb $DISPLAY

# Remap Caps_Lock with Escape
xmodmap ~/.config/i3/keybindings -display :0
