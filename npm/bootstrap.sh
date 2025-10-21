#!/usr/bin/env bash

# Install global npm packages

set -e

echo "Installing global npm packages..."

# Check if npm is available
if ! command -v npm &> /dev/null; then
    echo "npm is not installed. Please install Node.js first."
    echo "Run the homebrew bootstrap script or install Node.js manually."
    exit 1
fi

# List of packages to install
PACKAGES=(
    "git-open"
    "npm-why"
    "prettier"
    "serve"
    "vercel"
)

# Install each package if not already installed
for package in "${PACKAGES[@]}"; do
    if npm list -g "$package" &> /dev/null; then
        echo "✓ $package already installed"
    else
        echo "Installing $package..."
        npm install -g "$package"
    fi
done

echo ""
echo "Global npm packages installation complete!"
echo ""
echo "Installed packages:"
npm list -g --depth=0 | grep -E "$(IFS="|"; echo "${PACKAGES[*]}")" || true
