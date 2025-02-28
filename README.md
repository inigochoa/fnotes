# fnotes

A simple command-line markdown note manager for Linux systems.

## Features

- Create, list, and manage markdown notes from the terminal
- Interactive selection using fzf with preview support
- Configurable editor and notes directory
- Default template for new notes
- Trashcan functionality for deleted notes

## Requirements

- fzf (for interactive note selection)
- bat (for note preview)
- Linux environment with bash

## Installation

### Quick Installation (Recommended)

Install fnotes with a single command:

```bash
curl -sSL https://raw.githubusercontent.com/inigochoa/fnotes/refs/heads/main/scripts/install.sh | bash
```

This installer will:
- Download fnotes to your ~/.local/bin directory
- Set up necessary configurations
- Add fnotes to your PATH
- Create required directories
- Check for dependencies
- Configure your shell to load fnotes

After installation, restart your terminal or run `source ~/.bashrc` (or `~/.zshrc` for Zsh users) to start using fnotes.

### Manual Installation

If you prefer manual installation:

1. Download the script:

```bash
curl -o ~/.local/bin/fnotes https://raw.githubusercontent.com/inigochoa/fnotes/main/fnotes
```

2. Make the script executable:

```bash
chmod +x ~/.local/bin/fnotes
```

3. Add to your PATH (if ~/.local/bin is not already in your PATH):

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

4. Load the function:

```bash
echo 'source ~/.local/bin/fnotes' >> ~/.bashrc
```

5. Restart your terminal or source your bashrc file:

```bash
source ~/.bashrc
```

## Usage

```
fnotes [command]
```

### Commands

- `new` or `n`: Create a new note
- `delete` or `d`: Delete a note (moves to trash)
- `list` or `ls`: List notes (default if no command provided)
- `help` or `h`: Show help message

### Examples

```bash
# Create a new note
fnotes new

# List and open a note
fnotes list

# Delete a note
fnotes delete

# Simply run fnotes to list notes
fnotes
```

## Configuration

Configuration file is stored at `~/.config/fnotes/config` and is created automatically on first run.

### Example configuration:

```
# Configuration for fnotes
editor=vim
notes_dir=~/Documents/notes
```

### Configuration options

- `editor`: The editor to use for opening notes (default: nano)
- `notes_dir`: Directory to store notes (default: ~/fnotes)

## Template

The default template for new notes is defined in the script:

```
# %TITLE%

Date: %DATE%

```

To modify the template, edit the `DEFAULT_TEMPLATE` variable in the script.

## Directory Structure

- `~/fnotes`: Default directory for storing notes
- `~/fnotes/.trash`: Trash directory for deleted notes
- `~/.config/fnotes`: Configuration directory

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
