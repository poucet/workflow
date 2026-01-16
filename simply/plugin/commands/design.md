---
description: Promote idea(s) to design document
argument-hint: <idea#>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Design

Promote triaged ideas from IDEAS.md into detailed design documents in DESIGN.md.

## Context

Read `docs/simply.yaml` for: project, version, phase
Version path: `docs/{project}/{version}/`

## Steps

1. Take idea number from args or show Inbox and ask which to promote
2. Read the idea details from IDEAS.md
3. Create or append to DESIGN.md:
   - Add new design entry with next available number
   - Reference source idea number
   - Fill in problem statement from idea
   - Prompt for: goals, non-goals, proposed solution
   - Set status to "draft"
4. Update IDEAS.md:
   - Move idea from Inbox to Triaged
   - Set disposition to "roadmap"
5. Update Design Index table
6. Run `jj commit` with IDEAS.md and DESIGN.md
7. Confirm design created and show next steps
