#!/bin/bash

# install_zoxide.sh
# Installs zoxide for intelligent directory jumping

install_zoxide() {
    my_log "[📦] Installing zoxide..."
    
    # Install zoxide using Homebrew
    brew install zoxide
    
    # Add zoxide to zsh configuration
    if ! grep -q "eval \"\$(zoxide init zsh)\"" "$HOME/.zshrc"; then
        echo "eval \"\$(zoxide init zsh)\"" >> "$HOME/.zshrc"
        my_log "[✅] Added zoxide initialization to .zshrc"
    else
        my_log "[ℹ️] zoxide initialization already exists in .zshrc"
    fi
    
    my_log "[✅] zoxide installation complete!"
}
