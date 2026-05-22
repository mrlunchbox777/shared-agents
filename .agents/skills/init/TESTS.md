# Init Skill Test Checklist

Manual QA checklist for `.agents/skills/init/SKILL.md`.

## How to run

1. Start a fresh opencode session.
2. From each scenario's specified working directory, invoke the init workflow (for example by asking: `run init setup`).
3. Follow the scenario steps and compare observed behavior to expected outcomes.
4. Mark each scenario Pass/Fail and record notes.

## Preconditions

- You can access:
  - `~/src/mrlunchbox777/shared-agents`
  - `~/.config/opencode/`
- You can safely create backups under `~/.config/opencode/`.
- You can run read-only git commands in `shared-agents`.

## Safety first

- Before editing config files, make backups:

```bash
cp ~/.config/opencode/AGENTS.md ~/.config/opencode/AGENTS.md.bak 2>/dev/null || true
cp ~/.config/opencode/opencode.json ~/.config/opencode/opencode.json.bak 2>/dev/null || true
```

- After tests, restore backups if desired.

## Scenarios

### T1: Blocks when not in shared-agents root

Setup:

- Run from a different directory (not `~/src/mrlunchbox777/shared-agents`).

Expected:

- Init stops immediately.
- Message states init is blocked because cwd is not shared-agents root.
- Includes retry command:

```bash
cd ~/src/mrlunchbox777/shared-agents
```

- No file writes occur.

### T2: Checks main sync and offers update

Setup:

- Run from shared-agents root.
- Ensure branch is `main` for this test if practical.

Expected:

- Compares local `main` with `origin/main`.
- If behind, offers exactly two options:
  - `Update now (Recommended)`
  - `Skip update`
- If update selected, asks confirmation before running update.

### T3: Global AGENTS create path

Setup:

- Temporarily move existing `~/.config/opencode/AGENTS.md` out of the way (if present).

Expected:

- Proposes initial content for `~/.config/opencode/AGENTS.md`.
- Includes shared-agents references and local-overrides-global precedence.
- Asks exact write confirmation before writing.
- No write occurs if user declines.

### T4: Global AGENTS update path

Setup:

- Ensure `~/.config/opencode/AGENTS.md` exists with custom content.

Expected:

- Reads existing file and proposes update (not blind overwrite).
- Preserves unrelated user content where practical.
- Asks exact write confirmation before writing.

### T5: opencode.json existing-file prompt

Setup:

- Ensure `~/.config/opencode/opencode.json` exists.

Expected:

- Asks exactly:

```text
Found existing ~/.config/opencode/opencode.json. Do you want to update it now?
```

- If declined, no opencode.json write occurs.

### T6: Block-by-block question order

Expected question order:

1. `model`
2. `small_model`
3. `default_agent`
4. `instructions`
5. `skills.paths`
6. `provider`
7. `mcp`
8. `permission`
9. `permission.bash`
10. `plugin`
11. `lsp`
12. `formatter`
13. `autoupdate`
14. `share`
15. `logLevel`

Expected behavior:

- One question at a time.
- Shows current value or `unset`.
- Includes a brief one-line description of what the setting controls.
- Includes a docs reference link for that setting (or `https://opencode.ai/config.json`).
- Offers recommended default and practical options.

### T7: Triple confirmation for risky bash permission

Setup:

- In `permission.bash` step, choose less restrictive than `ask`/`disabled`.

Expected:

- Shows all three escalating warnings with exact semantics.
- Requires explicit affirmative response each time.
- If any response is non-affirmative, final config sets `permission.bash` to `ask`.

### T8: Final preview before write

Expected:

- Before writing opencode.json, presents full proposed JSON.
- Asks exact write confirmation prompt.
- Decline path performs no write.

### T9: Schema freshness and correctness

Purpose:

- Ensure init uses current schema URL and does not rely on stale assumptions.

Checks:

1. Confirm output JSON contains:

```json
"$schema": "https://opencode.ai/config.json"
```

2. During init updates, verify the skill behavior validates uncertain fields against:

`https://opencode.ai/config.json`

3. If adding rarely used fields, confirm the shape in live schema before write.

Pass criteria:

- Schema URL is present and exact.
- No invented/invalid field shapes are introduced.

### T10: Finalization and restart reminder

Expected:

- Summary of changed vs skipped items.
- Reminder to restart opencode after config writes.
- Provides quick verification commands.

## Quick verification commands

Run these after a passing flow:

```bash
ls ~/.config/opencode
```

```bash
python3 -m json.tool ~/.config/opencode/opencode.json >/dev/null
```

```bash
git -C ~/src/mrlunchbox777/shared-agents status --short
```

## Result template

Use this template while running tests:

```text
Date:
Tester:

T1: pass/fail - notes
T2: pass/fail - notes
T3: pass/fail - notes
T4: pass/fail - notes
T5: pass/fail - notes
T6: pass/fail - notes
T7: pass/fail - notes
T8: pass/fail - notes
T9: pass/fail - notes
T10: pass/fail - notes

Overall: pass/fail
Follow-ups:
```
