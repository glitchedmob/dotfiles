#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== macOS Dotfiles Installer ==="
echo ""

# Check and install Xcode Command Line Tools
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Please complete the Xcode installation dialog, then re-run this script."
  exit 1
fi
echo "✓ Xcode Command Line Tools installed"

# Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH for Apple Silicon
  if [[ $(uname -m) == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi
echo "✓ Homebrew installed"

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install 1Password
echo "Installing 1Password..."
brew install --cask 1password
brew install 1password-cli
echo "✓ 1Password installed"

# Install chezmoi
echo "Installing chezmoi..."
brew install chezmoi
echo "✓ chezmoi installed"

echo ""
echo "=== Install complete ==="
