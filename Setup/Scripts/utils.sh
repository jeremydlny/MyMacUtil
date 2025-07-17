#!/bin/bash

# Common utility functions

# Add line to file if it doesn't exist
add_if_missing() {
    local line="$1"
    if ! grep -Fxq "$line" ~/.zshrc; then
        echo "$line" >> ~/.zshrc
    fi
}

# Log function with optional quiet mode
my_log() {
    if [ -z "$QUIET" ] || [ "$QUIET" = "false" ]; then
        echo "$@"
    fi
}

# Verbose log function
my_log_verbose() {
    if [ "$VERBOSE" = "true" ]; then
        echo "$@"
    fi
}
