#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Installing Homebrew packages ==="

brew bundle --file="$SCRIPT_DIR/Brewfile"

echo "✓ Homebrew packages installed"
