#!/usr/bin/env bash

# =============================================================================
# macOS Development Environment Setup Script
# =============================================================================
#
# DESCRIPTION:
#   This script automates the setup of a development environment on macOS.
#   It installs Xcode Command Line Tools, Homebrew, and several CLI tools
#   before using Chezmoi to bootstrap dotfiles from a GitHub repository.
#
# USAGE:
#   Option 1: Save and run locally
#     chmod +x setup.sh
#     ./setup.sh
#
#   Option 2: Run directly from GitHub
#     bash -c "$(curl -fsSL https://raw.githubusercontent.com/lukeevanstech/dotfiles/main/setup.sh)"
#
# COMPONENTS:
#   - Xcode Command Line Tools: Required for many development tools
#   - Homebrew: The missing package manager for macOS
#   - Chezmoi: Dotfile manager that helps manage configuration files across machines
#   - 1Password CLI: Command-line interface for 1Password password manager
#
# REPOSITORY:
#   The script pulls dotfiles from: https://github.com/lukeevanstech/dotfiles.git
#
# =============================================================================

# Colors for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions for logging
log_info() {
  echo -e "${BLUE}INFO:${NC} $1"
}

log_success() {
  echo -e "${GREEN}SUCCESS:${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}WARNING:${NC} $1"
}

log_error() {
  echo -e "${RED}ERROR:${NC} $1"
}

section() {
  echo -e "\n${BLUE}=== $1 ===${NC}"
}

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Script starts here
echo -e "${GREEN}Starting macOS environment setup...${NC}"

# Install xcode
section "Installing Xcode Command Line Tools"
if ! xcode-select -p &>/dev/null; then
  log_info "Xcode Command Line Tools not found, installing..."
  xcode-select --install
  
  # Wait for xcode-select to complete
  log_info "Waiting for Xcode Command Line Tools installation to complete..."
  log_info "If a dialog opened, please click Install and follow the prompts."
  log_info "Press any key once installation has completed..."
  read -n 1 -s
  
  if ! xcode-select -p &>/dev/null; then
    log_error "Xcode Command Line Tools installation failed. Please install manually and run this script again."
    exit 1
  fi
  
  log_success "Xcode Command Line Tools installed."
else
  log_info "Xcode Command Line Tools already installed."
fi

# Install brew
section "Installing Homebrew"
if ! command_exists brew; then
  log_info "Homebrew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH for the current session
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    log_info "Added Homebrew to PATH for this session (Apple Silicon Mac)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
    log_info "Added Homebrew to PATH for this session (Intel Mac)"
  else
    log_error "Homebrew installation completed but brew command not found in expected locations."
    log_error "Please add Homebrew to your PATH manually and run this script again."
    exit 1
  fi
  
  log_success "Homebrew installed and added to PATH."
else
  log_info "Homebrew already installed."
fi

# Array of packages to install before Chezmoi dotfiles
section "Installing Required CLI Tools"
pre_chezmoi_packages=(
  "chezmoi"
  "1password-cli"
  "powershell"  # PowerShell for cross-platform scripting
  # Add more packages here as needed
)

# Install packages
for package in "${pre_chezmoi_packages[@]}"; do
  # Extract command name - typically it's the package name without "-cli" suffix
  command_name="${package%-cli}"
  
  if ! command_exists "$command_name"; then
    log_info "$package not found, installing..."
    if ! brew install "$package"; then
      log_error "Failed to install $package. Please install manually and run this script again."
      exit 1
    fi
    log_success "$package installed."
  else
    log_info "$package already installed."
  fi
done

# Initialize and apply dotfiles with Chezmoi
section "Setting up dotfiles with Chezmoi"
if command_exists chezmoi; then
  log_info "Initializing Chezmoi with dotfiles repository..."
  
  # Initialize chezmoi with the dotfiles repository
  if ! chezmoi init https://github.com/lukeevanstech/dotfiles.git; then
    log_error "Failed to initialize Chezmoi with the dotfiles repository."
    exit 1
  fi
  
  # Ask before applying
  echo
  log_info "Ready to apply dotfiles configuration."
  read -p "Do you want to apply the configuration now? (y/n) " -n 1 -r
  echo
  
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    log_info "Applying dotfiles configuration..."
    
    if ! chezmoi apply; then
      log_error "Failed to apply dotfiles configuration."
      exit 1
    fi
    
    log_success "Dotfiles applied successfully."
  else
    log_info "Skipping dotfiles application. You can apply them later with 'chezmoi apply'."
  fi
else
  log_error "Chezmoi not found. Something went wrong with the installation."
  exit 1
fi

section "Setup Complete"
log_success "Your macOS environment has been set up successfully!"
log_info "Next steps:"
log_info "1. Restart your terminal or run 'source ~/.zshrc' to apply shell configuration"
log_info "2. If you use 1Password, run 'op signin' to authenticate the CLI"
log_info "3. For NFS mounts, set up your mount information in 1Password (see README.nfs-mounts.md)"
echo