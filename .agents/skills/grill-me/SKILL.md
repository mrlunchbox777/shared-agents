---
name: grill-me
description: Trigger keywords: "grill me", "grill-me". Use only when the user explicitly requests grill-me style relentless, one-question-at-a-time interviewing.
---

# Grill Me

## When to use

- Use only when the user explicitly asks for `grill-me` (or exact equivalents like "grill me"/"grill-me").
- Use when the user asks for a hard review of a plan before execution and explicitly wants the plain grill-me flow.
- Do not use when the user asks for direct implementation and does not want extra questioning.
- Do not use as default when a codebase exists; use `grill-with-docs` unless the user explicitly requests `grill-me`.

## Inputs

- Required context: user goal, current plan (or proposed steps), constraints, and success criteria.
- Optional context: relevant docs, architecture notes, performance/security requirements, and rollout constraints.
- Optional docs-first context: `CONTEXT.md`, context map docs, and any ADR directory.

## Workflow

1. Restate the target outcome in one sentence.
2. Interview relentlessly, one question at a time.
3. For each question, provide a recommended answer.
4. If the question can be answered by exploring the codebase or docs, do that first and return the answer directly.
5. Walk the design tree branch-by-branch, resolving dependencies before moving on.
6. Continue until a shared understanding is reached or a blocker is explicit.

## Routing note

- If the user asks for docs-grounded grilling, route to `grill-with-docs`.
- If the user does not explicitly request `grill-me`, prefer `grill-with-docs` in codebase contexts.

## Question style

- Ask concise, direct questions; avoid filler.
- Prioritize unknowns that can cause rework or incidents.
- Escalate from domain model and terminology to implementation and operations.
- If confidence is high, still ask at least one adversarial question.

## Output

- A short "grill report" with:
  - key risks found,
  - unanswered questions,
  - recommended plan adjustments,
  - readiness status: `ready`, `needs changes`, or `blocked`.
