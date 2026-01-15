#!/bin/bash
# Install Simply plugin at user level

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Simply plugin..."
echo "From: $SCRIPT_DIR"

# Create ~/.claude/plugins/
mkdir -p "$HOME/.claude/plugins"

# Symlink simply/ directory to ~/.claude/plugins/simply
if [[ -L "$HOME/.claude/plugins/simply" ]]; then
    rm "$HOME/.claude/plugins/simply"
elif [[ -d "$HOME/.claude/plugins/simply" ]]; then
    echo "Error: ~/.claude/plugins/simply exists and is not a symlink"
    exit 1
fi
ln -s "$SCRIPT_DIR" "$HOME/.claude/plugins/simply"
echo "✓ Linked ~/.claude/plugins/simply/"

# Keep ~/.simply for templates access
if [[ -L "$HOME/.simply" ]]; then
    rm "$HOME/.simply"
fi
ln -s "$SCRIPT_DIR" "$HOME/.simply"
echo "✓ Linked ~/.simply/ (for templates)"

echo ""
echo "✓ Simply plugin installed!"
echo ""
echo "Next steps:"
echo "  Use '/simply init' in any project to initialize the workflow"
