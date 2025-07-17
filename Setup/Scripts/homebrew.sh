#!/bin/bash

# Homebrew installation and configuration

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        my_log "[🍺] Installing Homebrew..."
        if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
            echo "Error: Homebrew installation failed" >&2
            return 1
        fi
    else
        my_log "[✔] Homebrew already installed."
    fi

    # Check Homebrew version
    if ! brew --version &>/dev/null; then
        echo "Error: Homebrew installation is corrupted" >&2
        return 1
    fi
    return 0
}

configure_homebrew() {
    local BREW_CONFIG=~/.brewconfig.zsh
    if [ ! -f "$BREW_CONFIG" ]; then
        cat <<EOF > "$BREW_CONFIG"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
EOF
        my_log "Created $BREW_CONFIG"
    else
        my_log "[✔] $BREW_CONFIG already exists."
    fi

    if ! grep -q "source ~/.brewconfig.zsh" ~/.zshrc; then
        echo 'source ~/.brewconfig.zsh' >> ~/.zshrc
    fi
    source ~/.brewconfig.zsh
    return 0
}
