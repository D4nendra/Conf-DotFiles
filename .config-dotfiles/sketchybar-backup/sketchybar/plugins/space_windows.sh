#!/bin/bash

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  # Get all workspaces
  all_workspaces=$(aerospace list-workspaces --all)

  for workspace in $all_workspaces; do
    apps=$(aerospace list-windows --workspace "$workspace" 2>/dev/null | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
    is_focused=$([ "$workspace" = "$FOCUSED_WORKSPACE" ] && echo "true" || echo "false")

    if [ -z "$apps" ] && [ "$is_focused" = "false" ]; then
      # Empty and not focused → hide
      sketchybar --set space.$workspace drawing=off
    else
      # Has apps OR is focused → show
      sketchybar --set space.$workspace drawing=on

      if [ -n "$apps" ]; then
        icon_strip=" "
        while read -r app; do
          icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
        done <<< "$apps"
        sketchybar --set space.$workspace label="$icon_strip"
      else
        sketchybar --set space.$workspace label=""
      fi
    fi
  done
fi