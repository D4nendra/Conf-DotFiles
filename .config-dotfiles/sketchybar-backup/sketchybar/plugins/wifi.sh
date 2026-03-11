#!/usr/bin/env bash

# This simply checks if your Mac has an active internet route 
# (Works perfectly for Wi-Fi, USB hotspots, and Bluetooth tethering)
if route -n get default &>/dev/null; then
  # If an internet connection exists, show as Connected
  sketchybar --set $NAME icon="󰤨" label="Connected"
else
  # If no internet connection exists, show as Disconnected
  sketchybar --set $NAME icon="󰤭" label="Disconnected"
fi
