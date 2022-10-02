#!/bin/bash

scrot /tmp/lockscreenwalpaper.png
convert -scale 10% -scale 1000% /tmp/lockscreenwalpaper.png /tmp/lockscreenwalpaper.png
i3lock -t -i /tmp/lockscreenwalpaper.png 
