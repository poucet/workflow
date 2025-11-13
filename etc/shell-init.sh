#!/bin/bash

# ============================================================================
# Common Shell Initialization Functions
# ============================================================================
# This file contains shell-agnostic helper functions.
# Do not source this directly - use shell-init.zsh or shell-init.bash instead.

# Register tools from a specified directory, based on a '.tools' manifest file.
# Usage: register_tools /path/to/project
register_tools() {
    local target_dir="$1"

    if [ -z "$target_dir" ] || [ ! -d "$target_dir" ]; then
        echo "⚠ Directory not found: $target_dir"
        return
    fi

    if [ ! -f "$target_dir/.tools" ]; then
        return
    fi

    local project_bin_dir="$target_dir/bin"
    if [ ! -d "$project_bin_dir" ]; then
        return
    fi

    # Add the project's bin to the PATH if not already present
    if [[ ":$PATH:" != *":$project_bin_dir:"* ]]; then
        export PATH="$project_bin_dir:$PATH"
        echo "  ✓ Added $project_bin_dir to PATH"
    fi

    # Read the .tools file and register each tool
    while IFS= read -r tool_name || [[ -n "$tool_name" ]]; do
        # Ignore comments and empty lines
        if [[ "$tool_name" =~ ^\s*# ]] || [[ -z "$tool_name" ]]; then
            continue
        fi
        _setup_completion_logic "$tool_name" "$project_bin_dir/$tool_name"
    done < "$target_dir/.tools"
}
