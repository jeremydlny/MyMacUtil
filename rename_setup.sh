#!/bin/bash

# Move contents from Mac-Setup to Setup
git mv Mac-Setup Setup

# Commit changes
git commit -m "refactor: rename Mac-Setup to Setup"

echo "✅ Renamed Mac-Setup to Setup on develop branch"
