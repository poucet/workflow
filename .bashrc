# Generic bash initialization for workflow-based projects

# ============================================================================
# Project-specific setup
# ============================================================================

# Determine the project root (current working directory)
PROJECT_ROOT="$(pwd)"

# Determine workflow tools directory
# If this IS the workflow repo, use current directory
# Otherwise, when sourced from ~/.bashrc, use the directory containing this file
if [ -f "$PROJECT_ROOT/bin/workflow" ] && [ -f "$PROJECT_ROOT/.bashrc" ]; then
    WORKFLOW_TOOLS_DIR="$PROJECT_ROOT"
else
    # Get directory containing this .bashrc file
    WORKFLOW_TOOLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

# Setup bash completion for a tool
_setup_tool_completion() {
    local tool_name="$1"
    local tool_script="$2"

    # Create completion function
    eval "_comp_${tool_name}() {
        local cur=\${COMP_WORDS[COMP_CWORD]}
        local prev=\${COMP_WORDS[COMP_CWORD-1]}
        local cmd=\${COMP_WORDS[1]}

        # If we're completing the first argument (the subcommand)
        if [ \$COMP_CWORD -eq 1 ]; then
            local commands=\$(\"$tool_script\" commands 2>/dev/null)
            COMPREPLY=(\$(compgen -W \"\$commands\" -- \"\$cur\"))
            return
        fi

        # Otherwise, get completion info for this subcommand
        local position=\$COMP_CWORD
        local completion_info=\$(\"$tool_script\" complete \"\$cmd\" 2>/dev/null)
        [ -z \"\$completion_info\" ] && return 0

        # Parse completion info for this position
        while IFS=: read -r pos comp_type comp_source; do
            [ \$pos -eq \$position ] || continue

            case \"\$comp_type\" in
                branches|static)
                    local options=\$(eval \"\$comp_source\" 2>/dev/null)
                    COMPREPLY=(\$(compgen -W \"\$options\" -- \"\$cur\"))
                    return
                    ;;
                files)
                    COMPREPLY=(\$(compgen -f -- \"\$cur\"))
                    return
                    ;;
                freeform)
                    # Just allow any input
                    return
                    ;;
            esac
        done <<< \"\$completion_info\"
    }"

    complete -F "_comp_${tool_name}" "$tool_name"
}

# Setup PATH and completions in a single pass
_setup_scripts() {
    local dirs_to_scan=()

    # Add workflow tools bin if it exists
    if [ -d "$WORKFLOW_TOOLS_DIR/bin" ]; then
        dirs_to_scan+=("$WORKFLOW_TOOLS_DIR/bin")
    fi

    # Add current project's bin if it exists and is different
    if [ -d "$PROJECT_ROOT/bin" ] && [ "$WORKFLOW_TOOLS_DIR" != "$PROJECT_ROOT" ]; then
        dirs_to_scan+=("$PROJECT_ROOT/bin")
    fi

    if [ ${#dirs_to_scan[@]} -eq 0 ]; then
        return
    fi

    # Add directories to PATH and setup completions in one pass
    for bin_dir in "${dirs_to_scan[@]}"; do
        # Add to PATH if not already there
        if [[ ":$PATH:" != *":$bin_dir:"* ]]; then
            export PATH="$bin_dir:$PATH"
        fi

        # Setup completions for tools in this directory
        for tool_script in "$bin_dir"/*; do
            [ ! -f "$tool_script" ] && continue

            local tool_name=$(basename "$tool_script")
            local commands=$("$tool_script" commands 2>/dev/null)

            if [ -n "$commands" ]; then
                _setup_tool_completion "$tool_name" "$tool_script"
                echo "  ✓ $tool_name"
            fi
        done
    done

    echo "✓ Scripts ready"
}

# Initialize
_setup_scripts
