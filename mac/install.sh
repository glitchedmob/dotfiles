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

# Run zsh.sh (Oh My Zsh and plugins)
echo ""
"$MAC_DIR/config/zsh.sh"

# Run dev-tools.sh (nvm, Python, Node, .NET)
echo ""
"$MAC_DIR/config/dev-tools.sh"

# Create project directories
echo ""
echo "Creating project directories..."
mkdir -p "$HOME/projects/lz"
mkdir -p "$HOME/playground"
echo "✓ Directories created"

# Initialize and apply chezmoi
echo ""
echo "Applying chezmoi dotfiles..."
mkdir -p "$HOME/.local/share"
rm -rf "$HOME/.local/share/chezmoi"
ln -s "$DOTFILES_DIR" "$HOME/.local/share/chezmoi"
chezmoi init
chezmoi apply

# Convert dotfiles remote from HTTPS to SSH
echo ""
echo "Converting dotfiles remote to SSH..."
cd "$DOTFILES_DIR"
if git remote get-url origin | grep -q "^https://"; then
  git remote set-url origin git@github.com:glitchedmob/dotfiles.git
  echo "✓ Remote converted to SSH"
else
  echo "✓ Remote already using SSH"
fi

echo ""
echo "=== Install complete ==="
