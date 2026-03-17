#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MAC_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== macOS Install ==="
echo ""

# Check for 1Password CLI authentication
if ! op whoami &>/dev/null; then
  echo "Error: 1Password CLI not authenticated."
  echo "Please run: eval \$(op signin)"
  exit 1
fi
echo "✓ 1Password authenticated"

# Run brew.sh (installs packages including chezmoi)
echo ""
"$MAC_DIR/config/brew.sh"

# Run defaults.sh (macOS settings)
echo ""
"$MAC_DIR/config/defaults.sh"

# Initialize and apply chezmoi
echo ""
echo "Applying chezmoi dotfiles..."
chezmoi init --source "$DOTFILES_DIR/dotfiles"
chezmoi apply

echo ""
echo "=== Install complete ==="
