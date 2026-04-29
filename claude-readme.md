# Infinum Design — Claude Configuration

This directory contains the team's shared Claude Code configuration. It defines how Claude behaves across all design work at Infinum.

---

## File Structure

```
~/.claude/
├── CLAUDE.md                  ← Core philosophy, behavior rules, key terms
├── rules/
│   ├── design.md              ← Skills, product design, Figma, critique format
│   └── workflow.md            ← Process, AI usage rules, project setup
└── README.md                  ← This file
```

Claude Code automatically loads `CLAUDE.md` and all files in `rules/` at session start — no imports or manual steps needed.

---

## Skill Packages

Two skill packages must be installed for Claude to use the design skills referenced in `rules/design.md`:

| Package | What it covers |
|---|---|
| [Designer Skills Collection](https://github.com/not-alpha/design-team-skills) | 63 skills across design-research, design-systems, ux-strategy, ui-design, interaction-design, prototyping-testing, design-ops, designer-toolkit |
| [Inclusive Design Skills](https://github.com/not-alpha/inclusive-design-skills) | 40 skills across cognitive-accessibility, inclusive-interaction, accessible-content, inclusive-personas, adaptive-interfaces, accessibility-decisions |

See each repo's README for installation instructions.

---

## Config Files

### `CLAUDE.md`
Core philosophy and stable behavioral rules. Claude reads this on every session start.

**Contains:** Core Philosophy · Way of Working (planning, roles, reasoning, response format, constraints) · Key Terms · How to Apply This as Claude

**Update when:** The team's fundamental approach to design changes, a new behavioral rule is needed, or terminology is added or changed.

**Update cadence:** Rarely — this file should be stable.

---

### `rules/design.md`
Design craft — skills, product design conventions, Figma integration, and critique format.

**Contains:** Designer Skills Plugins table · Product Design guidelines · Figma Integration · Critique & Feedback Format

**Update when:** New skills are installed, Figma MCP tools change, design conventions evolve, or critique format is adjusted.

**Update cadence:** When plugins are updated or design conventions change.

---

### `rules/workflow.md`
Process and operational rules — how to start a session, the design process phases, AI usage policy, and the project setup template.

**Contains:** Starting a Session checklist · Process Overview · AI Usage Rules · Project CLAUDE.md Template

**Update when:** The design process changes, AI policy is updated, or the project template needs new fields.

**Update cadence:** Quarterly, or when policy changes.

---

## Project-Level CLAUDE.md

Every client project should have its own `CLAUDE.md` at the project root. This gives Claude the context it needs for that specific project without it being part of the global config.

The template is in `rules/workflow.md`. Copy it into the project folder and fill in all fields before starting work.

### What to fill in per phase

| Phase | Most important fields |
|---|---|
| **Discovery** | Brief, platform, what's in scope |
| **Exploration** | Brief, platform, component library, key constraints |
| **Refinement** | All fields — especially what's been decided |
| **Handoff** | Active phase, component library, what's been decided |
| **QA / DIR** | Active phase, component library, what's been decided |

---

## Making Changes

- Propose changes via PR with a short rationale
- Test the change in at least one real session before merging
- Review cadence: quarterly, or after any major process change
