# Jujutsu Workflow Tool

A powerful workflow management tool for Jujutsu (jj) that provides Git-like branch workflows using workspaces. This tool enables you to work on multiple features in parallel, each in their own isolated workspace with color-coded VSCode windows.

## Features

- **Isolated Workspaces**: Create separate working directories for each feature
- **Color-Coded VSCode Windows**: Each workspace gets a unique color theme for easy identification
- **Selective Merging**: Merge all commits or cherry-pick specific ones
- **Linear History**: Rebase-based workflow for clean, linear commit history
- **Project-Specific Setup**: Extensible setup hooks for custom initialization
- **Multi-Workspace Support**: Work on multiple features simultaneously

## Installation

1. Clone this repository

2. Add VSCode terminal integration to your shell RC file (`.bashrc` or `.zshrc`):

   **For bash (~/.bashrc):**
   ```bash
   # VSCode terminal integration - load workflow tools
   if [ "$TERM_PROGRAM" = "vscode" ]; then
       source /path/to/workflow/etc/shell-init.bash
       register_tools "/path/to/workflow"
       register_tools "$(pwd)"
   fi
   ```

   **For zsh (~/.zshrc):**
   ```bash
   # VSCode terminal integration - load workflow tools
   if [ "$TERM_PROGRAM" = "vscode" ]; then
       source /path/to/workflow/etc/shell-init.zsh
       register_tools "/path/to/workflow"
       register_tools "$(pwd)"
   fi
   ```

   This setup:
   - Only loads in VSCode terminals (not other terminals)
   - Sources the shell completion and commands
   - Registers workflow tools from the installation directory
   - Registers project-specific tools from the current directory

## Quick Start

```bash
# Create a new feature workspace
workflow create my-feature

# Make changes, commit as you go
jj commit -m "Add feature X"
jj commit -m "Add tests for X"

# Flatten all commits into one (optional)
workflow flatten my-feature "Add complete feature X with tests"

# Merge into main
workflow merge my-feature

# Push to remote
jj git push

# Clean up workspace
workflow delete my-feature
```

## Commands

### `workflow create <name>`

Creates a new workspace and opens it in VSCode with a unique color theme.

```bash
workflow create authentication
```

This will:
- Create a new jj workspace at `.jj-workspaces/<name>`
- Generate a unique color theme for the workspace
- Create a VSCode workspace file
- Run any project-specific setup (from `etc/setup.sh`)
- Open the workspace in a new VSCode window

### `workflow open <name>`

Opens an existing workspace in VSCode.

```bash
workflow open authentication
```

### `workflow merge <name> [commit-ids...]`

Merges workspace changes into main.

**Merge all commits:**
```bash
workflow merge authentication
```

**Merge specific commits only:**
```bash
# First, view commits in your workspace
jj log -r 'authentication@ ~ main'

# Then merge only the ones you want
workflow merge authentication abc123 def456
```

The merge process:
- Rebases commits onto main (preserving individual commits)
- Updates main bookmark to point to the merged commits
- Updates git HEAD to main
- Keeps workspace in sync

### `workflow sync <name>`

Syncs a workspace with the latest main branch.

```bash
workflow sync authentication
```

Use this when:
- Main has been updated and you want the latest changes
- Before merging to ensure clean rebase

### `workflow flatten <name> "message"`

Squashes all commits in a workspace into a single commit with a new message.

```bash
workflow flatten authentication "Add JWT authentication system with tests"
```

This is useful for:
- Cleaning up messy commit history before merging
- Creating atomic commits for review
- Simplifying your feature's story

### `workflow delete <name>`

Deletes a workspace (only if it has no unmerged commits).

```bash
workflow delete authentication
```

Safety checks:
- Won't delete if workspace has commits ahead of main
- Removes both the workspace directory and VSCode workspace file

### `workflow workspaces`

Lists all workspaces in the repository.

```bash
workflow workspaces
```

### `workflow files [revision]`

Shows modified files in a revision (defaults to current workspace).

```bash
# Show files in current workspace
workflow files

# Show files in specific revision
workflow files authentication@
```

## Workflows

### Single Feature Development

```bash
# 1. Create workspace
workflow create user-profile

# 2. Make changes and commit
jj commit -m "Add user profile model"
jj commit -m "Add profile API endpoints"
jj commit -m "Add profile UI"

# 3. Sync with main if needed
workflow sync user-profile

# 4. Optionally flatten commits
workflow flatten user-profile "Add complete user profile feature"

# 5. Merge to main
workflow merge user-profile

# 6. Push to remote
jj git push

# 7. Clean up
workflow delete user-profile
```

### Multi-Feature Development

Work on multiple features in parallel, each in its own VSCode window:

```bash
# Create multiple workspaces
workflow create feature-a
workflow create feature-b
workflow create feature-c

# Each opens in a different VSCode window with a unique color!
# Work on each independently

# Merge them in any order
workflow merge feature-a
jj git push

workflow merge feature-c
jj git push

workflow merge feature-b
jj git push
```

### Selective Merging

Sometimes you only want to merge specific commits from a workspace:

