#!/bin/bash

# Oh My Posh installation

install_oh_my_posh() {
    echo "[✨] Installing Oh My Posh..."
    if ! brew install oh-my-posh; then
        echo "Error: Failed to install Oh My Posh" >&2
        return 1
    fi

    local OMP_INIT='eval "\$(oh-my-posh init zsh --config \$(brew --prefix oh-my-posh)/themes/atomic.omp.json)"'
    if ! grep -q 'oh-my-posh init zsh' ~/.zshrc; then
        echo "$OMP_INIT" >> ~/.zshrc
        echo "[✔] Oh My Posh config added to .zshrc"
    else
        echo "[✔] Oh My Posh already configured in .zshrc"
    fi
    return 0
}
