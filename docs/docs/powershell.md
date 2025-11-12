---
sidebar_position: 3
---

# PowerShell Setup

This guide covers PowerShell installation, configuration, and module management on macOS.

## Overview

PowerShell provides a powerful cross-platform scripting environment with:
- Advanced cmdlets and pipeline support
- Object-oriented command output
- Module system for extensibility
- Integration with .NET and macOS APIs
- Consistent experience across platforms

## Installation

PowerShell is automatically installed via the `run_once_install-powershell.sh.tmpl` script when you apply your dotfiles.

### Manual Installation

If needed, you can install PowerShell manually:

```bash
brew install --cask powershell
```

Verify installation:
```bash
pwsh --version
```

## Profile Configuration

The PowerShell profile is located at:
- **Template**: `dot_config/powershell/Microsoft.PowerShell_profile.ps1.tmpl`
- **Installed**: `~/.config/powershell/Microsoft.PowerShell_profile.ps1`

### Profile Features

#### Module Imports

The profile automatically imports essential modules:

```powershell
# Enhanced readline functionality
Import-Module PSReadLine

# Git integration
Import-Module posh-git

# Custom prompt themes
Import-Module oh-my-posh

# File/folder icons
Import-Module Terminal-Icons

# Fuzzy finder integration
Import-Module PSFzf
```

#### Custom Prompt

The profile configures oh-my-posh for a beautiful, informative prompt:

```powershell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/theme.omp.json" | Invoke-Expression
```

#### Aliases and Functions

Common aliases for productivity:
```powershell
# Directory navigation
Set-Alias -Name ll -Value Get-ChildItem

# Git shortcuts
Set-Alias -Name g -Value git

# System utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path
}
```

## Module Management

PowerShell modules are defined in `.chezmoidata/powershell.yaml` and automatically managed.

### Installed Modules

The configuration includes these essential modules:

#### PSReadLine
Enhanced command-line editing with:
- Syntax highlighting
- Multi-line editing
- History searching
- Predictive IntelliSense

#### posh-git
Git integration providing:
- Git status in prompt
- Tab completion for Git commands
- Branch information display

#### oh-my-posh
Customizable prompt themes:
- Cross-platform consistency
- Rich segment customization
- Git status visualization
- Execution time tracking

#### Terminal-Icons
Visual file/folder icons in listings:
- Color-coded by file type
- Instant visual recognition
- Works with `Get-ChildItem`

#### PSFzf
Fuzzy finder integration:
- `Ctrl+T` - Find files
- `Ctrl+R` - Search history
- `Alt+C` - Change directory

#### Az Module Suite
Azure management modules:
- `Az.Accounts` - Authentication
- `Az.Resources` - Resource management
- `Az.Storage` - Storage operations
- `Az.KeyVault` - Secrets management
- `Az.Compute` - VM management

#### Microsoft.Graph
Microsoft 365 and Azure AD:
- User management
- Group operations
- Intune administration
- Conditional Access policies

#### Other Modules
- **PSIntuneAuth** - Intune authentication
- **IntuneWin32App** - App packaging
- **Pester** - Testing framework
- **PSScriptAnalyzer** - Code quality

### Adding New Modules

1. Edit the module list:
```bash
chezmoi edit ~/.chezmoidata/powershell.yaml
```

2. Add your module:
```yaml
powershell:
  modules:
    - name: ModuleName
      description: What the module does
```

3. Apply changes:
```bash
chezmoi apply
```

The module will be automatically installed.

### Updating Modules

Modules are automatically updated when you run `chezmoi apply` if the configuration changes.

To manually update all modules:
```powershell
Update-Module
```

To update a specific module:
```powershell
Update-Module -Name ModuleName
```

## Module Configuration

### PSReadLine Configuration

Customize in your profile:
```powershell
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
```

### oh-my-posh Themes

List available themes:
```powershell
Get-PoshThemes
```

Change theme:
```powershell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/jandedobbeleer.omp.json" | Invoke-Expression
```

Make it permanent by updating your profile.

### PSFzf Configuration

Customize keybindings:
```powershell
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
```

## Common Tasks

### Running Scripts

Execute a PowerShell script:
```powershell
./script.ps1
```

With parameters:
```powershell
./script.ps1 -Parameter "value" -Flag
```

### Azure Management

Connect to Azure:
```powershell
Connect-AzAccount
```

List resources:
```powershell
Get-AzResource
```

### Microsoft Graph

Connect:
```powershell
Connect-MgGraph -Scopes "User.Read.All"
```

Get users:
```powershell
Get-MgUser -All
```

## Troubleshooting

### Execution Policy

If you can't run scripts:
```powershell
Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Module Import Errors

Check if module is installed:
```powershell
Get-Module -ListAvailable -Name ModuleName
```

Import manually:
```powershell
Import-Module ModuleName -Force
```

### Profile Not Loading

Check profile path:
```powershell
$PROFILE
Test-Path $PROFILE
```

Reload profile:
```powershell
. $PROFILE
```

### Module Installation Failed

Clear package cache:
```powershell
Unregister-PSRepository PSGallery
Register-PSRepository -Default
```

Install module manually:
```powershell
Install-Module -Name ModuleName -Force -AllowClobber
```

### Oh-my-posh Not Working

Verify installation:
```bash
brew list oh-my-posh
```

Reinstall if needed:
```bash
brew reinstall oh-my-posh
```

## Best Practices

1. **Keep Modules Updated** - Run `Update-Module` regularly
2. **Use Virtual Environments** - Isolate project dependencies
3. **Test Scripts** - Use Pester for script testing
4. **Follow Style Guide** - Use PSScriptAnalyzer
5. **Secure Credentials** - Use SecureString and credential management
6. **Error Handling** - Always use try/catch blocks
7. **Comment Code** - Use comment-based help for functions

## Resources

- [PowerShell Documentation](https://docs.microsoft.com/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
- [PSReadLine on GitHub](https://github.com/PowerShell/PSReadLine)
- [oh-my-posh Documentation](https://ohmyposh.dev/)
- [Azure PowerShell](https://docs.microsoft.com/powershell/azure/)
