#!/bin/bash
set -e

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

MENUBAR_SCRIPT="$(dirname "$0")/menubar.sh"
if [ -f "$MENUBAR_SCRIPT" ]; then
    "$MENUBAR_SCRIPT"
fi

echo "Restarting affected services..."
killall Dock Finder 2>/dev/null || true

echo "macOS preferences applied."
