#!/bin/bash

# macOS Setup Script
# Orchestrates the installation and configuration of macOS components

# Get the absolute path of the script directory
SCRIPT_DIR=$(dirname "$(realpath "$BASH_SOURCE")")

# Load configuration
source "./Config/default.conf"

# Source utility functions
source "./Scripts/utils.sh"

# Source installation scripts
source "Scripts/homebrew.sh"
source "Scripts/fonts.sh"
source "Scripts/zsh_config.sh"
source "Scripts/install_oh_my_posh.sh"
source "Scripts/install_fastfetch.sh"
source "Scripts/install_apps.sh"

# Check prerequisites
check_prerequisites() {
    if ! [[ $(sw_vers) =~ "macOS" ]]; then
        log "Error: This script is only for macOS" >&2
        exit 1
    fi
    
    if ! ping -c 1 google.com &>/dev/null; then
        log "Error: No internet connection" >&2
        exit 1
    fi
}

# Main installation flow
main() {
    check_prerequisites
    
    log "[🔧] Starting macOS Setup..."
    
    # Core components
    
    if install_font; then
        log "[✅] Fonts installation completed"
    fi
    
    if configure_zsh; then
        log "[✅] Zsh configuration completed"
    fi
    
    # Additional components
    if install_oh_my_posh; then
        log "[✅] Oh My Posh installation completed"
    fi
    
    if install_fastfetch; then
        log "[✅] Fastfetch installation completed"
    fi
    
    if install_apps; then
        log "[✅] Applications installation completed"
    fi
    
    # Final message
    log "[✅] Setup complete!"
    log "[ℹ️] Summary of changes:"
    log "- Installed/updated Homebrew"
    log "- Configured Homebrew environment"
    log "- Installed ${FONT_NAME} Nerd Font"
    log "- Installed Oh My Posh"
    log "- Installed Fastfetch"
    log "- Installed essential applications"
    log "- Configured Zsh with aliases and settings"
    log ""
    log "[ℹ️] Next steps:"
    log "1. Manually install fonts via Font Book"
    log "2. Restart your terminal or run: source ~/.zshrc"
    log "3. Configure applications as needed"
}

# Run the main function
main "$@"

exit 0