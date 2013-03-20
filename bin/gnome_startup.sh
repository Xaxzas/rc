#!/bin/bash

# turn off bluetooth
rfkill block bluetooth

# start conky
sleep 10 && conky -c ~/.conkycolors/conkyrc &
