# Tests

This skill includes workflow-contract validation for grill-with-docs handoff payloads.

## Validator

- Script: `scripts/validate-grill-workflow`
- Purpose: validate handoff JSON contract, readiness rules, ADR blocker rules, and architecture follow-up requirements.

## Fixture suite

- Harness: `scripts/run-grill-workflow-tests`
- Fixture directory: `.agents/skills/examples/grill-workflow-tests`
- Naming rule:
  - `pass-*.json` must pass validation
  - `fail-*.json` must fail validation

Current fixtures:

- `pass-needs-changes-with-closure.json`
- `pass-e2e-dry-run-artifact.json`
- `fail-needs-changes-missing-closure.json`
- `fail-deprecated-term-used.json`
- `pass-deprecated-term-with-override.json`
- `fail-unresolved-blocker.json`
- `fail-blocker-cycle.json`
- `fail-adr-threshold-flag.json`
- `fail-ready-with-open-decisions.json`

## Run

```bash
scripts/validate-grill-workflow .agents/skills/examples/grill-with-docs-handoff.sample.json
```

```bash
scripts/run-grill-workflow-tests
```

```bash
make test-grill-workflow
```

## Expected result

- Exit code `0` and:

```json
{
  "ok": true,
  "message": "Validation passed"
}
```

## Failure output format

- Non-zero exit code.
- JSON array of errors with:
  - `code`
  - `path`
  - `hint`

## Latest run

- `scripts/run-grill-workflow-tests` passed with 9/9 fixtures.

## CI

- GitHub Actions runs this suite via `.github/workflows/grill-workflow-tests.yaml`.
