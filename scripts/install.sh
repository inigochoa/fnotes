#!/bin/bash

# install.sh - Installation script for fnotes
# This script downloads fnotes and configures it for use

# Colors for a clearer output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display error messages and exit
error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Welcome message
echo -e "${GREEN}=== fnotes installer ===${NC}"
echo "This script will install fnotes, a command-line markdown note manager."
echo ""

# Check requirements
echo "Checking requirements..."

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo -e "${YELLOW}Warning: fzf is not installed.${NC}"
    echo "fzf is required for fnotes to work."
    read -p "Continue installing fnotes anyway? (y/n): " continue_install
    [[ ! "$continue_install" =~ ^[Ss]$ ]] && error_exit "Installation aborted. Please install fzf and try again."
fi

# Check if bat is installed
if ! command -v bat &> /dev/null; then
    echo -e "${YELLOW}Warning: bat is not installed.${NC}"
    echo "bat is required for previewing notes in fnotes."
    read -p "Continue installing fnotes anyway? (y/n): " continue_install
    [[ ! "$continue_install" =~ ^[Ss]$ ]] && error_exit "Installation aborted. Please install fzf and try again."
fi

# Create directory ~/.local/bin if it does not exist
echo "Setting up directories..."
mkdir -p ~/.local/bin || error_exit "Could not create directory ~/.local/bin"

# Download fnotes
echo "Downloading fnotes..."
# fnotes url
FNOTES_URL="https://raw.githubusercontent.com/inigochoa/fnotes/main/src/fnotes.sh"

# Download the script from the repository
if ! curl -sSL "$FNOTES_URL" -o ~/.local/bin/fnotes; then
    error_exit "Failed to download fnotes. Please check your internet connection and the URL."
fi

# Verify that the download was successful
if [ ! -s ~/.local/bin/fnotes ]; then
    error_exit "fnotes download failed or the file is empty."
fi

# Make fnotes executable
chmod +x ~/.local/bin/fnotes || error_exit "Failed to make fnotes script executable"

# Create basic directory structure
mkdir -p ~/.config/fnotes || error_exit "Could not create configuration directory ~/.config/fnotes"
mkdir -p ~/fnotes || error_exit "Failed to create notes directory ~/fnotes"

# Final notes
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "fnotes has been installed in ~/.local/bin/fnotes"
echo ""
echo -e "To start using fnotes, restart your terminal"
echo ""
echo -e "Available commands:"
echo -e "  ${GREEN}fnotes new${NC} - Create a new note"
echo -e "  ${GREEN}fnotes list${NC} - List and open notes"
echo -e "  ${GREEN}fnotes delete${NC} - Delete a note"
echo -e "  ${GREEN}fnotes help${NC} - Show help"
echo ""
echo -e "To customize the settings, edit: ${YELLOW}~/.config/fnotes/config${NC}"
echo ""
echo -e "${YELLOW}Enjoy fnotes!${NC}"
