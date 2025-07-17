#!/bin/bash

# Bootstrap script for MyMacUtil
# Downloads all necessary files before running the main installation script

# Simple logging function
log() {
    echo "[$1] $2"
}

# Get current directory
CURRENT_DIR=$(pwd)

# Download function
download_file() {
    local url="$1"
    local dest="$2"
    local base_url="https://raw.githubusercontent.com/jeremydlny/MyMacUtil/refs/heads/main/Setup"
    
    if [ -f "$CURRENT_DIR/$dest" ]; then
        log "ℹ️" "Skipping download of $dest (already exists)"
        return 0
    fi
    
    log "📦" "Downloading $dest..."
    curl -s "$base_url/$dest" -o "$CURRENT_DIR/$dest"
    if [ $? -ne 0 ]; then
        log "❌" "Failed to download $dest"
        return 1
    fi
    log "✅" "Downloaded $dest successfully"
    return 0
}

# Create necessary directories
mkdir -p "$CURRENT_DIR/Scripts"
mkdir -p "$CURRENT_DIR/Config"

# Download all necessary files
FILES=(
    "Config/default.conf"
    "Scripts/utils.sh"
    "Scripts/homebrew.sh"
    "Scripts/fonts.sh"
    "Scripts/zsh_config.sh"
    "Scripts/install_oh_my_posh.sh"
    "Scripts/install_fastfetch.sh"
    "Scripts/install_apps.sh"
    "install.sh"
)

# Download files
for file in "${FILES[@]}"; do
    dest="$file"
    dir=$(dirname "$dest")
    
    # Create directory if needed
    if [ "$dir" != "." ]; then
        mkdir -p "$CURRENT_DIR/$dir"
    fi
    
    if [ -f "$CURRENT_DIR/$dest" ]; then
        log "ℹ️" "Skipping download of $dest (already exists)"
        continue
    fi
    
    log "📦" "Downloading $dest..."
    curl -s "https://raw.githubusercontent.com/jeremydlny/MyMacUtil/refs/heads/main/Setup/$file" -o "$CURRENT_DIR/$dest"
    if [ $? -ne 0 ]; then
        log "❌" "Failed to download $dest"
        exit 1
    fi
    log "✅" "Downloaded $dest successfully"
done

# Make the installation script executable
chmod +x "$CURRENT_DIR/install.sh"

# Run the installation script
cd "$CURRENT_DIR" && ./install.sh "$@"
