# Workflow — Process, AI Usage & Project Setup

---

## Starting a Session

If the user hasn't provided the following context, ask for it before starting any design task. Don't assume — the right answer depends on all of these.

- **Project phase** — Discovery / Exploration / Refinement / Handoff / QA; determines appropriate depth and expected outputs
- **Platform** — iOS / Android / Web / cross-platform; affects component library assumptions, touch target rules, and system chrome constraints
- **Figma URL** — the relevant frame or section; ask if the task involves reviewing or building on an existing design
- **Component library** — which library is in use, or "none"; never assume one exists
- **Active constraint** — what is fixed (deadline, locked scope, compliance requirement); don't suggest work that conflicts with it
- **What you need** — a decision, a critique, a draft, a spec, a review; determines response format

At **Handoff** phase, always invoke `design-ops:handoff` and include accessibility notes as part of the output.

For new projects, use the Project CLAUDE.md template below.

---

## Process Overview

| Phase | Purpose | Key outputs |
|---|---|---|
| **Workshops & Strategy** | Align on problem, scope, and priorities with stakeholders | Product Blueprint, value-effort matrix, user story map, GTM canvas |
| **Research** | Understand users, context, and constraints | Personas, journey maps, research synthesis, Jobs to be Done |
| **Product Design** | Define structure, flows, and visual direction | IA, wireframes, UI designs, component specs |
| **Gathering Feedback** | Validate design with users and stakeholders | Usability test results, desirability test results, stakeholder sign-off |
| **Handover** | Deliver design to development in a buildable state | Annotated Figma files, handoff spec, accessibility notes |
| **QA / DIR** | Verify implementation matches design intent | DIR findings using 🔴🟠🟢 severity labels |

---

## AI Usage Rules

When AI tools are used in the design process:
- Only public data may be entered — never client-specific information, brand names, intellectual property, raw research data, GDPR-protected data, or workshop findings
- All AI outputs must be fact-checked before use
- AI-generated outputs must not be placed in client-accessible files without human review
- Clients must not be misled into thinking AI output was human-created work
- AI-generated visual assets (images, icons, illustrations) are a legal grey area — written client consent is required before using them in a project

---

## Project CLAUDE.md Template

Each project should have its own `CLAUDE.md` at the root of the project folder. Copy and fill in this template at project start:

```markdown
# [Project Name]

## Brief
[One paragraph: the problem being solved, target user, and business goal]

## Platform
[iOS / Android / Web / cross-platform]

## Stack
- Framework: [React + Tailwind / Flutter M3 / iOS SwiftUI / etc.]
- Component library: [name, or "building from scratch"]

## Active phase
[Discovery / Exploration / Refinement / Handoff / QA]

## Key constraints
[Fixed deadline, locked scope, compliance requirement, client-mandated patterns, etc.]

## Figma
- Screens file key: [fileKey from URL]
- Design library key: [fileKey, or "same as screens", or "none"]
- Token collections: [list names, or "discover via get_variable_defs"]
- Code Connect: [established / in progress / not set up]

## What's been decided
[Design decisions already made that Claude should not re-open or challenge]

## What's in scope
[Features or flows Claude should focus on in this project]
```
