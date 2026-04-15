---
description: Start next task, switch phase, or initialize
argument-hint: [phase]
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Next

Navigate work: start next task, switch phases, or initialize the workflow.

## Context

Read frontmatter from `docs/PROJECT.md` for: project, version, phase
Phase path: `docs/{project}/{version}/phases/{phase}/`
Templates: `~/.simply/templates/`

**Bootstrap**: PROJECT.md is auto-loaded on session start, including its Architecture section — so you already have codebase context without scanning files. If that section looks stale relative to the current codebase (e.g., new top-level directories, changed component graph), offer to refresh it.

## Steps

1. **Check state**: Read `docs/PROJECT.md` frontmatter

2. **If not initialized**:
   - Ask for project name (default: directory name)
   - Create `docs/PROJECT.md` from `~/.simply/templates/PROJECT.md` with frontmatter `project`, `version: "0.1"`, `phase: "01"` and a starter body (problem / current focus / notes)
   - Create version dir and copy templates from `~/.simply/templates/version/`
   - Create phase dir and copy templates from `~/.simply/templates/phase/`
   - Confirm setup complete

3. **If arg is a phase number**: Switch to that phase
   - Create new phase dir if needed (copy from templates)
   - Build a recap from the current phase and **prepend** it to the new phase's JOURNAL.md as a `## Previous Phase Recap (Phase {old} → {new})` section containing:
     - Open / in-progress / blocked tasks from the old phase's TASKS.md (status + title)
     - Last 3–5 entries from the old phase's JOURNAL.md
     - Any unresolved decisions or risks worth carrying forward
   - Update `docs/PROJECT.md` frontmatter with the new phase
   - Run `jj commit` with changed files
   - Show new phase status

4. **If no arg**: Find next task and start it immediately
   - Read TASKS.md for current phase
   - Check for in-progress tasks first
   - Find next `todo` task by priority (P0 > P1 > P2)
   - If no tasks remain: ask if ready to switch to next phase
   - Treat `/simply:next` as a "go" command — do NOT ask "ready to start?". Mark the task in-progress and begin implementation immediately.

5. **When starting a task** (happens automatically on `/simply:next`):
   - Update TASKS.md: change status from ⬜ to 🔄
   - `jj commit` with TASKS.md update
   - Show task details and acceptance criteria, then start working on it right away

6. **When finishing a task** (user says "done" or similar):
   - Verify acceptance criteria are met
   - Update TASKS.md: change status from 🔄 to ✅
   - **Auto-commit**: if there are uncommitted code changes beyond TASKS.md, run `jj commit` with a templated message `Phase {NN}: Task {X.Y}: {task name}` bundling the code + TASKS.md update. If only TASKS.md changed, commit just that. Skip the commit only if the user explicitly says not to.
   - Suggest `/simply:next` for the next task

7. **If task is blocked**:
   - Update TASKS.md: change status to 🚫, add note
   - Ask what's blocking and if there's a different task to start
