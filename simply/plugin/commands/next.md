---
description: Start next task (or initialize if not set up)
allowed-tools: Bash(jj:*), Read, Write, Glob
---

# Simply Next

Start next task, or initialize workflow if not set up.

## Steps

1. Check if `docs/simply.yaml` exists
2. If not initialized:
   - Ask for project name (default: directory name)
   - Create `docs/simply.yaml` with project, version: "0.1", phase: "01"
   - Create `docs/{project}/0.1/` and copy version templates from `~/.simply/templates/version/`
   - Create `docs/{project}/0.1/phases/01/` and copy phase templates from `~/.simply/templates/phase/`
3. If initialized:
   - Read TASKS.md
   - Find next `todo` task by priority (P0 > P1 > P2 > P3)
   - Present task details and ask if ready to start
