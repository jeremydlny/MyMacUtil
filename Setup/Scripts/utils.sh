#!/bin/bash

# Common utility functions

# Add line to file if it doesn't exist
add_if_missing() {
    local line="$1"
    if ! grep -Fxq "$line" ~/.zshrc; then
        echo "$line" >> ~/.zshrc
    fi
}

# Log function with optional verbose mode
log() { $QUIET || echo "$@"; }

# Verbose log function
log_verbose() { $VERBOSE && echo "$@"; }