```bash
# Create and work in workspace
workflow create experiments

jj commit -m "Try approach A"
jj commit -m "Add useful utility function"
jj commit -m "Try approach B (didn't work)"
jj commit -m "Add another utility"

# View all commits
jj log -r 'experiments@ ~ main'

# Merge only the utility commits
workflow merge experiments <commit-id-utility-1> <commit-id-utility-2>
```

## Project-Specific Setup

You can customize workspace initialization by creating `etc/setup.sh` in your project root:

```bash
#!/bin/bash
# etc/setup.sh

workspace_path="$1"

echo "Running project setup for workspace at: $workspace_path"

# Example: Install dependencies
cd "$workspace_path"
npm install

# Example: Copy configuration
cp .env.example .env

# Example: Run database migrations
npm run migrate
```

The setup script receives the workspace path as its first argument and runs after workspace creation.

## VSCode Integration

Each workspace gets a unique color theme applied to:
- Title bar (active and inactive)
- Status bar
- Activity bar

This makes it easy to distinguish between multiple VSCode windows when working on different features.

The color is deterministically generated from the workspace name, so reopening a workspace always uses the same color.

## How It Works

### Workspace Structure

```
your-repo/
├── .jj/                          # Jujutsu metadata
├── .jj-workspaces/               # Workspace directory
│   ├── feature-a/                # Workspace working directory
│   ├── feature-a.code-workspace  # VSCode workspace file
│   ├── feature-b/
│   └── feature-b.code-workspace
└── etc/
    └── setup.sh                  # Optional setup script
```

### Jujutsu Concepts

- **Workspace**: A separate working directory attached to the same repository
- **Workspace Commit**: Each workspace has an empty working copy commit at its tip (e.g., `feature-a@`)
- **Revset**: Jujutsu's query language for specifying commits (e.g., `feature-a@ ~ main` means "commits in feature-a that are not in main")

### Merge Strategy

The tool uses a rebase-based merge strategy:

1. Rebase workspace commits onto main using `jj rebase -s workspace- -d main`
2. Move main bookmark to the tip of rebased commits
3. Update git HEAD to point to main

This creates a clean, linear history by replaying workspace commits on top of main. Individual commits and their messages are preserved. Conflicts are handled by jujutsu's first-class conflict support, allowing you to resolve them at your convenience.

## Tips and Best Practices

### Keep Workspaces Small

Workspaces are best for feature-sized work:
- ✅ Single feature or bug fix
- ✅ Related set of changes
- ❌ Long-running branches with many unrelated changes

### Sync Regularly

Keep your workspace in sync with main:
```bash
workflow sync my-feature
```

This prevents merge conflicts and keeps your workspace up to date.

### Use Flatten for Clean History

Before merging, consider flattening your commits:
```bash
workflow flatten my-feature "Add complete authentication system"
```

This creates a clean, atomic commit that's easier to review and revert if needed.

### Leverage Multiple Workspaces

Work on multiple features without switching contexts:
- Each workspace has its own working directory
- Each VSCode window has a unique color
- No need to stash or commit incomplete work

### Commit Often

With jj, commits are cheap and local:
```bash
jj commit -m "WIP: trying new approach"
```

You can always flatten them later before merging.

## Troubleshooting

### Workspace has uncommitted changes

```bash
# Commit the changes first
jj commit -m "Your message"

# Then merge
workflow merge my-feature
```

### Can't delete workspace

```bash
Error: Workspace has N commits ahead of main
```

This means the workspace has unmerged commits. Either:
- Merge them: `workflow merge my-feature`
- Abandon them: `jj abandon 'my-feature@ ~ main'`

### Merge conflicts

```bash
# After workflow merge shows conflicts
jj status  # See conflicted files

# Resolve conflicts manually, then
jj commit -m "Resolve conflicts"
```

## Comparison with Git

| Git Workflow | Jujutsu Workflow |
|-------------|------------------|
| `git checkout -b feature` | `workflow create feature` |
| `git checkout feature` | `workflow open feature` |
| `git checkout main && git merge feature` | `workflow merge feature` |
| `git rebase main` | `workflow sync feature` |
| `git rebase -i main` | `workflow flatten feature "msg"` |
| `git branch -d feature` | `workflow delete feature` |

## Advanced Usage

### Custom Completion

The tool includes bash and zsh completion. If completion isn't working:

```bash
# Reload your shell configuration
source ~/.bashrc  # or ~/.zshrc

# Verify workflow commands complete
workflow <TAB>
```

### Checking Workspace Status

```bash
# List all workspaces
workflow workspaces

# View commits in a workspace
jj log -r 'my-feature@ ~ main'

# View file changes in a workspace
workflow files my-feature@
jj diff -r my-feature@
```

### Working with Bookmarks

Jujutsu bookmarks are like Git branches:

```bash
# Create a bookmark on current commit
jj bookmark create feature-name

# Merge a bookmark instead of workspace
workflow merge feature-name
```

## Contributing

Contributions welcome! This tool is designed to be extended and customized for your workflow needs.

## License

MIT License - feel free to use and modify for your needs.
