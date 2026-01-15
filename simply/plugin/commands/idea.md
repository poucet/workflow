---
description: Add idea to inbox and commit
argument-hint: <text>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Idea

Add idea to IDEAS.md inbox and commit immediately.

## Context

Read `docs/simply.yaml` for: project, version, phase
Version path: `docs/{project}/{version}/`

## Steps

1. Take text from args or ask for it
2. Append to Inbox table in IDEAS.md with date
3. Run `jj commit` with only IDEAS.md
4. Confirm idea captured
