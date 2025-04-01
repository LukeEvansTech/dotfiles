# PowerShell Module and Script Management

This document explains how PowerShell modules and scripts are managed with chezmoi.

## Quick Start

1. **Add modules or scripts to configuration**:
   - Edit `.chezmoidata/powershell.yaml` to add or remove modules and scripts

2. **Apply configuration**:
   ```bash
   chezmoi apply
   ```

## Configuration Structure

The PowerShell configuration is stored in `.chezmoidata/powershell.yaml`:

```yaml
powershell:
  modules:
    - "PSReadLine"        # Enhanced command-line editing
    - "posh-git"          # Git integration for PowerShell
    - "oh-my-posh"        # Prompt theme engine
    - "Terminal-Icons"    # File and folder icons
    - "ImportExcel@7.8.5" # Excel manipulation with pinned version
  
  scripts:
    - "IntuneBrew"        # Intune management script
    - "PSWindowsUpdate@2.2.0" # Windows Update script with pinned version
```

### Version Pinning

You can pin a specific version of a module or script by using the `Name@Version` format:

```yaml
- "Microsoft.Graph@2.5.0"  # Pins Microsoft Graph module to version 2.5.0
```

When a version is pinned:
1. Only that specific version will be installed
2. The module/script won't be updated to newer versions automatically

### Common Modules

| Module             | Description                                 |
| ------------------ | ------------------------------------------- |
| `posh-git`         | Git integration for PowerShell prompt       |
| `oh-my-posh`       | Prompt theme engine for any shell           |
| `Terminal-Icons`   | File and folder icons in terminal listings  |
| `PSScriptAnalyzer` | Static code analyzer for PowerShell scripts |

### Common Scripts

| Script       | Description                               |
| ------------ | ----------------------------------------- |
| `IntuneBrew` | Script for managing Intune configurations |

## How It Works

The script `run_onchange_install-powershell-components.sh.tmpl`:

1. Checks if PowerShell is installed (installs it if needed)
2. Creates a temporary PowerShell script
3. Executes the script with `pwsh -File`
4. The PowerShell script:
   - Configures PSGallery as a trusted repository
   - Installs or updates each module and script in the configuration
   - Automatically removes previous versions of modules and scripts when updating
   - Respects version pinning for modules and scripts
   - Handles platform-specific differences (Windows/macOS/Linux)

## Prerequisites

- PowerShell 7+ (installed via Homebrew on macOS)
- Internet connection to access the PowerShell Gallery

## Adding New Modules

To add a new PowerShell module:

1. Find the module name using `Find-Module -Name "*keyword*"` in PowerShell
2. Add the module name to `.chezmoidata/powershell.yaml` under the `modules` section
3. Run `chezmoi apply` to install

## Adding New Scripts

To add a new PowerShell script:

1. Find the script name using `Find-Script -Name "*keyword*"` in PowerShell
2. Add the script name to `.chezmoidata/powershell.yaml` under the `scripts` section
3. Run `chezmoi apply` to install

## Removing Modules

To remove a module from automatic management:

1. Delete the module from `.chezmoidata/powershell.yaml`
2. The module will remain installed but won't be updated automatically

To completely uninstall a module:

```powershell
Uninstall-Module -Name ModuleName -AllVersions
```

## Removing Scripts

To remove a script from automatic management:

1. Delete the script from `.chezmoidata/powershell.yaml`
2. The script will remain installed but won't be updated automatically

To completely uninstall a script:

```powershell
Uninstall-Script -Name ScriptName
```

## PowerShell Profile

Your PowerShell profile is also managed by chezmoi at:
`~/.config/powershell/Microsoft.PowerShell_profile.ps1`

This profile is loaded every time you start PowerShell and can contain:
- Module imports
- Custom functions
- Aliases
- Prompt customization

## Version Management

By default, the system now:

1. **Checks for newer versions** before updating modules and scripts
2. **Only updates when a newer version is available** in the PowerShell Gallery
3. **Automatically removes previous versions** after updating to save disk space
4. **Respects pinned versions** when specified in the format `Name@Version`

This behavior ensures that:
- Your system stays clean without accumulating multiple versions of the same module
- You always have the latest features and security updates
- You can still pin specific versions when needed for compatibility

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