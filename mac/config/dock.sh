#!/bin/bash
set -e

echo "Configuring Dock with dockutil..."

if ! command -v dockutil &> /dev/null; then
    echo "dockutil not installed. Run: brew install dockutil"
    exit 1
fi

dockutil --remove all --no-restart

add_to_dock() {
    local app_path="$1"
    if [ -e "$app_path" ]; then
        dockutil --add "$app_path" --no-restart
    fi
}

add_to_dock "/System/Applications/Apps.app"
add_to_dock "/Applications/Firefox.app"
add_to_dock "/Applications/Spotify.app"
add_to_dock "/Applications/Slack.app"
add_to_dock "/Applications/Discord.app"
add_to_dock "/Applications/Spark Desktop.app"
add_to_dock "/Applications/BusyCal.app"
add_to_dock "/Applications/Todoist.app"
add_to_dock "/Applications/Obsidian.app"
add_to_dock "/Applications/Ghostty.app"
add_to_dock "/Applications/Visual Studio Code.app"
add_to_dock "$HOME/Applications/PhpStorm.app"
add_to_dock "$HOME/Applications/Rider.app"
add_to_dock "$HOME/Applications/WebStorm.app"
add_to_dock "$HOME/Applications/PyCharm.app"
add_to_dock "$HOME/Applications/DataGrip.app"
add_to_dock "$HOME/Applications/GoLand.app"

dockutil --add "$HOME/Downloads" --section others --view grid --display folder --no-restart

echo "✓ Dock configured"
