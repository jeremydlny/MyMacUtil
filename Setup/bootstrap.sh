#!/bin/bash

# Bootstrap script for MyMacUtil
# Downloads all necessary files before running the main installation script

# Simple logging function
log() {
    echo "[$1] $2"
}

# Get the script directory
if [ -n "$BASH_SOURCE" ]; then
    # Direct execution
    SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
    echo "Running in direct execution mode"
else
    # Curl execution
    SCRIPT_DIR="/Users/Jeremy/Documents/Programmation/MyMacUtil/MyMacUtil/Setup"
    echo "Running in curl execution mode"
fi

echo "Script directory: $SCRIPT_DIR"
echo "Current directory: $(pwd)"

# Use absolute paths for all operations instead of changing directory
SCRIPTS_DIR="${SCRIPT_DIR}/Scripts"

# Create necessary directories
mkdir -p "${SCRIPT_DIR}/Scripts" "${SCRIPT_DIR}/Config" || {
    echo "Error: Failed to create directories in $SCRIPT_DIR" >&2
    exit 1
}

# Download function
download_file() {
    local url="$1"
    local target="$2"
    local base_url="https://raw.githubusercontent.com/jeremydlny/MyMacUtil/refs/heads/main/Setup"
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")" 2>/dev/null
    
    if [ -f "$target" ]; then
        log "ℹ️" "Skipping download of $target (already exists)"
        return 0
    fi
    
    log "📦" "Downloading $target..."
    if curl -fsSL "$base_url/$target" -o "$target"; then
        log "✅" "Successfully downloaded $target"
        return 0
    else
        log "❌" "Failed to download $target"
        echo "Error downloading $target" >&2
        return 1
    fi
}

# Download the main install script first
log "📦" "Downloading main installation script..."
if curl -fsSL "https://raw.githubusercontent.com/jeremydlny/MyMacUtil/refs/heads/main/Setup/install.sh" -o "install.sh"; then
    log "✅" "Successfully downloaded install.sh"
    chmod +x "install.sh"
else
    log "❌" "Failed to download install.sh"
    exit 1
fi

# List of files to download
FILES=(
    "Scripts/install_oh_my_posh.sh"
    "Scripts/install_fastfetch.sh"
    "Scripts/zsh_config.sh"
    "Scripts/fonts.sh"
    "Config/default.conf"
)

# Download all files
for file in "${FILES[@]}"; do
    download_file "$file" "$file"
done

# Run the main installation script
if [ -f "install.sh" ]; then
    log "🚀" "Running main installation script..."
    bash "install.sh"
else
    log "❌" "Could not find install.sh"
    exit 1
fi