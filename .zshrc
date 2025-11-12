# Generic zsh initialization for workflow-based projects

# ============================================================================
# Project-specific setup
# ============================================================================

# Determine the project root (current working directory)
PROJECT_ROOT="$(pwd)"

# Determine workflow tools directory
# If this IS the workflow repo, use current directory
# Otherwise, when sourced from ~/.zshrc, use the directory containing this file
if [ -f "$PROJECT_ROOT/bin/workflow" ] && [ -f "$PROJECT_ROOT/.zshrc" ]; then
    WORKFLOW_TOOLS_DIR="$PROJECT_ROOT"
else
    # Get directory containing this .zshrc file
    WORKFLOW_TOOLS_DIR="${0:A:h}"
fi

# Add both workflow tools bin and current project's bin to PATH
_add_scripts_to_path() {
    local dirs_to_add=()

    # Add workflow tools bin if it exists
    if [ -d "$WORKFLOW_TOOLS_DIR/bin" ]; then
        dirs_to_add+=("$WORKFLOW_TOOLS_DIR/bin")
    fi

    # Add current project's bin if it exists and is different
    if [ -d "$PROJECT_ROOT/bin" ] && [ "$WORKFLOW_TOOLS_DIR" != "$PROJECT_ROOT" ]; then
        dirs_to_add+=("$PROJECT_ROOT/bin")
    fi

    # Add each directory to PATH if not already there
    for dir in "${dirs_to_add[@]}"; do
        if [[ ":$PATH:" != *":$dir:"* ]]; then
            export PATH="$dir:$PATH"
        fi
    done

    if [ ${#dirs_to_add[@]} -gt 0 ]; then
        echo "✓ Added bin/ to PATH"
    fi
}

# Setup zsh completion for a tool
_setup_tool_completion() {
    local tool_name="$1"
    local tool_script="$2"

    # Ensure zsh completion system is loaded
    autoload -U compinit 2>/dev/null
    compinit -u 2>/dev/null

    # Create completion function
    eval "_comp_${tool_name}() {
        local -a commands
        local cmd=\"\${words[2]}\"

        # If we're completing the first argument (the subcommand)
        if [ \$CURRENT -eq 2 ]; then
            commands=(\$(\"$tool_script\" commands 2>/dev/null))
            _describe 'commands' commands
            return
        fi

        # Otherwise, get completion info for this subcommand
        local position=\$((CURRENT - 1))
        local completion_info=\$(\"$tool_script\" complete \"\$cmd\" 2>/dev/null)
        [ -z \"\$completion_info\" ] && return 0

        # Parse completion info for this position
        while IFS=: read -r pos comp_type comp_source; do
            [ \$pos -eq \$position ] || continue

            case \"\$comp_type\" in
                branches|static)
                    local -a options
                    options=(\$(eval \"\$comp_source\" 2>/dev/null))
                    _describe 'options' options
                    return
                    ;;
                files)
                    _files
                    return
                    ;;
                freeform)
                    _message \"\$comp_source\"
                    return
                    ;;
            esac
        done <<< \"\$completion_info\"
    }"

    compdef "_comp_${tool_name}" "$tool_name"
}

# Setup completions for all tools in both directories
_setup_completions() {
    local dirs_to_scan=()

    # Scan workflow tools directory
    if [ -d "$WORKFLOW_TOOLS_DIR/bin" ]; then
        dirs_to_scan+=("$WORKFLOW_TOOLS_DIR/bin")
    fi

    # Scan current project's directory if different
    if [ -d "$PROJECT_ROOT/bin" ] && [ "$WORKFLOW_TOOLS_DIR" != "$PROJECT_ROOT" ]; then
        dirs_to_scan+=("$PROJECT_ROOT/bin")
    fi

    if [ ${#dirs_to_scan[@]} -eq 0 ]; then
        return
    fi

    echo "Setting up completions..."

    for bin_dir in "${dirs_to_scan[@]}"; do
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

    echo "✓ Completions ready"
}

# Initialize
_add_scripts_to_path
_setup_completions
