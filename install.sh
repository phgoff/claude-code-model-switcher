#!/bin/bash

# Claude Code Switcher (CCM) Installation Script
VERSION="1.2.0"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration paths
CONFIG_DIR="$HOME/.ccm"
CONFIG_FILE="$CONFIG_DIR/configs.json"
REPO_DIR="$CONFIG_DIR/repo"
REPO_URL="https://github.com/phgoff/claude-code-model-switcher.git"

# Installation directory
INSTALL_DIR="$HOME/.local/bin"
CCM_SCRIPT="$REPO_DIR/ccm"

# Print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Clone or update the repository
print_status $BLUE "Setting up CCM repository..."

if [[ -d "$REPO_DIR" ]]; then
    print_status $YELLOW "Repository already exists at $REPO_DIR"
    print_status $CYAN "Updating..."
    cd "$REPO_DIR" && git pull -q
    print_status $GREEN "✓ Repository updated"
else
    print_status $CYAN "Cloning repository from GitHub..."
    git clone -q "$REPO_URL" "$REPO_DIR"
    print_status $GREEN "✓ Repository cloned to $REPO_DIR"
fi

# Check if script exists
if [[ ! -f "$CCM_SCRIPT" ]]; then
    print_status $RED "Error: ccm script not found in $REPO_DIR"
    exit 1
fi

# Create installation directory if it doesn't exist
if [[ ! -d "$INSTALL_DIR" ]]; then
    mkdir -p "$INSTALL_DIR"
    print_status $BLUE "Created installation directory: $INSTALL_DIR"
fi

# Copy script to installation directory
cp "$CCM_SCRIPT" "$INSTALL_DIR/ccm"
chmod +x "$INSTALL_DIR/ccm"

print_status $GREEN "✓ CCM script installed to: $INSTALL_DIR/ccm"

# Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    print_status $YELLOW "⚠ Warning: $INSTALL_DIR is not in your PATH"
    echo
    print_status $CYAN "To add it to your PATH, run one of the following:"
    echo
    print_status $BLUE "For bash (add to ~/.bashrc):"
    echo "  echo 'export PATH=\"\$PATH:$INSTALL_DIR\"' >> ~/.bashrc"
    echo
    print_status $BLUE "For zsh (add to ~/.zshrc):"
    echo "  echo 'export PATH=\"\$PATH:$INSTALL_DIR\"' >> ~/.zshrc"
    echo
    print_status $BLUE "For fish (add to ~/.config/fish/config.fish):"
    echo "  echo 'set -gx PATH \$PATH $INSTALL_DIR' >> ~/.config/fish/config.fish"
    echo
    print_status $YELLOW "Then restart your terminal or run: source ~/.bashrc (or ~/.zshrc)"
else
    print_status $GREEN "✓ $INSTALL_DIR is already in your PATH"
fi

# Check dependencies
echo
print_status $BLUE "Checking dependencies..."

if command -v jq &> /dev/null; then
    print_status $GREEN "✓ jq is installed"
else
    print_status $YELLOW "⚠ jq is not installed (optional but recommended)"
    print_status $CYAN "Install jq with:"
    echo "  macOS: brew install jq"
    echo "  Ubuntu: sudo apt-get install jq"
    echo "  CentOS: sudo yum install jq"
fi

# Test installation
echo
print_status $BLUE "Testing installation..."

if "$INSTALL_DIR/ccm" help &> /dev/null; then
    print_status $GREEN "✓ CCM is working correctly!"
    echo

    # Create default configs.json if it doesn't exist
    if [[ ! -f "$CONFIG_FILE" ]]; then
        print_status $BLUE "Creating default configuration..."
        mkdir -p "$CONFIG_DIR"
        cat > "$CONFIG_FILE" << 'EOF'
{
  "current_model": "original",
  "available_models": {
    "example": {
      "haiku_model": "example-haiku",
      "sonnet_model": "example-sonnet",
      "opus_model": "example-opus",
      "base_url": "https://api.example.com",
      "auth_token": "your-token-here"
    }
  }
}
EOF
        print_status $GREEN "✓ Created default configs.json at $CONFIG_FILE"
        print_status $YELLOW "Please edit this file to add your actual model configurations."
    fi

    print_status $CYAN "You can now use CCM with:"
    echo "  ccm <model>       # Switch to specified model"
    echo "  ccm status        # Show current status"
    echo "  ccm list          # List available models"
    echo "  ccm reload        # Reload current model from configs.json"
    echo "  ccm reset         # Reset to original Claude Code"
    echo "  ccm config        # Open config file in editor"
    echo "  ccm update        # Update to latest version"
    echo "  ccm version       # Show version"
    echo "  ccm help          # Show help"
else
    print_status $RED "✗ Installation test failed"
    exit 1
fi

echo
print_status $GREEN "🎉 Installation completed successfully!"
