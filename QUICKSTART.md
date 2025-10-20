# Claude Code Switcher (CCM) - Quick Start

## Overview

CCM lets you switch between Claude Code models by managing configurations.

## Installation

```bash
./install.sh
```

### Uninstall

```bash
./uninstall.sh          # Complete removal
./uninstall.sh --force  # Skip confirmation
```

## Basic Usage

```bash
ccm <model>         # Switch to model
ccm status          # Check current model
ccm list            # List available models  
ccm reload          # Reload from configs.json
ccm reset           # Reset to original Claude Code
ccm help            # Show help
```

## Configuration

Edit `~/.ccm/configs.json` to add/modify models:

```json
{
  "available_models": {
    "mymodel": {
      "name": "My-Model",
      "base_url": "https://api.example.com",
      "auth_token": "your-token",
      "small_fast_model": "My-Model"
    }
  }
}
```

## Workflow

1. Edit `~/.ccm/configs.json`
2. Run `ccm reload` or `ccm <model>`
3. Check with `ccm status`

## Files

- `~/.ccm/configs.json` - Model configurations
- `~/.claude/settings.json` - Active settings

## Troubleshooting

- **Command not found**: Ensure `~/.local/bin` is in PATH
- **Config not updating**: Run `ccm reload` after editing configs.json

## Uninstall

```bash
./uninstall.sh          # Complete removal
./uninstall.sh --config-only  # Remove configs only
./uninstall.sh --script-only  # Remove script only
./uninstall.sh --force  # Skip confirmation
```

The uninstaller:
- Removes `~/.local/bin/ccm`
- Deletes `~/.ccm/` configuration directory  
- Resets Claude Code by removing `~/.claude/settings.json`
- Creates backup before removing settings
- Shows confirmation summary first