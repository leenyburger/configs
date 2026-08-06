#!/usr/bin/env bash

CONFIG_DIR="${CONFIG_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$CONFIG_DIR/colors.sh"

# SF Symbols glyphs, rendered via the "SF Pro" font (these codepoints live in
# SF Pro's private-use area). Verified against FelixKratz's own dotfiles
# (icons.lua, sf_symbols table).
ICON_100="􀛨"
ICON_75="􀺸"
ICON_50="􀺶"
ICON_25="􀛩"
ICON_0="􀛪"
ICON_CHARGING="􀢋"

BATT_INFO="$(pmset -g batt)"
CHARGE="$(echo "$BATT_INFO" | grep -Eo '[0-9]+%' | head -1 | tr -d '%')"

CHARGING="no"
echo "$BATT_INFO" | grep -q "AC Power" && CHARGING="yes"

ICON="$ICON_0"
COLOR="$GREEN"

if [ -n "$CHARGE" ]; then
  if [ "$CHARGE" -ge 80 ]; then
    ICON="$ICON_100"
  elif [ "$CHARGE" -ge 55 ]; then
    ICON="$ICON_75"
  elif [ "$CHARGE" -ge 40 ]; then
    ICON="$ICON_50"
  elif [ "$CHARGE" -ge 20 ]; then
    ICON="$ICON_25"
  else
    ICON="$ICON_0"
  fi

  if [ "$CHARGE" -lt 20 ]; then
    COLOR="$RED"
  elif [ "$CHARGE" -lt 40 ]; then
    COLOR="$YELLOW"
  else
    COLOR="$GREEN"
  fi

  if [ "$CHARGING" = "yes" ]; then
    ICON="$ICON_CHARGING"
  fi
fi

sketchybar --set battery \
  icon="$ICON" \
  icon.color="$COLOR" \
  label="${CHARGE:-?}%"
