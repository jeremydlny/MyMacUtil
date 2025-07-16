#!/bin/bash

# Install Oh My Posh
install_oh_my_posh() {
    if ! command -v oh-my-posh &>/dev/null; then
        log "[📦] Installing Oh My Posh..."
        brew install --formula oh-my-posh
        
        # Configure Oh My Posh
        if [ ! -d "$HOME/.poshthemes" ]; then
            log "[📦] Installing themes..."
            mkdir -p "$HOME/.poshthemes"
            curl -s https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomic.json -o "$HOME/.poshthemes/atomic.json"
        fi
        
        log "[✅] Oh My Posh installed successfully"
    else
        log "[ℹ️] Oh My Posh is already installed"
    fi
}
