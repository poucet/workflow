#!/bin/bash

# ============================================================================
# Bash Shell Initialization
# ============================================================================
# Source this file once in your ~/.bashrc:
#   source /path/to/workflow/etc/shell-init.bash
#
# Then call the function to register tools from different directories:
#   register_tools /path/to/workflow
#   register_tools /path/to/project

# --- Bash-specific Completion Logic ---

_setup_completion_logic() {
    local tool_name="$1"
    local tool_script="$2"

    if [ ! -f "$tool_script" ]; then
        return
    fi

    # Check if completion is already registered
    if complete -p "$tool_name" &>/dev/null; then
        return
    fi

    eval "_comp_${tool_name}() {
        local cur=\"\${COMP_WORDS[COMP_CWORD]}\"
        local position=\$COMP_CWORD
        local options=\$(\"$tool_script\" complete \"\$position\" \"\${COMP_WORDS[@]:1}\" 2>/dev/null)
        if [ -n \"\$options\" ]; then
            COMPREPLY=(\$(compgen -W \"\$options\" -- \"\$cur\"))
        else
            COMPREPLY=(\$(compgen -f -- \"\$cur\"))
        fi
    }"

    complete -F "_comp_${tool_name}" "$tool_name"
    echo "  ✓ $tool_name"
}

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/shell-init.sh"
