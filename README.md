# Claude Code Switcher (CCM)

A shell application for managing Claude Code model configurations. Switch between AI models by updating the settings.json file.

## Features

- 🚀 **Model Switching**: Switch between models with simple commands
- 📊 **Status Monitoring**: View current model configuration
- ⚙️ **Configuration Management**: Edit configs.json and reload changes
- 🔄 **Original Mode**: Reset to original Claude Code configuration
- 🎨 **Colorful Output**: Easy-to-read terminal output

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
ccm help            # Show help
```

## Configuration

Models are defined in `~/.ccm/configs.json`. Edit this file to add or modify models.

Example:
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

### Usage

1. Edit `~/.ccm/configs.json` to configure your models
2. Switch models: `ccm <model-name>`
3. Check status: `ccm status`
4. Reload after config changes: `ccm reload`

## File Structure

```
~/.ccm/
├── configs.json           # Model configurations
└── settings_backup_*.json # Backups

~/.claude/
└── settings.json          # Active Claude Code settings
```

## Troubleshooting

1. **Command not found**: Ensure `~/.local/bin` is in your PATH
2. **Permission denied**: Run `chmod +x ccm`
3. **Configuration not updating**: Edit `~/.ccm/configs.json` then run `ccm reload`

## Requirements

- Bash shell
- Basic Unix tools

## Uninstall

Complete removal:
```bash
./uninstall.sh
```

Selective removal:
```bash
./uninstall.sh --config-only    # Remove configs only
./uninstall.sh --script-only    # Remove script only
./uninstall.sh --force          # Skip confirmation
```

The uninstaller:
- Removes the CCM script from `~/.local/bin/ccm`
- Deletes configuration directory `~/.ccm/`
- Resets Claude Code by removing `~/.claude/settings.json`
- Creates backup of current settings before removal
- Checks shell configs for PATH cleanup suggestions
- Shows confirmation summary before proceeding

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

**Version**: 1.0.0  
**Author**: Claude Code Switcher  
**Last Updated**: 2024