#!/bin/bash

# Install Oh My Posh
install_oh_my_posh() {
    if ! command -v oh-my-posh &>/dev/null; then
        my_log "[📦] Installing Oh My Posh..."
        brew install --formula oh-my-posh
        
        # Configure Oh My Posh
        if [ ! -d "$HOME/.poshthemes" ]; then
            my_log "[📦] Installing themes..."
            mkdir -p "$HOME/.poshthemes"
            curl -s https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomic.json -o "$HOME/.poshthemes/atomic.json"
        fi
        
        my_log "[✅] Oh My Posh installed successfully"
    else
        my_log "[ℹ️] Oh My Posh is already installed"
    fi
}
