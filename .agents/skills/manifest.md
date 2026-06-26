# Shared Skills Manifest

This file tracks reusable skills available in this repository.

## Active Skills

- [`init`](.agents/skills/init/SKILL.md): initialize global opencode AGENTS/opencode.json from shared-agents with explicit confirmation and safety checks.
- [`grill-me`](.agents/skills/grill-me/SKILL.md): pressure-test a plan with rigorous, risk-focused questions when the user explicitly requests `grill-me`.
- [`grill-with-docs`](.agents/skills/grill-with-docs/SKILL.md): docs-first grilling orchestration that emits machine-readable handoffs and routes to language/ADR/issues/architecture sub-workflows.
- [`ubiquitous-language`](.agents/skills/ubiquitous-language/SKILL.md): refine shared domain terms, update `CONTEXT.md`, and enforce terminology deltas/deprecations.
- [`adr-writer`](.agents/skills/adr-writer/SKILL.md): record strict-threshold architecture decisions and prepare blocker-safe ADR issue linkage.
- [`to-issues`](.agents/skills/to-issues/SKILL.md): convert `ready` grilling outcomes into dependency-linked implementation issues.
- [`plan-and-execute`](.agents/skills/plan-and-execute/SKILL.md): uses interactive primary-session planning followed by structured checklist execution for complex software tasks.
- [`improve-codebase-architecture`](.agents/skills/improve-codebase-architecture/SKILL.md): run risk-triggered architecture follow-ups and maintain `ARCHITECTURE_REVIEW.md` cadence metadata.
