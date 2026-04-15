---
description: Create atomic commits from open changes
allowed-tools: Bash(jj:*), Read, Edit
---

# Simply Commit

Review open changes and create meaningful atomic commits.

## Context

Read frontmatter from `docs/PROJECT.md` for: project, version, phase
Phase path: `docs/{project}/{version}/phases/{phase}/`

## Steps

1. Run `jj status` and `jj diff` to see all uncommitted changes

2. Group changes into logical, self-contained units:
   - Each commit = one coherent change (feature, fix, refactor)
   - Related files together, unrelated changes separate

3. For each group: `jj commit` with clear message (imperative, ~50 chars)

4. **Update journal** (if significant work):
   - Append a brief entry to the current phase's JOURNAL.md noting what was done, decisions made, blockers hit, or things learned

5. **Refresh architecture** (if structural change):
   - If the commits touched 5+ files, added/removed top-level directories, introduced new components, or changed the component graph, offer to refresh the `## Architecture` section of `docs/PROJECT.md`
   - Keep the refresh concise — bullets and short paragraphs only, this is auto-loaded into every session
   - Update `architecture_updated` in the frontmatter to today's date
   - Commit the PROJECT.md update separately

6. Report summary of commits created
