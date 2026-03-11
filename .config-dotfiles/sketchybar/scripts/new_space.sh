#!/bin/bash

# Find the first empty workspace (AeroSpace returns a list, we take the first one)
EMPTY_WORKSPACE=$(aerospace list-workspaces --empty yes | head -n 1)

# If an empty workspace exists, switch to it
if [ ! -z "$EMPTY_WORKSPACE" ]; then
  aerospace workspace "$EMPTY_WORKSPACE"
fi
