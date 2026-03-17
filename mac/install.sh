#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
MAC_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== macOS Install ==="
echo ""

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
echo "Setting gh editor to neovim..."
gh config set editor nvim
echo "✓ gh editor set to nvim"

echo ""
echo "=== Install complete ==="
