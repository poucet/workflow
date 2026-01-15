#!/bin/bash
# Install Simply workflow at user level

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Simply workflow..."
echo "From: $SCRIPT_DIR"

# Symlink entire simply/ directory to ~/.simply
if [[ -L "$HOME/.simply" ]]; then
    rm "$HOME/.simply"
fi
ln -s "$SCRIPT_DIR" "$HOME/.simply"
echo "✓ Linked ~/.simply/"

# Create ~/.claude/commands/
mkdir -p "$HOME/.claude/commands"

# Symlink command to ~/.simply/simply.md
if [[ -L "$HOME/.claude/commands/simply.md" ]]; then
    rm "$HOME/.claude/commands/simply.md"
fi
ln -s "$HOME/.simply/simply.md" "$HOME/.claude/commands/simply.md"
echo "✓ Linked ~/.claude/commands/simply.md"

echo ""
echo "✓ Simply workflow installed!"
echo ""
echo "Next steps:"
echo "  Use '/simply init' in any project to initialize the workflow"
