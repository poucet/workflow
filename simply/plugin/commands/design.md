---
description: Develop or continue a design conversation
argument-hint: <idea# or design#>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Design

Collaboratively develop a design document. Can start from an idea or continue an existing design.

## Context

Read frontmatter from `docs/PROJECT.md` for: project, version, phase
Version path: `docs/{project}/{version}/`

**Bootstrap**: PROJECT.md's Architecture section is auto-loaded on session start — use it for codebase context without scanning files.

## Approach

This is a **collaborative conversation**, not a form to fill out. Design happens iteratively across multiple sessions. Guide the user through problem discovery. Ask one or two questions at a time. Validate understanding before moving on.

**Checkpoint often** — save progress to DESIGN.md even if incomplete. Use status to track:
- `draft` — still exploring the problem
- `refined` — problem clear, exploring approaches
- `approved` — ready for `/simply:plan`
- `planned` — mapped to roadmap and tasks

## Steps

1. **Select or resume**:
   - If arg is idea#: start new design from that idea
   - If arg is design#: resume that design, review where we left off
   - If no arg: show ideas (💡 idea / 🎯 ready) AND draft/refined designs, ask what to work on

2. **Understand the problem** (ask iteratively):
   - "What problem are you trying to solve?"
   - "Who experiences this problem? When?"
   - "What happens today without this? What's the impact?"
   - "Can you give me a concrete example?"
   - Summarize your understanding and ask: "Do I have this right?"

3. **Define scope** (ask iteratively):
   - "What would success look like?"
   - "What's explicitly out of scope for now?"
   - "Are there constraints I should know about?"
   - Confirm: "So the goal is X, and we're not trying to do Y—correct?"

4. **Find patterns** (review existing designs and ideas):
   - Read DESIGN.md and IDEAS.md for related problems
   - "This sounds similar to X—is it the same underlying problem?"
   - "I see a pattern here: A, B, and C all need Y. Should we solve this once?"
   - Look for: shared data flows, repeated transformations, common constraints
   - Propose generalizations: "What if we built Z that handles all of these?"

5. **Explore approaches** (only after problem and patterns are clear):
   - "I can think of a few approaches... which resonates?"
   - "What tradeoffs matter most to you?"
   - "Any approaches you've already considered or ruled out?"
   - If patterns found: "Should this be a reusable building block?"

6. **Capture design**: Once aligned, write to DESIGN.md:
   - Problem statement (in user's words)
   - Goals and non-goals
   - Patterns identified (link to related designs if generalizing)
   - High-level approach (not implementation details)
   - Open questions remaining
   - Status: "draft"

7. **Update artifacts**:
   - Update the idea's status in IDEAS.md: 💡 → 🔄 (in progress) while the design is active, or 🗑️ if rejected
   - Update Design Index table in DESIGN.md
   - Run `jj commit` with IDEAS.md and DESIGN.md

8. **Confirm**: Summarize what was captured and suggest next steps
