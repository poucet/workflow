---
description: Start next task, switch phase, or initialize
argument-hint: [phase]
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Next

Navigate work: start next task, switch phases, or initialize the workflow.

## Context

Read `docs/simply.yaml` for: project, version, phase
Phase path: `docs/{project}/{version}/phases/{phase}/`
Templates: `~/.simply/templates/`

**Bootstrap**: Read ARCHITECTURE.md first if it exists — this gives you codebase context without scanning files.

## Steps

1. **Check state**: Read `docs/simply.yaml`

2. **If not initialized**:
   - Ask for project name (default: directory name)
   - Create `docs/simply.yaml` with project, version: "0.1", phase: "01"
   - Create version dir and copy templates from `~/.simply/templates/version/`
   - Create phase dir and copy templates from `~/.simply/templates/phase/`
   - Confirm setup complete

3. **If arg is a phase number**: Switch to that phase
   - Prepare HANDOFF.md for current phase (summarize completed work, open items)
   - Create new phase dir if needed (copy from templates)
   - Update `docs/simply.yaml` with new phase
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
   - `jj commit` with TASKS.md update
   - Suggest `/simply:next` for the next task

7. **If task is blocked**:
   - Update TASKS.md: change status to 🚫, add note
   - Ask what's blocking and if there's a different task to start
