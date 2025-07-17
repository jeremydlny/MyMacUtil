#!/bin/bash

# Install and configure Fastfetch
install_fastfetch() {
    if ! command -v fastfetch &>/dev/null; then
        my_log "[📦] Installing Fastfetch..."
        if ! brew install fastfetch; then
            echo "[❌] Failed to install Fastfetch" >&2
            return 1
        fi
        my_log "[✅] Fastfetch installed successfully"
    else
        my_log "[ℹ️] Fastfetch is already installed"
    fi

    # Add fastfetch to startup
    add_if_missing ""
    add_if_missing "# ----- Fastfetch on startup -----"
    add_if_missing "if command -v fastfetch &>/dev/null; then"
    add_if_missing "  fastfetch"
    add_if_missing "fi"
    
    return 0
}
