#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"
fi

npm install --global --prefix "$HOME/.local" --ignore-scripts @earendil-works/pi-coding-agent

if ! command -v chezmoi >/dev/null 2>&1; then
  curl -fsSL https://get.chezmoi.io | sh -s -- -b "$HOME/.local/bin"
fi

chezmoi --source "$DOTFILES_DIR" apply
npm ci --ignore-scripts --prefix "$HOME/.pi/agent/extensions/fabric-local-files"
