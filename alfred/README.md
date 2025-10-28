# Alfred Configuration

This directory manages Alfred app preferences, workflows, and settings.

## Setup Method

Alfred supports setting a custom sync folder to store all preferences, workflows, snippets, and themes. This dotfiles repo uses that approach.

### Initial Setup (On Your Main Machine)

1. Open Alfred Preferences
2. Go to **Advanced** tab
3. Click **Set preferences folder...**
4. Choose: `~/dotfiles/alfred/Alfred.alfredpreferences`
5. Alfred will move all your settings to this folder
6. Commit the `Alfred.alfredpreferences` folder to this repo

### Setup on New Machine

Run the bootstrap script which will:
- Set Alfred's sync folder to this directory
- Alfred will automatically load all preferences

## What Gets Synced

When using Alfred's sync folder, the following are automatically synced:

- **Preferences** - All Alfred settings
- **Workflows** - All installed workflows (built-in and custom)
- **Snippets** - Text expansion snippets
- **Themes** - Custom themes
- **Clipboard History** - Optional (can be excluded)
- **Hotkeys** - Keyboard shortcuts

## Privacy Considerations

Alfred's sync folder may contain:
- Recent searches
- Clipboard history (if enabled)
- Workflow data that might include API keys

**Recommendation:** Review `.gitignore` to exclude sensitive data if needed.

## Workflows Directory

If you prefer to manage workflows separately:
- Export workflows as `.alfredworkflow` files
- Place them in `workflows/` subdirectory
- Update bootstrap to import them

## Usage

After running bootstrap, open Alfred and all your preferences should be loaded automatically.
