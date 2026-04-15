---
description: Add idea to inbox and commit
argument-hint: <text>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Idea

Add an idea to IDEAS.md and commit immediately.

## Context

Read frontmatter from `docs/PROJECT.md` for: project, version, phase
Version path: `docs/{project}/{version}/`

## Steps

1. Take text from args or ask for it
2. Append a row to the IDEAS.md table with status 💡 (idea), today's date in the Updated column, and any notes provided
3. Run `jj commit` with only IDEAS.md
4. Confirm idea captured
