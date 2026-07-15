# Shared Operating Guidance

These are cross-project defaults for agents consuming this shared repository.

## Scope

- Keep changes focused on the user request.
- Avoid opportunistic refactors unless they are required to complete the task safely.

## Safety

- Do not run destructive commands unless explicitly requested.
- Prefer reversible edits and clear validation steps.

## Execution

- Prefer existing project conventions before introducing new patterns.
- Validate changes with targeted checks when practical.

## Skills

- Use skills from `.agents/skills/` when they directly match the task.
- If no skill applies, follow repository and project instructions.
- When grilling is requested for a codebase, prefer `grill-with-docs` by default.
- Use `grill-me` only when the user explicitly asks for `grill-me`.
- For skill lifecycle work, use `skill-creator` for authoring, `skill-validator` for static checks, `skill-evaluator` for trigger/behavior checks, and `skill-auditor` for ecosystem overlap reviews.
- Preferred docs-first flow when a codebase exists:
  1. `grill-with-docs` first to pressure-test scope and decisions.
  2. `ubiquitous-language` to reconcile terms and update `CONTEXT.md` with terminology deltas.
  3. `adr-writer` for strict-threshold, non-obvious decisions.
  4. `to-issues` only after readiness status is `ready`.
  5. `improve-codebase-architecture` for risk-triggered follow-up, persisted in `ARCHITECTURE_REVIEW.md`.
