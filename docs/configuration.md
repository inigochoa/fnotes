# fnotes - Config guide

This document explains all the configuration options available for fnotes.

## Configuration File

fnotes uses a simple configuration file based on key=value pairs.

Location: `~/.config/fnotes/config`

## Configuration Options

### Date format

Defines how dates will be formatted in new notes.

```
date_format=%d/%m/%Y
```

Possible values:
- Any valid format for the Linux `date` command.
- Use `man date` to see all available options.

Common examples:
- `%d/%m/%Y`: 02/28/2025 (day/month/year)
- `%Y-%m-%d`: 2025-02-28 (ISO format)
- `%B %d, %Y`: February 28, 2025 (full month)
- `%a, %d %b %Y`: Fri, 28 Feb 2025 (short format)

Default: `%m/%d/%Y`

### Editor

Defines which editor will be used to open notes.

```
editor=nano
```

Possible values:
- Any editor installed on your system: `nano`, `vim`, `code`, `kate`, `gedit`,
  etc.

Default: `nano`

### Notes Directory

Define where your notes will be stored.

```
notes_dir=~/fnotes
```

Possible values:
- Any valid path where you have write permissions.
- You can use `~` to refer to your home directory.

Default: `~/fnotes`

## Template

The template for new notes is defined directly in the script and is used when
you choose the option to use template when creating a new note.

The default template is:

```
# %TITLE%

Date: %DATE%

```

Where:
- `%TITLE%` is replaced with the name of the note (without extension)
- `%DATE%` is replaced with the current date in MM/DD/YYYY format

## Full Configuration Example

```
# Setting up fnotes
date_format=%A, %d %B %Y
editor=nvim
notes_dir=~/fnotes
```

## Modify Settings

### Manually

You can edit the configuration file directly:

```bash
nano ~/.config/fnotes/config
```

## Reset Settings

If you want to return to the default settings, simply delete the configuration
file:

```bash
rm ~/.config/fnotes/config
```

The next time you run fnotes, a new configuration file will be created with the
default values.
