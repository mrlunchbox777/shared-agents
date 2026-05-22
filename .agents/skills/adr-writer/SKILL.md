---
name: adr-writer
description: Use to draft ADR records for strict-threshold decisions discovered during grilling and produce blocker-ready issue metadata.
---

# ADR Writer

## When to use

- Use when a decision meets all strict criteria: hard to reverse, surprising without context, and meaningful trade-off.
- Use when `/grill-with-docs` marks a decision as ADR-required.
- Do not use for routine choices with low consequence or easy reversibility.

## Inputs

- Required context: decision statement, alternatives considered, selected option, consequences, and traceable evidence.
- Required policy: strict ADR threshold with explicit qualification text for why the decision qualifies.
- Optional context: existing ADR index and naming conventions.

## Workflow

1. Confirm decision satisfies strict threshold and produce explicit qualification text.
2. Draft ADR markdown with context, decision, alternatives, consequences, and status.
3. Assign stable ADR issue metadata for downstream planning (`issue_id`, `blocked_by` linkage target).
4. Queue or write ADR file path according to repository conventions.
5. Emit references for dependent implementation issues to treat ADR issues as blockers.

## Validation

- Required checks:
  - Qualification text includes all three strict-threshold criteria.
  - ADR includes at least one rejected alternative and consequence section.
  - Downstream issue contract marks ADR issue as blocker for dependent work.
- Expected outcomes:
  - High-signal ADR artifacts only (no ADR spam).
  - Deterministic linkage for issue generation.

## Output contract

- Return:
  - ADR qualification summary,
  - ADR file path/name,
  - stable `issue_id` for ADR-linked issue,
  - list of implementation issue IDs blocked by this ADR.
