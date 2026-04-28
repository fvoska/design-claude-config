# design-claude-config

Shared Claude Code global configuration for the Infinum design team. These files tell Claude how to work with Infinum designers — our philosophy, process, response format, and design skills.

## Prerequisites

[Claude Code](https://claude.ai/code) installed on your machine.

## Setup

```bash
git clone https://github.com/not-alpha/design-claude-config.git
cd design-claude-config
chmod +x setup.sh
./setup.sh
```

Then open `~/.claude/CLAUDE.md` and fill in the **"Who you're working with"** section with your own name and role. This is the most important step — it tells Claude who it's talking to and how to calibrate its responses for you specifically.

## Updating

When the config files change, pull and re-run the script. Your existing files are automatically backed up as `.bak` before being overwritten.

```bash
git pull
./setup.sh
```

## What's included

| File | Installs to | What it does |
|---|---|---|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | Core Infinum design philosophy, way of working, key terms |
| `rules/workflow.md` | `~/.claude/rules/workflow.md` | Session start checklist, process phases, AI usage rules |
| `rules/design.md` | `~/.claude/rules/design.md` | Designer skills reference, Figma integration, critique format |

## What's NOT included

- **Project-specific `CLAUDE.md` files** — these live inside each project folder and are not shared here
- **Memory files** — Claude's session memory is personal and stays on your machine
- **Plugin/skill files** — skills are installed separately via the Claude Code plugin system
