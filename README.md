# Claude Code Model Switcher (CCM)

A shell application for managing Claude Code model configurations. Switch between AI models by updating the settings.json file.

## Features

- 🚀 **Model Switching**: Switch between models with simple commands
- 📊 **Status Monitoring**: View current model configuration
- ⚙️ **Configuration Management**: Edit configs.json and reload changes
- 🔄 **Original Mode**: Reset to original Claude Code configuration
- 🎨 **Colorful Output**: Easy-to-read terminal output
- 📦 **Auto Updates**: Get latest version from GitHub with `ccm update`
- 🔢 **Version Info**: Check your version with `ccm version`

## Installation

### Install

1. Make the script executable:
```bash
chmod +x ccm
```

2. Run the installer:
```bash
./install.sh
```

The installer will:
- Clone the CCM repository to `~/.ccm/repo/`
- Install the script to `~/.local/bin/ccm`
- Create default configuration at `~/.ccm/configs.json`

### Uninstall

To completely remove CCM:
```bash
./uninstall.sh
```

Uninstall options:
```bash
./uninstall.sh --force          # Skip confirmation
./uninstall.sh --config-only    # Only remove configs
./uninstall.sh --script-only    # Only remove script
```

## Usage

### Commands

```bash
ccm <model>         # Switch to specified model
ccm status          # Show current configuration
ccm list            # List available models
ccm reload          # Reload current model from configs.json
ccm reset           # Reset to original Claude Code
ccm config          # Open config file in your default editor
ccm update          # Update CCM to latest version from GitHub
ccm version         # Show CCM version
ccm help            # Show help
```

## Configuration

Models are defined in `~/.ccm/configs.json`. Edit this file to add or modify models.

Example:
```json
{
  "available_models": {
    "mymodel": {
      "haiku_model": "my-model-haiku",
      "sonnet_model": "my-model-sonnet",
      "opus_model": "my-model-opus",
      "base_url": "https://api.example.com",
      "auth_token": "your-token"
    }
  }
}
```

### Usage

1. Edit `~/.ccm/configs.json` to configure your models
2. Switch models: `ccm <model-name>`
3. Check status: `ccm status`
4. Reload after config changes: `ccm reload`
5. Update CCM: `ccm update`

## File Structure

```
~/.ccm/
├── repo/                   # Git repository (for updates)
├── configs.json            # Model configurations
└── settings_backup_*.json  # Backups

~/.claude/
└── settings.json           # Active Claude Code settings
```

## Updating

### From GitHub

CCM automatically clones the repository during installation. To get the latest version:

```bash
ccm update
```

This will:
- Pull latest changes from GitHub
- Backup your current script
- Install the updated version

### Local Development

If you're editing the `ccm` script locally, copy it directly to the installed location:

```bash
cp ccm ~/.local/bin/ccm
```

Do **not** run `./install.sh` or `ccm update` after making local changes — they pull from GitHub and will overwrite your edits.

## Troubleshooting

1. **Command not found**: Ensure `~/.local/bin` is in your PATH
2. **Permission denied**: Run `chmod +x ccm`
3. **Configuration not updating**: Edit `~/.ccm/configs.json` then run `ccm reload`
4. **Update not working**: Run `./install.sh` to reclone the repository

## Requirements

- Bash shell
- Git (for installation and updates)
- Basic Unix tools

## Version

Current version: **1.3.0**

Check your version with `ccm version`.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

MIT License - feel free to use and modify as needed.

## Support

For issues, questions, or feature requests:
1. Check this README for common solutions
2. Create an issue in the repository
3. Use the `ccm help` command for usage information

---

**Version**: 1.3.0
**Author**: Claude Code Switcher
**Last Updated**: 2024
