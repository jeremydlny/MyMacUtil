#!/bin/bash

# bootstrap.sh
# Bootstrap script for MyMacUtil
# Downloads all necessary files before running the main installation script

# Simple logging function
log() {
    echo "[$1] $2"
}

# Set installation directory
INSTALL_DIR="$HOME/.my-macutil"

# Create installation directory and navigate to it
mkdir -p "$INSTALL_DIR" && cd "$INSTALL_DIR" || {
    echo "Error: Could not create/access directory: $INSTALL_DIR" >&2
    exit 1
}

# Create necessary directories
mkdir -p "Scripts" "Config"

# Download function
download_file() {
    local target="$1"
    local base_url="https://raw.githubusercontent.com/jeremydlny/MyMacUtil/main/Setup"
    
    mkdir -p "$(dirname "$target")" 2>/dev/null
    
    [ -f "$target" ] && return 0
    
    log "📦" "Downloading $target..."
    if curl -fsSL "$base_url/$target" -o "$target"; then
        log "✅" "Downloaded $target"
        return 0
    else
        log "❌" "Failed to download $target"
        return 1
    fi
}

# Download main install script
log "📦" "Downloading installation files..."
download_file "install.sh" && chmod +x "install.sh"

# Download all required files
FILES=(
    "Scripts/utils.sh"
    "Scripts/homebrew.sh"
    "Scripts/install_apps.sh"
    "Scripts/install_oh_my_posh.sh"
    "Scripts/install_fastfetch.sh"
    "Scripts/zsh_config.sh"
    "Scripts/fonts.sh"
    "Config/default.conf"
)

for file in "${FILES[@]}"; do
    download_file "$file"
done

# Run installation
log "🚀" "Starting installation..."
bash "install.sh"