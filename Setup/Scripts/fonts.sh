#!/bin/bash

# Font installation for macOS

install_font() {
    # Use macOS font directory instead of ~/.fonts
    FONT_DIR="$HOME/Library/Fonts"
    FONT_NAME="CascadiaCode"
    FONT_VERSION="v3.2.1"
    
    my_log "[🔡] Installing ${FONT_NAME} Nerd Font..."

    # Check if font directory exists and is writable
    if [ ! -w "${FONT_DIR}" ]; then
        echo "Error: Cannot write to font directory" >&2
        return 1
    fi

    # Download and install only regular and italic fonts
    fonts_to_download=(
        "${FONT_NAME}-Regular.ttf"
        "${FONT_NAME}-Italic.ttf"
    )
    success=true

    # Create font directory if it doesn't exist
    mkdir -p "$FONT_DIR"

    for font in "${fonts_to_download[@]}"; do
        font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/$font"
        
        if curl -I "$font_url" &>/dev/null; then
            if ! curl -L "$font_url" -o "${FONT_DIR}/$font"; then
                echo "Error: Failed to download $font" >&2
                success=false
                break
            fi
        else
            echo "Warning: $font not found at URL" >&2
            success=false
            break
        fi
    done
    
    if $success; then
        # On macOS, fonts are automatically available after copying to ~/Library/Fonts
        my_log "[✅] ${FONT_NAME} fonts installed successfully"
        return 0
    else
        my_log "[❌] Fonts installation failed"
        return 1
    fi
}