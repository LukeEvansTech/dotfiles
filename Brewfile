# file location: ~/.dotfiles/Brewfile

# This file is used along with the `brew bundle` command to ensure that required packages and apps are installed.
# Also can be used to ensure that any package/apps that were installed as experimentation are uninstalled from the system.
# If you are starting such a file on a machine where you have already installed some apps using brew, then use `brew bundle dump` to create this file and avoid starting from scratch

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
brew 'wget'
# brew "screen"

# Hashicorp
tap "hashicorp/tap"
brew "hashicorp/tap/packer"
brew "hashicorp/tap/terraform"

# Packer - https://vmware-samples.github.io/packer-examples-for-vsphere/getting-started/requirements/#__tabbed_2_3
# brew "mkpasswd"
brew "jq"
brew "gomplate"
brew "ansible"

# [GitHub - mas-cli/mas: :package: Mac App Store command line interface](https://github.com/mas-cli/mas)
brew "mas"

# PowerShell
cask "powershell"

# Go
brew "go"

# alt-tab - https://alt-tab-macos.netlify.app/ - installed using Installomator
# cask "alt-tab"