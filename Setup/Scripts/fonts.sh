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

    # Download and install font
    if ! curl -L "$FONT_URL" -o "${FONT_DIR}/${FONT_NAME}.zip"; then
        echo "Error: Failed to download font" >&2
        return 1
    fi

    # Extract font
    if ! unzip -o "${FONT_DIR}/${FONT_NAME}.zip" -d "$FONT_DIR"; then
        echo "Error: Failed to extract font" >&2
        return 1
    fi

    log "[✔] Font installed successfully"
    return 0
}
