#!/bin/bash

# Show a native macOS popup menu
THEME=$(osascript -e 'choose from list {"AeroSpace New", "Old Backup"} with prompt "Select SketchyBar Theme:" default items {"AeroSpace New"}')

# Exit if the user clicked "Cancel"
if [ "$THEME" = "false" ]; then
    exit 0
fi

# Define your paths
DOTFILES_DIR="$HOME/Downloads/Conf-DotFiles/.config-dotfiles"
CONFIG_DIR="$HOME/.config"

# Remove the current active sketchybar link
rm -rf "$CONFIG_DIR/sketchybar"

# Link the chosen theme and reload
if [ "$THEME" = "AeroSpace New" ]; then
    ln -s "$DOTFILES_DIR/sketchybar" "$CONFIG_DIR/sketchybar"
    sketchybar --reload
elif [ "$THEME" = "Old Backup" ]; then
    ln -s "$DOTFILES_DIR/sketchybar-backup/sketchybar" "$CONFIG_DIR/sketchybar"
    sketchybar --reload
fi
