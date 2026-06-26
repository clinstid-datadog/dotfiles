# Dotfiles — Instructions for Claude

## Overview

Dotfiles are managed with [chezmoi](https://www.chezmoi.io/). The source directory is `~/dotfiles`
(this repo). chezmoi copies/templates files to their installed locations — the repo files and
installed files are separate copies.

Files in the repo use chezmoi naming conventions:
- `dot_foo` → `~/.foo`
- `dot_config/bar/` → `~/.config/bar/`
- `private_dot_foo` → `~/.foo` (deployed with mode `0600`)
- `foo.tmpl` → templated file (chezmoi renders before deploying)

## Machine detection

chezmoi auto-detects the machine type from the OS — no profile flags needed.

| OS    | `is_workspace` | Notes                          |
|-------|----------------|--------------------------------|
| macOS | `false`        | Common + macOS-specific files  |
| Linux | `true`         | Common + Linux-specific files  |

## Workflow: syncing changes back to the repo

When dotfiles have been modified at their installed locations, use chezmoi to sync them back before
committing.

### 1. See what changed

```sh
chezmoi diff     # shows diff between repo source and installed files
chezmoi status   # shows which files differ
```

### 2. Sync changes back to the repo

**For existing tracked files:**

```sh
chezmoi re-add ~/.some-file
```

**For new files not yet tracked:**

```sh
chezmoi add ~/.some-new-file
```

### 3. Verify

```sh
chezmoi diff
```

Should show no differences for the updated files.

## Templated files

Templated files have a `.tmpl` suffix in the repo (e.g. `dot_gitconfig.tmpl`,
`dot_tmux.conf.tmpl`). chezmoi renders them before deploying, so the installed file contains the
rendered output with template directives resolved.

**`chezmoi re-add` cannot be used on templated files** — it would overwrite the template with the
rendered version, destroying the template logic.

For templated files, either:
- Edit the template directly in the repo (`~/dotfiles/` directory), or
- Run `chezmoi diff` to see what changed in the installed file, then manually apply those changes
  to the template.

Currently templated files in this repo:

- `dot_gitconfig.tmpl` — uses `{{ if .is_workspace }}` to set different git config per machine type
- `dot_tmux.conf.tmpl` — uses `{{ if .is_workspace }}` for workspace-specific settings
- `dot_claude/settings.local.json.tmpl` — per-machine Claude Code settings
- `dot_local/bin/executable_claude-sync.tmpl` — the claude-sync daemon script

## Workflow: committing and pushing

This is a single-user repo — commit directly to `main`.

```sh
cd ~/dotfiles
git add <files>
git commit -m "Description of changes"
git push
```

Note: the `claude-sync` daemon automatically commits and pushes changes to managed `~/.claude/`
files. For all other dotfiles, commit manually after running `chezmoi re-add`.

## Key file mapping

| Repo path                        | Installed path               | Templated |
|----------------------------------|------------------------------|-----------|
| `dot_zshrc`                      | `~/.zshrc`                   | No        |
| `dot_gitconfig.tmpl`             | `~/.gitconfig`               | Yes       |
| `dot_tmux.conf.tmpl`             | `~/.tmux.conf`               | Yes       |
| `dot_vimrc`                      | `~/.vimrc`                   | No        |
| `dot_p10k.zsh`                   | `~/.p10k.zsh`                | No        |
| `dot_config/nvim/`               | `~/.config/nvim/`            | No        |
| `dot_claude/`                    | `~/.claude/`                 | Partial   |
| `private_dot_ssh/`               | `~/.ssh/`                    | No        |
