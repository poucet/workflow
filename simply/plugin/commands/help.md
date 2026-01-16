---
description: Show Simply workflow commands and usage
allowed-tools: Read, Glob
---

# Simply Help

Display available Simply commands and explain the workflow.

## Output

Show the user this information:

---

**Simply Workflow** — A structured approach to turning ideas into working software.

### Workflow Progression

```
idea → design → roadmap → breakdown → next
  ↓       ↓        ↓          ↓        ↓
Inbox   Specs   Features    Tasks    Work
```

### Commands

| Command | Description |
|---------|-------------|
| `/simply:idea <text>` | Capture a quick idea to the inbox |
| `/simply:design <idea#>` | Collaboratively develop a design from an idea |
| `/simply:roadmap <design#>` | Promote a design to roadmap features |
| `/simply:breakdown <phase>` | Break down roadmap features into tasks |
| `/simply:next` | Start the next task (or initialize project) |
| `/simply:status` | Show current phase status and next task |
| `/simply:journal <text>` | Add an entry to the session journal |
| `/simply:commit` | Create atomic commits from open changes |
| `/simply:switch <phase>` | Complete current phase and switch to next |

### Artifacts

| File | Purpose | Location |
|------|---------|----------|
| IDEAS.md | Raw ideas inbox | `docs/{project}/{version}/` |
| DESIGN.md | Detailed problem/solution specs | `docs/{project}/{version}/` |
| ROADMAP.md | Prioritized features by phase | `docs/{project}/{version}/` |
| TASKS.md | Actionable tasks for a phase | `docs/{project}/{version}/phases/{phase}/` |
| JOURNAL.md | Session notes and decisions | `docs/{project}/{version}/phases/{phase}/` |
| HANDOFF.md | Phase completion summary | `docs/{project}/{version}/phases/{phase}/` |

### Getting Started

1. Run `/simply:next` to initialize a new project
2. Use `/simply:idea` to capture ideas as they come
3. Use `/simply:design` to develop ideas into designs
4. Use `/simply:roadmap` to plan features across phases
5. Use `/simply:breakdown` to create actionable tasks
6. Use `/simply:next` to work through tasks

---
