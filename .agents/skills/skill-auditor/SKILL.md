---
name: skill-auditor
description: Use to audit the skill ecosystem for capability coverage, overlapping responsibilities, fragmented guidance, and consolidation opportunities.
---

# Skill Auditor

## When to use

- Use when the user asks to review, audit, rationalize, consolidate, or map available skills.
- Use before adding multiple new skills or after a large skill ecosystem change.
- Use when there may be overlap between skills, commands, agents, `AGENTS.md`, or documentation.
- Do not use for validating one skill's frontmatter or links; use `skill-validator` for static checks.

## Inputs

- Skill roots and manifests to inspect, defaulting to `.agents/skills/` and `.agents/skills/manifest.md`.
- Nearby standing instructions such as `AGENTS.md`, `.agents/instructions.md`, and `.agents/README.md`.
- Optional target domain or concern, such as ADRs, issue generation, planning, or skill creation.
- Optional decision constraints, such as compatibility, portability, or preferred consolidation policy.

## Workflow

1. Inventory all registered and discoverable skills, including name, description, triggers, non-triggers, core workflow, outputs, and supporting files.
2. Build a capability map grouped by outcome rather than by file name.
3. Compare skill descriptions and `When to use` sections for overlapping verbs, trigger phrases, artifacts, and output contracts.
4. Identify fragmented guidance split across skills, `AGENTS.md`, commands, or docs.
5. Classify each concern as `keep separate`, `merge`, `split`, `promote to AGENTS.md`, `demote to docs`, or `convert to command`.
6. Recommend the smallest safe change for each issue and call out risks of changing trigger scope.
7. Do not rewrite skills during the audit unless the user explicitly asks for implementation.

## Validation

- Required checks:
  - Every manifest entry resolves to an existing skill file.
  - Every discovered skill is either registered or intentionally unregistered.
  - Overlap findings cite concrete skill names and trigger text.
  - Consolidation recommendations include rationale and expected behavior impact.
- Expected outcomes:
  - The user can see the ecosystem's capability landscape.
  - Redundancy and fragmentation are actionable instead of speculative.

## Output contract

- Return a capability map, overlap findings, consolidation recommendations, and open questions.
- Prioritize high-risk trigger conflicts before style or naming improvements.
- Include `no findings` explicitly when no meaningful overlap or fragmentation is found.
