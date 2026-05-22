# validate-grill-workflow Spec Checklist

This file defines the expected checks for a future `scripts/validate-grill-workflow` implementation and CI job.

## Runtime + CI enforcement

- Enforce checks during skill execution for immediate feedback.
- Re-run the same checks in CI/local script for repeatability.

## Input contract checks

- Validate handoff payload against `.agents/skills/grill-with-docs-handoff.schema.json`.
- Require `schema_version` and semver format.
- Reject unknown top-level keys unless schema explicitly allows them.

## Readiness gate checks

- Allow `to-issues` only when `status=ready`.
- Require all four gate criteria:
  - `core_terms_reconciled=true`
  - `open_decisions` empty, or each deferred decision has `owner`, `due_date`, and `risk_if_delayed`
  - `adr_state` is `queued` or `recorded` when ADR candidates exist
  - `implementation_slice_bounded=true`
- For `needs changes`, require closure checklist output mapped to gate failures.

## Terminology checks

- Require `language_updates` block with `added`, `changed`, and `deprecated` every session.
- Fail when deprecated terms appear in issue inputs or follow-up docs.
- Allow deprecated-term usage only when `allow_deprecated_terms_for_migration=true`.

## ADR checks

- For each ADR candidate, require strict-threshold flags all true:
  - hard to reverse,
  - surprising without context,
  - meaningful trade-off consequences.
- Require qualification text.
- Ensure ADR-derived work is split into dedicated ADR issues.

## Issue graph checks

- Require issue schema fields for every issue input.
- Require stable `issue_id` for every issue.
- Require ADR issue IDs to appear as blockers for dependent implementation issues.
- Fail on unresolved `blocked_by` references.
- Fail on cycles in blocker graph.

## Architecture follow-up checks

- Require `architecture_followups.review_doc_path = ARCHITECTURE_REVIEW.md`.
- Require reminder cadence metadata.
- Require owner/due_date/risk_if_delayed on every follow-up item.

## Exit conditions

- Pass: all checks clean.
- Fail: emit machine-readable error list with code, path, and remediation hint.
