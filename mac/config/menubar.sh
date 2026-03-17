#!/bin/bash
set -e

echo "Configuring Menu Bar..."

defaults -currentHost write com.apple.controlcenter WiFi -int 2
defaults -currentHost write com.apple.controlcenter Bluetooth -int 18
defaults -currentHost write com.apple.controlcenter Sound -int 18
defaults -currentHost write com.apple.controlcenter Battery -int 2

echo "Restarting SystemUIServer..."
killall SystemUIServer 2>/dev/null || true

echo "Menu bar configured."
