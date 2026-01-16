---
description: Create atomic commits from open changes
allowed-tools: Bash(jj:*), Read, Edit
---

# Simply Commit

Review open changes and create meaningful atomic commits.

## Context

Read `docs/simply.yaml` for: project, version, phase
Phase path: `docs/{project}/{version}/phases/{phase}/`

## Steps

1. Run `jj status` and `jj diff` to see all uncommitted changes

2. Group changes into logical, self-contained units:
   - Each commit = one coherent change (feature, fix, refactor)
   - Related files together, unrelated changes separate

3. For each group: `jj commit` with clear message (imperative, ~50 chars)

4. **Update journal** (if significant work):
   - Add brief entry to JOURNAL.md noting what was done
   - Include any decisions made, blockers hit, or things learned

5. Report summary of commits created
