#!/bin/bash

# Font installation

install_font() {
    local FONT_DIR=~/.fonts
    local FONT_NAME="CascadiaCode"
    local FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/${FONT_NAME}.zip"

    log "[🔡] Installing ${FONT_NAME} Nerd Font..."

    # Check if font directory exists and is writable
    if [ ! -w "${FONT_DIR}" ]; then
        echo "Error: Cannot write to font directory" >&2
        return 1
    fi

    # Check if URL is valid
    if ! curl -I "$FONT_URL" &>/dev/null; then
        echo "Error: Font URL is not valid" >&2
        return 1
    fi

    # Download and install only regular and italic fonts
    local fonts_to_download=(
        "${FONT_NAME}-Regular.ttf"
        "${FONT_NAME}-Italic.ttf"
    )
    local success=true

    for font in "${fonts_to_download[@]}"; do
        local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$font"
        
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
        log "[✅] Fonts installation completed"
        return 0
    else
        log "[❌] Fonts installation failed"
        return 1
    fi
}
