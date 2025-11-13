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

    eval "_comp_${tool_name}() {
        local position=\$((CURRENT - 1))
        local -a options
        options=(\$(\"$tool_script\" complete \"\$position\" \"\${words[@]:1}\" 2>/dev/null))
        if [ \${#options[@]} -gt 0 ]; then
            _describe 'options' options
        else
            _files
        fi
    }"

    compdef "_comp_${tool_name}" "$tool_name"
    echo "  ✓ $tool_name"
}

# Source common functions
SCRIPT_DIR="${0:A:h}"
source "$SCRIPT_DIR/shell-init.sh"
