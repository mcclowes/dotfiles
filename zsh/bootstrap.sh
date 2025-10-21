#!/usr/bin/env bash

# Install and configure oh-my-zsh

set -e

echo "Setting up Zsh configuration..."

# Install oh-my-zsh if not already installed
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "oh-my-zsh already installed"
fi

# Backup existing .zshrc if it exists and doesn't have our marker
if [[ -f "${HOME}/.zshrc" ]] && ! grep -q "# DOTFILES_MANAGED" "${HOME}/.zshrc"; then
    echo "Backing up existing .zshrc to .zshrc.backup"
    cp "${HOME}/.zshrc" "${HOME}/.zshrc.backup"
fi

# Create new .zshrc
echo "Creating .zshrc configuration..."
cat > "${HOME}/.zshrc" << 'EOF'
# DOTFILES_MANAGED - Do not remove this line

export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="bureau"

# Standard plugins - add custom plugins to the list
plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

## --------------- User configuration ---------------

# Editor
export EDITOR='vim'

# Paths
PATH="/sbin:$PATH"
PATH="/bin:$PATH"
PATH="/usr/sbin:$PATH"
PATH="/usr/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"

# Homebrew (Apple Silicon and Intel)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# pyenv (if installed)
if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# nvm (if installed)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm (if installed)
if command -v pnpm &> /dev/null; then
    export PNPM_HOME="${HOME}/Library/pnpm"
    PATH="$PNPM_HOME:$PATH"
fi

# Yarn (if installed)
if [[ -d "$HOME/.yarn/bin" ]]; then
    PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

export PATH

# -- Functions --

# Date/time functions (from dotfiles/.zshrc)
function unixTime { date +%s ; }
function isoTime { date +"%Y-%m-%d %H:%M:%S" }
function isoDate { date +"%Y-%m-%d" }

# Auto-fetch on cd to git repos (optional - comment out if too aggressive)
# cd () { builtin cd "$@" && cd_git_checker; }
# cd_git_checker () {
#   if [ -d .git ]; then
#     git fetch &> /dev/null &
#   fi;
# }

# Brew autocomplete
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
fi

# npmfetch - clean install npm packages
function npmfetch {
  rm -rf node_modules && npm update --save-dev && npm update --save
}

# Add your custom aliases and functions below this line

EOF

# Install zsh-syntax-highlighting plugin if not present
if [[ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

echo "Zsh configuration complete!"
echo "Restart your terminal or run 'source ~/.zshrc' to apply changes"