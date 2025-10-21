#!/usr/bin/env bash

# Install command-line tools using Homebrew

set -e

echo "Installing Homebrew and packages..."

# Check if Homebrew is already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon and Intel Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        # Apple Silicon
        eval "$(/opt/homebrew/bin/brew shellenv)"
        (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "${HOME}/.zprofile"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        # Intel
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed"
fi

# Make sure we're using the latest Homebrew
echo "Updating Homebrew..."
brew update

# Upgrade any already-installed formulae
echo "Upgrading existing packages..."
brew upgrade

# Save Homebrew's installed location
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated)
echo "Installing GNU utilities..."
if ! brew list coreutils &> /dev/null; then
    brew install coreutils
fi

if [[ ! -f "${BREW_PREFIX}/bin/sha256sum" ]]; then
    ln -sf "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"
fi

# Install some other useful utilities
if ! brew list moreutils &> /dev/null; then
    brew install moreutils
fi

# Install GNU `find`, `locate`, `updatedb`, and `xargs`
if ! brew list findutils &> /dev/null; then
    brew install findutils
fi

# Install GNU `sed`
if ! brew list gnu-sed &> /dev/null; then
    brew install gnu-sed
fi

# Install a modern version of Bash
if ! brew list bash &> /dev/null; then
    brew install bash
fi

if ! brew list bash-completion@2 &> /dev/null; then
    brew install bash-completion@2
fi

# Switch to using brew-installed bash as default shell (optional)
if ! grep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
    echo "Adding Homebrew bash to allowed shells..."
    echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
    echo "You can now run: chsh -s ${BREW_PREFIX}/bin/bash (if you want to use Homebrew bash)"
fi

# Install from Brewfile
echo "Installing packages from Brewfile..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
brew bundle --file="${SCRIPT_DIR}/Brewfile"

# Cleanup
echo "Cleaning up..."
brew cleanup

echo "Homebrew setup complete!"