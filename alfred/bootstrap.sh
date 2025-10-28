#!/usr/bin/env bash

set -e

echo "Setting up Alfred configuration..."

# Check if Alfred is installed
if [ ! -d "/Applications/Alfred 4.app" ] && [ ! -d "/Applications/Alfred 5.app" ]; then
    echo "⚠️  Alfred not found. Install via: brew install --cask alfred"
    echo "   Then run this script again."
    exit 0
fi

# Get the absolute path to the alfred preferences directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
ALFRED_PREFS_DIR="$DOTFILES_DIR/alfred/Alfred.alfredpreferences"

echo "Alfred preferences will be synced to: $ALFRED_PREFS_DIR"

# Set Alfred's sync folder preference
if [ -d "$ALFRED_PREFS_DIR" ]; then
    # Preferences folder already exists (from git)
    defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string "$ALFRED_PREFS_DIR"
    echo "✓ Alfred sync folder set to dotfiles directory"
    echo "  Open Alfred to load your preferences"
else
    # First time setup - ask user to set it manually
    echo ""
    echo "📋 First Time Setup Instructions:"
    echo "   1. Open Alfred Preferences"
    echo "   2. Go to Advanced tab"
    echo "   3. Click 'Set preferences folder...'"
    echo "   4. Select: $ALFRED_PREFS_DIR"
    echo "   5. After Alfred moves your preferences, commit the changes"
    echo ""
    echo "   Alternatively, run this to set it now:"
    echo "   defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string \"$ALFRED_PREFS_DIR\""
fi

# Optional: Import individual workflows if they exist
WORKFLOWS_DIR="$DOTFILES_DIR/alfred/workflows"
if [ -d "$WORKFLOWS_DIR" ]; then
    echo ""
    echo "Importing standalone workflows..."
    for workflow in "$WORKFLOWS_DIR"/*.alfredworkflow; do
        if [ -f "$workflow" ]; then
            echo "  - $(basename "$workflow")"
            open "$workflow"
        fi
    done
fi

echo "✓ Alfred configuration complete"
