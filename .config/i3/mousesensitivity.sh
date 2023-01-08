#!/bin/bash

# https://unix.stackexchange.com/questions/90572/how-can-i-set-mouse-sensitivity-not-just-mouse-acceleration

# To get your device id use command:
#    xinput list

# if you do not have xinput install it:
#    sudo apt install xinput

# To get your param id use command:
#    xinput list-props <device_id>

# xinput --set-prop <device_id> <param_id> <X 0 0>  <0 Y 0> <0 0 multipiler>
# P.S. default values for multipiler, X and Y is "1"
xinput --set-prop 11 158 0.35 0 0 0 0.35 0 0 0 1
