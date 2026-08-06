#!/usr/bin/env bash

CONFIG_DIR="${CONFIG_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$CONFIG_DIR/colors.sh"

SID="$1"
FOCUSED="${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

if [ "$SID" = "$FOCUSED" ]; then
  sketchybar --set "space.$SID" \
    icon.color="$BASE" \
    background.drawing=on \
    background.color="$BLUE" \
    background.corner_radius=6 \
    background.height=24
  exit 0
fi

# Not focused. Dim empty workspaces so the eye is drawn to ones with windows.
# If the aerospace CLI call fails for any reason, fall back to "occupied"
# styling so a transient error never hides a workspace that has windows.
COUNT="$(aerospace list-windows --workspace "$SID" --count 2>/dev/null)"

if [ -n "$COUNT" ] && [ "$COUNT" -eq 0 ] 2>/dev/null; then
  sketchybar --set "space.$SID" \
    icon.color="$SURFACE1" \
    background.drawing=off
else
  sketchybar --set "space.$SID" \
    icon.color="$TEXT" \
    background.drawing=off
fi
