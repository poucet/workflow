# Claude Code Project Guidelines

## Version Control

- Use `jj commit` for all commits (not `git commit` or `jj describe`)
- Only include files relevant to the current change
- Write clear, concise commit messages

## Build & Test

- Do not run tests, builds, or type generation commands
- The user handles all verification and testing

## Development Approach

- Work on one feature at a time
- Break features into small, atomic steps that compile independently
- Each step should be a self-contained, working incremental `jj commit`

## Documentation

**See `simply/simply.md` for the development workflow.**

- Update phase docs before each commit (DEVLOG, OBSERVATIONS, etc.)

## Self-Improvement

- When corrected, update this file or simply/ to capture the lesson
- Treat corrections as opportunities to improve future interactions
