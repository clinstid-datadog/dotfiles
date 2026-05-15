---
name: Git branch naming convention
description: Branch names must use chris.linstid/ prefix, not clinstid/ or other shorthand
type: feedback
originSessionId: 575b9faa-5eb6-42e9-a9df-fb8330a6972e
---
Always use `chris.linstid/` as the branch prefix, never `clinstid/` or any other shorthand.

Templates:
- General: `chris.linstid/{description-of-work}`
- With Jira ticket: `chris.linstid/{JIRA-TICKET}/{description-of-work}`

**Why:** This is explicitly documented in the personal CLAUDE.md at `~/dd/experimental/users/chris.linstid/claude/CLAUDE.md`.

**How to apply:** Every time a new git branch is created, check the prefix before running the command.
