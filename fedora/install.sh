#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$HOME/.local/bin:$PATH"

# Load an existing NVM installation, including in non-interactive SSH sessions.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"
fi

node -e '
if (Number(process.versions.node.split(".")[0]) < 24) {
  console.error("The configured Fabric package requires Node 24 or newer. Update Node first.");
  process.exit(1);
}
'

npm install --global --prefix "$HOME/.local" --ignore-scripts @earendil-works/pi-coding-agent

if ! command -v chezmoi >/dev/null 2>&1; then
  curl -fsSL https://get.chezmoi.io | sh -s -- -b "$HOME/.local/bin"
fi

# Apply only agent configuration, not AWS, SSH, or shell settings.
chezmoi --source "$DOTFILES_DIR" apply "$HOME/.pi" "$HOME/.mcporter"

npm ci --ignore-scripts --prefix "$HOME/.pi/agent/extensions/fabric-local-files"

node -e '
const { execFileSync } = require("node:child_process");
const { packages } = require(process.argv[1]);
for (const source of packages) {
  execFileSync("pi", ["install", source], { stdio: "inherit" });
}
' "$HOME/.pi/agent/settings.json"

pi --version
printf '\nPi setup complete. Start pi and use /login to sign in.\n'
