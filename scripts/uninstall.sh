#!/bin/bash

# uninstall.sh - Script to uninstall fnotes

# Colors for a clearer output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Uninstalling fnotes ===${NC}"

# Ask if you want to keep the data
read -p "Do you want to keep your notes and settings? (y/n): " keep_data
if [[ "$keep_data" =~ ^[Nn]$ ]]; then
    # Erase data and settings
    echo "Deleting settings and notes..."
    rm -rf ~/.config/fnotes

    # Only delete the notes directory if it is the default one
    if [ -f ~/.config/fnotes/config ]; then
        # Try to read the configured location of the notes
        configured_dir=$(grep "^notes_dir=" ~/.config/fnotes/config | cut -d= -f2)
        if [ -n "$configured_dir" ]; then
            # Expand ~ if present
            eval configured_dir=$configured_dir
            echo "Removing notes directory: $configured_dir"
            rm -rf "$configured_dir"
        else
            # If the configuration cannot be read, ask about the default directory
            read -p "Remove default notes directory (~/fnotes)? (y/n): " remove_default
            if [[ "$remove_default" =~ ^[Ss]$ ]]; then
                rm -rf ~/fnotes
            fi
        fi
    else
        # If there is no configuration file, ask about the default directory
        read -p "Remove default notes directory (~/fnotes)? (y/n): " remove_default
        if [[ "$remove_default" =~ ^[Ss]$ ]]; then
            rm -rf ~/fnotes
        fi
    fi
else
    echo "Keeping notes and settings..."
fi

# Delete the script
echo "Removing the fnotes script..."
rm -f ~/.local/bin/fnotes

echo -e "${GREEN}fnotes has been uninstalled!${NC}"
echo ""
echo "To complete the uninstallation, restart your terminal"
