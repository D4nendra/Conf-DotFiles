#!/usr/bin/env bash

WORKSPACE="$1"
FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
apps=$(aerospace list-windows --workspace "$WORKSPACE" 2>/dev/null | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" drawing=on \
                           background.color=0xfff58919 \
                           label.shadow.drawing=on \
                           icon.shadow.drawing=on \
                           background.border_width=2
elif [ -z "$apps" ]; then
  sketchybar --set "$NAME" drawing=off
else
  sketchybar --set "$NAME" drawing=on \
                           background.color=0x44FFFFFF \
                           label.shadow.drawing=off \
                           icon.shadow.drawing=off \
                           background.border_width=0
fi

if [ -n "$apps" ]; then
  icon_strip=" "
  while read -r app; do
    icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
  done <<< "$apps"
  sketchybar --set "$NAME" label="$icon_strip"
else
  sketchybar --set "$NAME" label=""
fi