#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

echo "Applying macOS preferences..."

if command -v macprefs &> /dev/null; then
    MACPREFS_DIR="$(dirname "$0")/macprefs"
    
    for config in "$MACPREFS_DIR"/*.json; do
        if [ -f "$config" ]; then
            echo "Applying $(basename "$config")..."
            macprefs apply --config "$config"
        fi
    done
else
    echo "macprefs not installed. Run: brew install jmcombs/macprefs/macprefs"
    exit 1
fi

DOCK_SCRIPT="$(dirname "$0")/dock.sh"
if [ -f "$DOCK_SCRIPT" ]; then
    "$DOCK_SCRIPT"
fi

MENUBAR_SCRIPT="$(dirname "$0")/menubar.sh"
if [ -f "$MENUBAR_SCRIPT" ]; then
    "$MENUBAR_SCRIPT"
fi

echo ""
echo "Setting desktop wallpaper..."
DOTFILES_ASSETS="$DOTFILES_DIR/assets"
WALLPAPER_SRC="$DOTFILES_ASSETS/background-logo.png"
WALLPAPER_DEST="$HOME/Pictures/background-logo.png"

if [ -f "$WALLPAPER_SRC" ]; then
    cp "$WALLPAPER_SRC" "$WALLPAPER_DEST"
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$WALLPAPER_DEST\""
    echo "✓ Wallpaper set"
else
    echo "Wallpaper not found at $WALLPAPER_SRC, skipping"
fi

echo "Restarting affected services..."
killall Dock Finder 2>/dev/null || true

echo "macOS preferences applied."
