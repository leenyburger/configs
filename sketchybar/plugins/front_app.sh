#!/usr/bin/env bash

CONFIG_DIR="${CONFIG_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$CONFIG_DIR/colors.sh"

APP="${INFO:-$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)}"

ICON_MAP="$CONFIG_DIR/plugins/icon_map.sh"
FONT_FLAG_FILE="/tmp/sketchybar_app_font_available"
FONT_AVAILABLE="0"
[ -f "$FONT_FLAG_FILE" ] && FONT_AVAILABLE="$(cat "$FONT_FLAG_FILE")"

# Only attempt icons when both the font is installed (checked once at bar load
# via fc-list, see sketchybarrc) and a generated icon_map.sh is present. See
# https://github.com/kvndrsslr/sketchybar-app-font for how to generate one.
# Missing either, we degrade gracefully to a plain text label instead of
# erroring or showing tofu glyphs.
if [ "$FONT_AVAILABLE" = "1" ] && [ -f "$ICON_MAP" ]; then
  # shellcheck disable=SC1090
  source "$ICON_MAP"
  ICON="$(icon_map "$APP")"
  sketchybar --set front_app \
    icon.drawing=on \
    icon.font="sketchybar-app-font:Regular:16.0" \
    icon="$ICON" \
    label="$APP"
else
  sketchybar --set front_app \
    icon.drawing=off \
    label="$APP"
fi
