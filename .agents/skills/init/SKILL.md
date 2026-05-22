---
name: init
description: Use ONLY when the user asks to initialize or bootstrap opencode global setup (for example "init", "first-time setup", "configure ~/.config/opencode", or "set up shared-agents"). Verifies shared-agents root, proposes global AGENTS.md and opencode.json updates, and requires explicit confirmation before writes.
---

# Init Skill

Initialize a machine-level opencode setup that points to this shared repository while preserving local override priority.

## When to use

- Use when the user asks to initialize or repair global opencode setup from this repository.
- Use when the user wants help creating or updating `~/.config/opencode/AGENTS.md` and `~/.config/opencode/opencode.json`.
- Do not use for regular per-project coding tasks.

## Required behaviors

1. Never write files without explicit user confirmation.
2. If a target file exists, propose a diff-style update first.
3. Prefer safe defaults and explain priority/override behavior clearly.
4. Ask exactly one question at a time during configuration steps.
5. Use the exact confirmation prompts in this skill for any write/update action.

## Workflow

### 1) Verify execution location

1. Detect current working directory and git root.
2. Confirm execution is from shared-agents root.
   - Expected root pattern: repository containing `AGENTS.md` and `.agents/` for this shared repo.
3. If not at root, stop and report:
   - Why initialization is blocked.
   - Exact command to retry from root, for example:

```bash
cd ~/src/mrlunchbox777/shared-agents
```

Do not continue until user reruns from root.

Required blocked message format:

```text
Init is blocked: current directory is not the shared-agents root.
Run this command, then run init again:
cd ~/src/mrlunchbox777/shared-agents
```

### 2) Check sync status of shared-agents main

1. Fetch remote state safely (read-only git operations).
2. Compare local `main` against `origin/main`.
3. If behind, offer update options:
   - Recommended: fast-forward local main.
   - Alternative: continue without updating.
4. If user chooses update, request confirmation before executing update command.

Ask using this menu:

- `Update now (Recommended)`: fast-forward local main from origin/main.
- `Skip update`: continue initialization with current checkout.

If update is selected, ask exactly:

```text
About to update shared-agents main from origin/main. Confirm update?
```

### 3) Prepare global AGENTS.md

Target file: `~/.config/opencode/AGENTS.md`

1. If missing:
   - Propose initial file content.
   - Explain it points to shared-agents as global baseline.
2. If present:
   - Read and summarize current structure.
   - Propose update that preserves user custom content when possible.
3. In both cases, include explicit precedence model in the file content:
   - Global/shared instructions are baseline defaults.
   - Local/project instructions and skills override global settings.
   - More specific scope has higher priority.

Suggested precedence wording to include:

1. Session/tool runtime constraints (highest)
2. Repository-local `AGENTS.md` and `.agents/` instructions
3. Parent-directory/project-scoped instructions
4. Global `~/.config/opencode/AGENTS.md`
5. Shared reusable guidance from `shared-agents` (baseline)

4. Ask for confirmation before writing or modifying `~/.config/opencode/AGENTS.md`.

Use this exact write confirmation prompt:

```text
I have a proposed AGENTS.md update for ~/.config/opencode/AGENTS.md. Write this change?
```

### 4) Offer global opencode.json setup

Target file: `~/.config/opencode/opencode.json`

1. Detect whether file exists.
2. If file exists, ask whether to update it.
3. If missing or user says yes, run an interactive configuration flow.

If file exists, ask exactly:

```text
Found existing ~/.config/opencode/opencode.json. Do you want to update it now?
```

Configuration flow requirements:

1. Start with `"$schema": "https://opencode.ai/config.json"`.
2. Step through major configurable blocks one at a time, for example:
   - `model`, `small_model`
   - `default_agent`
   - `instructions`
   - `skills.paths`
   - `provider`
   - `mcp`
   - `permission`
   - `plugin`
   - `lsp`, `formatter`, `autoupdate`, `share`, `logLevel`
3. For each block:
   - Offer practical options (unset, enable/disable, add entry, keep current).
   - Provide a recommended default and at least one concrete example when option space is large.
4. Merge updates conservatively; do not delete unrelated existing keys.
5. Present final proposed JSON before any write.
6. Ask for explicit confirmation before writing.

Use this exact write confirmation prompt:

```text
I have a proposed opencode.json update for ~/.config/opencode/opencode.json. Write this change?
```

### 4a) Canonical block-by-block question flow

Ask blocks in this order. Ask one question at a time. For each block, show current value (or `unset`) and offer options.

1. `model`
   - Recommended: set explicit provider/model.
   - Options: `keep current`, `unset`, `set to example anthropic/claude-sonnet-4-6`, `enter custom`.
2. `small_model`
   - Recommended: set a cheaper/faster model if available.
   - Options: `keep current`, `unset`, `set example`, `enter custom`.
3. `default_agent`
   - Recommended: keep `general` unless user has a strong preference.
   - Options: `keep current`, `unset`, `set general`, `enter custom`.
4. `instructions`
   - Recommended: include `AGENTS.md`.
   - Options: `keep current`, `replace with ["AGENTS.md"]`, `append AGENTS.md`, `enter custom list`.
5. `skills.paths`
   - Recommended: include `~/src/mrlunchbox777/shared-agents/.agents/skills`.
   - Options: `keep current`, `unset`, `set recommended path only`, `append recommended path`, `enter custom paths`.
