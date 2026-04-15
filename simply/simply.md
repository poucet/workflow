# Simply Development Workflow

A structured workflow for turning ideas into working software, one phase at a time.

## Quick Reference

| Command | Purpose |
|---------|---------|
| `/simply:status` | Show project status and available commands |
| `/simply:next [phase]` | Start next task or switch phase |
| `/simply:idea <text>` | Capture idea to inbox |
| `/simply:design [#]` | Develop or continue a design |
| `/simply:plan <design#>` | Map design to roadmap and tasks |
| `/simply:commit` | Create atomic commits (also journals + refreshes architecture) |

## Workflow Loop

```
idea → design → plan → next → (work) → commit
  ↑                              ↓
  └──────────────────────────────┘
```

1. **Capture** ideas as they come (`/simply:idea`)
2. **Design** solutions collaboratively (`/simply:design`)
3. **Plan** approved designs into tasks (`/simply:plan`)
4. **Work** on tasks one at a time (`/simply:next`)
5. **Commit** changes atomically (`/simply:commit`)
6. **Repeat**

## Project Structure

```
docs/
├── PROJECT.md               # Project context + architecture + frontmatter
└── {project}/
    └── {version}/
        ├── IDEAS.md         # Idea inbox (lifecycle-tracked)
        ├── DESIGN.md        # Design documents
        ├── ROADMAP.md       # Feature roadmap
        └── phases/
            └── {phase}/
                ├── TASKS.md    # Phase tasks
                └── JOURNAL.md  # Session notes + phase recaps
```

`docs/PROJECT.md` is auto-loaded into every session via a SessionStart hook. It carries:
- **Frontmatter**: project / version / phase — current workflow state
- **Body**: problem statement, current focus, and the Architecture section (overview, structure, component graph, conventions)

This means Claude gets project context and codebase bootstrap **for free** on every session, with no per-command scanning.

## Principles

- **One thing at a time**: Focus on the current task
- **PROJECT.md is the bootstrap**: One file, auto-loaded, covers intent + architecture
- **Checkpoint often**: Save progress incrementally
- **Atomic commits**: Each commit is one coherent change; commits also journal and refresh the Architecture section when structural changes happen
- **Carry context forward**: Phase transitions auto-prepend a recap to the next phase's JOURNAL.md

## Getting Started

```bash
# Install the plugin
./simply/setup.sh

# Initialize a project
/simply:next
```
