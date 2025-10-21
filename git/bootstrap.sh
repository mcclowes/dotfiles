#!/usr/bin/env bash

# Setup git configuration

set -e

echo "Setting up git configuration..."

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GITCONFIG_SRC="${SCRIPT_DIR}/gitconfig"
GITCONFIG_DEST="${HOME}/.gitconfig"

# Backup existing gitconfig if it exists and is not a symlink
if [[ -f "${GITCONFIG_DEST}" ]] && [[ ! -L "${GITCONFIG_DEST}" ]]; then
    echo "Backing up existing .gitconfig to .gitconfig.backup"
    cp "${GITCONFIG_DEST}" "${HOME}/.gitconfig.backup"
fi

# Remove old symlink or file
if [[ -L "${GITCONFIG_DEST}" ]] || [[ -f "${GITCONFIG_DEST}" ]]; then
    rm "${GITCONFIG_DEST}"
fi

# Create symlink
echo "Creating symlink: ${GITCONFIG_DEST} -> ${GITCONFIG_SRC}"
ln -sf "${GITCONFIG_SRC}" "${GITCONFIG_DEST}"

echo ""
echo "Git configuration complete!"
echo ""
echo "IMPORTANT: Please update your git config with your details:"
echo "  git config --global user.name \"Your Name\""
echo "  git config --global user.email \"your.email@example.com\""
echo ""
echo "Or edit ${GITCONFIG_SRC} directly"