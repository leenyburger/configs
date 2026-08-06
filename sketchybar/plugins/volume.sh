#!/usr/bin/env bash

CONFIG_DIR="${CONFIG_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$CONFIG_DIR/colors.sh"

# SF Symbols glyphs, rendered via the "SF Pro" font. Verified against
# FelixKratz's own dotfiles (icons.lua, sf_symbols table).
ICON_100="􀊩"
ICON_66="􀊧"
ICON_33="􀊥"
ICON_10="􀊡"
ICON_MUTED="􀊣"

# The built-in volume_change event passes the new volume in $INFO. When the
# script runs for other reasons (e.g. the initial `sketchybar --update`),
# $INFO is empty, so fall back to querying the current volume directly.
VOLUME="$INFO"
if [ -z "$VOLUME" ]; then
  VOLUME="$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)"
fi
VOLUME="${VOLUME:-0}"

MUTED="false"
[ "$VOLUME" -eq 0 ] 2>/dev/null && MUTED="$(osascript -e 'output muted of (get volume settings)' 2>/dev/null)"

if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ] 2>/dev/null; then
  ICON="$ICON_MUTED"
  COLOR="$SURFACE1"
elif [ "$VOLUME" -le 10 ]; then
  ICON="$ICON_10"
  COLOR="$TEXT"
elif [ "$VOLUME" -le 33 ]; then
  ICON="$ICON_33"
  COLOR="$TEXT"
elif [ "$VOLUME" -le 66 ]; then
  ICON="$ICON_66"
  COLOR="$TEXT"
else
  ICON="$ICON_100"
  COLOR="$TEXT"
fi

sketchybar --set volume \
  icon="$ICON" \
  icon.color="$COLOR" \
  label="${VOLUME}%"
