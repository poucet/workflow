---
description: Show phase status and next task
allowed-tools: Read, Glob
---

# Simply Status

Show current phase status and suggest next task.

## Context

Read `docs/simply.yaml` for: project, version, phase
Phase path: `docs/{project}/{version}/phases/{phase}/`

## Steps

1. Read simply.yaml for current state
2. Read TASKS.md for task counts (todo/doing/done)
3. Report summary: project, version, phase, task breakdown
4. Find next `todo` task by priority (P0 > P1 > P2 > P3)
5. If found, present task details and ask if ready to start
