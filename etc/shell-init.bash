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

_generic_completion() {
    local tool_script="$1"
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local position=$COMP_CWORD
    local options
    options="$("${tool_script}" complete "${position}" "${COMP_WORDS[@]:1}" 2>/dev/null)"
    local exit_code=$?

    if [ $exit_code -ne 0 ]; then
        COMPREPLY=($(compgen -o default -o dirnames -f -- "$cur"))
        return
    fi

    if [ -n "$options" ]; then
        COMPREPLY=($(compgen -W "$options" -- "$cur"))
    else
        COMPREPLY=($(compgen -o default -o dirnames -f -- "$cur"))
    fi
}

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

    # Create a wrapper function that calls the generic completion with the tool script
    eval "function _comp_${tool_name}() { _generic_completion '$tool_script'; }"

    complete -F "_comp_${tool_name}" "$tool_name"
    echo "  ✓ $tool_name"
}

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/shell-init.sh"
