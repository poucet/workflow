---
description: Break down roadmap features into phase tasks
argument-hint: <phase>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Breakdown

Break down roadmap features for a phase into actionable tasks in TASKS.md.

## Context

Read `docs/simply.yaml` for: project, version, phase
Version path: `docs/{project}/{version}/`
Phase path: `docs/{project}/{version}/phases/{phase}/`

## Steps

1. Take phase from args or use current phase from simply.yaml
2. Read ROADMAP.md and find all features for target phase
3. For each feature in the phase:
   - Show feature details (problem, solution, files)
   - Ask for task breakdown:
     - What discrete tasks make up this feature?
     - What files will each task touch?
     - What priority for each task?
4. Create/update phase directory if needed (copy templates)
5. Update TASKS.md:
   - Add tasks to Task Table with priorities
   - Add Feature Details sections with acceptance criteria
6. Mark features as "broken down" in ROADMAP.md (check Done column)
7. Run `jj commit` with ROADMAP.md and phase TASKS.md
8. Confirm breakdown complete and show task summary
