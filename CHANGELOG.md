# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added docs-first skill orchestration via `.agents/skills/grill-with-docs/SKILL.md` with structured sub-workflow handoffs.
- Added new skills for docs-grounded planning and execution flow:
  - `.agents/skills/ubiquitous-language/SKILL.md`
  - `.agents/skills/adr-writer/SKILL.md`
  - `.agents/skills/to-issues/SKILL.md`
  - `.agents/skills/improve-codebase-architecture/SKILL.md`
- Added machine-readable handoff schema at `.agents/skills/grill-with-docs-handoff.schema.json`.
- Added executable validator at `scripts/validate-grill-workflow`.
- Added fixture harness at `scripts/run-grill-workflow-tests` and test target `make test-grill-workflow`.
- Added skill-level test documentation at `.agents/skills/grill-with-docs/TESTS.md`.
- Added GitHub Actions workflow `.github/workflows/grill-workflow-tests.yaml` to run grill workflow fixture tests on push/PR.

### Changed

- Updated `grill-me` usage to explicit opt-in only; codebase grilling now defaults to `grill-with-docs` routing.
- Updated `.agents/instructions.md` and `.agents/skills/manifest.md` to reflect docs-first flow and explicit `grill-me` behavior.
- Updated `grill-skills-plan.md` with finalized contract decisions from grilling.
