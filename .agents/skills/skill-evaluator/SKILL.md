---
name: skill-evaluator
description: Use to evaluate agent skills with should-trigger and should-not-trigger cases, executable validation hooks, and pass/fail reports for review or CI.
---

# Skill Evaluator

## When to use

- Use when a new or changed skill needs behavior-oriented validation beyond static structure checks.
- Use when the user asks for trigger tests, skill evals, CI readiness, or proof that a skill activates correctly.
- Use after `skill-validator` passes when both static and behavioral validation are needed.
- Do not use when the task is only to inspect frontmatter, naming, or broken links; use `skill-validator` instead.

## Inputs

- Target skill path or skill name.
- Should-trigger prompts that ought to activate the skill.
- Should-not-trigger prompts that are adjacent but should not activate the skill.
- Optional executable validation scripts, commands, fixtures, or examples referenced by the skill.
- Optional CI constraints, such as required shell, network policy, timeout, and artifact format.

## Workflow

1. Read the target `SKILL.md` and extract its description, `When to use`, non-trigger guidance, validation requirements, and output contract.
2. If trigger cases are missing, derive a minimal suite with at least two should-trigger prompts and two should-not-trigger prompts for non-trivial skills.
3. Check each case against the skill description and body, marking expected activation as `trigger`, `do-not-trigger`, or `ambiguous`.
4. Run any safe executable validation commands referenced by the skill when they are deterministic and allowed by the current environment.
5. Do not run destructive, credential-touching, publishing, deployment, or network-heavy commands without explicit confirmation.
6. Generate a deterministic pass/fail report suitable for review comments or CI logs.
7. Recommend description or trigger-scope edits when cases are ambiguous or overly broad.

## Validation

- Required checks:
  - Every should-trigger case clearly maps to the skill description and `When to use` guidance.
  - Every should-not-trigger case is excluded by explicit non-trigger language or a clear boundary.
  - Referenced executable checks either pass, are skipped with reason, or fail with command output.
  - Ambiguous cases produce concrete wording recommendations.
- Expected outcomes:
  - Skill activation behavior is testable and reviewable.
  - CI reports distinguish static failures, behavior failures, skipped checks, and manual follow-ups.

## Output contract

- Return a report with `overall_status`, `target_skill`, `trigger_cases`, `executable_checks`, and `recommendations`.
- Use `overall_status: pass` only when trigger cases and executable checks meet expectations.
- Use `overall_status: needs changes` when wording, tests, or commands need revision.
