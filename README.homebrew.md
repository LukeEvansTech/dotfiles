# Homebrew Package Management

This document explains how Homebrew packages are managed with chezmoi.

## Quick Start

1. **Add packages to configuration**:
   - Edit `.chezmoidata/packages.yaml` to add or remove packages
   - Packages are organized into `brews` (command-line tools) and `casks` (applications)

2. **Apply configuration**:
   ```bash
   chezmoi apply
   ```

## Configuration Structure

The package configuration is stored in `.chezmoidata/packages.yaml`:

```yaml
packages:
  darwin:
    brews:
      - "git"       # Command-line tools
      - "python"
    casks:
      - "firefox"   # Applications
      - "visual-studio-code"
```

### Package Types

| Type    | Description                            | Example                 |
| ------- | -------------------------------------- | ----------------------- |
| `brews` | Command-line tools and libraries       | `git`, `python`, `jq`   |
| `casks` | macOS applications and larger binaries | `firefox`, `powershell` |

## How It Works

The script `run_onchange_darwin-install-packages.sh.tmpl`:

1. Creates a temporary Brewfile from your configuration
2. Installs all specified packages using `brew bundle`
3. Removes packages that are no longer in your configuration
4. Preserves system packages and dependencies

### Smart Cleanup

The script intelligently manages package removal:

- **System packages** (like `git`, `curl`, `zsh`) are never removed
- **Dependencies** of other packages are preserved
- Only packages explicitly removed from configuration are uninstalled

## Adding New Packages

To add a new package:

1. Find the package name using `brew search [package]`
2. Determine if it's a brew or cask:
   - Command-line tools are usually brews
   - Applications are usually casks
3. Add to the appropriate section in `.chezmoidata/packages.yaml`
4. Run `chezmoi apply` to install

## Removing Packages

To remove a package:

1. Delete the package from `.chezmoidata/packages.yaml`
2. Run `chezmoi apply` to uninstall

## Troubleshooting

- **Installation failures**: Check if the package name is correct
- **Removal failures**: The package might be a dependency of another package
- **Performance issues**: Large casks may take time to download and install

## Management Tips

- Add comments to document what each package does
- Group related packages together
- Consider using `brew info [package]` to learn more about a package before adding it