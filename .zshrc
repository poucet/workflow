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

        # Otherwise, get completions from the script
        # Position is CURRENT - 1 (to account for tool name at position 1)
        local position=\$((CURRENT - 1))
        local current_word=\"\${words[\$CURRENT]}\"

        # Ask script for completions
        local -a options
        options=(\$(\"$tool_script\" complete \"\$cmd\" \"\$position\" \"\$current_word\" 2>/dev/null))

        if [ \${#options[@]} -gt 0 ]; then
            _describe 'options' options
        else
            # Fallback to file completion if no options provided
            _files
        fi
    }"

    compdef "_comp_${tool_name}" "$tool_name"
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
