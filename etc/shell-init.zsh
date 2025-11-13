#!/bin/zsh

# ============================================================================
# Zsh Shell Initialization
# ============================================================================
# Source this file once in your ~/.zshrc:
#   source /path/to/workflow/etc/shell-init.zsh
#
# Then call the function to register tools from different directories:
#   register_tools /path/to/workflow
#   register_tools /path/to/project

# --- Zsh-specific Completion Logic ---

# Initialize completion system once
autoload -U compinit &>/dev/null
compinit -u &>/dev/null

_generic_completion() {
    local tool_script="$1"
    local position=$((CURRENT - 1))
    local output
    output="$(${tool_script} complete "${position}" "${words[@]:1}" 2>/dev/null)"
    local exit_code=$?

    if [ $exit_code -ne 0 ]; then
        _files
        return
    fi

    if [ -n "$output" ]; then
        local -a options
        # Check if output contains newlines or spaces
        if [[ "$output" == *$'\n'* ]]; then
            # Split on newlines
            options=("${(@f)output}")
        else
            # Split on spaces
            options=("${(@s: :)output}")
        fi
        _describe 'options' options
    else
        _files
    fi
}

_setup_completion_logic() {
    local tool_name="$1"
    local tool_script="$2"

    if [ ! -f "$tool_script" ]; then
        return
    fi

    # Check if completion is already registered
    if [[ $(type -w "_comp_${tool_name}" 2>/dev/null) == *function* ]]; then
        return
    fi

    # Create a wrapper function that calls the generic completion with the tool script
    eval "function _comp_${tool_name}() { _generic_completion '$tool_script' }"

    compdef "_comp_${tool_name}" "$tool_name"
    echo "  ✓ $tool_name"
}

# Source common functions
SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/shell-init.sh"
