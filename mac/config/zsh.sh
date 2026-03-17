#!/bin/bash

set -e

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

echo "=== ZSH Setup ==="

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✓ Oh My Zsh already installed"
fi

PLUGINS_DIR="$ZSH_CUSTOM/plugins"

install_plugin() {
    local name="$1"
    local repo="$2"

    if [ ! -d "$PLUGINS_DIR/$name" ]; then
        echo "Installing plugin: $name..."
        git clone --depth 1 "$repo" "$PLUGINS_DIR/$name"
    else
        echo "✓ Plugin $name already installed"
    fi
}

install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"
install_plugin "zsh-nvm" "https://github.com/lukechilds/zsh-nvm.git"
install_plugin "pyenv-lazy" "https://github.com/davidparsson/zsh-pyenv-lazy.git"

echo ""
echo "=== ZSH Setup complete ==="
