#!/bin/bash

# macOS Setup Script
# Orchestrates the installation and configuration of macOS components

# Load configuration
source config/default.conf

# Source utility functions
source scripts/utils.sh

# Source installation scripts
source Scripts/homebrew.sh
source Scripts/fonts.sh
source Scripts/zsh_config.sh
source Scripts/install_oh_my_posh.sh
source Scripts/install_fastfetch.sh
source Scripts/install_apps.sh

# Source Zsh configuration
source Scripts/zsh_config.sh

# Run installation steps
log "[🔧] Starting macOS Setup..."

# Check prerequisites
check_prerequisites() {
    if ! [[ $(sw_vers) =~ "macOS" ]]; then
        log "Error: This script is only for macOS" >&2
        exit 1
    fi

    if [ $(df -k / | awk 'NR==2 {print $4}') -lt $MIN_DISK_SPACE ]; then
        log "Error: Not enough disk space" >&2
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
    
    # Core components
    install_homebrew && configure_homebrew
    install_font
    configure_zsh
    
    # Additional components
    install_oh_my_posh
    install_fastfetch
    install_apps
    
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

main "$@"

exit 0