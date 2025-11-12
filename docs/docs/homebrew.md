---
sidebar_position: 4
---

# Homebrew Package Management

This guide covers Homebrew package management, including how packages are defined, installed, and maintained.

## Overview

Homebrew is the package manager for macOS that installs the tools and applications you need. This dotfiles repository manages Homebrew packages declaratively through YAML configuration.

## Configuration

Packages are defined in `.chezmoidata/homebrew.yaml` with three main categories:

### Formulae (CLI Tools)

Command-line tools and utilities installed via Homebrew formulae:

```yaml
homebrew:
  formulae:
    - name: tool-name
      description: What it does
```

### Casks (Applications)

GUI applications installed via Homebrew Casks:

```yaml
homebrew:
  casks:
    - name: app-name
      description: What it does
```

### Fonts

Fonts installed from the homebrew-cask-fonts tap:

```yaml
homebrew:
  fonts:
    - name: font-name
      description: Font description
```

## Installed Packages

### Essential CLI Tools

#### Version Control
- **git** - Distributed version control
- **gh** - GitHub CLI
- **git-lfs** - Git Large File Storage

#### Development
- **mise** - Tool version manager (replaces asdf)
- **node** - JavaScript runtime
- **python** - Python language
- **powershell** - Cross-platform shell

#### System Utilities
- **chezmoi** - Dotfile manager
- **1password-cli** - 1Password command-line tool
- **wget** - Network downloader
- **curl** - Data transfer tool
- **jq** - JSON processor
- **yq** - YAML processor

#### Kubernetes & Cloud
- **kubectl** - Kubernetes CLI
- **helm** - Kubernetes package manager
- **k9s** - Kubernetes TUI
- **terraform** - Infrastructure as Code
- **azure-cli** - Azure command line

#### Shell Enhancement
- **zsh** - Z shell
- **atuin** - Shell history manager
- **fzf** - Fuzzy finder
- **bat** - Cat clone with syntax highlighting
- **eza** - Modern ls replacement
- **ripgrep** - Fast text search
- **fd** - Fast find alternative

#### Monitoring & Performance
- **htop** - Interactive process viewer
- **btop** - Resource monitor
- **nmap** - Network scanner
- **speedtest-cli** - Internet speed test

### GUI Applications (Casks)

#### Development
- **visual-studio-code** - Code editor
- **docker** - Container platform
- **postman** - API testing
- **github** - GitHub Desktop

#### Productivity
- **1password** - Password manager
- **alfred** - Productivity launcher
- **notion** - Notes and docs
- **obsidian** - Knowledge base
- **rectangle** - Window management

#### Communication
- **slack** - Team messaging
- **discord** - Voice and chat
- **zoom** - Video conferencing

#### Utilities
- **iterm2** - Terminal emulator
- **stats** - System monitoring
- **appcleaner** - Application uninstaller
- **keka** - Archive utility

#### Browsers
- **google-chrome** - Web browser
- **firefox** - Web browser
- **brave-browser** - Privacy browser

#### Cloud Storage
- **google-drive** - Google Drive sync
- **dropbox** - Cloud storage

### Fonts

- **font-fira-code-nerd-font** - Monospace with ligatures
- **font-jetbrains-mono-nerd-font** - JetBrains monospace
- **font-meslo-lg-nerd-font** - Meslo with icons
- **font-hack-nerd-font** - Hack with icons

Nerd Fonts include programming ligatures and icons for terminal use.

## Managing Packages

### Adding New Packages

1. Edit the Homebrew configuration:
```bash
chezmoi edit ~/.chezmoidata/homebrew.yaml
```

2. Add your package:
```yaml
homebrew:
  formulae:
    - name: new-tool
      description: What it does
  casks:
    - name: new-app
      description: What it does
```

3. Apply changes:
```bash
chezmoi apply
```

The package will be automatically installed.

### Removing Packages

1. Remove from the YAML configuration:
```bash
chezmoi edit ~/.chezmoidata/homebrew.yaml
```

2. Apply changes:
```bash
chezmoi apply
```

The package will be automatically uninstalled (unless it's a dependency).

### Finding Packages

Search for formulae:
```bash
brew search <term>
```

Get package info:
```bash
brew info <package>
```

Browse on the web:
- Formulae: https://formulae.brew.sh/
- Casks: https://formulae.brew.sh/cask/

## Automation Script

The `run_onchange_darwin-install-packages.sh.tmpl` script handles package management:

### Features

- **Automatic Installation** - Installs packages from YAML
- **Automatic Removal** - Removes packages not in YAML
- **Dependency Protection** - Preserves required dependencies
- **Idempotent** - Safe to run multiple times
- **Change Detection** - Runs only when YAML changes

### How It Works

1. Reads package lists from `.chezmoidata/homebrew.yaml`
2. Compares with currently installed packages
3. Installs missing packages
4. Removes packages not in configuration
5. Preserves system packages and dependencies

### Manual Execution

Run the script manually:
```bash
bash ~/.local/share/chezmoi/run_onchange_darwin-install-packages.sh.tmpl
```

Or through chezmoi:
```bash
chezmoi apply
```

## Common Tasks

### Update All Packages

```bash
brew update
brew upgrade
```

### Update Specific Package

```bash
brew upgrade <package>
```

### Clean Up Old Versions

```bash
brew cleanup
```

### Check for Issues

```bash
brew doctor
```

### List Installed Packages

```bash
# List formulae
brew list

# List casks
brew list --cask

# List with versions
brew list --versions
```

### Lock Package Version

Add to `.chezmoidata/homebrew.yaml`:
```yaml
homebrew:
  formulae:
    - name: package@version
      description: Locked version
```

## Troubleshooting

### Installation Fails

Check Homebrew status:
```bash
brew doctor
```

Update Homebrew:
```bash
brew update
```

Clear cache:
```bash
brew cleanup -s
rm -rf "$(brew --cache)"
```

### Cask Installation Issues

Try reinstalling:
```bash
brew reinstall --cask <app>
```

Force install:
```bash
brew install --cask <app> --force
```

### Dependency Conflicts

Check dependencies:
```bash
brew deps <package>
```

View dependents:
```bash
brew uses <package> --installed
```

### Package Not Found

Update tap list:
```bash
brew update
brew tap
```

Add specific tap:
```bash
brew tap <tap-name>
```

### Permission Issues

Fix permissions:
```bash
sudo chown -R $(whoami) $(brew --prefix)/*
```

## Best Practices

1. **Regular Updates** - Run `brew upgrade` weekly
2. **Clean Up** - Run `brew cleanup` monthly
3. **Review Before Removing** - Check dependencies with `brew uses`
4. **Use Versions** - Pin critical tools to specific versions
5. **Document Additions** - Add descriptions when adding packages
6. **Test Changes** - Apply on test system before production
7. **Backup Before Major Changes** - Use Time Machine or similar

## Advanced Usage

### Bundle Dump

Export current packages to Brewfile:
```bash
brew bundle dump --file=~/Brewfile
```

### Tap Management

Add a tap:
```bash
brew tap <user/repo>
```

Remove a tap:
```bash
brew untap <user/repo>
```

### Service Management

Start service:
```bash
brew services start <service>
```

List services:
```bash
brew services list
```

## Resources

- [Homebrew Documentation](https://docs.brew.sh/)
- [Homebrew Formulae](https://formulae.brew.sh/)
- [Homebrew Cask](https://github.com/Homebrew/homebrew-cask)
- [Homebrew Fonts](https://github.com/Homebrew/homebrew-cask-fonts)
