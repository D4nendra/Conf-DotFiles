#!/usr/bin/env bash

# Fetch all existing workspaces and the currently focused one from AeroSpace
ALL_WORKSPACES=$(aerospace list-workspaces --all)
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Loop through all possible 10 spaces
for sid in {1..10}; do
  # Check if the workspace ID exists in the list of active AeroSpace workspaces
  if echo "$ALL_WORKSPACES" | grep -qw "$sid"; then
    # Workspace exists: show it
    sketchybar --set space.$sid drawing=on \
               --set space_ex.$sid drawing=on
               
    # Highlight logic
    if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
      # If focused, change the text color so it contrasts with your pink highlight dot
      sketchybar --set space_ex.$sid icon.color=0xFF1E1E2E
      
      # Optional: If you want to physically move your pink highlighter dot to this item
      # sketchybar --animate tanh 15 --set highlight_space associated_space=$sid
    else
      # Not focused: default white text
      sketchybar --set space_ex.$sid icon.color=0xFFFFFFFF
    fi
    
  else
    # Workspace doesn't exist: hide it
    sketchybar --set space.$sid drawing=off \
               --set space_ex.$sid drawing=off
  fi
done
