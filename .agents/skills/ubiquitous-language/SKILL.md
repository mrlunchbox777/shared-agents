---
name: ubiquitous-language
description: Use to refine and persist shared domain terms in CONTEXT.md (or selected context docs), emit terminology deltas, and enforce deprecated-term policy.
---

# Ubiquitous Language

## When to use

- Use when `/grill-with-docs` identifies fuzzy, conflicting, or missing domain terms.
- Use when preparing implementation outputs that require stable term definitions.
- Do not use when the task is purely low-level implementation with no domain-language impact.

## Inputs

- Required context: active feature/problem statement, current glossary terms, code references using impacted terms.
- Required docs target resolution order:
  1. Nearest `CONTEXT.md` in the active working area.
  2. Repo-root `CONTEXT.md`.
  3. `contexts/<name>/CONTEXT.md` when explicitly selected.
- Optional context: prior terminology deltas and migration notes.

## Workflow

1. Locate the canonical context doc using the required resolution order.
2. Extract terms affected by current design decisions and compare against code naming.
3. Propose concrete term updates and challenge ambiguous wording.
4. Apply accepted glossary edits to the target context doc.
5. Emit a mandatory terminology delta block with `added`, `changed`, and `deprecated`.
6. Validate downstream artifacts for deprecated-term usage; fail unless explicit migration override is set.

## Validation

- Required checks:
  - Terminology delta is present for every session output.
  - Deprecated terms do not appear in downstream outputs unless `allow_deprecated_terms_for_migration=true`.
  - Updated terms are reflected consistently in examples and relationships.
- Expected outcomes:
  - A stable glossary update in the selected context doc.
  - A machine-readable terminology delta suitable for handoff schema consumers.

## Output contract

- Return a concise report with:
  - selected context doc path,
  - term updates applied,
  - deprecated-term violations (if any),
  - required migration override notice (if used).
