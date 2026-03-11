#!/bin/bash

# Fetch state, track, and artist from Music or Spotify
APP_STATE=$(osascript -e '
if application "Music" is running then
    tell application "Music"
        if player state is playing then return "playing::" & name of current track & "::" & artist of current track
    end tell
end if
if application "Spotify" is running then
    tell application "Spotify"
        if player state is playing then return "playing::" & name of current track & "::" & artist of current track
    end tell
end if
return "stopped"
' 2>/dev/null)

# If playing, parse the string and update the bar
if [[ "$APP_STATE" == playing* ]]; then
    TRACK=$(echo "$APP_STATE" | awk -F'::' '{print $2}')
    ARTIST=$(echo "$APP_STATE" | awk -F'::' '{print $3}')

    # Formats the output (e.g., Sense - *Luna)
    sketchybar --set "$NAME" label="$TRACK - $ARTIST" drawing=on
else
    # Hide the widget if stopped or paused
    sketchybar --set "$NAME" drawing=off
fi
