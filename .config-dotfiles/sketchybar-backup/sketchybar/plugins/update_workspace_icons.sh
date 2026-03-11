#!/usr/bin/env bash

# Tell SketchyBar where to find Homebrew apps
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

CONFIG_DIR="$HOME/.config/sketchybar"

update_space_icons() {
    local sid=$1
    # Get the apps for this specific workspace
    local apps=$(aerospace list-windows --workspace "$sid" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

    if [ "${apps}" != "" ]; then
        icon_strip=" "
        while read -r app; do
            icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
        done <<<"${apps}"
    else
        icon_strip=""
    fi
    
    # We remove the drawing=on here because highlight_space.sh handles hiding/showing spaces!
    sketchybar --set space.$sid label="$icon_strip" label.drawing=on
}

# Update all active workspaces to ensure clean state
for sid in $(aerospace list-workspaces --all); do
    update_space_icons "$sid"
done
