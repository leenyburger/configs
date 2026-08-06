#!/usr/bin/env bash

CONFIG_DIR="${CONFIG_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$CONFIG_DIR/colors.sh"

# aerospace.toml triggers aerospace_mode_change with MODE=service on entering
# the service mode, and MODE=main on every binding that returns to main mode
# (on-mode-changed alone doesn't pass which mode was entered, so this is
# threaded through explicitly at the source).
case "$MODE" in
  service)
    sketchybar --set mode \
      drawing=on \
      label="SERVICE" \
      background.color="$PEACH"
    ;;
  *)
    sketchybar --set mode drawing=off
    ;;
esac
