---
description: Update architecture summary from codebase
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob, Grep
---

# Simply Summarize

Update ARCHITECTURE.md with current codebase understanding. This file bootstraps other commands so they don't need to re-scan the codebase.

## Context

Read `docs/simply.yaml` for: project, version, phase
Version path: `docs/{project}/{version}/`

## When to Use

- After significant structural changes
- When starting a new session on an unfamiliar codebase
- Periodically to keep architecture docs current
- When `/simply:design` or `/simply:next` feel slow

## Steps

1. **Read existing state**:
   - Check if ARCHITECTURE.md exists
   - Read current contents if present

2. **Scan codebase** (focus on structure, not details):
   - Directory structure (key paths only)
   - Entry points and main modules
   - Public interfaces / exports
   - Configuration files
   - Key dependencies (package.json, Cargo.toml, etc.)

3. **Identify components**:
   - Group related files into logical components
   - Note dependencies between components
   - Identify data flow patterns

4. **Update ARCHITECTURE.md**:
   - Preserve any manual notes/decisions
   - Update structural information
   - Update timestamp
   - Keep it concise — this is a bootstrap doc, not exhaustive

5. **Commit**:
   - Run `jj commit` with ARCHITECTURE.md
   - Report what changed

## Guidelines

- **Be concise** — aim for quick scanning, not comprehensive docs
- **Focus on "where"** — where is X? where does Y happen?
- **Skip implementation details** — that's what code is for
- **Update incrementally** — don't rewrite from scratch each time
- **Use Mermaid diagrams** — for component graphs and data flows (renders in VSCode)
