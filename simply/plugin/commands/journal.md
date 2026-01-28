---
description: Add entry to session journal
argument-hint: <text>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Journal

Add entry to JOURNAL.md.

## Context

Read `docs/simply.yaml` for: project, version, phase
Phase path: `docs/{project}/{version}/phases/{phase}/`

## Steps

1. Take text from args or ask for it
2. Append entry with timestamp to JOURNAL.md
3. Ask if ready to commit (journal entries are often made mid-work)
4. If yes: `jj commit` with only JOURNAL.md
5. Confirm entry added
