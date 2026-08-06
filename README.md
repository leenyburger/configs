# configs

Colleen's macOS window-management setup: [AeroSpace](https://github.com/nikitabobko/AeroSpace)
(tiling window manager) + [SketchyBar](https://github.com/FelixKratz/SketchyBar)
(status bar) + [JankyBorders](https://github.com/FelixKratz/JankyBorders)
(focused-window border), styled with Catppuccin Mocha.

## Install

```sh
./install.sh
```

This installs the Homebrew packages, symlinks `aerospace.toml` and
`sketchybar/` into `~/.config`, makes the plugin scripts executable, starts
SketchyBar, and launches AeroSpace. It's safe to re-run — existing configs
that aren't already symlinks get backed up to `*.bak` instead of overwritten.

After installing, two manual steps (also printed by the script):

1. Grant AeroSpace Accessibility permission: **System Settings -> Privacy &
   Security -> Accessibility**.
2. Auto-hide the macOS menu bar, since SketchyBar replaces it: **System
   Settings -> Control Center -> Automatically hide and show the menu bar ->
   Always**.

## Keyboard shortcuts

All bindings use `alt` as the primary modifier. `alt`-based bindings shadow
macOS's special-character input (e.g. `option-8` normally types `•`) — that
tradeoff is intentional here. [Raycast](https://raycast.com) (`cmd-space`) and
[Whisper Flow](https://wisprflow.ai) (`fn`) hotkeys don't conflict with
anything below.

### Focus / move

| Keys              | Action              |
| ----------------- | ------------------- |
| `alt h/j/k/l`      | Focus left/down/up/right |
| `alt-shift h/j/k/l`| Move window left/down/up/right |

### Layout

| Keys           | Action                          |
| -------------- | -------------------------------- |
| `alt-slash`    | Tiles layout (horizontal/vertical) |
| `alt-comma`    | Accordion layout                 |
| `alt-f`        | Toggle floating/tiling            |
| `alt-shift-f`  | Toggle fullscreen                 |

### Resize

| Keys        | Action        |
| ----------- | ------------- |
| `alt-minus` | Shrink window |
| `alt-equal` | Grow window   |

### Workspaces

| Keys        | Workspace | Lives here                  |
| ----------- | --------- | ---------------------------- |
| `alt-1`     | 1         | Linear                       |
| `alt-2`     | 2         | —                             |
| `alt-3`     | 3         | —                             |
| `alt-4`     | 4         | Zoom (main monitor)           |
| `alt-5`     | 5         | —                             |
| `alt-6`     | 6         | —                             |
| `alt-7`     | 7         | Slack                         |
| `alt-8`     | 8         | Claude                        |
| `alt-9`     | 9         | Spotify                       |
| `alt-i`     | I         | Terminal (Ghostty) + Cursor   |
| `alt-m`     | M         | —                             |
| `alt-m`     | M         | Pages (either monitor — move it with `alt-shift-tab`) |
| `alt-o`     | O         | Notion                        |
| `alt-p`     | P         | Browser (Chrome)              |
| `alt-u`     | U         | —                             |

`alt-shift-<key>` moves the focused window to that workspace instead of
switching to it (e.g. `alt-shift-1` moves the window to workspace 1).

| Keys                | Action                                  |
| ------------------- | ---------------------------------------- |
| `alt-tab`           | Workspace back-and-forth                 |
| `alt-shift-tab`     | Move current workspace to the next monitor |

### Service mode

| Keys                 | Action                                    |
| -------------------- | ------------------------------------------ |
| `alt-shift-semicolon`| Enter service mode                         |
| `esc`                | Reload config, back to main mode           |
| `r`                  | Flatten workspace tree, back to main mode  |
| `f`                  | Toggle floating/tiling, back to main mode  |
| `b`                  | Balance window sizes, back to main mode    |
| `backspace`          | Close all windows but current, back to main mode |
| `alt-shift h/j/k/l`  | Join with left/down/up/right, back to main mode |

While in service mode, SketchyBar shows a `SERVICE` pill so it's obvious the
keyboard is in a different mode.
