---
description: Map approved designs to roadmap and tasks
argument-hint: <design#>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Plan

Map approved designs to the roadmap and break them down into actionable tasks.

## Context

Read frontmatter from `docs/PROJECT.md` for: project, version, phase
Version path: `docs/{project}/{version}/`
Tasks: `docs/{project}/{version}/TASKS.md` (flat, all phases)

## When to Use

Use this command when a design is ready to be scheduled and broken down:
- Design status is "approved" or ready for implementation
- You know roughly when/where this work should happen

## Steps

1. **Select design**: Take design number from args or show approved designs and ask which to plan

2. **Review design**: Read the design from DESIGN.md and summarize:
   - Problem being solved
   - Proposed approach
   - Any patterns/dependencies noted

3. **Place in roadmap**: Ask the user:
   - "Which phase should this go in?" — show existing phase identifiers (distinct values in the Phase column of TASKS.md, plus the current phase from frontmatter). Accept any freeform identifier; new phase names are fine.
   - "What priority? (P0 = must have, P1 = should have, P2 = nice to have)"
   - "Complexity estimate? (S/M/L/XL)"

4. **Break into tasks**: For the design, ask:
   - "What are the discrete steps to implement this?"
   - "What files will each task touch?"
   - For each task, confirm priority within the feature

5. **Update artifacts**:
   - Add feature to ROADMAP.md in the target phase
   - Append task rows to the flat TASKS.md, filling in Phase, ID (next `T{N}` after current max), Status ⬜, Priority, and the per-task detail section below the table
   - Update design status to "planned"
   - If this design originated from an idea, flip the idea's status in IDEAS.md to ✅ (done — rolled into roadmap)
   - Run `jj commit` with changed files

6. **Confirm**: Show summary of what was planned and where (phase, task IDs added)
