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
                app_path="/Applications/${app_name/\//-}.app"
            fi
            ;;
    esac

    # Check if the app exists at the determined path
    if [ -d "$app_path" ]; then
        echo "[ℹ️] $app_name is already installed"
        return 0
    fi

    # Check if the DMG file is already downloaded in Homebrew cache
    local cache_dir="$HOME/Library/Caches/Homebrew/downloads"
    if [ -d "$cache_dir" ]; then
        local dmg_file=$(find "$cache_dir" -type f -name "*${app_name}*.dmg" -o -name "*${app_name}*.zip" 2>/dev/null)
        if [ -n "$dmg_file" ]; then
            echo "[ℹ️] $app_name is already downloaded"
            return 0
        fi
    fi

    # Check with brew list --cask as fallback
    if brew list --cask "$app_name" &>/dev/null; then
        echo "[ℹ️] $app_name is already installed"
        return 0
    fi

    return 1
}

install_apps() {
    echo "[📦] Installing essential applications..."

    # Browsers
    if ! is_app_installed "brave-browser"; then
        brew install --cask brave-browser
    else
        echo "[ℹ️] Brave Browser is already installed"
    fi

    # Development tools
    if ! is_app_installed "gitkraken"; then
        brew install --cask gitkraken
    else
        echo "[ℹ️] GitKraken is already installed"
    fi

    # Communication
    if ! is_app_installed "discord"; then
        brew install --cask discord
    else
        echo "[ℹ️] Discord is already installed"
    fi

    # Media
    if ! is_app_installed "vlc"; then
        brew install --cask vlc
    else
        echo "[ℹ️] VLC is already installed"
    fi

    # Security
    if ! is_app_installed "protonvpn"; then
        brew install --cask protonvpn
    else
        echo "[ℹ️] ProtonVPN is already installed"
    fi

    # Torrent
    if ! is_app_installed "transmission"; then
        brew install --cask transmission
    else
        echo "[ℹ️] Transmission is already installed"
    fi

    # System utilities
    if ! is_app_installed "cleanmymac"; then
        brew install --cask cleanmymac
    else
        echo "[ℹ️] CleanMyMac is already installed"
    fi

    # Window management
    if ! is_app_installed "rectangle"; then
        brew install --cask rectangle
    else
        echo "[ℹ️] Rectangle is already installed"
    fi

    # Display management
    if ! is_app_installed "scroll-reverser"; then
        brew install --cask scroll-reverser
    else
        echo "[ℹ️] Scroll Reverser is already installed"
    fi

    # System monitoring
    if ! is_app_installed "istat-menus"; then
        brew install --cask istat-menus
    else
        echo "[ℹ️] iStat Menus is already installed"
    fi

    # AI tools
    if ! is_app_installed "chatgpt"; then
        brew install --cask chatgpt
    else
        echo "[ℹ️] ChatGPT is already installed"
    fi

    # Battery management
    if ! is_app_installed "aldente"; then
        brew install --cask aldente
    else
        echo "[ℹ️] AlDente is already installed"
    fi

    # Window switching
    if ! is_app_installed "alt-tab"; then
        brew install --cask alt-tab
    else
        echo "[ℹ️] Alt-Tab is already installed"
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
