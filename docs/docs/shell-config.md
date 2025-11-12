---
sidebar_position: 2
---

# Shell Configuration

This guide covers the shell configuration managed by this dotfiles repository, including zsh, bash, and related tools.

## Z Shell (zsh)

The primary shell configuration is in `dot_zshrc` and includes:

### Editor Configuration

```bash
export EDITOR=code
export VISUAL=$EDITOR
```

Sets Visual Studio Code as the default editor for command-line operations.

### Path Configuration

```bash
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
```

Ensures proper path ordering with local binaries taking precedence.

### Homebrew Integration

```bash
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
```

Automatically configures Homebrew environment variables on Apple Silicon Macs.

### Development Tools

#### mise

[mise](https://mise.jdx.dev/) manages development tool versions (Node.js, Python, Ruby, etc.):

```bash
eval "$(mise activate zsh)"
```

Features:
- Per-project tool versions
- Automatic version switching
- Compatible with asdf plugins
- Faster than alternatives

Usage:
```bash
# Install a tool
mise install node@20

# Use in current directory
mise use node@20

# Show installed tools
mise list
```

#### atuin

[atuin](https://atuin.sh/) provides enhanced shell history:

```bash
eval "$(atuin init zsh)"
```

Features:
- Searchable history across machines
- Context-aware suggestions
- Statistics and insights
- Encrypted sync

Usage:
- Press `Ctrl+R` for interactive history search
- Press `Up` arrow for filtered history
- `atuin search <query>` for manual searches

## Bash Configuration

The `dot_bashrc` file provides fallback bash configuration:

```bash
# Basic bash setup
export EDITOR=code
export VISUAL=$EDITOR
export PATH="/usr/local/bin:$PATH"
```

While zsh is the primary shell, bash configuration ensures compatibility when needed.

## Customization

### Adding Aliases

Edit your shell configuration in chezmoi:

```bash
chezmoi edit ~/.zshrc
```

Add your aliases:
```bash
alias ll='ls -la'
alias g='git'
alias k='kubectl'
```

Apply changes:
```bash
chezmoi apply
```

### Changing Default Shell

To change your default shell:

```bash
# Change to zsh
chsh -s /bin/zsh

# Change to bash
chsh -s /bin/bash
```

### Environment Variables

Add custom environment variables to your shell config:

```bash
export MY_VAR="value"
export PATH="$HOME/bin:$PATH"
```

For sensitive values, consider using 1Password:

```bash
export API_KEY="$(op read "op://Private/API Key/credential")"
```

## Shell Prompt

The shell prompt is managed by:
- **oh-my-posh** for PowerShell (see [PowerShell Setup](/docs/powershell))
- Default zsh prompt with git integration

To customize the zsh prompt, you can use popular frameworks:
- [Starship](https://starship.rs/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Oh My Zsh](https://ohmyz.sh/)

## Terminal Emulator

This configuration works with any terminal emulator. Popular choices:
- **iTerm2** - Feature-rich macOS terminal
- **Warp** - Modern terminal with AI features
- **Alacritty** - GPU-accelerated terminal
- **kitty** - Fast, feature-full terminal

## Troubleshooting

### Command Not Found

If commands aren't found after applying changes:

```bash
# Reload shell configuration
source ~/.zshrc

# Or restart your terminal
```

### Path Issues

Verify your PATH:
```bash
echo $PATH
```

Check Homebrew installation:
```bash
brew doctor
```

### Tool Version Issues

Check mise status:
```bash
mise doctor
mise list
```

Reset mise:
```bash
mise cache clear
mise install
```

### History Not Syncing

For atuin sync issues:
```bash
# Check status
atuin status

# Force sync
atuin sync --force

# Re-login
atuin login
```
