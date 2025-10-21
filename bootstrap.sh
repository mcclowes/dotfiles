#!/usr/bin/env bash

# Dotfiles bootstrap script
# This script sets up a new macOS development environment

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() {
    echo -e "${BLUE}==>${NC} $1"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
}

warning() {
    echo -e "${YELLOW}!${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
}

# Get the dotfiles directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

info "Starting dotfiles setup from: $DOTFILES_DIR"
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    error "This script is designed for macOS only"
    exit 1
fi

# Confirm before proceeding
echo "This script will install:"
echo "  • Homebrew and packages"
echo "  • Git configuration"
echo "  • Zsh configuration with oh-my-zsh"
echo "  • Global npm packages"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    warning "Setup cancelled"
    exit 0
fi

# Run individual bootstrap scripts
run_bootstrap() {
    local component=$1
    local dir="${DOTFILES_DIR}/${component}"

    if [[ -f "${dir}/bootstrap.sh" ]]; then
        info "Setting up ${component}..."
        cd "$dir"
        if bash ./bootstrap.sh; then
            success "${component} setup complete"
        else
            error "${component} setup failed"
            return 1
        fi
        cd "$DOTFILES_DIR"
    else
        warning "No bootstrap script found for ${component}"
    fi
}

echo ""
info "Phase 1: Homebrew and Applications"
run_bootstrap "homebrew"

echo ""
info "Phase 2: Git Configuration"
run_bootstrap "git"

echo ""
info "Phase 3: Zsh Configuration"
run_bootstrap "zsh"

echo ""
info "Phase 4: npm Global Packages"
run_bootstrap "npm"

echo ""
success "All done! Your development environment is ready."
echo ""
info "Next steps:"
echo "  1. Restart your terminal to load zsh configuration"
echo "  2. Review README.md for manual configuration steps"
echo "  3. Customize git/gitconfig with your details"
echo ""