#!/usr/bin/env bash

SID="$1"
FOCUSED="${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

if [ "$SID" = "$FOCUSED" ]; then
  sketchybar --set "space.$SID" \
    icon.color=0xff1e1e2e \
    background.drawing=on \
    background.color=0xff89b4fa \
    background.corner_radius=6 \
    background.height=24
else
  sketchybar --set "space.$SID" \
    icon.color=0xffcdd6f4 \
    background.drawing=off
fi
