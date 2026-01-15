---
description: Complete current phase and switch to next
argument-hint: <phase>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Switch

Complete handoff for current phase and switch to next.

## Context

Read `docs/simply.yaml` for: project, version, phase
Phase path: `docs/{project}/{version}/phases/{phase}/`
Templates: `~/.simply/templates/phase/`

## Steps

1. Take phase from args or ask for it
2. Prepare HANDOFF.md for current phase:
   - Read TASKS.md and JOURNAL.md
   - Summarize completed work, open items, notes for next phase
   - Save to HANDOFF.md
3. Create new phase dir if needed (copy from templates)
4. Update `docs/simply.yaml` with new phase
5. Confirm switch and show new phase status
