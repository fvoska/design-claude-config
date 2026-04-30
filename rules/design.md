# Design — Skills, Craft & Figma

---

## Skill invocation policy

For any design task, invoke the relevant skill from the installed
community marketplaces (`design-team-skills` and `inclusive-design-skills`)
before responding. Match by skill description — Claude already has all
skill names and descriptions in context once the plugins are installed,
so trust the description match instead of routing through a hardcoded
table.

**Exception:** For quick factual questions, single-concept lookups, or
tasks under ~5 minutes (e.g. "what does DIR mean?"), skill invocation
is optional. Use judgment — if the answer is already in context, skip
the overhead.

**If a skill invocation fails** (unknown skill error), check that the
plugin is installed via `/plugin`. The plugin name precedes the colon
in the skill identifier (e.g. `design-ops:workshop-facilitation` lives
in the `design-ops` plugin).

---

## Infinum-specific skill rules

These override or sequence the default skill matching. They exist
because the rules below can't be derived from individual skill
descriptions alone — they encode Infinum process, not skill behavior.

- **Phase-bound mandates.** At Handoff phase, always invoke
  `design-ops:handoff` and include accessibility notes as part of
  the output — they're not optional.

- **Mobile design systems start with foundations.** Invoke
  `design-systems:mobile-foundation` *before* `design-systems:design-token`
  or `design-systems:naming-convention`. It establishes mobile-specific
  layout constraints (touch targets, safe areas, screen widths, system
  chrome, text scaling, Flutter M3 rules, Figma MCP compatibility) that
  the generic skills assume but don't cover.

- **Accessibility is opt-out, not opt-in.** For any task touching
  diverse users, adaptive interfaces, or assistive technology, invoke
  the relevant `inclusive-*` plugin skill by default. Don't wait to
  be asked — flag WCAG AA issues at the design stage.

- **Motion is purposeful and scheduled.** When motion design comes up,
  invoke `interaction-design:animation-principles` and note it requires
  its own estimate and workflow.

- **Workshops produce specific artefacts.** When prepping or documenting
  workshops, invoke `design-ops:workshop-facilitation` and reference the
  expected outputs (Product Blueprint, value-effort matrix, user story
  map, stakeholder map, GTM canvas).

---

## Product Design Defaults

Behavioral defaults that apply across all design tasks unless the
context overrides them.

### Wireframes
- Always use real, realistic content — never Lorem Ipsum. If you need
  placeholder content, generate plausible examples.
- Don't design every screen state upfront — focus on structure and
  flow first; edge cases come after the core is validated.

### Information Architecture
- When helping with IA, always produce both: **system attributes**
  (what information each screen needs) and a **flowchart** (how screens
  connect). Don't do one without the other.

### Accessibility
- WCAG AA is the default target for every project unless stated otherwise.
- Flag accessibility issues at the design stage — never defer to QA.
- If a design decision compromises accessibility, say so explicitly and
  offer a compliant alternative.

### UI Design
- When exploring visual direction, produce 2 options (max 3). Don't go
  deep on one direction before alternatives have been seen.
- Recommend **desirability testing** when stakeholder or user opinion on
  visual direction is genuinely uncertain — don't recommend it for every
  UI decision.

---

## Figma Integration

### Skill routing

| Task | Load skill |
|---|---|
| Any read, inspect, query, or write on a Figma file | `figma:figma-use` |
| Building or updating a full screen from code or description | `figma:figma-generate-design` |
| Creating or extending a design system library (tokens, components, variants) | `figma:figma-generate-library` |
| Translating a component spec into Figma | `figma:figma-generate-library` |
| Generating code from a Figma design | `figma:figma-implement-design` |
| Mapping Figma components ↔ code counterparts | `figma:figma-code-connect` — trigger: any component that exists in both Figma and a codebase |
| Setting up design system rules in Figma | `figma:figma-create-design-system-rules` |

### Tool selection

| I need | Use |
|---|---|
| Token/variable names + code hints for a node | `get_design_context` |
| File structure, hierarchy, node IDs, positions | `get_metadata` |
| Full variable schema (all collections, values, modes) | `get_variable_defs` |
| Visual check of a node | `get_screenshot` |
| Execute JS in the file | `use_figma` — always load `figma:figma-use` first |

### Constraints (apply to every Figma task)

1. **Inspect before creating.** Discover existing naming conventions,
   token paths, and component names before writing anything. Never
   impose new conventions on an existing file.
2. **Token names from the file.** Use `get_variable_defs` or inspect
   an existing frame to extract exact variable paths. Never hardcode
   hex values or invent token names.
3. **Screenshot after every visual change.** Check alignment, spacing,
   clipping. Fix before reporting complete.
4. **Use the official plugin only.** `mcp__plugin_figma_figma__*`.
   Never use `mcp__figma-console__figma_execute`.

---

## Critique & Feedback Format

Use 🔴🟠🟢 severity labels consistently across all review contexts —
design critique, DIR, and stakeholder feedback.

| Label | Severity | Meaning |
|---|---|---|
| 🔴 | Must fix | Accessibility violation, broken flow, incorrect pattern, blocks launch |
| 🟠 | Should address | UX concern, inconsistency, edge case gap, degrades experience |
| 🟢 | Consider | Improvement opportunity, polish, not blocking |

Always lead with what's working before surfacing issues. Group feedback
by screen or flow, not by severity, to make it actionable.
