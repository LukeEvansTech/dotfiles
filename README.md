# Dotfiles and System Configuration

This repository contains my personal dotfiles and system configuration managed with [chezmoi](https://www.chezmoi.io/). It automates the setup of a new macOS machine with my preferred settings, packages, and configurations.

## Overview

This repository includes:

- Shell configuration (zsh, bash)
- Git configuration
- macOS system preferences
- Package management via Homebrew
- NFS mount automation with 1Password integration
- Automated setup script for new machines

## Getting Started

### Quick Start (New Machine Setup)

For a fresh macOS installation, you can use the automated setup script:

```bash
# Option 1: Run directly from GitHub
bash -c "$(curl -fsSL https://raw.githubusercontent.com/lukeevanstech/dotfiles/main/setup.sh)"

# Option 2: Download and run locally
curl -fsSL https://raw.githubusercontent.com/lukeevanstech/dotfiles/main/setup.sh -o setup.sh
chmod +x setup.sh
./setup.sh
```

This script will:
1. Install Xcode Command Line Tools
2. Install Homebrew
3. Install required CLI tools (chezmoi, 1password-cli)
4. Initialize and apply this dotfiles repository

### Manual Installation

If you prefer to set up manually:

#### Prerequisites

- macOS (some scripts are macOS-specific)
- [Homebrew](https://brew.sh/) for package management
- [1Password](https://1password.com/) and 1Password CLI for secrets management

#### Steps

1. Install chezmoi:
   ```bash
   brew install chezmoi
   ```

2. Initialize with this repository:
   ```bash
   chezmoi init https://github.com/lukeevanstech/dotfiles.git
   ```

3. Apply the configuration:
   ```bash
   chezmoi apply
   ```

## Components

### Shell Configuration

- `dot_zshrc`: Z shell configuration with:
  - Editor preferences
  - Path configuration
  - Homebrew integration
  - [mise](https://github.com/jdx/mise) for development tool version management
  - [atuin](https://github.com/atuinsh/atuin) for shell history management

- `dot_bashrc`: Bash shell configuration (fallback)

### PowerShell Configuration

- `run_once_install-powershell.sh.tmpl`: Installs PowerShell on macOS
- `run_onchange_install-powershell-modules.sh.tmpl`: Shell wrapper that executes PowerShell to install and update modules
- `dot_config/powershell/Microsoft.PowerShell_profile.ps1.tmpl`: PowerShell profile with:
  - Module imports (PSReadLine, posh-git, oh-my-posh, Terminal-Icons, PSFzf)
  - Custom prompt configuration
  - Aliases and helper functions
  - OS-specific settings
- `.chezmoidata/powershell.yaml`: List of PowerShell modules to install

### Git Configuration

- `dot_gitconfig`: Global Git configuration
- `dot_gitignore`: Global Git ignore patterns

### macOS System Configuration

- `run_once_macos-defaults.sh.tmpl`: Configures macOS system preferences using the `defaults` command
  - Security & privacy settings
  - UI/UX preferences
  - Finder customization
  - Dock & Launchpad settings
  - Keyboard, trackpad & input settings
  - Network & performance optimizations
  - Energy & power management
  - App-specific settings (Safari, Terminal, etc.)

### Package Management

- `.chezmoidata/homebrew.yaml`: Defines packages to install via Homebrew
  - CLI tools and utilities
  - Applications via Homebrew Casks
  - Fonts

- `run_onchange_darwin-install-homebrew.sh.tmpl`: Installs and manages packages defined in homebrew.yaml
  - Automatically installs new packages
  - Removes packages no longer in the list
  - Preserves system packages and dependencies

### NFS Mount Automation

- `run_once_setup-nfs-mounts.sh.tmpl`: Automates NFS mount setup using 1Password
  - Retrieves mount information from 1Password
  - Creates mount points
  - Mounts NFS shares
  - Optionally adds entries to /etc/fstab

- `README.nfs-mounts.md`: Detailed documentation for NFS mount functionality

## Usage

### Updating Configuration

After making changes to your dotfiles:

```bash
# Apply changes
chezmoi apply

# Update repository with local changes
chezmoi cd
git add .
git commit -m "Update configuration"
git push
```

### Adding New Dotfiles

```bash
# Add a file
chezmoi add ~/.some_config_file

# Edit the file in the chezmoi source directory
chezmoi edit ~/.some_config_file

# Apply changes
chezmoi apply
```

## Customization

### Adding New Packages

Edit `.chezmoidata/homebrew.yaml` to add new Homebrew packages or casks.

### Adding PowerShell Modules

Edit `.chezmoidata/powershell.yaml` to add new PowerShell modules. The modules will be installed automatically when you run `chezmoi apply`.

### Modifying macOS Defaults

Edit `run_once_macos-defaults.sh.tmpl` to change macOS system preferences.

### Adding NFS Mounts

1. Create a new item in 1Password with tag `nfs-mount`
2. Add required fields (see `README.nfs-mounts.md` for details)
3. Run `chezmoi apply`

## Maintenance

### Updating Packages

```bash
chezmoi cd
# Update homebrew.yaml with new packages
chezmoi apply
```

### Updating PowerShell Modules

```bash
# Update all PowerShell modules
pwsh -Command "Update-Module"

# Or run chezmoi apply to update based on your configuration
chezmoi apply
```

### Troubleshooting

If you encounter issues:

1. Check the output of `chezmoi apply --verbose`
2. Verify that prerequisites are installed
3. Ensure 1Password CLI is authenticated for NFS mount functionality
4. For PowerShell module issues:
   - Check PowerShell execution policy: `Get-ExecutionPolicy`
   - Verify module availability: `Get-Module -ListAvailable`
   - Check for errors in the PowerShell profile: `Test-Path $PROFILE`

## License

This project is licensed under the MIT License - see the LICENSE file for details.