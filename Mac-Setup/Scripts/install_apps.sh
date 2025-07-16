#!/bin/bash

# macOS Applications installation

install_apps() {
    echo "[📦] Installing essential applications..."
    
    # Development tools
    brew install --cask iterm2
    brew install --cask visual-studio-code
    brew install --cask docker
    
    # Productivity
    brew install --cask notion
    brew install --cask slack
    brew install --cask zoom
    
    # Browsers
    brew install --cask google-chrome
    brew install --cask firefox
    
    # Utilities
    brew install --cask spectacle
    brew install --cask alfred
    brew install --cask 1password
    
    echo "[✅] Applications installed successfully"
    return 0
}
