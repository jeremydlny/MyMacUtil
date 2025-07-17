#!/bin/bash

# Bootstrap script for MyMacUtil
# Downloads all necessary files before running the main installation script

# Simple logging function
log() {
    echo "[$1] $2"
}

# Get absolute path of the script directory
SCRIPT_DIR="$( cd \"$( dirname \"${BASH_SOURCE[0]}\" )\" && pwd )"

# Create necessary directories in the current directory
current_dir="$PWD"
if [ ! -d "$SCRIPT_DIR" ]; then
    echo "Error: Could not find script directory: $SCRIPT_DIR" >&2
    echo "Current directory: $current_dir" >&2
    exit 1
fi

# Download function
download_file() {
    local url="$1"
    local dest="$2"
    local base_url="https://raw.githubusercontent.com/jeremydlny/MyMacUtil/refs/heads/main/Setup"
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dest")" 2>/dev/null
    
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

# Create necessary directories in the script directory
mkdir -p "$SCRIPT_DIR/Scripts" "$SCRIPT_DIR/Config" 2>/dev/null || {
    echo "Error: Failed to create directories in $SCRIPT_DIR" >&2
    exit 1
}

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
    download_file "$file" "$file" || {
        echo "Error downloading $file" >&2
        echo "Current directory: $current_dir" >&2
        exit 1
    }
done

# Check if all files were downloaded successfully
for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Error: Failed to download $file" >&2
        exit 1
    fi
done

# Make sure we're in the correct directory
if [ -d "$SCRIPT_DIR" ]; then
    cd "$SCRIPT_DIR" || {
        echo "Error: Failed to change directory to $SCRIPT_DIR" >&2
        exit 1
    }
else
    echo "Error: Failed to find script directory at $SCRIPT_DIR" >&2
    exit 1
fi

# Make the installation script executable
chmod +x "$SCRIPT_DIR/install.sh" 2>/dev/null

# Run the installation script
if [ -x "$SCRIPT_DIR/install.sh" ]; then
    "$SCRIPT_DIR/install.sh" "$@"
else
    echo "Error: Failed to make install.sh executable" >&2
    exit 1
fi
