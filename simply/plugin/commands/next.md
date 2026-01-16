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

4. **If no arg**: Find next task
   - Read TASKS.md for current phase
   - Find next `todo` task by priority (P0 > P1 > P2)
   - If no tasks remain: ask if ready to switch to next phase
   - Present task details and ask if ready to start
