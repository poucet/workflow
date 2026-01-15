---
description: Development workflow system for managing phases, tasks, and project state
argument-hint: <action> [args]
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply

Read state from `docs/simply.yaml`: project, version, phase

## Structure

```
docs/
├── simply.yaml
└── {project}/{version}/
    ├── ROADMAP.md, IDEAS.md
    └── phases/{phase}/
        ├── TASKS.md, JOURNAL.md, HANDOFF.md
```

Templates: `~/.simply/templates/version/` and `~/.simply/templates/phase/`

## Files

| File | Purpose |
|------|---------|
| `ROADMAP.md` | Phase overview and goals |
| `IDEAS.md` | Idea inbox |
| `TASKS.md` | Task table + specs |
| `JOURNAL.md` | Session log |
| `HANDOFF.md` | Context for next phase |

---

## Commands

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
4. Create `docs/{project}/0.1/` and copy version templates
5. Create `docs/{project}/0.1/phases/01/` and copy phase templates

### status

Show current phase status.
1. Read simply.yaml for current state
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
1. Create phase dir if needed (copy from templates)
2. Update `docs/simply.yaml`
3. Load new phase context

### commit

Review open changes and create meaningful atomic commits.
1. Run `jj status` and `jj diff` to see all uncommitted changes
2. Group changes into logical, self-contained units:
   - Each commit = one coherent change (feature, fix, refactor)
   - Related files together, unrelated changes separate
3. For each group: `jj commit` with clear message (imperative, ~50 chars)
4. Report summary of commits created
