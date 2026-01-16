---
description: Collaboratively develop design from idea
argument-hint: <idea#>
allowed-tools: Bash(jj:*), Read, Write, Edit, Glob
---

# Simply Design

Collaboratively develop a design document from an idea. Focus on understanding the problem deeply before discussing solutions.

## Context

Read `docs/simply.yaml` for: project, version, phase
Version path: `docs/{project}/{version}/`

## Approach

This is a **collaborative conversation**, not a form to fill out. Guide the user through problem discovery. Ask one or two questions at a time. Validate understanding before moving on.

## Steps

1. **Select idea**: Take idea number from args or show Inbox and ask which to explore

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

4. **Explore approaches** (only after problem is clear):
   - "I can think of a few approaches... which resonates?"
   - "What tradeoffs matter most to you?"
   - "Any approaches you've already considered or ruled out?"

5. **Capture design**: Once aligned, write to DESIGN.md:
   - Problem statement (in user's words)
   - Goals and non-goals
   - High-level approach (not implementation details)
   - Open questions remaining
   - Status: "draft"

6. **Update artifacts**:
   - Move idea from Inbox to Triaged in IDEAS.md
   - Update Design Index table
   - Run `jj commit` with IDEAS.md and DESIGN.md

7. **Confirm**: Summarize what was captured and suggest next steps
