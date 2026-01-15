---
description: Development workflow system for managing phases, tasks, and project state
argument-hint: <action> [args]
---

# Simply

Development workflow system for Claude Code.

## Current State

Read from `docs/simply.yaml`:
- `project` - project directory under docs/
- `version` - current version
- `phase` - current phase

## Directory Structure

User-level (installed once via `simply/setup.sh`):
```
~/.simply/                    # Symlink to workflow repo simply/
├── simply.md
├── setup.sh
└── templates/
    ├── version/
    │   ├── ROADMAP.md
    │   └── IDEAS.md
    └── phase/
        ├── TASKS.md
        ├── JOURNAL.md
        └── HANDOFF.md
~/.claude/
└── commands/
    └── simply.md             # Symlink to ~/.simply/simply.md
```

Per-project (via `/simply init`):
```
your-project/
├── docs/
│   ├── simply.yaml           # Current state
│   └── {project}/
│       └── {version}/
│           ├── ROADMAP.md
│           ├── IDEAS.md
│           └── phases/{phase}/
│               ├── TASKS.md
│               ├── JOURNAL.md
│               └── HANDOFF.md
└── .jj-workspaces/           # jj workspaces (gitignored)
```

## Phase Files

| File | Purpose | When to Update |
|------|---------|----------------|
| `TASKS.md` | Task table + feature specs | Mark tasks done, add new tasks |
| `JOURNAL.md` | Chronological log & notes | During work (Thoughts, Changes, Obs) |
| `HANDOFF.md` | Context for next phase | At end of phase |

## Path Resolution

| Resource | Path |
|----------|------|
| State | `docs/simply.yaml` |
| Roadmap | `docs/{project}/{version}/ROADMAP.md` |
| Ideas | `docs/{project}/{version}/IDEAS.md` |
| Phase dir | `docs/{project}/{version}/phases/{phase}/` |
| Version templates | `~/.simply/templates/version/` |
| Phase templates | `~/.simply/templates/phase/` |

---

## Commands

Use `/simply <action>` to manage phases.

### init

Initialize Simply workflow in current project.
1. Check if `docs/simply.yaml` exists - if so, report current state and exit
2. Ask for project name (default: directory name)
3. Create `docs/simply.yaml`:
   ```yaml
   project: {project-name}
   version: "0.1"
   phase: "01"
   ```
4. Create version directory: `docs/{project}/0.1/`
5. Copy version templates from `~/.simply/templates/version/` to version directory
6. Create phase directory: `docs/{project}/0.1/phases/01/`
7. Copy phase templates from `~/.simply/templates/phase/` to phase directory
8. Confirm setup complete

### status

Show current phase status.
1. Read this file for current state
2. Read TASKS.md for task counts
3. Report summary

### next-task

Find next task to work on.
1. Read TASKS.md
2. Find next `todo` task (P0 > P1 > P2 > P3)
3. Present details, ask if ready to start

### journal <text>

Add entry to JOURNAL.md.
1. Take text from args or ask
2. Append with timestamp
3. Confirm

### idea <text>

Add idea to IDEAS.md inbox and commit immediately.
1. Take text from args or ask
2. Append to Inbox table with date
3. Run `jj commit` with only IDEAS.md
4. Confirm

### handoff

Prepare HANDOFF.md for phase end.
1. Read TASKS.md, JOURNAL.md
2. Draft system state, notes, and next steps
3. Save to HANDOFF.md

### switch <phase>

Switch to different phase.
1. Create phase dir if needed (from templates)
2. Update `docs/simply.yaml`
3. Load new phase context

### commit

Review open changes and create meaningful atomic commits.
1. Run `jj status` and `jj diff` to see all uncommitted changes
2. Analyze changes and group them into logical, self-contained units:
   - Each commit should represent one coherent change (feature, fix, refactor)
   - Related files should be committed together
   - Unrelated changes should be separate commits
3. For each logical group:
   - Use `jj commit` with only the relevant files
   - Write a clear, concise commit message describing the "why"
   - Message format: imperative mood, 50 char summary line
4. Continue until all changes are committed
5. Report summary of commits created

Commit principles:
- Atomic: Each commit is one logical change that compiles independently
- Self-contained: Commit includes all files needed for that change
- Meaningful: Message explains purpose, not just what changed
- Ordered: Dependencies committed before dependents

---

## Starting a New Phase

1. Create phase directory: `docs/{project}/{version}/phases/{NN}/`
2. Copy all files from `~/.simply/templates/phase/` to the new phase directory:
   - `TASKS.md`
   - `JOURNAL.md`
   - `HANDOFF.md`
3. Copy phase overview from ROADMAP.md into TASKS.md
4. Read previous phase's HANDOFF.md for context
5. Update `docs/simply.yaml` with new phase number

## Phase Transitions

When completing a phase:
1. Update TASKS.md with final status
2. Capture learnings and context in HANDOFF.md
3. Update `docs/simply.yaml` for next phase
