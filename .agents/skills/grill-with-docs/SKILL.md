---
name: grill-with-docs
description: Use to pressure-test implementation plans against codebase docs, refine language, capture ADR decisions, and emit machine-readable handoff JSON for downstream workflows.
---

# Grill With Docs

## When to use

- Use when a codebase exists and the user wants grilling plus documentation-grounded alignment.
- Use before implementation when requirements, terms, decisions, or sequencing are still fluid.
- Do not use for non-codebase brainstorming where plain `grill-me` is sufficient.

## Inputs

- Required context: user goal, current plan, repo context, and success criteria.
- Required docs-first context: nearest `CONTEXT.md` (fallback to repo root, then explicit `contexts/<name>/CONTEXT.md`).
- Optional context: existing ADR files, architecture review notes, and open implementation issues.

## Workflow

1. Restate target outcome in one sentence.
2. Interview one question at a time with recommendation-first prompts.
3. Resolve terminology using `ubiquitous-language` sub-workflow and emit terminology deltas.
4. Identify strict-threshold decisions and route to `adr-writer` sub-workflow.
5. Maintain readiness-gate state while grilling:
   - core terms reconciled,
   - open decisions resolved/deferred with owner+due_date+risk_if_delayed,
   - ADR-required decisions queued or recorded,
   - implementation slice bounded.
6. Emit a machine-readable handoff JSON block with required sections:
   - `language_updates`
   - `adr_candidates`
   - `readiness_gate`
   - `issue_inputs`
   - `architecture_followups`
7. If status is `ready`, `to-issues` may execute.
8. If status is `needs changes`, emit closure checklist mapped to failed gate checks.
9. If risk signals exist, emit `improve-codebase-architecture` follow-ups persisted to `ARCHITECTURE_REVIEW.md`.

## Validation

- Required checks:
  - Handoff JSON validates against `.agents/skills/grill-with-docs-handoff.schema.json`.
  - Deprecated terms are blocked unless migration override is explicit.
  - ADR-derived work is split into dedicated ADR issues and linked as blockers.
  - `to-issues` is not invoked unless status is `ready`.
- Expected outcomes:
  - Shared understanding grounded in repo language.
  - Deterministic downstream execution without re-discovery.

## Output contract

- Return:
  - concise grill report with readiness status,
  - unresolved risks/questions,
  - recommended plan adjustments,
  - schema-versioned handoff JSON block for sub-workflows.
