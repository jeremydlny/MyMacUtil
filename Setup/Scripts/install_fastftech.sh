#!/bin/bash

# Fastfetch installation

install_fastfetch() {
    echo "[📦] Installing Fastfetch..."
    if ! brew install fastfetch; then
        echo "Error: Failed to install Fastfetch" >&2
        return 1
    fi

    # Add fastfetch to startup
    add_if_missing ""
    add_if_missing "# ----- Fastfetch on startup -----"
    add_if_missing "if command -v fastfetch &>/dev/null; then"
    add_if_missing "  fastfetch"
    add_if_missing "fi"
    
    return 0
}
