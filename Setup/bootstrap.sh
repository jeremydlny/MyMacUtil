#!/bin/bash

# Bootstrap script for MyMacUtil
# Downloads all necessary files before running the main installation script

# Simple logging function
log() {
    echo "[$1] $2"
}

# Get the installation directory
if [ -n "$BASH_SOURCE" ]; then
    # Direct execution
    INSTALL_DIR="$HOME/.my-macutil"
    echo "Running in direct execution mode"
else
    # Curl execution
    INSTALL_DIR="$HOME/.my-macutil"
    echo "Running in curl execution mode"
fi

echo "Installation directory: $INSTALL_DIR"
echo "Current directory: $(pwd)"

# Create installation directory if it doesn't exist
mkdir -p "$INSTALL_DIR" || {
    echo "Error: Could not create installation directory: $INSTALL_DIR" >&2
    exit 1
}

cd "$INSTALL_DIR" || {
    echo "Error: Could not change to installation directory: $INSTALL_DIR" >&2
    exit 1
}

# Create necessary directories
mkdir -p "Scripts" "Config" || {
    echo "Error: Failed to create directories in $SCRIPT_DIR" >&2
    exit 1
}

# Download function
download_file() {
    local target="$1"
    local base_url="https://raw.githubusercontent.com/jeremydlny/MyMacUtil/main/Setup"
    
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
if download_file "install.sh" "install.sh"; then
    log "✅" "Successfully downloaded install.sh"
    chmod +x "install.sh"
else
    log "❌" "Failed to download install.sh"
    exit 1
fi

# List of files to download
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

# Download all files
for file in "${FILES[@]}"; do
    download_file "$file"
done

# Run the main installation script
if [ -f "install.sh" ]; then
    log "🚀" "Running main installation script..."
    bash "install.sh"
else
    log "❌" "Could not find install.sh"
    exit 1
fi

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
    "Scripts/utils.sh"
    "Scripts/homebrew.sh"
    "Scripts/install_apps.sh"
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