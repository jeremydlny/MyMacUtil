#!/bin/bash

# install.sh
# macOS Setup Script
# Orchestrates the installation and configuration of macOS components

# Get absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load configuration
source "$SCRIPT_DIR/Config/default.conf"

# Source utility functions
source "$SCRIPT_DIR/Scripts/utils.sh"

# Source installation scripts
source "$SCRIPT_DIR/Scripts/homebrew.sh"
source "$SCRIPT_DIR/Scripts/fonts.sh"
source "$SCRIPT_DIR/Scripts/zsh_config.sh"
source "$SCRIPT_DIR/Scripts/install_oh_my_posh.sh"
source "$SCRIPT_DIR/Scripts/install_fastfetch.sh"
source "$SCRIPT_DIR/Scripts/install_apps.sh"

# Check prerequisites
check_prerequisites() {
    if [[ $(sw_vers) != *macOS* ]]; then
        my_log "Error: This script is only for macOS" >&2
        exit 1
    fi
    
    if ! ping -c 1 google.com &>/dev/null; then
        my_log "Error: No internet connection" >&2
        exit 1
    fi
}

# Reload zsh configuration and restart shell
reload_terminal() {
    my_log "[🔄] Reloading terminal configuration..."
    
    # Source the zshrc file
    source "$HOME/.zshrc" 2>/dev/null || true
    
    # Restart the shell session
    my_log "[✅] Configuration reloaded! Starting new shell session..."
    
    # Use exec to replace current shell with new one
    exec zsh -l
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
    
    # Check if we're in a piped execution
    if [ -t 0 ]; then
        # Direct execution - can restart terminal
        my_log "[ℹ️] Restarting terminal..."
        reload_terminal
    else
        # Piped execution - provide instructions
        my_log "[ℹ️] To complete setup:"
        my_log "1. Run: source ~/.zshrc"
        my_log "2. Or restart your terminal"
    fi
}

# Run the main function
main "$@"

exit 0