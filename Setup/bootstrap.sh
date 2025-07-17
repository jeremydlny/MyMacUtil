#!/bin/bash -i

# Bootstrap script for MyMacUtil
set -e

log() { echo "[$1] $2"; }

# Setup
INSTALL_DIR="$HOME/.my-macutil"
BASE_URL="https://raw.githubusercontent.com/jeremydlny/MyMacUtil/main/Setup"

mkdir -p "$INSTALL_DIR"/{Scripts,Config} && cd "$INSTALL_DIR"

# Download function
download() {
    [ -f "$1" ] && return 0
    curl -fsSL "$BASE_URL/$1" -o "$1"
}

# Download files
log "📦" "Downloading files..."
download "install.sh" && chmod +x "install.sh"

for file in Scripts/{utils,homebrew,install_apps,install_oh_my_posh,install_fastfetch,zsh_config,fonts}.sh Config/default.conf; do
    download "$file"
done

# Run installation
log "🚀" "Starting installation..."
./install.sh
exec zsh -l