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
| `/simply:commit` | Create atomic commits from changes |
| `/simply:journal <text>` | Add session note |
| `/simply:summarize` | Update architecture summary |
| `/simply:compat` | Run compatibility checks |

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

## Principles

- **One thing at a time**: Focus on the current task
- **Bootstrap first**: Read ARCHITECTURE.md before scanning code
- **Checkpoint often**: Save progress incrementally
- **Atomic commits**: Each commit is one coherent change
- **Clear handoffs**: Document context when switching phases

## Getting Started

```bash
# Install the plugin
./simply/setup.sh

# Initialize a project
/simply:next
```
