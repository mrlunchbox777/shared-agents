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
