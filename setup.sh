#!/usr/bin/env bash
# =============================================================================
# Infinum Design — Claude Code setup
#
# What this does:
#   1. Adds the two community marketplaces (designer + inclusive design)
#   2. Installs Infinum house rules into ~/.claude/infinum/   (we own this dir)
#   3. Appends ONE @import line to ~/.claude/CLAUDE.md        (idempotent)
#
# What this does NOT do:
#   - Overwrite the user's ~/.claude/CLAUDE.md content
#   - Mirror or copy any community-plugin folders into this repo
#   - Auto-install individual plugins (you choose via /plugin)
#
# Re-running is safe — nothing user-owned gets stomped.
# =============================================================================
set -euo pipefail

# Resolve the directory this script lives in so `cp CLAUDE.md ...` etc.
# work whether invoked as `./setup.sh`, from a parent dir, or via the
# Node shim under `bin/install.js` (which `npx` runs from a tmp clone).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

CLAUDE_DIR="${HOME}/.claude"
INFINUM_DIR="${CLAUDE_DIR}/infinum"
USER_CLAUDE_MD="${CLAUDE_DIR}/CLAUDE.md"
IMPORT_LINE="@~/.claude/infinum/index.md  # managed by design-claude-config"

# Community marketplaces.
# TODO(upstream): once contributions land, switch to:
#   - Owl-Listener/designer-skills
#   - Owl-Listener/inclusive-design-skills
MARKETPLACES=(
  "not-alpha/design-team-skills"
  "not-alpha/inclusive-design-skills"
)

# ---------------------------------------------------------------- pretty print
if [ -t 1 ]; then
  RED=$'\e[31m'; GREEN=$'\e[32m'; YELLOW=$'\e[33m'
  CYAN=$'\e[36m'; DIM=$'\e[2m'; BOLD=$'\e[1m'; NC=$'\e[0m'
else
  RED=''; GREEN=''; YELLOW=''; CYAN=''; DIM=''; BOLD=''; NC=''
fi
ok()   { printf '  %s✓%s %s\n' "$GREEN" "$NC" "$*"; }
warn() { printf '  %s⚠%s %s\n' "$YELLOW" "$NC" "$*"; }
fail() { printf '  %s✗%s %s\n' "$RED"    "$NC" "$*" >&2; exit 1; }
step() { printf '\n%s→%s %s%s%s\n'      "$CYAN" "$NC" "$BOLD" "$*" "$NC"; }

# ---------------------------------------------------------------- preflight
printf '\n%sInfinum Design — Claude Code setup%s\n' "$BOLD" "$NC"

if ! command -v claude >/dev/null 2>&1; then
  fail "Claude Code CLI not found. Install: https://docs.anthropic.com/claude-code/install"
fi
ok "Claude Code CLI detected: $(claude --version 2>/dev/null | head -1)"

# ---------------------------------------------------------------- marketplaces
step "Adding community marketplaces"
for source in "${MARKETPLACES[@]}"; do
  # `claude plugin marketplace add` is idempotent: re-add returns success
  # but emits a notice. We swallow output and treat any error as a real failure.
  if claude plugin marketplace add "$source" >/dev/null 2>&1; then
    ok "$source"
  elif claude plugin marketplace list 2>/dev/null | grep -qF "$source"; then
    ok "$source ${DIM}(already added)${NC}"
  else
    warn "Could not add $source — try manually: ${CYAN}claude plugin marketplace add $source${NC}"
  fi
done

# ---------------------------------------------------------------- house rules
step "Installing Infinum house rules to ~/.claude/infinum/"
mkdir -p "$INFINUM_DIR"

# Source files in rules/ → same names under our namespace
cp rules/philosophy.md "$INFINUM_DIR/philosophy.md"
cp rules/workflow.md   "$INFINUM_DIR/workflow.md"
cp rules/design.md     "$INFINUM_DIR/design.md"
ok "Wrote philosophy.md, workflow.md, design.md"

# Personalization stub — only created if missing, so re-runs preserve edits
if [ ! -f "$INFINUM_DIR/whoami.md" ]; then
  cat > "$INFINUM_DIR/whoami.md" <<'EOF'
# Who you're working with

> Replace this with your name and role so Claude can calibrate
> its responses. Example:
>
> "Senior product designer at Infinum, focused on fintech and
> loyalty domains. Comfortable with design systems work; new to
> Flutter."
EOF
  ok "Created whoami.md ${DIM}(edit this to introduce yourself)${NC}"
else
  ok "whoami.md preserved ${DIM}(already personalized)${NC}"
fi

# Index file: regenerated every run so it always reflects current rules
cat > "$INFINUM_DIR/index.md" <<'EOF'
@~/.claude/infinum/whoami.md
@~/.claude/infinum/philosophy.md
@~/.claude/infinum/workflow.md
@~/.claude/infinum/design.md
EOF
ok "Regenerated index.md"

# ---------------------------------------------------------------- link from user CLAUDE.md
step "Linking from ~/.claude/CLAUDE.md"
touch "$USER_CLAUDE_MD"
if grep -qF "$IMPORT_LINE" "$USER_CLAUDE_MD"; then
  ok "Import line already present — no changes"
else
  printf '\n%s\n' "$IMPORT_LINE" >> "$USER_CLAUDE_MD"
  ok "Appended one line to ~/.claude/CLAUDE.md"
fi

# ---------------------------------------------------------------- summary
cat <<EOF

${GREEN}${BOLD}✓ Done.${NC}

${BOLD}Next:${NC}
  • ${CYAN}Personalize:${NC} edit ${DIM}~/.claude/infinum/whoami.md${NC}
  • ${CYAN}Install plugins:${NC} open Claude Code, run ${BOLD}/plugin${NC}, then in
    the Discover tab install whichever skills you want from the two
    marketplaces above (8 design + 6 inclusive plugins available).

${BOLD}Updating later:${NC}
  ${DIM}npx -y github:infinum/design-claude-config${NC}
  ${DIM}# or, if you cloned the repo: cd <clone> && git pull && ./setup.sh${NC}

${BOLD}Uninstall:${NC}
  Remove the line "${DIM}${IMPORT_LINE}${NC}" from ~/.claude/CLAUDE.md
  ${DIM}rm -rf ~/.claude/infinum${NC}
  ${DIM}claude plugin marketplace remove design-team-skills${NC}
  ${DIM}claude plugin marketplace remove inclusive-design-skills${NC}

EOF
