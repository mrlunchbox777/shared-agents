---
name: improve-codebase-architecture
description: Use to run risk-triggered architecture follow-up reviews and maintain ARCHITECTURE_REVIEW.md cadence metadata.
---

# Improve Codebase Architecture

## When to use

- Use when grilling identifies architectural drift, coupling risk, scalability risk, or repeated workaround patterns.
- Use after implementation when explicit architecture follow-up items are produced.
- Do not use as an automatic deep review on every change.

## Inputs

- Required context: architecture risks, affected boundaries/modules, and current constraints.
- Required persistence target: `ARCHITECTURE_REVIEW.md` for reminder cadence and follow-ups.
- Optional context: prior architecture review history and ADR set.

## Workflow

1. Confirm trigger is risk-based (not generic cadence-only execution).
2. Assess impacted boundaries and classify risks by severity and reversibility.
3. Propose architecture improvements with incremental rollout slices.
4. Update or create `ARCHITECTURE_REVIEW.md` with:
  - follow-up actions,
  - owners,
  - due dates,
  - reminder cadence metadata.
5. Emit outputs for downstream planning with clear links to ADRs/issues when needed.

## Validation

- Required checks:
  - Review trigger maps to explicit risk statement.
  - `ARCHITECTURE_REVIEW.md` includes cadence metadata and actionable follow-ups.
  - Any deferred item includes owner, due_date, and risk_if_delayed.
- Expected outcomes:
  - Focused architecture improvements with durable tracking.
  - Lightweight cadence reminders without forced deep-run automation.

## Output contract

- Return:
  - risk summary,
  - recommended architecture changes,
  - updated `ARCHITECTURE_REVIEW.md` entries,
  - linkage hints for issue/ADR workflows.
