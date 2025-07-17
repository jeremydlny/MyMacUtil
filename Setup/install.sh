#!/bin/bash

# macOS Setup Script
# Orchestrates the installation and configuration of macOS components

# Get the absolute path of the script directory
SCRIPT_DIR=$(dirname "$(realpath "$BASH_SOURCE")")

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

# Source Zsh configuration
source "$SCRIPT_DIR/Scripts/zsh_config.sh"

# Run installation steps
log "[🔧] Starting macOS Setup..."

# Install fonts
install_font

# Check prerequisites
check_prerequisites() {
    if ! [[ $(sw_vers) =~ "macOS" ]]; then
        log "Error: This script is only for macOS" >&2
        exit 1
    fi

    # Get available disk space in kilobytes and convert to bytes
    local available_space=$(( $(df -k / | awk 'NR==2 {print $4}') * 1024 ))
    
    if [ -z "$available_space" ]; then
        log "Error: Failed to get disk space information" >&2
        exit 1
    fi
    
    if [ "$available_space" -lt "$MIN_DISK_SPACE" ]; then
        log "Error: Not enough disk space" >&2
        log "Available: $((available_space / 1024 / 1024))GB"
        log "Required: $((MIN_DISK_SPACE / 1024 / 1024))GB"
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
    if install_homebrew && configure_homebrew; then
        log "[✅] Homebrew installation completed"
    fi
    
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

main "$@"

exit 0