6. `provider`
   - Recommended: leave unset unless user is actively configuring credentials.
   - Options: `keep current`, `unset`, `add provider block`, `edit existing provider block`.
   - Example provider key: `anthropic`, `openai`, `google`.
7. `mcp`
   - Recommended: keep minimal on first setup.
   - Options: `keep current`, `unset`, `add local server`, `add remote server`.
8. `permission`
   - Recommended: conservative baseline.
   - Options: `keep current`, `set baseline permissions`, `edit specific tool permission`.
9. `permission.bash` (always ask even if `permission` unchanged)
   - Recommended: `ask`.
   - Options: `ask (Recommended)`, `disabled`, `allow with patterns`, `allow broadly`.
10. `plugin`
   - Recommended: keep unset initially.
   - Options: `keep current`, `unset`, `add npm plugin`, `add local plugin path`.
11. `lsp`
   - Recommended: keep default behavior (`unset`) unless user wants explicit off/on.
   - Options: `keep current`, `unset`, `true`, `false`.
12. `formatter`
   - Recommended: keep default behavior (`unset`) unless user wants explicit off/on.
   - Options: `keep current`, `unset`, `true`, `false`.
13. `autoupdate`
   - Recommended: `notify`.
   - Options: `keep current`, `unset`, `true`, `false`, `notify`.
14. `share`
   - Recommended: `manual`.
   - Options: `keep current`, `unset`, `manual`, `auto`, `disabled`.
15. `logLevel`
   - Recommended: `INFO`.
   - Options: `keep current`, `unset`, `DEBUG`, `INFO`, `WARN`, `ERROR`.

After final block, present full proposed JSON and request write confirmation.

### 5) Bash permission hardening (mandatory)

When configuring permissions:

1. Recommend `permission.bash` as `"ask"` (or disabled, if user prefers strict mode).
2. If user chooses anything less restrictive than ask/disabled (for example broad allow):
   - Perform a three-step escalating confirmation sequence.
   - Use progressively stronger warnings each time.
   - Require an explicit "yes" at each step.
3. If any confirmation is not affirmative, revert proposal to `ask`.

Escalation pattern:

1. Warning 1: accidental destructive command risk.
2. Warning 2: credential and data loss exposure risk.
3. Warning 3: final security confirmation with recommendation to keep `ask`.

Use these exact prompts for non-`ask`/non-`disabled` choices:

1. `Security warning 1/3: allowing bash beyond ask can run destructive commands accidentally. Continue with this bash setting?`
2. `Security warning 2/3: this can expose credentials or delete data if a command is misused. Continue with this bash setting?`
3. `Security warning 3/3 (final): recommended setting is bash=ask. Do you explicitly want to keep this less restrictive setting?`

Acceptance rule:

- Require explicit affirmative response to all three prompts.
- Any non-affirmative response (including uncertainty) sets `permission.bash` to `ask`.
- Report this fallback clearly in final summary.

### 6) Finalize

1. Report what changed and what was skipped.
2. Remind user to restart opencode after config changes.
3. Provide quick verification commands (for example checking file presence and git status).

## Suggested global AGENTS.md content shape

Use this as a baseline template and adapt to existing user content when updating:

```markdown
# Global Agent Instructions

This global configuration uses shared defaults from `~/src/mrlunchbox777/shared-agents`.

## Shared Source

- Shared global instruction baseline: `~/src/mrlunchbox777/shared-agents/AGENTS.md`
- Shared instruction index: `~/src/mrlunchbox777/shared-agents/.agents/README.md`
- Shared skills manifest: `~/src/mrlunchbox777/shared-agents/.agents/skills/manifest.md`

## Priority and Overrides

Use the most specific instruction source available. More local scope overrides more global scope.

1. Session/runtime constraints (highest)
2. Repository-local `AGENTS.md` and local `.agents/` files
3. Parent-directory scoped instructions
4. This global file `~/.config/opencode/AGENTS.md`
5. Shared reusable guidance in `shared-agents` (baseline)

## Behavior

- Treat shared guidance as defaults.
- Prefer local repository instructions whenever there is any conflict.
- Keep global instructions generic and non-project-specific.
```

## Suggested opencode.json baseline

Use this as a starting point for first-time setup, then patch based on user choices in the block-by-block flow.

```json
{
  "$schema": "https://opencode.ai/config.json",
  "instructions": [
    "AGENTS.md"
  ],
  "skills": {
    "paths": [
      "~/src/mrlunchbox777/shared-agents/.agents/skills"
    ]
  },
  "permission": {
    "bash": "ask"
  },
  "autoupdate": "notify",
  "share": "manual",
  "logLevel": "INFO"
}
```

Baseline rules:

- Keep baseline minimal and conservative.
- Add `model` and provider blocks only when the user chooses them.
- Preserve unrelated existing keys when updating an existing file.
- If user declines any section, keep it unchanged (or unset on first-time setup).

## Validation checklist

- Current working directory is shared-agents root.
- `~/.config/opencode/AGENTS.md` exists and reflects shared baseline plus override policy.
- `~/.config/opencode/opencode.json` includes schema and intended blocks.
- `permission.bash` is `ask` unless user explicitly overrode via triple confirmation.
- User is reminded to restart opencode.

For regression checks after editing this skill, run the manual checklist in `.agents/skills/init/TESTS.md`.

## Implementation notes

- Keep prompts short and deterministic so runs are reproducible.
- Never batch multiple decisions into one question.
- Preserve unrelated keys in existing `opencode.json`; patch only chosen blocks.
- If user asks for a risky value, honor user choice only after required confirmations.
