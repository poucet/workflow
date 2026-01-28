---
description: Run compatibility checks against external codebases
allowed-tools: Read, Task, Edit
---

# Simply Compat

Run compatibility checks defined in the project's COMPATIBILITY.md.

## Context

- Read `docs/simply.yaml` for: project, version
- Compatibility doc: `docs/{project}/{version}/COMPATIBILITY.md`
- Agent template: `~/.simply/plugin/agents/codebase-analyzer.md`

## Arguments

- No args: Run all checkpoints against all targets
- Target name (e.g., `lumina`): All checkpoints, one target
- Checkpoint ID (e.g., `CP1`): One checkpoint, all targets

## COMPATIBILITY.md Format

The project's compatibility doc must define:

```markdown
## Targets

| Name | Path |
|------|------|
| target1 | ~/path/to/codebase1 |
| target2 | ~/path/to/codebase2 |

## Checkpoints

### CP1: Checkpoint Name
**Expects:** What this project expects to find
**Check prompt:**
\```
Questions to ask the codebase-analyzer agent
\```
**target1 status:** _unchecked_
**target2 status:** _unchecked_
```

## Steps

1. **Load config**: Read `docs/simply.yaml` to get project/version

2. **Load compatibility doc**: Read `docs/{project}/{version}/COMPATIBILITY.md`
   - Parse Targets table → list of {name, path}
   - Parse Checkpoints → list of {id, name, expects, prompt}

3. **Filter by args**: If target or checkpoint specified, filter list

4. **Build agent prompts**: For each checkpoint × target:
   ```
   Analyze the codebase at: {target.path}

   Questions:
   {checkpoint.prompt}

   For each question, report:
   - **Found:** yes/no
   - **Location:** file path and line number if found
   - **Pattern:** exact signature, structure, or code snippet
   - **Notes:** any relevant context

   Be concise. Only report what was asked.
   ```

5. **Launch agents in parallel**:
   - Use `Task` tool with `subagent_type: Explore`, `model: haiku`
   - Run different targets in parallel for same checkpoint

6. **Compare results**: For each checkpoint × target:
   - Does found pattern align with "expects"?
   - Status: `aligned` | `misaligned` | `not found`

7. **Update COMPATIBILITY.md**:
   - Update status fields for each checkpoint/target
   - Add row to History table if present

8. **Report summary**:
   ```
   ## Compatibility Check: {project}

   | Checkpoint | target1 | target2 | Action |
   |------------|---------|---------|--------|
   | CP1: Name  | aligned | aligned | none   |
   ```
