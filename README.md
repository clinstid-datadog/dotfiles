# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/), with automatic live sync of Claude Code configuration across machines via a background daemon.

## What's managed

| Files | Target |
|---|---|
| `dot_zshrc`, `dot_zshrc.*` | `~/.zshrc`, `~/.zshrc.{macos,linux,helpers,aliases,dd,tokens}` |
| `dot_gitconfig.tmpl` | `~/.gitconfig` |
| `dot_gitignore` | `~/.gitignore` |
| `dot_tmux.conf.tmpl` | `~/.tmux.conf` |
| `dot_vimrc`, `dot_vimrc-coc` | `~/.vimrc`, `~/.vimrc-coc` |
| `dot_p10k.zsh` | `~/.p10k.zsh` |
| `dot_config/nvim/` | `~/.config/nvim/` |
| `dot_config/btop/` | `~/.config/btop/` |
| `dot_vim/ftplugin/` | `~/.vim/ftplugin/` |
| `dot_claude/` | `~/.claude/` (settings, CLAUDE.md, commands, skills, memory) |
| `private_Library/LaunchAgents/com.chris.claude-sync.plist` | `~/Library/LaunchAgents/` (macOS only) |
| `dot_config/systemd/user/claude-sync.service` | `~/.config/systemd/user/` (Linux only) |

Files prefixed `private_` are deployed with mode `0600`. The `private_dot_ssh/` and `private_Library/` directories preserve their `0700` permissions.

## Machine profiles

chezmoi auto-detects the machine type from the hostname — no manual configuration needed.

| Hostname pattern | `is_workspace` | Applied files |
|---|---|---|
| `ironman`, `warmachine`, etc. | `false` | Common + macOS files + launchd agent |
| `workspace-*` | `true` | Common + Linux files + systemd service |

## Claude Code sync

A background daemon (`claude-sync`) watches managed `~/.claude/` files and syncs them through this git repo:

- **Outbound**: when any managed file changes, `chezmoi re-add` captures it, then `git commit && git push`
- **Inbound**: every 60 seconds, `git pull --rebase && chezmoi apply`

Files synced across all machines: `settings.json`, `settings.local.json` (templated per machine type), `CLAUDE.md`, `commands/`, `skills/`, `static-app-patterns.md`.

Project memory directories (macOS only, since they encode absolute paths): `~/.claude/projects/*/memory/`.

Ephemeral Claude Code state (`history.jsonl`, `sessions/`, `plugins/`, `cache/`, etc.) is excluded from sync.

---

## Setup: macOS

### Prerequisites

```sh
brew install chezmoi fswatch
```

### First-time setup

```sh
# Clone the repo (if you don't have it already)
git clone git@github.com:clinstid-datadog/dotfiles.git ~/dotfiles

# Initialize chezmoi (auto-detects machine type from hostname)
chezmoi init --source ~/dotfiles

# Preview what chezmoi will change
chezmoi diff

# Apply
chezmoi apply
```

### Enable the auto-sync daemon

```sh
mkdir -p ~/.local/state/claude-sync

launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/com.chris.claude-sync.plist
```

Verify it's running:

```sh
launchctl list | grep claude-sync
tail -f ~/.local/state/claude-sync/err.log
```

### Stop the daemon

```sh
launchctl bootout "gui/$(id -u)/com.chris.claude-sync"
```

---

## Setup: workspace (Linux)

SSH into the workspace and run:

```sh
git clone git@github.com:clinstid-datadog/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

`install.sh` calls `scripts/setup-workspace.sh` which installs system packages, chezmoi, and applies the dotfiles. The `claude-sync` systemd service is enabled automatically.

Verify the sync service is running:

```sh
systemctl --user status claude-sync
journalctl --user -u claude-sync -f
```

---

## Day-to-day usage

### Apply remote changes locally

```sh
chezmoi update          # git pull + chezmoi apply in one command
```

### Add a new file to be managed

```sh
chezmoi add ~/.some-new-config
chezmoi re-add ~/.some-new-config   # after editing the installed file
```

### Edit a managed file

Either edit in-place and run `chezmoi re-add`, or edit the source directly:

```sh
chezmoi edit ~/.zshrc   # opens source file in $EDITOR
chezmoi apply           # deploy changes
```

### Check what's out of sync

```sh
chezmoi diff
chezmoi status
```

### Push a manual change

```sh
cd ~/dotfiles
git add -A
git commit -m "..."
git push
```

The sync daemon on other machines will pick it up within 60 seconds.

### Add a new Claude memory directory to sync

When a new project gets a `memory/` directory you want synced, add it manually:

```sh
chezmoi add ~/.claude/projects/<project-dir>/memory/
cd ~/dotfiles
git add -A && git commit -m "sync: add <project> memory"
git push
```

Also add the new paths to the `MANAGED_DIRS` array in `dot_local/bin/executable_claude-sync.tmpl` so the daemon watches it going forward.

---

## Repo structure

```
~/dotfiles/
├── .chezmoi.toml.tmpl          # chezmoi config template (auto-detects machine type)
├── .chezmoiignore              # excludes ephemeral files and platform-specific paths
├── .chezmoiscripts/            # run_onchange scripts (reload daemon on config change)
├── scripts/
│   └── setup-workspace.sh      # Linux workspace bootstrap script
├── install.sh                  # entry point (calls setup-workspace.sh)
├── dot_claude/                 # ~/.claude/ managed files
│   ├── settings.json
│   ├── settings.local.json.tmpl
│   ├── CLAUDE.md
│   ├── commands/
│   ├── skills/
│   └── projects/*/memory/
├── dot_config/
│   ├── nvim/                   # neovim config
│   ├── btop/
│   └── systemd/user/           # Linux systemd service (workspaces only)
├── dot_local/bin/
│   └── executable_claude-sync.tmpl   # sync daemon script
├── private_Library/LaunchAgents/     # macOS launchd agent (macOS only)
└── dot_zshrc, dot_gitconfig.tmpl, etc.
```
