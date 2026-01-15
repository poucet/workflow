# Simply

Development workflow system for Claude Code.

## Current State

Read from `docs/simply.yaml`:
- `project` - project directory under docs/
- `version` - current version
- `phase` - current phase

## Directory Structure

User-level (installed once via `workflow setup`):
```
~/.simply/
└── templates/                # Symlink to workflow repo templates
    ├── version/
    │   ├── ROADMAP.md
    │   └── IDEAS.md
    └── phase/
        ├── TASKS.md
        ├── JOURNAL.md
        └── HANDOFF.md
~/.claude/
└── commands/
    └── simply.md             # Symlink to workflow repo simply.md
```

Per-project (via `workflow install`):
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

---

## Starting a New Phase

1. Create `docs/{project}/{version}/phases/{NN}/`
2. Copy templates from `~/.simply/templates/phase/`
3. Copy phase overview from ROADMAP.md to TASKS.md
4. Read previous HANDOFF.md for context
5. Update `docs/simply.yaml`

## Phase Transitions

When completing a phase:
1. Update TASKS.md with final status
2. Capture learnings and context in HANDOFF.md
3. Update `docs/simply.yaml` for next phase
