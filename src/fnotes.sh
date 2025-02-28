#!/bin/bash

# fnotes - Simple markdown notes manager
# Autor: Iñigo Ochoa
# Fecha: 28/02/2025

# Check requirements
check_requirements() {
    if ! command -v fzf &> /dev/null; then
        echo "Error: fzf is not installed."
        return 1
    fi

    if ! command -v bat &> /dev/null; then
        echo "Error: bat is not installed."
        return 1
    fi

    # Check if there is a trash can tool available (optional)
    if ! command -v gio &> /dev/null && ! command -v trash-put &> /dev/null; then
        echo "Note: 'gio' and 'trash-cli' have not been detected. The internal trash will be used."
        echo "To use the system trash, install 'gio' or 'trash-cli'."
        echo ""
    fi

    return 0
}

# Load configuration
load_config() {
    CONFIG_DIR="$HOME/.config/fnotes"
    CONFIG_FILE="$CONFIG_DIR/config"

    # Default values
    EDITOR="nano"
    NOTES_DIR="$HOME/fnotes"
    DATE_FORMAT="%m/%d/%Y"

    # Default template
    DEFAULT_TEMPLATE="# %TITLE%\n\nDate: %DATE%\n\n"
    TEMPLATE="$DEFAULT_TEMPLATE"

    # Create configuration directory if it does not exist
    if [ ! -d "$CONFIG_DIR" ]; then
        mkdir -p "$CONFIG_DIR"
    fi

    # Create notes directory if it doesn't exist
    if [ ! -d "$NOTES_DIR" ]; then
        mkdir -p "$NOTES_DIR"
    fi

    # Read configuration if exists
    if [ -f "$CONFIG_FILE" ]; then
        # Read editor
        if grep -q "^editor=" "$CONFIG_FILE"; then
            EDITOR=$(grep "^editor=" "$CONFIG_FILE" | cut -d= -f2)
        fi

        # Read notes directory
        if grep -q "^notes_dir=" "$CONFIG_FILE"; then
            NOTES_DIR=$(grep "^notes_dir=" "$CONFIG_FILE" | cut -d= -f2)
            # Expand ~ if present
            NOTES_DIR="${NOTES_DIR/#\~/$HOME}"
            # Create directory if it does not exist
            if [ ! -d "$NOTES_DIR" ]; then
                mkdir -p "$NOTES_DIR"
            fi
        fi

        # Read date format
        if grep -q "^date_format=" "$CONFIG_FILE"; then
            DATE_FORMAT=$(grep "^date_format=" "$CONFIG_FILE" | cut -d= -f2)
        fi
    else
        # Create configuration file with default values
        cat > "$CONFIG_FILE" << EOF
# Setting up fnotes
editor=$EDITOR
notes_dir=~/fnotes
date_format=$DATE_FORMAT
EOF
    fi
}

# Create a new note
create_note() {
    echo "Creating a new note..."

    # Solicitar nombre de la nota
    read -p "Name of the note (without extension): " note_name

    if [ -z "$note_name" ]; then
        echo "Error: Note name cannot be empty."
        return 1
    fi

    # Add .md extension if not present
    if [[ "$note_name" != *.md ]]; then
        note_name="$note_name.md"
    fi

    note_path="$NOTES_DIR/$note_name"

    # Verificar si la nota ya existe
    if [ -f "$note_path" ]; then
        echo "Error: The note already exists."
        return 1
    fi

    # Ask if the template is used
    read -p "Use template? (y/n): " use_template

    if [[ "$use_template" =~ ^[Ss]$ ]]; then
        # Extract the title of the note (without extension)
        title="${note_name%.md}"

        # Replace variables in the template
        content="${DEFAULT_TEMPLATE//%TITLE%/$title}"
        content="${content//%DATE%/$(date +"$DATE_FORMAT")}"

        # Create the note with the template
        echo -e "$content" > "$note_path"
    else
        # Create an empty note
        touch "$note_path"
    fi

    echo "Note created in: $note_path"

    # Open the note in the editor
    $EDITOR "$note_path"
}

# Delete a note
delete_note() {
    echo "Select a note to delete:"

    # List notes to delete
    selected_note=$(find "$NOTES_DIR" -maxdepth 1 -type f -name "*.md" | sort | fzf --preview "bat --color=always --style=plain {}" --preview-window=right:70%)

    if [ -z "$selected_note" ]; then
        echo "No notes selected."
        return 0
    fi

    # Confirm deletion
    note_name=$(basename "$selected_note")
    read -p "Are you sure you want to delete '$note_name'? (y/n): " confirm

    if [[ "$confirm" =~ ^[Ss]$ ]]; then
        # Check if gio is available (for system trash)
        if command -v gio &> /dev/null; then
            gio trash "$selected_note"
            echo "Note moved to system trash: $note_name"
        # Alternative with trash-cli if available
        elif command -v trash-put &> /dev/null; then
            trash-put "$selected_note"
            echo "Note moved to system trash: $note_name"
        # Alternative with internal waste bin
        else
            # Create internal trash directory if it doesn't exist
            TRASH_DIR="$NOTES_DIR/.trash"
            if [ ! -d "$TRASH_DIR" ]; then
                mkdir -p "$TRASH_DIR"
            fi

            # Move to internal trash with timestamp
            timestamp=$(date +"%Y%m%d%H%M%S")
            mv "$selected_note" "$TRASH_DIR/${timestamp}_${note_name}"
            echo "Note moved to internal trash: $TRASH_DIR/${timestamp}_${note_name}"
            echo "Note: Install 'gio' or 'trash-cli' to use the system trash."
        fi
    else
        echo "Operation cancelled."
    fi
}

# List and open notes
list_notes() {
    echo "Select a note to open:"

    # Check for notes
    if [ -z "$(find "$NOTES_DIR" -maxdepth 1 -type f -name "*.md" 2>/dev/null)" ]; then
        echo "No notes available. Create a new note with 'fnotes new'"
        return 0
    fi

    # Using fzf to select a note with preview using bat
    selected_note=$(find "$NOTES_DIR" -maxdepth 1 -type f -name "*.md" | sort | fzf --preview "bat --color=always --style=plain {}" --preview-window=right:70%)

    if [ -z "$selected_note" ]; then
        echo "No notes selected."
        return 0
    fi

    # Open the selected note in the configured editor
    $EDITOR "$selected_note"
}

# Main function
fnotes() {
    # Check requirements
    if ! check_requirements; then
        return 1
    fi

    # Load configuration
    load_config

    # Processing arguments
    case "$1" in
        "new" | "n")
            create_note
            ;;
        "delete" | "d" | "rm")
            delete_note
            ;;
        "list" | "ls" | "")
            list_notes
            ;;
        "help" | "h" | "--help" | "-h")
            echo "Usage: fnotes [command]"
            echo ""
            echo "Commands:"
            echo "  new, n       Create a new note"
            echo "  delete, d    Delete a note (move to trash)"
            echo "  list, ls     List and open notes (default)"
            echo "  help, h      Show this help"
            ;;
        *)
            echo "Unknown command: $1"
            echo "Use 'fnotes help' to see the available commands."
            return 1
            ;;
    esac
}

# Execute the main function with the provided arguments
fnotes "$@"
