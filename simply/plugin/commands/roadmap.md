---
description: Promote design(s) to roadmap features
argument-hint: <design#>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Roadmap

Promote approved designs from DESIGN.md into prioritized features in ROADMAP.md.

## Context

Read `docs/simply.yaml` for: project, version, phase
Version path: `docs/{project}/{version}/`

## Steps

1. Take design number from args or show designs with "approved" status and ask which to promote
2. Read design details from DESIGN.md
3. Ask for:
   - Target phase (existing or new phase name)
   - Priority (P0/P1/P2/P3)
   - Complexity estimate (S/M/L/XL)
   - Impact (low/medium/high)
4. Update ROADMAP.md:
   - Add feature to appropriate phase's Feature Overview table
   - Add Feature Details section with problem/solution from design
   - Update Key Files if known
5. Update DESIGN.md:
   - Set design status to "implemented"
6. Run `jj commit` with DESIGN.md and ROADMAP.md
7. Confirm feature added and show roadmap summary
