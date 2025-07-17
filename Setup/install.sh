#!/bin/bash

# macOS Setup Script
# Orchestrates the installation and configuration of macOS components

# Get the absolute path of the script directory
SCRIPT_DIR="$(pwd)"

# Load configuration
source "./Config/default.conf"

# Source utility functions
source "./Scripts/utils.sh"

# Source installation scripts
source "./Scripts/homebrew.sh"
source "./Scripts/fonts.sh"
source "./Scripts/zsh_config.sh"
source "./Scripts/install_oh_my_posh.sh"
source "./Scripts/install_fastfetch.sh"
source "./Scripts/install_apps.sh"

# Check prerequisites
check_prerequisites() {
    if ! [[ $(sw_vers) =~ "macOS" ]]; then
        my_log "Error: This script is only for macOS" >&2
        exit 1
    fi
    
    if ! ping -c 1 google.com &>/dev/null; then
        my_log "Error: No internet connection" >&2
        exit 1
    fi
}

# Main installation flow
main() {
    check_prerequisites
    
    my_log "[🔧] Starting macOS Setup..."
    
    # Source required scripts
    source "./Scripts/install_oh_my_posh.sh"
    source "./Scripts/install_fastfetch.sh"

    # Core components
    
    install_font
    configure_zsh
    
    # Additional components
    install_oh_my_posh
    install_fastfetch
    install_apps
    
    # Final message
    my_log "[✅] Setup complete!"
    my_log "[ℹ️] Summary of changes:"
    my_log "- Installed/updated Homebrew"
    my_log "- Configured Homebrew environment"
    my_log "- Installed ${FONT_NAME} Nerd Font"
    my_log "- Installed Oh My Posh"
    my_log "- Installed Fastfetch"
    my_log "- Installed essential applications"
    my_log "- Configured Zsh with aliases and settings"
    my_log ""
    my_log "[ℹ️] Next steps:"
    my_log "1. Manually install fonts via Font Book"
    my_log "2. Restart your terminal or run: source ~/.zshrc"
    my_log "3. Configure applications as needed"
}

# Run the main function
main "$@"

exit 0