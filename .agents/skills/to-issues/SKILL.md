---
name: to-issues
description: Use to convert a ready grilling outcome into machine-linked implementation issues with required schema and blocker dependencies.
---

# To Issues

## When to use

- Use after readiness status is `ready`.
- Use when structured handoff data is present and validated.
- Do not use when readiness is `needs changes` or `blocked`.

## Inputs

- Required context: validated handoff JSON, readiness gate results, ADR blocker set.
- Required issue schema fields per issue:
  - `issue_id`
  - `title`
  - `problem_statement`
  - `scope_in`
  - `scope_out`
  - `acceptance_criteria`
  - `dependencies`
  - `blocked_by`
  - `risks`
  - `docs_to_update`
  - `test_notes`

## Workflow

1. Confirm status is `ready` and readiness gate is fully satisfied.
2. Validate required schema fields and generate stable `issue_id` values.
3. Split every ADR-derived unit into its own issue.
4. Mark ADR issues as blockers for all dependent implementation issues via `blocked_by`.
5. Emit issue set in deterministic order with dependency graph integrity.

## Validation

- Required checks:
  - `ready` status present with no failing gate checks.
  - All required schema fields exist for every issue.
  - Every non-ADR dependent issue references at least one ADR blocker when applicable.
  - No deprecated terms appear unless migration override is explicit.
- Expected outcomes:
  - Actionable, unambiguous issue set.
  - Durable machine-readable dependencies.

## Output contract

- Return a structured issue list with full schema fields and blocker links.
- Include a compact dependency report (roots, blocked nodes, unresolved references).
