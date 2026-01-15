#!/bin/bash

# Pre-compact hook for Claude Code
# Outputs simply pre-compact instructions to Claude

SIMPLY_FILE="${CLAUDE_PROJECT_DIR}/simply/simply.md"

if [[ ! -f "$SIMPLY_FILE" ]]; then
    echo "ERROR: Simply file not found: $SIMPLY_FILE" >&2
    exit 2
fi

# Extract just the Pre-Compact section
sed -n '/^## Pre-Compact/,/^## /p' "$SIMPLY_FILE" | head -n -1 >&2

exit 2
