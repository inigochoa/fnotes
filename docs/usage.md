# fnotes - User Guide

This guide details how to use fnotes to manage your markdown notes.

## Basic Commands

### Create a new note

```bash
fnotes new
# or
fnotes n
```

When creating a new note:
1. You will be asked for a name for the note (the .md extension will be added
  automatically if you don't include it)
2. You will be asked if you want to use the predefined template
3. If you choose to use the template, a note will be created with a title and
  date
4. The note will automatically open in your configured editor

### List and open notes

```bash
fnotes list
# or
fnotes ls
# or
fnotes
```

When listing notes:
1. You will see an interactive picker with all your notes using fzf
2. The preview of each note will be displayed on the right using bat
3. You can search by typing part of the name
4. When selecting a note, it will open in your configured editor

### Delete a note

```bash
fnotes delete
# or
fnotes d
```

When deleting a note:
1. You will be shown a picker with all your notes
2. Select the note you want to delete
3. Confirm the deletion
4. The note will be moved to the system trash (or an internal trash if one is
  not available)

## Tips and Tricks

### Navigation in fzf

- Use the arrow keys to move through the list
- Type to filter the list
- Press `Enter` to select
- Press `Esc` or `Ctrl+C` to cancel

### Visualization with bat

Bat displays notes with Markdown syntax highlighting, making it easy to see:
- Titles and headings
- Bold and italic text
- Lists
- Links
- Code blocks

### Recover deleted notes

If you are using the system trash:
1. Open your system trash
2. Find your deleted notes
3. Restore the ones you need

If you're using the internal trash:
1. Deleted notes are located in `~/fnotes/.trash` (or whatever path you've set)
2. They have a date/time prefix to identify them
3. You can manually copy them back to your notes directory
