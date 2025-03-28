# PowerShell Scripts Implementation Plan

This document outlines the plan for extending the current PowerShell setup to support script installation in addition to modules.

## Overview

The current setup manages PowerShell modules through:
- `.chezmoidata/powershell.yaml` - Configuration file listing modules to install
- `run_onchange_install-powershell-modules.sh.tmpl` - Script that installs/updates these modules
- `README.powershell.md` - Documentation for the PowerShell setup

We will extend this to support PowerShell scripts (like IntuneBrew) by:
1. Adding a new "scripts" section to the YAML configuration
2. Updating the installation script to handle script installation
3. Updating the documentation

## Implementation Details

### 1. Update PowerShell YAML Configuration

Add a new "scripts" section to `.chezmoidata/powershell.yaml`:

```yaml
powershell:
  modules:
    # Core modules
    - "posh-git"          # Git integration for PowerShell
    # - "oh-my-posh"        # Prompt theme engine - https://ohmyposh.dev/docs/migrating
    - "Terminal-Icons"    # File and folder icons
    
    # Utility modules
    - "PSScriptAnalyzer"  # Static code analyzer
    - "ImportExcel"       # Excel manipulation
    - "PSFzf"             # Fuzzy finder integration
    
    # Microsoft modules
    - "PnP.PowerShell"
    - "Microsoft.PowerShell.SecretManagement" # Secret management
    - "Microsoft.PowerShell.SecretStore"      # Secret store backend
    
  scripts:
    # PowerShell scripts to install
    - "IntuneBrew"        # Example script for Intune management
```

### 2. Update PowerShell Installation Script

Modify `run_onchange_install-powershell-modules.sh.tmpl` to add script installation functionality:

1. Add a new function `Install-RequiredScript` to the PowerShell script:

```powershell
function Install-RequiredScript {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        
        [Parameter(Mandatory = $false)]
        [switch]$Update
    )
    
    try {
        # Check if script is already installed
        $scriptInfo = Get-InstalledScript -Name $Name -ErrorAction SilentlyContinue
        
        if ($scriptInfo) {
            if ($Update) {
                Write-Status "Updating script: $Name" -Type Info
                Update-Script -Name $Name -Force -ErrorAction Stop
                Write-Status "Script updated: $Name" -Type Success
            }
            else {
                Write-Status "Script already installed: $Name" -Type Info
            }
        }
        else {
            Write-Status "Installing script: $Name" -Type Info
            Install-Script -Name $Name -Force -Scope CurrentUser -ErrorAction Stop
            Write-Status "Script installed: $Name" -Type Success
        }
    }
    catch {
        Write-Status "Failed to install/update script $Name`: $_" -Type Error
    }
}
```

2. Add code to process scripts from the YAML configuration:

```powershell
# Install/update scripts from the YAML configuration
Write-Status "Processing PowerShell scripts..." -Type Info

$scripts = @(
{{ range .powershell.scripts }}    "{{ . }}"
{{ end }})

foreach ($script in $scripts) {
    Install-RequiredScript -Name $script -Update
}
```

3. Update the script's purpose comment to include script installation:

```
# Purpose:
#   Installs and updates PowerShell modules and scripts defined in .chezmoidata/powershell.yaml
```

### 3. Update Documentation

Update `README.powershell.md` to include information about script installation:

1. Update the configuration structure section:

```markdown
## Configuration Structure

The PowerShell configuration is stored in `.chezmoidata/powershell.yaml`:

```yaml
powershell:
  modules:
    - "PSReadLine"        # Enhanced command-line editing
    - "posh-git"          # Git integration for PowerShell
    - "Terminal-Icons"    # File and folder icons
  
  scripts:
    - "IntuneBrew"        # Intune management script
```

2. Add a section about scripts:

```markdown
### Common Scripts

| Script       | Description                               |
| ------------ | ----------------------------------------- |
| `IntuneBrew` | Script for managing Intune configurations |
```

3. Add instructions for adding/removing scripts:

```markdown
## Adding New Scripts

To add a new PowerShell script:

1. Find the script name using `Find-Script -Name "*keyword*"` in PowerShell
2. Add the script name to `.chezmoidata/powershell.yaml` under the `scripts` section
3. Run `chezmoi apply` to install

## Removing Scripts

To remove a script from automatic management:

1. Delete the script from `.chezmoidata/powershell.yaml`
2. The script will remain installed but won't be updated automatically

To completely uninstall a script:

```powershell
Uninstall-Script -Name ScriptName
```
```

## Implementation Workflow

1. Switch to Code mode to implement these changes
2. Update the YAML configuration file
3. Update the installation script
4. Update the documentation
5. Test the changes by running `chezmoi apply`

## Mermaid Diagram

```mermaid
flowchart TD
    A[chezmoi apply] --> B[run_onchange script]
    B --> C[Generate PowerShell script]
    C --> D[Execute PowerShell script]
    D --> E{Process components}
    E --> F[Install/update modules]
    E --> G[Install/update scripts]
    F --> H[Complete]
    G --> H