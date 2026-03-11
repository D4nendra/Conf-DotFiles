#!/bin/bash

# Fetch the focused window's app name and title from AeroSpace
WINDOW_TITLE=$(aerospace list-windows --focused --format '%{app-name} - %{window-title}')

# If there is no focused window (e.g., empty workspace), set a default
if [ "$WINDOW_TITLE" = " - " ] || [ -z "$WINDOW_TITLE" ]; then
  WINDOW_TITLE="Desktop"
fi

# Update the Sketchybar item
sketchybar --set $NAME label="$WINDOW_TITLE"
