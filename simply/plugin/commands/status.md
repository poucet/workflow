---
description: Show workflow status and available commands
allowed-tools: Read, Glob
---

# Simply Status

Show current workflow status. If not initialized, show help.

## Context

Read frontmatter from `docs/PROJECT.md` for: project, version, phase
Version path: `docs/{project}/{version}/`
Journal path: `docs/{project}/{version}/journals/{phase}.md`

## Steps

1. **Check state**: Try to read `docs/PROJECT.md` (frontmatter holds current project/version/phase)

2. **If not initialized**, show help:
   ```
   Simply Workflow — turn ideas into working software.

   Commands:
     /simply:idea <text>     Capture idea to inbox
     /simply:design [#]      Develop or continue a design
     /simply:plan <design#>  Map design to roadmap and tasks
     /simply:next [phase]    Start next task or switch phase
     /simply:commit          Create atomic commits (+ journal + arch refresh)
     /simply:status          Show this status

   Run /simply:next to initialize a new project.
   ```

3. **If initialized**, show status:
   - Project, version, phase
   - Task counts for the current phase (filtered from TASKS.md): ⬜ todo / 🔄 in-progress / ✅ done
   - Total task counts across all phases (for overview)
   - Idea counts by status: 💡 / 🪵 / 🎯 / 🔄 / ✅ / 🗑️
   - Designs in progress (draft/refined count)
   - Next suggested action
