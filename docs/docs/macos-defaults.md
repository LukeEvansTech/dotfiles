---
sidebar_position: 5
---

# macOS System Defaults

This guide covers the macOS system preferences and defaults configured by this dotfiles repository.

## Overview

The `run_once_macos-defaults.sh.tmpl` script configures macOS system preferences using the `defaults` command. These settings are applied once when you first set up your system with chezmoi.

## Security & Privacy

### Firewall
```bash
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
```
Enables the built-in firewall for network protection.

### Screen Lock
```bash
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
```
Requires password immediately after sleep or screensaver.

### Privacy
```bash
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
```
Disables personalized advertising.

## User Interface & Experience

### General UI
```bash
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
```

### Window Management
```bash
# Disable window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable mission control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
```
Speeds up UI by reducing animation delays.

### Menu Bar
```bash
# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Set clock format
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  h:mm a"
```

## Finder

### View Options
```bash
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
```

### Search & Display
```bash
# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable file extension change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
```

### Folders & Navigation
```bash
# Show ~/Library folder
chflags nohidden ~/Library

# Disable .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Keep folders on top
defaults write com.apple.finder _FXSortFoldersFirst -bool true
```

## Dock

### Behavior
```bash
# Set icon size
defaults write com.apple.dock tilesize -int 48

# Enable magnification
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 64

# Auto-hide dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
```

### Features
```bash
# Minimize windows into app icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open apps
defaults write com.apple.dock show-process-indicators -bool true

# Don't show recent applications
defaults write com.apple.dock show-recents -bool false
```

### Hot Corners
```bash
# Top left: Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# Bottom right: Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0
```

Values:
- 0: No action
- 2: Mission Control
- 3: Application windows
- 4: Desktop
- 5: Start screensaver
- 6: Disable screensaver
- 10: Put display to sleep
- 11: Launchpad
- 12: Notification Center

## Keyboard & Input

### Keyboard
```bash
# Fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable auto-capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
```

### Text Input
```bash
# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
```

### Trackpad
```bash
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Enable three finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5
```

## Screenshots

```bash
# Save screenshots to ~/Screenshots
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location -string "~/Screenshots"

# Save as PNG
defaults write com.apple.screencapture type -string "png"

# Disable shadow
defaults write com.apple.screencapture disable-shadow -bool true

# Include date in filename
defaults write com.apple.screencapture include-date -bool true
```

## Applications

### Safari
```bash
# Enable develop menu
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Show full URL
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
```

### Terminal
```bash
# Use UTF-8
defaults write com.apple.terminal StringEncodings -array 4

# Enable Secure Keyboard Entry
defaults write com.apple.terminal SecureKeyboardEntry -bool true
```

### TextEdit
```bash
# Use plain text mode
defaults write com.apple.TextEdit RichText -int 0

# Open files as UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4

# Save files as UTF-8
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
```

### Activity Monitor
```bash
# Show main window on launch
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
```

## Network

### DNS
```bash
# Speed up DNS lookups
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES
```

### Bonjour
```bash
# Disable Bonjour advertising
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
```

## Performance

### Window Server
```bash
# Reduce transparency
defaults write com.apple.universalaccess reduceTransparency -bool true
```

### Animations
```bash
# Speed up window resize animations
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable opening/closing animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
```

## Power Management

### Energy Saver
```bash
# Disable sleep for display when charging
sudo pmset -c displaysleep 0

# Disable machine sleep when charging
sudo pmset -c sleep 0

# Enable lid wake
sudo pmset -a lidwake 1
```

### Battery
```bash
# Show battery percentage in menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Display sleep on battery
sudo pmset -b displaysleep 10
```

## Customization

### Modifying Defaults

To customize these settings:

1. Find the setting you want to change
2. Edit the script:
```bash
chezmoi edit ~/.local/share/chezmoi/run_once_macos-defaults.sh.tmpl
```

3. Modify the value:
```bash
# Example: Change dock size from 48 to 36
defaults write com.apple.dock tilesize -int 36
```

4. Apply changes (note: this is a run_once script):
```bash
chezmoi apply --force
```

### Adding New Defaults

To add new settings:

1. Find the domain and key:
```bash
# Read current value
defaults read com.apple.dock tilesize

# Watch for changes
defaults read > before.txt
# Change setting in System Preferences
defaults read > after.txt
diff before.txt after.txt
```

2. Add to script:
```bash
defaults write <domain> <key> -<type> <value>
```

3. Apply and test

### Resetting Defaults

To reset a specific setting:
```bash
defaults delete <domain> <key>
```

To reset an entire domain:
```bash
defaults delete <domain>
```

## Applying Changes

Most settings require restarting the affected application or service:

```bash
# Restart Finder
killall Finder

# Restart Dock
killall Dock

# Restart SystemUIServer
killall SystemUIServer

# Restart cfprefsd
killall cfprefsd
```

Full system restart ensures all changes take effect.

## Troubleshooting

### Settings Not Applied

1. Check script ran:
```bash
ls -la ~/.local/share/chezmoi/run_once_*
```

2. Force re-run:
```bash
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```

3. Verify setting:
```bash
defaults read <domain> <key>
```

### Settings Reverted

Some settings may be overridden by:
- System Preferences
- MDM policies
- System updates

### Permission Errors

Settings requiring sudo may need admin password:
```bash
sudo defaults write /Library/Preferences/...
```

## Best Practices

1. **Backup First** - Time Machine before major changes
2. **Test Changes** - Try on test account first
3. **Document Modifications** - Add comments to script
4. **One Change at a Time** - Easier to troubleshoot
5. **Restart Services** - Ensure changes take effect
6. **Version Control** - Commit changes to git

## Resources

- [macOS defaults List](https://macos-defaults.com/)
- [defaults man page](https://ss64.com/osx/defaults.html)
- [Awesome macOS Command Line](https://github.com/herrbischoff/awesome-macos-command-line)
