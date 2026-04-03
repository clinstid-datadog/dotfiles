# Dotfiles — Instructions for Claude

## Overview

Dotfiles are managed with [dotdrop](https://dotdrop.readthedocs.io/en/latest/). The config is at
`config.yaml`. Dotdrop uses `nolink` mode — it **copies** files rather than symlinking, so the
installed files (e.g. `~/.config/nvim/init.lua`) and the repo files
(e.g. `dotfiles/config/nvim/init.lua`) are separate copies.

All dotdrop commands should be run from the root of this repo.

## Profiles

Profiles are defined in `config.yaml`. Check `config.yaml` to find the right profile — machine
profiles are typically named after hostnames (e.g. `chris-linstid-blue-0`) and inherit from a
parent profile like `workspace`. If the hostname doesn't match a profile directly, use the parent
profile (e.g. `workspace`). Specify the profile with `-p <profile>` on all dotdrop commands.

## Workflow: syncing changes back to the repo

When dotfiles have been modified at their installed locations, use dotdrop to sync them back before
committing.

### 1. See what changed

```sh
dotdrop compare -p <profile>
```

### 2. Sync changes back to the repo

**For existing tracked files**, use `dotdrop update`:

```sh
# Preview
dotdrop update -p <profile> -k <key> --dry

# Apply
dotdrop update -p <profile> -k <key>

# By installed path instead of key
dotdrop update -p <profile> <installed-path>
```

**For new files or directories** that aren't yet tracked (even if they live inside a tracked
directory like `d_nvim`), `dotdrop update` will NOT pick them up. Use `dotdrop import` instead:

```sh
# Preview
dotdrop import -p <profile> <installed-path> --dry

# Apply
dotdrop import -p <profile> <installed-path>
```

`dotdrop import` copies the file/directory into the repo and adds a new entry to `config.yaml`
for the current profile. Review `config.yaml` after importing to confirm the new key and profile
assignment look correct.

### 3. Verify

```sh
dotdrop compare -p <profile>
```

Should show no differences for the updated files.

## Templated files

Some files use Jinja2 templating with dotdrop's custom delimiters (`{{@@ ... @@}}` for variables,
`{%@@ ... @@%}` for control flow). Currently templated files in this repo:

- `dotfiles/gitconfig` — uses `{%@@ if is_workspace @@%}` to set different git config per host
- `dotfiles/tmux.conf` — uses `{%@@ if is_workspace @@%}` for workspace-specific settings

**`dotdrop update` cannot be used on templated files.** The installed file contains rendered output
(template directives resolved), so running update would overwrite the template with the rendered
version, destroying the template logic.

For templated files, either:
- Edit the template directly in the repo (`dotfiles/` directory), or
- Use `dotdrop update -p <profile> -k <key> --show-patch` to generate a diff of what changed in
  the installed file, then manually apply those changes to the template in the repo.

## Workflow: committing and pushing

This is a single-user repo — commit directly to `main`.

```sh
git add <files>
git commit -m "Description of changes"
git push
```

## Key dotfile keys (from config.yaml)

| Key           | Installed path      | Repo path                    | Templated |
|---------------|---------------------|------------------------------|-----------|
| `d_nvim`      | `~/.config/nvim/`   | `dotfiles/config/nvim/`      | No        |
| `f_zshrc`     | `~/.zshrc`          | `dotfiles/zshrc`             | No        |
| `f_tmux.conf` | `~/.tmux.conf`      | `dotfiles/tmux.conf`         | Yes       |
| `f_gitconfig` | `~/.gitconfig`      | `dotfiles/gitconfig`         | Yes       |

See `config.yaml` for the full list.
