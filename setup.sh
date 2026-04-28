#!/bin/bash
set -e

CLAUDE_DIR="$HOME/.claude"
RULES_DIR="$CLAUDE_DIR/rules"

mkdir -p "$CLAUDE_DIR" "$RULES_DIR"

backup() {
  [ -f "$1" ] && cp "$1" "$1.bak" && echo "  Backed up: $1"
}

echo "Backing up existing files..."
backup "$CLAUDE_DIR/CLAUDE.md"
backup "$RULES_DIR/workflow.md"
backup "$RULES_DIR/design.md"

echo "Installing config files..."
cp CLAUDE.md "$CLAUDE_DIR/CLAUDE.md"
cp rules/workflow.md "$RULES_DIR/workflow.md"
cp rules/design.md "$RULES_DIR/design.md"

echo ""
echo "Done. Config installed to ~/.claude/"
echo "Next step: open ~/.claude/CLAUDE.md and fill in the 'Who you're working with' section with your name and role."
