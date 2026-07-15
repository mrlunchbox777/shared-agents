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

1. Run the deterministic validator first when working in this repository:

```bash
bash skills.sh validate
```

2. If validating a non-default skill root or manifest, pass them explicitly:

```bash
bash skills.sh validate .agents/skills .agents/skills/manifest.md
```

3. Review the script output for frontmatter, name format, directory/name consistency, description length, required sections, broken local Markdown links, and manifest registration.
4. Manually inspect any judgment-based concerns the script cannot prove, such as whether the description is specific enough or trigger scope is too broad.
5. Produce a pass/fail report grouped by skill, with exact file paths and line references where possible.

## Script coverage

- Script path: `.agents/skills/skill-validator/scripts/validate-skills.sh`.
- Repo entrypoint: `skills.sh validate`.
- Deterministic checks: `SKILL.md` discovery, YAML frontmatter presence, required `name` and `description`, name regex, directory/name match, description length, required action sections, local Markdown links, and manifest entries.
- Manual checks: activation specificity, ambiguous trigger wording, and whether missing sections are justified by an unusual skill shape.

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
