# Design — Skills, Craft & Figma

---

## Designer Skills Plugins

The following skills are installed and **must be used** whenever doing UX/design work. Always invoke the relevant skill(s) before starting any design task.

**Exception:** For quick factual questions, single-concept lookups, or tasks that take under ~5 minutes (e.g. "what does DIR mean?", "give me a one-line definition of X"), skill invocation is optional. Use judgment — if the answer is already in context, don't add overhead.

### Available skills and when to invoke them

| Skill invocation | When to use |
|---|---|
| `design-ops:workshop-facilitation` | Planning or documenting a discovery workshop; producing Product Blueprint, value-effort matrix, user story map, stakeholder map, or GTM canvas |
| `design-ops:figma-file-setup` | Setting up or auditing Figma file structure, naming conventions, or asset export |
| `design-ops:design-review-process` | Design review gates, pre-handoff reviews, or Design Implementation Reviews (DIR) |
| `ux-strategy:experience-map` | Mapping user journeys, touchpoints, phases across a flow |
| `ux-strategy:design-principles` | Establishing or applying design principles to decisions |
| `ux-strategy:design-brief` | Scoping a new design problem |
| `ux-strategy:north-star-vision` | Defining long-term product direction |
| `ux-strategy:opportunity-framework` | Identifying and prioritising design opportunities |
| `ux-strategy:metrics-definition` | Defining success metrics for features |
| `ux-strategy:competitive-analysis` | Benchmarking against competitors |
| `ux-strategy:stakeholder-alignment` | Preparing design decisions for stakeholder review |
| `interaction-design:error-handling-ux` | Any screen with error states, validation, or failure paths |
| `interaction-design:state-machine` | Modelling complex multi-state flows |
| `interaction-design:loading-states` | Async operations, skeleton screens, progress |
| `interaction-design:feedback-patterns` | Confirmations, toasts, inline feedback |
| `interaction-design:gesture-patterns` | Mobile gesture interactions |
| `interaction-design:micro-interaction-spec` | Specifying animations and transitions |
| `interaction-design:animation-principles` | Motion design decisions |
| `designer-toolkit:ux-writing` | Writing or reviewing any product copy |
| `ui-design:*` | Visual design, component decisions, layout |
| `design-systems:mobile-foundation` | Starting or auditing a mobile design library; defining tokens, spacing, layout constants, component anatomy, or variant naming conventions for cross-platform (iOS + Android) mobile |
| `design-systems:*` | Design token or component system decisions |
| `design-research:*` | Research planning, synthesis, insight work |
| `prototyping-testing:*` | Prototype planning or usability test prep |
| `designer-toolkit:*` | General designer workflow and productivity |
| `design-ops:*` | Design team process and operations |
| `cognitive-accessibility:assess-load` | Evaluating cognitive load of a screen or flow |
| `cognitive-accessibility:plain-language-design` | Simplifying copy for clarity and comprehension |
| `cognitive-accessibility:wayfinding-navigation` | Navigation clarity, orientation, and wayfinding |
| `cognitive-accessibility:error-prevention-recovery` | Designing to prevent errors and support recovery |
| `cognitive-accessibility:*` | Any task involving mental effort, attention, or memory |
| `inclusive-interaction:keyboard-navigation` | Keyboard accessibility review or design |
| `inclusive-interaction:touch-target-design` | Touch target sizing and spacing |
| `inclusive-interaction:motion-sensitivity` | Animations that may cause discomfort (vestibular) |
| `inclusive-interaction:audit` | Full interaction accessibility audit |
| `inclusive-interaction:*` | Any interaction pattern that must work across abilities |
| `accessible-content:alt-text-design` | Writing or reviewing alt text for images |
| `accessible-content:form-labelling` | Form field labels, hints, and error messages |
| `accessible-content:heading-structure` | Heading hierarchy and document structure |
| `accessible-content:rewrite` | Rewriting content for accessibility and clarity |
| `accessible-content:*` | Any content that must be perceivable or readable |
| `inclusive-personas:generate` | Creating disability-inclusive user personas |
| `inclusive-personas:ability-spectrum-mapping` | Mapping user needs across an ability spectrum |
| `inclusive-personas:inclusive-user-stories` | Writing user stories that include edge-case users |
| `inclusive-personas:*` | Any research or persona work that should include diverse users |
| `adaptive-interfaces:colour-independence` | Designing without relying on colour alone |
| `adaptive-interfaces:flexible-typography` | Typography that scales and adapts |
| `adaptive-interfaces:responsive-accessibility` | Accessibility across screen sizes and orientations |
| `adaptive-interfaces:*` | Any interface that must adapt to user preferences or context |
| `accessibility-decisions:compliance-mapping` | Mapping design decisions to WCAG criteria |
| `accessibility-decisions:handoff` | Documenting accessibility requirements for developers |
| `accessibility-decisions:tradeoff-analysis` | Evaluating accessibility vs. other design constraints |
| `accessibility-decisions:*` | Documenting, communicating, or auditing accessibility decisions |

### How to invoke

Use the `Skill` tool with the format `pluginName:skillName`:
```
Skill("design-ops:workshop-facilitation")
Skill("interaction-design:error-handling-ux")
```

**If a skill invocation fails** (unknown skill error), find and read the SKILL.md file directly:
```
~/.claude/plugins/cache/designer-skills/{plugin}/{version}/skills/{skill-name}/SKILL.md
~/.claude/plugins/cache/inclusive-design-skills/{plugin}/{version}/skills/{skill-name}/SKILL.md
```

---

## Product Design Defaults

Behavioral defaults that apply across all design tasks unless the context overrides them.

### Wireframes
- Always use real, realistic content — never Lorem Ipsum. If you need placeholder content, generate plausible examples.
- Don't design every screen state upfront — focus on structure and flow first; edge cases come after the core is validated.

### Information Architecture
- When helping with IA, always produce both: **system attributes** (what information each screen needs) and a **flowchart** (how screens connect). Don't do one without the other.

### Accessibility
- WCAG AA is the default target for every project unless stated otherwise.
- Flag accessibility issues at the design stage — never defer to QA.
- If a design decision compromises accessibility, say so explicitly and offer a compliant alternative.

### UI Design
- When exploring visual direction, produce 2 options (max 3). Don't go deep on one direction before alternatives have been seen.
- Recommend **desirability testing** when stakeholder or user opinion on visual direction is genuinely uncertain — don't recommend it for every UI decision.

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

1. **Inspect before creating.** Discover existing naming conventions, token paths, and component names before writing anything. Never impose new conventions on an existing file.
2. **Token names from the file.** Use `get_variable_defs` or inspect an existing frame to extract exact variable paths. Never hardcode hex values or invent token names.
3. **Screenshot after every visual change.** Check alignment, spacing, clipping. Fix before reporting complete.
4. **Use the official plugin only.** `mcp__plugin_figma_figma__*`. Never use `mcp__figma-console__figma_execute`.

---

## Critique & Feedback Format

Use 🔴🟠🟢 severity labels consistently across all review contexts — design critique, DIR, and stakeholder feedback.

| Label | Severity | Meaning |
|---|---|---|
| 🔴 | Must fix | Accessibility violation, broken flow, incorrect pattern, blocks launch |
| 🟠 | Should address | UX concern, inconsistency, edge case gap, degrades experience |
| 🟢 | Consider | Improvement opportunity, polish, not blocking |

Always lead with what's working before surfacing issues. Group feedback by screen or flow, not by severity, to make it actionable.
