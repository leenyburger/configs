#!/usr/bin/env bash
#
# Idempotent bootstrap for a fresh Mac: installs AeroSpace + SketchyBar +
# JankyBorders via Homebrew, symlinks this repo's configs into ~/.config,
# and starts everything up. Safe to re-run.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing packages via Homebrew"
brew install --cask nikitabobko/tap/aerospace
brew install FelixKratz/formulae/sketchybar
brew install FelixKratz/formulae/borders

# SF Pro isn't available by name to SketchyBar without installing it, even
# though it's Apple's system typeface — without it the SF Symbols icons
# (battery, volume) render as question-mark boxes.
brew install --cask font-sf-pro

# Best-effort: this font makes front_app's icons render, but the bar works
# fine without it (front_app.sh degrades to plain text automatically).
brew install --cask font-sketchybar-app-font || true

# link_config <source-in-repo> <target-in-~/.config>
# Backs up any existing non-symlink target instead of clobbering it.
link_config() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "==> Backing up existing $dest to $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  ln -s "$src" "$dest"
  echo "==> Linked $dest -> $src"
}

echo "==> Linking configs into ~/.config"
link_config "$REPO_DIR/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
link_config "$REPO_DIR/sketchybar" "$HOME/.config/sketchybar"
link_config "$REPO_DIR/ghostty" "$HOME/.config/ghostty"
link_config "$REPO_DIR/vim/vimrc" "$HOME/.vimrc"

echo "==> Making plugin scripts executable"
chmod +x "$REPO_DIR"/sketchybar/plugins/*.sh
chmod +x "$REPO_DIR"/sketchybar/sketchybarrc
chmod +x "$REPO_DIR"/sketchybar/colors.sh

echo "==> Starting SketchyBar"
brew services start sketchybar

echo "==> Launching AeroSpace"
open -a AeroSpace

cat <<'EOF'

==> Almost done. Two manual steps:

1. AeroSpace needs Accessibility permission:
   System Settings -> Privacy & Security -> Accessibility -> enable AeroSpace.

2. SketchyBar replaces the macOS menu bar's UI, so you'll likely want to
   auto-hide it:
   System Settings -> Control Center -> Automatically hide and show the menu bar -> Always.

EOF
