# Simply Workflow

A structured development workflow for Claude Code that turns ideas into working software, one phase at a time. Includes a Claude Code plugin (`simply/`) and Jujutsu workspace tooling for parallel feature development.

## The Simply Workflow

The core of this project is a Claude Code plugin that guides you through a repeatable development loop:

```
idea --> design --> plan --> next --> (work) --> commit
  ^                                    |
  +------------------------------------+
```

1. **Capture** ideas as they come (`/simply:idea`)
2. **Design** solutions collaboratively (`/simply:design`)
3. **Plan** approved designs into tasks (`/simply:plan`)
4. **Work** on tasks one at a time (`/simply:next`)
5. **Commit** changes atomically (`/simply:commit`)
6. **Repeat**

### Commands

| Command | Purpose |
|---------|---------|
| `/simply:status` | Show project status and available commands |
| `/simply:next [phase]` | Start next task or switch phase |
| `/simply:idea <text>` | Capture idea to inbox |
| `/simply:design [#]` | Develop or continue a design |
| `/simply:plan <design#>` | Map design to roadmap and tasks |
| `/simply:commit` | Create atomic commits from changes |
| `/simply:journal <text>` | Add session note |
| `/simply:summarize` | Update architecture summary |
| `/simply:compat` | Run compatibility checks against external codebases |

### Project Structure

Each project managed by Simply maintains a structured documentation tree:

```
docs/
├── simply.yaml              # Current project/version/phase
└── {project}/
    └── {version}/
        ├── ARCHITECTURE.md  # Codebase structure (bootstrap)
        ├── IDEAS.md         # Idea inbox
        ├── DESIGN.md        # Design documents
        ├── ROADMAP.md       # Feature roadmap
        ├── COMPATIBILITY.md # External codebase checks
        └── phases/
            └── {phase}/
                ├── TASKS.md    # Phase tasks
                ├── JOURNAL.md  # Session notes
                └── HANDOFF.md  # Phase transition context
```

### Principles

- **One thing at a time**: Focus on the current task
- **Bootstrap first**: Read ARCHITECTURE.md before scanning code
- **Checkpoint often**: Save progress incrementally
- **Atomic commits**: Each commit is one coherent change
- **Clear handoffs**: Document context when switching phases

### Getting Started

```bash
# Install the plugin
./simply/setup.sh

# Initialize a project
/simply:next
```

---

## Jujutsu Workspace Tooling

The repository also includes shell-based workspace management for [Jujutsu (jj)](https://martinvonz.github.io/jj/), providing Git-like branch workflows using jj workspaces with color-coded VSCode windows.

### Features

- **Isolated Workspaces**: Separate working directories per feature
- **Color-Coded VSCode Windows**: Unique color theme per workspace
- **Selective Merging**: Merge all commits or cherry-pick specific ones
- **Linear History**: Rebase-based workflow for clean commit history

### Installation

Add VSCode terminal integration to your shell RC file (`.bashrc` or `.zshrc`):

```bash
# VSCode terminal integration - load workflow tools
if [ "$TERM_PROGRAM" = "vscode" ]; then
    source /path/to/workflow/etc/shell-init.zsh  # or .bash
    register_tools "/path/to/workflow"
    register_tools "$(pwd)"
fi
```

### Quick Start

```bash
workflow init              # Initialize jj in a git repo
workflow create my-feature # Create a new feature workspace
jj commit -m "Add feature" # Work and commit
workflow merge my-feature  # Merge into main
jj git push                # Push to remote
workflow delete my-feature # Clean up
```

### Workspace Commands

| Command | Purpose |
|---------|---------|
| `workflow init` | Convert git repo to jj colocated repo |
| `workflow create <name>` | Create workspace and open in VSCode |
| `workflow open <name>` | Open existing workspace in VSCode |
| `workflow merge <name> [commits...]` | Merge workspace into main (all or specific commits) |
| `workflow sync <name>` | Rebase workspace onto latest main |
| `workflow flatten <name> "msg"` | Squash all workspace commits into one |
| `workflow delete <name>` | Delete workspace (only if fully merged) |
| `workflow workspaces` | List all workspaces |
| `workflow files [rev]` | Show modified files in a revision |

### Comparison with Git

| Git | Jujutsu Workflow |
|-----|------------------|
| `git checkout -b feature` | `workflow create feature` |
| `git checkout feature` | `workflow open feature` |
| `git merge feature` | `workflow merge feature` |
| `git rebase main` | `workflow sync feature` |
| `git rebase -i main` | `workflow flatten feature "msg"` |
| `git branch -d feature` | `workflow delete feature` |

## License

MIT License - feel free to use and modify for your needs.
