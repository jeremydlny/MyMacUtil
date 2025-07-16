#!/bin/bash

# Zsh configuration

configure_zsh() {
    # Add essential Zsh configurations
    add_if_missing ""
    add_if_missing "# ----- Aliases -----"
    add_if_missing "alias ll='ls -laG'"
    add_if_missing "alias ..='cd ..'"
    add_if_missing "alias ...='cd ../..'"
    add_if_missing "alias ....='cd ../../..'"
    add_if_missing ""
    add_if_missing "# ----- Functions -----"
    add_if_missing "function cdd() { cd "\$HOME/Documents" }"
    add_if_missing "function cdp() { cd "\$HOME/Projects" }"
    add_if_missing ""
    add_if_missing "# ----- Environment -----"
    add_if_missing "export EDITOR='nvim'"
    add_if_missing "export VISUAL='nvim'"
    add_if_missing "export PAGER='less'"
    
    log "[✔] Zsh configuration updated"
    return 0
}
