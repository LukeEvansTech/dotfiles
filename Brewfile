# file location: ~/.dotfiles/Brewfile

# This file is used along with the `brew bundle` command to ensure that required packages and apps are installed.
# Also can be used to ensure that any package/apps that were installed as experimentation are uninstalled from the system.
# If you are starting such a file on a machine where you have already installed some apps using brew, then use `brew bundle dump` to create this file and avoid starting from scratch
#
# Install these Homebrew formula globally:
#   brew bundle --no-lock --file=~/.Brewfile
#
# List all installed Homebrew formula not in this Brewfile:
#   brew bundle cleanup --file=~/.Brewfile
#
# Uninstall all installed Homebrew formula not in this Brewfile:
#   brew bundle cleanup --force --file=~/.Brewfile
#
# Full instructions: https://github.com/Homebrew/homebrew-bundle

tap "homebrew/bundle"

# https://github.com/buo/homebrew-cask-upgrade
# tap "buo/cask-upgrade"

# Auto update
tap "homebrew/autoupdate"
brew "pinentry-mac"

# Fonts 
tap "homebrew/cask-fonts"
cask "font-fira-code"
cask "font-fira-code-nerd-font"
cask "font-fira-mono-nerd-font"

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew "coreutils"
# Install some other useful utilities like `sponge`.
# brew "moreutil"

# Install more recent versions of some macOS tools.
brew 'git'
brew "grep"
brew "openssh"
brew "bash"
brew 'wget'
brew "python" # Latest Python
brew "pipenv" # Node-style local modules for Python
# brew "screen"

# Node.js
brew "node"

# https://github.com/patrickvane/shfmt?tab=readme-ov-file - Had to restart Terminal to take effect
brew "shfmt"

# https://github.com/junegunn/fzf
brew "fzf"

# Useful command line tools

# Hashicorp
tap "hashicorp/tap"
brew "hashicorp/tap/packer"
brew "hashicorp/tap/terraform"

# Sidero Labs
tap "siderolabs/tap"
brew "siderolabs/tap/talosctl"

# Packer - https://vmware-samples.github.io/packer-examples-for-vsphere/getting-started/requirements/#__tabbed_2_3
# brew "mkpasswd"
brew "jq"
brew "gomplate"
brew "ansible"

# [GitHub - mas-cli/mas: :package: Mac App Store command line interface](https://github.com/mas-cli/mas)
brew "mas"

# PowerShell
cask "powershell"

# BitWarden CLI
brew "bitwarden-cli"

# Azure CLI
brew "azure-cli"

# Duti - https://alexpeattie.com/blog/associate-source-code-files-with-editor-in-macos-using-duti/
brew "duti"

# Go
brew "go"

# alt-tab - https://alt-tab-macos.netlify.app/ - installed using Installomator
# cask "alt-tab"