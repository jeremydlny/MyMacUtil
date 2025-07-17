#!/bin/bash

# macOS Applications installation

is_app_installed() {
    local app_name="$1"
    local app_path=""

    # List of known application names and their corresponding paths
    case "$app_name" in
        brave-browser)
            app_path="/Applications/Brave Browser.app"
            ;;
        scroll-reverser)
            app_path="/Applications/Scroll Reverser.app"
            ;;
        istat-menus)
            app_path="/Applications/iStat Menus.app"
            ;;
        alt-tab)
            app_path="/Applications/AltTab.app"
            ;;
        *)
            app_path="/Applications/${app_name}.app"
            if [ ! -d "$app_path" ]; then
                app_path="/Applications/${app_name///-}.app"
            fi
            ;;
    esac

    # Check if the app exists at the determined path
    if [ -d "$app_path" ]; then
        return 0
    fi

    # Check if the DMG file is already downloaded in Homebrew cache
    local cache_dir="$HOME/Library/Caches/Homebrew/downloads"
    if [ -d "$cache_dir" ]; then
        local dmg_file=$(find "$cache_dir" -type f -name "*${app_name}*.dmg" -o -name "*${app_name}*.zip" 2>/dev/null)
        if [ -n "$dmg_file" ]; then
            return 0
        fi
    fi

    # Check with brew list --cask as fallback
    if brew list --cask "$app_name" &>/dev/null; then
        return 0
    fi

    return 1
}

install_apps() {
    my_log "[📦] Installing essential applications..."

    # Browsers
    if ! is_app_installed "brave-browser"; then
        brew install --cask brave-browser
        my_log "[ℹ️] Brave Browser installed successfully"
    fi

    # Development tools
    if ! is_app_installed "gitkraken"; then
        brew install --cask gitkraken
        my_log "[ℹ️] GitKraken installed successfully"
    fi

    # Communication
    if ! is_app_installed "discord"; then
        brew install --cask discord
        my_log "[ℹ️] Discord installed successfully"
    fi

    # Media
    if ! is_app_installed "vlc"; then
        brew install --cask vlc
        my_log "[ℹ️] VLC installed successfully"
    fi

    # Security
    if ! is_app_installed "protonvpn"; then
        brew install --cask protonvpn
        my_log "[ℹ️] ProtonVPN installed successfully"
    fi

    # Torrent
    if ! is_app_installed "transmission"; then
        brew install --cask transmission
        my_log "[ℹ️] Transmission installed successfully"
    fi

    # System utilities
    if ! is_app_installed "cleanmymac"; then
        brew install --cask cleanmymac
        my_log "[ℹ️] CleanMyMac installed successfully"
    fi

    # Window management
    if ! is_app_installed "rectangle"; then
        brew install --cask rectangle
        echo "[ℹ️] Rectangle installed successfully"
    fi

    # Display management
    if ! is_app_installed "scroll-reverser"; then
        brew install --cask scroll-reverser
        echo "[ℹ️] Scroll Reverser installed successfully"
    fi

    # System monitoring
    if ! is_app_installed "istat-menus"; then
        brew install --cask istat-menus
        echo "[ℹ️] iStat Menus installed successfully"
    fi

    # AI tools
    if ! is_app_installed "chatgpt"; then
        brew install --cask chatgpt
        echo "[ℹ️] ChatGPT installed successfully"
    fi

    # Battery management
    if ! is_app_installed "aldente"; then
        brew install --cask aldente
        echo "[ℹ️] AlDente installed successfully"
    fi

    # Window switching
    if ! is_app_installed "alt-tab"; then
        brew install --cask alt-tab
        echo "[ℹ️] Alt-Tab installed successfully"
    fi

    # Maintenance
    if ! is_app_installed "keyboardcleantool"; then
        brew install --cask keyboardcleantool
    else
        echo "[ℹ️] KeyboardCleanTool is already installed"
    fi

    echo "[✅] Applications installation completed"
    return 0
}