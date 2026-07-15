---
name: skill-validator
description: Use to validate agent skill structure, frontmatter, path/name consistency, required sections, and broken references before skill changes are accepted.
---

# Skill Validator

## When to use

- Use when a skill is created, edited, copied, ported, or prepared for review.
- Use when the user asks to validate, lint, audit links, or check skill metadata.
- Use before merging broad changes under `.agents/skills/`, `.opencode/skills/`, or `.claude/skills/`.
- Do not use for ordinary application files unless they are supporting files referenced by a skill.

## Inputs

- Skill root paths to inspect, defaulting to `.agents/skills/` when unspecified.
- Changed skill paths from `git diff --name-only` when available.
- Local manifest or index paths, such as `.agents/skills/manifest.md`.
- Any repo-specific section requirements stated in `AGENTS.md`, `.agents/README.md`, or skill templates.

## Workflow

1. Discover candidate `SKILL.md` files under the requested skill roots.
2. Verify each skill file starts with YAML frontmatter containing `name` and `description`.
3. Confirm `name` matches `^[a-z0-9]+(-[a-z0-9]+)*$`, is 1-64 characters, and matches the containing directory name.
4. Confirm `description` is 1-1024 characters and specific enough to guide activation.
5. Check required body sections for the local convention, at minimum `When to use` plus either `Workflow`, `Validation`, or an equivalent action section.
6. Audit relative links and referenced local files from each `SKILL.md`; report missing targets without modifying unrelated files.
7. Confirm manifest/index entries exist when the repository uses a manifest.
8. Produce a pass/fail report grouped by skill, with exact file paths and line references where possible.

## Validation

- Required checks:
  - Every discovered `SKILL.md` has valid frontmatter.
  - Every skill directory name matches its frontmatter `name`.
  - Required sections are present or explicitly justified as not applicable.
  - Referenced local files and manifest entries resolve.
- Expected outcomes:
  - Skill rot is caught before review or merge.
  - Failures are actionable and limited to skill ecosystem files.

## Output contract

- Return `pass` only when all required checks pass.
- Return `fail` with a compact table of findings when any check fails.
- Include skipped roots, assumptions, and any checks that require manual follow-up.
