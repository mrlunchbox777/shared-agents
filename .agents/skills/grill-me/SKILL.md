---
name: grill-me
description: Trigger keywords: "grill me", "grill-me", "grill with docs", "grill-with-docs". Use when the user wants relentless, one-question-at-a-time interviewing to stress-test plans/designs before execution.
---

# Grill Me

## When to use

- Use when the user explicitly asks to be grilled, pressure-tested, challenged, or requests grill-with-docs behavior.
- Use when the user asks for a hard review of a plan before execution or architecture validation.
- Do not use when the user asks for direct implementation and does not want extra questioning.

## Inputs

- Required context: user goal, current plan (or proposed steps), constraints, and success criteria.
- Optional context: relevant docs, architecture notes, performance/security requirements, and rollout constraints.
- Optional docs-first context: `CONTEXT.md`, context map docs, and any ADR directory (for grill-with-docs style).

## Workflow

1. Restate the target outcome in one sentence.
2. Interview relentlessly, one question at a time.
3. For each question, provide a recommended answer.
4. If the question can be answered by exploring the codebase or docs, do that first and return the answer directly.
5. Walk the design tree branch-by-branch, resolving dependencies before moving on.
6. Continue until a shared understanding is reached or a blocker is explicit.

## Grill-with-docs mode

- Prefer this mode when a codebase exists and docs are available.
- Look for `CONTEXT.md` first; if present, treat it as canonical shared language.
- Challenge fuzzy terminology against existing glossary/domain terms.
- Cross-reference terms with actual code naming and boundaries.
- When decisions are non-obvious and hard to reverse, propose ADR updates.
- If requested, draft/update `CONTEXT.md` and ADR notes as decisions crystallize.

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
