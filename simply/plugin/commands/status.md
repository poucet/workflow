---
description: Show workflow status and available commands
allowed-tools: Read, Glob
---

# Simply Status

Show current workflow status. If not initialized, show help.

## Context

Read `docs/simply.yaml` for: project, version, phase
Phase path: `docs/{project}/{version}/phases/{phase}/`

## Steps

1. **Check state**: Try to read `docs/simply.yaml`

2. **If not initialized**, show help:
   ```
   Simply Workflow — turn ideas into working software.

   Commands:
     /simply:idea <text>     Capture idea to inbox
     /simply:design [#]      Develop or continue a design
     /simply:plan <design#>  Map design to roadmap and tasks
     /simply:next [phase]    Start next task or switch phase
     /simply:status          Show this status
     /simply:summarize       Update architecture summary
     /simply:commit          Create atomic commits
     /simply:journal <text>  Add session note

   Run /simply:next to initialize a new project.
   ```

3. **If initialized**, show status:
   - Project, version, phase
   - Task counts: ⬜ todo / 🔄 in-progress / ✅ done
   - Ideas in inbox (count)
   - Designs in progress (draft/refined count)
   - Next suggested action
