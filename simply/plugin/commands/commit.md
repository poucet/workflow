---
description: Create atomic commits from open changes
allowed-tools: Bash(jj:*)
---

# Simply Commit

Review open changes and create meaningful atomic commits.

## Steps

1. Run `jj status` and `jj diff` to see all uncommitted changes
2. Group changes into logical, self-contained units:
   - Each commit = one coherent change (feature, fix, refactor)
   - Related files together, unrelated changes separate
3. For each group: `jj commit` with clear message (imperative, ~50 chars)
4. Report summary of commits created
