# design-claude-config

Shared Claude Code configuration for the Infinum design team — our philosophy,
process, response format, and skill-invocation rules. Layers on top of two
community marketplaces (designer skills + inclusive design skills) without
overwriting your personal Claude config.

## Prerequisites

- [Claude Code](https://claude.ai/code) installed on your machine.
- **SSH access to the Infinum GitHub org.** This repo is private, and the
  install command clones it over SSH. If `git clone git@github.com:infinum/design-claude-config.git`
  works for you in a terminal, you're set. If not, follow GitHub's
  [add an SSH key to your account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
  guide and make sure you've been added to the Infinum org.
- Node.js 24 (current LTS).

## Setup

One command, no clone required:

```bash
npx -y github:infinum/design-claude-config
```

The script will:

1. Add the two community marketplaces (`not-alpha/design-team-skills`,
   `not-alpha/inclusive-design-skills`) via `claude plugin marketplace add`.
2. Install Infinum house rules into a namespaced directory you own:
   `~/.claude/infinum/`.
3. Append **one** `@import` line to `~/.claude/CLAUDE.md` — your personal
   file is preserved, never stomped.

After it finishes:

- **Personalize**: edit `~/.claude/infinum/whoami.md` so Claude knows your role.
- **Install plugins**: open Claude Code, run `/plugin`, then in the Discover
  tab install whichever skills you want from the two marketplaces.

### Alternative: clone and run

If you'd rather inspect the script before running it, or you don't have Node:

```bash
git clone git@github.com:infinum/design-claude-config.git
cd design-claude-config
./setup.sh
```

Both paths run the same `setup.sh` — `npx` just clones to a tmp dir for you.
Both require SSH access to the Infinum org (see Prerequisites).

## Updating

Re-runs are idempotent — your `whoami.md` personalization is preserved, the
import line is added only if missing, and existing marketplaces aren't
re-added.

```bash
npx -y github:infinum/design-claude-config
# or, if you cloned the repo:
cd <clone> && git pull && ./setup.sh
```

## What this repo does NOT mirror

This repo contains **only Infinum-specific rules and policy**. It does
not vendor, mirror, or copy any community plugin folders. The community
marketplaces stay under their own maintenance — we just add them via
the `claude plugin marketplace add` command in `setup.sh`.

## What gets installed

| Source file (this repo) | Installed to | Owner | Overwritten on re-run? |
|---|---|---|---|
| `rules/philosophy.md` | `~/.claude/infinum/philosophy.md` | this repo | yes |
| `rules/workflow.md` | `~/.claude/infinum/workflow.md` | this repo | yes |
| `rules/design.md` | `~/.claude/infinum/design.md` | this repo | yes |
| _(generated)_ | `~/.claude/infinum/whoami.md` | the user | **no** (preserved) |
| _(generated)_ | `~/.claude/infinum/index.md` | this repo | yes |
| _(one line appended)_ | `~/.claude/CLAUDE.md` | the user | no (idempotent) |

> Note: this repo's own `CLAUDE.md` is **not** installed. It's
> repo-context for Claude when editing this project (the install
> pattern, conventions, testing) — not design rules for users.

The `index.md` file is what `~/.claude/CLAUDE.md` imports — it just chains
the four other files via `@import`.

## How it loads

Claude Code reads `~/.claude/CLAUDE.md` at session start. Our one appended
line is `@~/.claude/infinum/index.md`, which in turn imports the four rule
files. Same loading semantics as inline content, with full isolation.

```
~/.claude/CLAUDE.md
└── @~/.claude/infinum/index.md
    ├── @whoami.md       ← who you are (you edit this)
    ├── @philosophy.md   ← Infinum design philosophy + key terms
    ├── @workflow.md     ← session start, process, AI policy, project template
    └── @design.md       ← skill invocation policy, Figma rules, critique format
```

## Skill plugins

Skills come from two community marketplaces, not from this repo:

| Marketplace | Skills | What's covered |
|---|---|---|
| [`design-team-skills`](https://github.com/not-alpha/design-team-skills) | 63 skills, 8 plugins | Research, systems, strategy, UI, interaction, prototyping, ops, toolkit |
| [`inclusive-design-skills`](https://github.com/not-alpha/inclusive-design-skills) | 40 skills, 6 plugins | Cognitive, interaction, content, personas, adaptive, decisions |

Both currently point at our forks. Once upstream contributions land, they
will switch to `Owl-Listener/designer-skills` and `Owl-Listener/inclusive-design-skills`.

## Uninstall

```bash
# 1. Remove the import line from ~/.claude/CLAUDE.md (one line, marked with
#    "managed by design-claude-config")
# 2. Remove the namespace
rm -rf ~/.claude/infinum
# 3. Remove the marketplaces (optional)
claude plugin marketplace remove design-team-skills
claude plugin marketplace remove inclusive-design-skills
```

## Making changes

- Open a PR with rationale.
- Test in at least one real session before merging.
- Review cadence: quarterly, or after any major process change.
