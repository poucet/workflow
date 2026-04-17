---
description: Start next task, switch phase, or initialize
argument-hint: [phase]
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Next

Navigate work: start next task, switch phases, or initialize the workflow.

## Context

Read frontmatter from `docs/PROJECT.md` for: project, version, phase
Version path: `docs/{project}/{version}/`
Journal path: `docs/{project}/{version}/journals/{phase}.md`
Templates: `~/.simply/templates/`

**Phase identifiers are freeform strings** — e.g., `01`, `02`, `02-auth`, `polish`. Numbered prefixes give natural sort order; names give readability. Use whichever the user prefers.

**Bootstrap**: PROJECT.md is auto-loaded on session start, including its Architecture section — so you already have codebase context without scanning files. If that section looks stale relative to the current codebase (e.g., new top-level directories, changed component graph), offer to refresh it.

## Steps

1. **Check state**: Read `docs/PROJECT.md` frontmatter

2. **If not initialized**:
   - Ask for project name (default: directory name)
   - Create `docs/PROJECT.md` from `~/.simply/templates/PROJECT.md` with frontmatter `project`, `version: "0.1"`, `phase: "01"` and a starter body (problem / current focus / notes)
   - Create version dir and copy templates from `~/.simply/templates/version/` (IDEAS.md, DESIGN.md, ROADMAP.md, TASKS.md)
   - Create `docs/{project}/{version}/journals/01.md` from `~/.simply/templates/JOURNAL.md` (substitute `{phase}` → `01`)
   - Confirm setup complete

3. **If arg is a phase identifier**: Switch to that phase
   - Accept any non-empty string as a phase identifier (numeric, slug, or mixed)
   - Create `docs/{project}/{version}/journals/{new-phase}.md` from the JOURNAL.md template if it doesn't already exist
   - Build a recap from the outgoing phase and **prepend** it to the new phase's journal as a `## Previous Phase Recap ({old} → {new})` section containing:
     - Open / in-progress / blocked tasks belonging to the old phase in TASKS.md (status + ID + title)
     - Last 3–5 entries from `journals/{old-phase}.md`
     - Any unresolved decisions or risks worth carrying forward
   - Update `docs/PROJECT.md` frontmatter with the new `phase` value
   - Run `jj commit` with changed files
   - Show new phase status (filtered TASKS.md view for this phase)

4. **If no arg**: Find next task and start it immediately
   - Read TASKS.md and filter rows where `Phase == current phase`
   - Check for in-progress (🔄) tasks first
   - Find next `todo` (⬜) task by priority (P0 > P1 > P2)
   - If no tasks remain for this phase: ask if ready to switch to another phase (don't auto-increment; ask the user what comes next)
   - Treat `/simply:next` as a "go" command — do NOT ask "ready to start?". Mark the task in-progress and begin implementation immediately.

5. **When starting a task** (happens automatically on `/simply:next`):
   - Update TASKS.md: change the task's row status from ⬜ to 🔄
   - `jj commit` with TASKS.md update
   - Show task details and acceptance criteria, then start working on it right away

6. **When finishing a task** (user says "done" or similar):
   - Verify acceptance criteria are met
   - Update TASKS.md: change status from 🔄 to ✅
   - **Auto-commit**: if there are uncommitted code changes beyond TASKS.md, run `jj commit` with a templated message `Phase {phase}: {task-id} {task name}` bundling the code + TASKS.md update. If only TASKS.md changed, commit just that. Skip the commit only if the user explicitly says not to.
   - Suggest `/simply:next` for the next task

7. **If task is blocked**:
   - Update TASKS.md: change status to 🚫, add note
   - Ask what's blocking and if there's a different task to start
