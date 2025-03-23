# PowerShell Module Management

This document explains how PowerShell modules are managed with chezmoi.

## Quick Start

1. **Add modules to configuration**:
   - Edit `.chezmoidata/powershell.yaml` to add or remove modules

2. **Apply configuration**:
   ```bash
   chezmoi apply
   ```

## Configuration Structure

The PowerShell module configuration is stored in `.chezmoidata/powershell.yaml`:

```yaml
powershell:
  modules:
    - "PSReadLine"        # Enhanced command-line editing
    - "posh-git"          # Git integration for PowerShell
    - "oh-my-posh"        # Prompt theme engine
    - "Terminal-Icons"    # File and folder icons
```

### Common Modules

| Module             | Description                                 |
| ------------------ | ------------------------------------------- |
| `posh-git`         | Git integration for PowerShell prompt       |
| `oh-my-posh`       | Prompt theme engine for any shell           |
| `Terminal-Icons`   | File and folder icons in terminal listings  |
| `PSScriptAnalyzer` | Static code analyzer for PowerShell scripts |

## How It Works

The script `run_onchange_install-powershell-modules.sh.tmpl`:

1. Checks if PowerShell is installed (installs it if needed)
2. Creates a temporary PowerShell script
3. Executes the script with `pwsh -File`
4. The PowerShell script:
   - Configures PSGallery as a trusted repository
   - Installs or updates each module in the configuration
   - Handles platform-specific differences (Windows/macOS/Linux)

## Prerequisites

- PowerShell 7+ (installed via Homebrew on macOS)
- Internet connection to access the PowerShell Gallery

## Adding New Modules

To add a new PowerShell module:

1. Find the module name using `Find-Module -Name "*keyword*"` in PowerShell
2. Add the module name to `.chezmoidata/powershell.yaml`
3. Run `chezmoi apply` to install

## Removing Modules

To remove a module from automatic management:

1. Delete the module from `.chezmoidata/powershell.yaml`
2. The module will remain installed but won't be updated automatically

To completely uninstall a module:

```powershell
Uninstall-Module -Name ModuleName -AllVersions
```

## PowerShell Profile

Your PowerShell profile is also managed by chezmoi at:
`~/.config/powershell/Microsoft.PowerShell_profile.ps1`

This profile is loaded every time you start PowerShell and can contain:
- Module imports
- Custom functions
- Aliases
- Prompt customization

## Troubleshooting

- **Installation failures**: Check internet connection and PowerShell Gallery access
- **Module conflicts**: Some modules may conflict with each other
- **Permission issues**: Some modules may require elevated privileges

## Cross-Platform Compatibility

The PowerShell module management is designed to work across:
- macOS
- Windows
- Linux

Platform-specific code handles differences in permission models and system paths.