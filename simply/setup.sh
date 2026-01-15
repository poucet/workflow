#!/bin/bash
# Install Simply plugin using Claude Code CLI

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Simply plugin..."
echo "From: $SCRIPT_DIR"

# Symlink ~/.simply for templates access
if [[ -L "$HOME/.simply" ]]; then
    rm "$HOME/.simply"
fi
ln -s "$SCRIPT_DIR" "$HOME/.simply"
echo "✓ Linked ~/.simply/"

# Uninstall existing plugin and marketplace
claude plugin uninstall simply 2>/dev/null
claude plugin marketplace remove simply-marketplace 2>/dev/null

# Add simply dir as marketplace (contains .claude-plugin/marketplace.json)
claude plugin marketplace add "$SCRIPT_DIR"
claude plugin install simply

# Replace cached plugin with symlink for live development
CACHE_DIR="$HOME/.claude/plugins/cache/simply-marketplace/simply/0.1.0"
if [[ -d "$CACHE_DIR" && ! -L "$CACHE_DIR" ]]; then
    rm -rf "$CACHE_DIR"
    ln -s "$HOME/.simply/plugin" "$CACHE_DIR"
    echo "✓ Linked cache to ~/.simply/plugin"
fi

echo ""
echo "✓ Simply plugin installed!"
echo ""
echo "Next steps:"
echo "  Restart Claude Code, then use '/simply:do' in any project"
