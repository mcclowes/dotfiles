# Dotfiles

Personal macOS development environment configuration and setup scripts.

## Quick Start

### Prerequisites

1. Update macOS and install Xcode Command Line Tools:
```bash
sudo softwareupdate -i -a
xcode-select --install
```

2. Clone this repository:
```bash
git clone https://github.com/mcclowes/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

3. Run the bootstrap script:
```bash
./bootstrap.sh
```

The script will guide you through the setup process and install:
- Homebrew and packages
- Applications via Homebrew Cask
- Git configuration
- Zsh configuration and oh-my-zsh
- Global npm packages

## What's Included

### Homebrew (`homebrew/`)
- Package manager for macOS
- Development tools (git, node, python, etc.)
- Applications via Cask (VS Code, Chrome, Slack, etc.)
- Fonts

### Git (`git/`)
- Global git configuration
- User settings (name, email)
- Delta diff viewer configuration
- Git LFS support

### Zsh (`zsh/`)
- Oh-my-zsh framework
- Custom plugins and theme
- Helpful functions and aliases
- PATH configuration for common tools

### npm (`npm/`)
- Global npm packages for development

## Customization

### Before Running

1. **Edit `git/gitconfig`** - Update your name and email
2. **Edit `homebrew/Brewfile`** - Add/remove applications you want
3. **Review `zsh/bootstrap.sh`** - Adjust plugins and configuration

### After Installation

Run individual components if needed:
```bash
cd homebrew && ./bootstrap.sh  # Update Homebrew packages
cd git && ./bootstrap.sh       # Refresh git config
cd zsh && ./bootstrap.sh       # Update zsh config
cd npm && ./bootstrap.sh       # Install npm packages
```

## Manual Configuration

### macOS Settings

#### Keyboard
- **Modifier keys**: Switch Cmd and Alt (for external keyboard only)
- **Shortcuts**:
  - Mission Control: Add 2nd binding to Mouse Button 3
  - Spotlight: Change to `Alt + Space`
  - Mail: Set `Cmd + E` to Archive

#### Applications
Some applications require manual installation:
- Adobe Creative Cloud

## Updating

To update your configuration:

1. Pull latest changes:
```bash
cd ~/dotfiles
git pull
```

2. Re-run bootstrap or individual scripts:
```bash
./bootstrap.sh
```

## Troubleshooting

### Homebrew Installation Fails
Ensure you have Command Line Tools installed:
```bash
xcode-select --install
```

### Permission Denied
Some scripts may need execution permissions:
```bash
chmod +x bootstrap.sh
```

### Zsh Configuration Not Loading
Ensure your `.zshrc` is sourcing the configuration:
```bash
source ~/.zshrc
```

## Structure

```
.
├── README.md
├── bootstrap.sh          # Main setup script
├── .zshrc               # Zsh functions
├── apple/               # macOS defaults (WIP)
├── git/                 # Git configuration
│   ├── bootstrap.sh
│   └── gitconfig
├── homebrew/            # Homebrew packages
│   ├── bootstrap.sh
│   └── Brewfile
├── npm/                 # Global npm packages
│   └── bootstrap.sh
└── zsh/                 # Zsh configuration
    └── bootstrap.sh
```

## License

Free to use and modify.
