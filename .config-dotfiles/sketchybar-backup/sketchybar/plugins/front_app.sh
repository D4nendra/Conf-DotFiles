if [ "$SENDER" = "front_app_switched" ]; then
  # Set the app name and app icon and then animate a bounce for the icon size
  sketchybar --set $NAME label="$INFO" icon.drawing=off  \
                   label.font="SF Pro:Semibold:16.0"
fi
