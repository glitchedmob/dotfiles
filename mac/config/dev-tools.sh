#!/bin/bash

set -e

echo "=== Dev Tools Setup ==="

echo ""
echo "--- nvm ---"
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | PROFILE=/dev/null bash
else
    echo "✓ nvm already installed"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo ""
echo "--- Node.js ---"
if command -v nvm &>/dev/null; then
    echo "Installing latest Node LTS..."
    nvm install --lts
    nvm alias default node
else
    echo "nvm not found, skipping Node install"
fi

echo ""
echo "--- Python ---"
if command -v pyenv &>/dev/null; then
    echo "Installing latest Python..."
    pyenv install 3 --skip-existing
    pyenv global 3
else
    echo "pyenv not found, skipping Python install"
fi

echo ""
echo "--- Ruby ---"
if command -v rbenv &>/dev/null; then
    eval "$(rbenv init -)"
    RUBY_LATEST=$(rbenv install -l | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -1)
    if [ -n "$RUBY_LATEST" ]; then
        if rbenv versions | grep -q "^  $RUBY_LATEST$"; then
            echo "✓ Ruby $RUBY_LATEST already installed"
        else
            echo "Installing Ruby $RUBY_LATEST..."
            rbenv install "$RUBY_LATEST"
        fi
        rbenv global "$RUBY_LATEST"
    else
        echo "Could not determine latest Ruby version, skipping"
    fi
else
    echo "rbenv not found, skipping Ruby install"
fi

echo ""
echo "--- CocoaPods ---"
if command -v gem &>/dev/null; then
    echo "Installing CocoaPods..."
    gem install cocoapods --no-document
else
    echo "gem not found, skipping CocoaPods install"
fi

echo ""
echo "--- tenv (Terraform/OpenTofu) ---"
if command -v tenv &>/dev/null; then
    echo "Installing latest OpenTofu..."
    tenv tofu install latest
    tenv tofu use latest
    
    echo "Installing latest Terraform..."
    tenv terraform install latest
    tenv terraform use latest
else
    echo "tenv not found, skipping Terraform/OpenTofu install"
fi

echo ""
echo "--- .NET ---"
DOTNET_VERSION="10.0.200"
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    DOTNET_ARCH="arm64"
elif [ "$ARCH" = "x86_64" ]; then
    DOTNET_ARCH="x64"
else
    echo "Unknown architecture: $ARCH, skipping .NET install"
    exit 0
fi

DOTNET_PKG="dotnet-sdk-${DOTNET_VERSION}-osx-${DOTNET_ARCH}.pkg"
DOTNET_URL="https://dotnetcli.azureedge.net/dotnet/Sdk/${DOTNET_VERSION}/${DOTNET_PKG}"

echo "Downloading .NET SDK ${DOTNET_VERSION} (${DOTNET_ARCH})..."
curl -sSL -o "/tmp/${DOTNET_PKG}" "${DOTNET_URL}"

echo "Installing .NET SDK (requires sudo)..."
sudo installer -pkg "/tmp/${DOTNET_PKG}" -target /

rm "/tmp/${DOTNET_PKG}"

echo "✓ .NET SDK ${DOTNET_VERSION} installed"

echo ""
echo "=== Dev Tools Setup complete ==="
