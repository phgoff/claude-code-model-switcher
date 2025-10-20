#!/bin/bash

# Claude Code Switcher (CCM) Uninstall Script
# Removes CCM and all associated files

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Installation directory
INSTALL_DIR="$HOME/.local/bin"
CCM_SCRIPT="$INSTALL_DIR/ccm"

# Configuration directories
CONFIG_DIR="$HOME/.ccm"
CLAUDE_DIR="$HOME/.claude"

# Print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Show help
show_help() {
    cat << 'EOF'
Claude Code Switcher (CCM) Uninstall Script

USAGE:
    ./uninstall.sh [options]

OPTIONS:
    --help, -h       Show this help message
    --config-only    Only remove configuration files (keep installed script)
    --script-only    Only remove installed script (keep configurations)
    --force          Skip confirmation prompts

EXAMPLES:
    ./uninstall.sh              # Full uninstall (with confirmation)
    ./uninstall.sh --force      # Full uninstall (no confirmation)
    ./uninstall.sh --config-only # Only remove configs
    ./uninstall.sh --script-only # Only remove script

EOF
}

# Confirmation prompt
confirm() {
    local message=$1
    local default=${2:-n}

    if [[ "$FORCE" == true ]]; then
        return 0
    fi

    read -p "$message [y/N]: " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Remove installed script
remove_script() {
    print_status $BLUE "Removing installed CCM script..."

    if [[ -f "$CCM_SCRIPT" ]]; then
        rm "$CCM_SCRIPT"
        print_status $GREEN "✓ Removed: $CCM_SCRIPT"
    else
        print_status $YELLOW "⚠ Script not found: $CCM_SCRIPT"
    fi
}

# Remove configuration files
remove_configs() {
    print_status $BLUE "Removing CCM configuration files..."

    if [[ -d "$CONFIG_DIR" ]]; then
        print_status $YELLOW "Removing directory: $CONFIG_DIR"
        rm -rf "$CONFIG_DIR"
        print_status $GREEN "✓ Removed: $CONFIG_DIR"
    else
        print_status $YELLOW "⚠ Config directory not found: $CONFIG_DIR"
    fi
}

# Reset Claude Code settings
reset_claude_settings() {
    print_status $BLUE "Resetting Claude Code to original state..."

    local settings_file="$CLAUDE_DIR/settings.json"

    if [[ -f "$settings_file" ]]; then
        # Create backup before removing
        local backup_file="$CONFIG_DIR/settings_backup_uninstall_$(date +%Y%m%d_%H%M%S).json"
        if [[ -d "$CONFIG_DIR" ]]; then
            cp "$settings_file" "$backup_file"
            print_status $GREEN "✓ Backup created: $backup_file"
        fi

        rm "$settings_file"
        print_status $GREEN "✓ Removed Claude Code settings file"
        print_status $CYAN "Claude Code will use original configuration"
    else
        print_status $YELLOW "⚠ No Claude Code settings file found"
    fi
}

# Clean up PATH from shell configs
cleanup_path() {
    print_status $BLUE "Checking shell configurations for PATH cleanup..."

    local shell_configs=(
        "$HOME/.bashrc"
        "$HOME/.bash_profile"
        "$HOME/.zshrc"
        "$HOME/.profile"
    )

    local path_entry="export PATH=\"\$PATH:$HOME/.local/bin\""
    local found=false

    for config in "${shell_configs[@]}"; do
        if [[ -f "$config" ]]; then
            if grep -q "$path_entry" "$config"; then
                print_status $YELLOW "Found CCM PATH entry in: $config"
                print_status $CYAN "You may want to manually remove this line:"
                print_status $CYAN "  $path_entry"
                found=true
            fi
        fi
    done

    if [[ "$found" == false ]]; then
        print_status $GREEN "✓ No PATH cleanup needed"
    fi
}

# Show summary of what will be removed
show_summary() {
    print_status $CYAN "=== Uninstall Summary ==="
    echo

    local remove_script=false
    local remove_configs=false
    local reset_claude=false

    if [[ "$CONFIG_ONLY" != true ]]; then
        if [[ -f "$CCM_SCRIPT" ]]; then
            print_status $RED "  • Script: $CCM_SCRIPT"
            remove_script=true
        fi
    fi

    if [[ "$SCRIPT_ONLY" != true ]]; then
        if [[ -d "$CONFIG_DIR" ]]; then
            print_status $RED "  • Configs: $CONFIG_DIR"
            remove_configs=true
        fi

        if [[ -f "$CLAUDE_DIR/settings.json" ]]; then
            print_status $RED "  • Claude settings: $CLAUDE_DIR/settings.json"
            reset_claude=true
        fi
    fi

    echo

    if [[ "$remove_script" == false && "$remove_configs" == false && "$reset_claude" == false ]]; then
        print_status $GREEN "Nothing to uninstall!"
        return 1
    fi

    return 0
}

# Main uninstall function
uninstall() {
    print_status $CYAN "=== Claude Code Switcher Uninstaller ==="
    echo

    # Show what will be removed
    if ! show_summary; then
        exit 0
    fi

    # Ask for confirmation
    if ! confirm "Do you want to proceed with the uninstall?"; then
        print_status $YELLOW "Uninstall cancelled."
        exit 0
    fi

    echo

    # Perform uninstallation
    if [[ "$CONFIG_ONLY" != true ]]; then
        remove_script
    fi

    if [[ "$SCRIPT_ONLY" != true ]]; then
        remove_configs
        reset_claude_settings
    fi

    echo
    cleanup_path
    echo

    print_status $GREEN "🎉 CCM Uninstall completed successfully!"

    if [[ "$CONFIG_ONLY" != true ]]; then
        print_status $CYAN "You may need to restart your terminal or run:"
        print_status $CYAN "  source ~/.bashrc   # or ~/.zshrc"
    fi
}

# Parse command line arguments
FORCE=false
CONFIG_ONLY=false
SCRIPT_ONLY=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --help|-h)
            show_help
            exit 0
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --config-only)
            CONFIG_ONLY=true
            shift
            ;;
        --script-only)
            SCRIPT_ONLY=true
            shift
            ;;
        *)
            print_status $RED "Error: Unknown option '$1'"
            echo
            show_help
            exit 1
            ;;
    esac
done

# Check for conflicting options
if [[ "$CONFIG_ONLY" == true && "$SCRIPT_ONLY" == true ]]; then
    print_status $RED "Error: --config-only and --script-only cannot be used together"
    exit 1
fi

# Run uninstall
uninstall
