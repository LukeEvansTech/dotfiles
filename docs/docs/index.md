---
sidebar_position: 1
---

# Getting Started

Welcome to the **Dotfiles & System Configuration** documentation! This project manages personal macOS system configuration and dotfiles using [chezmoi](https://www.chezmoi.io/) for seamless setup and maintenance across machines.

## What is This?

This repository provides automated setup and configuration management for macOS systems, including:
- Shell environments (zsh, bash)
- Git configuration
- PowerShell setup and modules
- macOS system preferences
- Homebrew package management
- NFS mount automation with 1Password integration

## Key Features

- 🔧 **chezmoi** - Dotfile management with templating
- 🍺 **Homebrew** - Package and application management
- 🔐 **1Password** - Secure secrets and NFS mount credentials
- 💻 **PowerShell** - Cross-platform scripting environment
- ⚡ **mise** - Development tool version management
- 🐚 **atuin** - Shell history synchronization
- 🎨 **oh-my-posh** - Customizable prompt themes

## Quick Start

### New Machine Setup

For a fresh macOS installation, use the automated setup script:

```bash
# Run directly from GitHub
bash -c "$(curl -fsSL https://raw.githubusercontent.com/lukeevanstech/dotfiles/main/setup.sh)"
```

This script will:
1. Install Xcode Command Line Tools
2. Install Homebrew
3. Install required CLI tools (chezmoi, 1password-cli)
4. Initialize and apply this dotfiles repository

### Manual Installation

If you prefer manual setup:

```bash
# Install chezmoi
brew install chezmoi

# Initialize with this repository
chezmoi init https://github.com/lukeevanstech/dotfiles.git

# Apply the configuration
chezmoi apply
```

## What's Managed?

### Shell Configuration
- **zsh** - Primary shell with custom prompt and aliases
- **bash** - Fallback shell configuration
- **PowerShell** - Cross-platform scripting with modules and profile

### Development Tools
- **Git** - Global configuration and ignore patterns
- **mise** - Tool version manager for development environments
- **atuin** - Enhanced shell history with sync

### System Configuration
- **macOS defaults** - System preferences and UI/UX settings
- **Homebrew packages** - CLI tools, applications, and fonts
- **PowerShell modules** - Automated installation and updates

### Infrastructure
- **NFS mounts** - Automated setup with 1Password credentials
- **Security** - Integrated 1Password for secrets management

## Architecture

```
dotfiles/
├── dot_zshrc                          # Z shell configuration
├── dot_bashrc                         # Bash configuration
├── dot_gitconfig                      # Git global config
├── dot_config/
│   └── powershell/                   # PowerShell profile
├── .chezmoidata/
│   ├── homebrew.yaml                 # Package definitions
│   └── powershell.yaml               # Module definitions
├── run_once_*.sh.tmpl                # One-time setup scripts
├── run_onchange_*.sh.tmpl            # Scripts that run on changes
├── setup.sh                          # Automated setup script
└── docs/                             # This documentation
```

## Common Tasks

### Applying Changes

After modifying your dotfiles:

```bash
# Apply all changes
chezmoi apply

# Apply with verbose output
chezmoi apply --verbose
```

### Updating Configuration

```bash
# Edit a file in chezmoi
chezmoi edit ~/.zshrc

# Add a new file to chezmoi
chezmoi add ~/.some_config_file

# Check what would change
chezmoi diff
```

### Managing Packages

```bash
# Update package list and apply
chezmoi cd
# Edit .chezmoidata/homebrew.yaml
chezmoi apply
```

## Next Steps

- [Shell Configuration](/docs/shell-config) - Customize your shell environment
- [PowerShell Setup](/docs/powershell) - Configure PowerShell and modules
- [Homebrew Packages](/docs/homebrew) - Manage installed packages
- [macOS Defaults](/docs/macos-defaults) - System preferences configuration
- [NFS Mounts](/docs/nfs-mounts) - Automated NFS mount setup

## Philosophy

This project follows these principles:

1. **Automation First** - Minimize manual setup steps
2. **Security Built-in** - Use 1Password for sensitive data
3. **Declarative** - Define desired state, let tools handle implementation
4. **Idempotent** - Safe to run multiple times
5. **Reproducible** - Consistent setup across machines
6. **Version Controlled** - Track all configuration changes
