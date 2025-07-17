#!/bin/bash

# Bootstrap script for MyMacUtil
# Downloads all necessary files before running the main installation script

# Simple logging function
log() {
    echo "[$1] $2"
}

# Download function
download_file() {
    local url="$1"
    local dest="$2"
    local base_url="https://raw.githubusercontent.com/jeremydlny/MyMacUtil/refs/heads/main/Setup"
    
    if [ -f "$dest" ]; then
        log "ℹ️" "Skipping download of $dest (already exists)"
        return 0
    fi
    
    log "📦" "Downloading $dest..."
    curl -s "$base_url/$dest" -o "$dest"
    if [ $? -ne 0 ]; then
        log "❌" "Failed to download $dest"
        return 1
    fi
    log "✅" "Downloaded $dest successfully"
    return 0
}

# Create necessary directories
mkdir -p Scripts
mkdir -p config

# Download all necessary files
FILES=(
    "config/default.conf"
    "Scripts/utils.sh"
    "Scripts/homebrew.sh"
    "Scripts/fonts.sh"
    "Scripts/zsh_config.sh"
    "Scripts/install_oh_my_posh.sh"
    "Scripts/install_fastfetch.sh"
    "Scripts/install_apps.sh"
    "install.sh"
)

for file in "${FILES[@]}"; do
    download_file "$file" "$file"
    if [ $? -ne 0 ]; then
        log "❌" "Aborting installation"
        exit 1
    fi

done

# Make the installation script executable
chmod +x install.sh

# Run the installation script
./install.sh "$@"
