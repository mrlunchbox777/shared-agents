---
name: skill-creator
description: Use when the user asks to create, improve, copy, port, evaluate, or brainstorm an agent skill. Probes the desired workflow, researches local and upstream skill examples, recommends patterns, then invokes plan-and-execute for implementation.
---

# Skill Creator

Create or improve reusable agent skills by clarifying the user's intent, studying good local and upstream examples, recommending the right shape, and executing through `plan-and-execute`.

## When to use

- Use when the user asks to create a new `SKILL.md`, skill folder, opencode skill, Claude/Codex/Agent Skills-compatible skill, or reusable agent workflow.
- Use when the user wants to copy, port, adapt, or take inspiration from another skill.
- Use when the user asks whether a workflow should become a skill, command, agent, AGENTS.md instruction, or regular documentation.
- Do not use for ordinary application-code changes unless the task is specifically about skill authoring or skill maintenance.

## Required behaviors

1. Ask one question at a time when user input is required.
2. Inspect the local repo's existing skill conventions before proposing a file shape.
3. Research upstream examples before implementation unless the user explicitly disables web research or no network access is available.
4. Prefer minimal, instruction-only skills unless scripts, templates, references, or assets clearly improve repeatability.
5. Make concrete recommendations before writing files.
6. Invoke `plan-and-execute` for the actual implementation after discovery and recommendations.
7. Preserve compatibility with opencode and the Agent Skills specification unless the user requests a product-specific format.

## Inputs to clarify

Probe until these are known or explicitly deferred:

- Target outcome: what the skill should help the agent accomplish.
- Trigger phrases: exact words, filenames, workflows, or situations that should activate the skill.
- Non-triggers: adjacent requests where the skill should stay quiet.
- Scope: personal, project, shared repo, product-specific, or cross-agent portable.
- Execution style: guidance-only, checklist workflow, code edits, command-running, research-only, eval loop, or subagent orchestration.
- Artifacts: only `SKILL.md`, or also `references/`, `scripts/`, `assets/`, examples, tests, eval cases, manifest entries, or config updates.
- Safety constraints: destructive commands, network use, credentials, privacy, permissions, and confirmation requirements.
- Success criteria: how to tell the skill works, including trigger tests and output expectations.

If the request is underspecified, start with the most important missing question:

```text
What repeated workflow should this skill make reliable, and what should trigger it?
```

## Discovery workflow

### 1) Inspect local conventions

Before recommending an implementation, inspect the relevant local files:

- Existing skills: `.agents/skills/*/SKILL.md`, `.opencode/skills/*/SKILL.md`, `.claude/skills/*/SKILL.md`.
- Local manifest or index files, such as `.agents/skills/manifest.md` and `.agents/README.md`.
- Nearby agent instructions, such as `AGENTS.md` and `.agents/instructions.md`.
- Local skill source scripts, such as `skills.sh`, when present.
- Existing tests, scripts, schemas, or examples for similar skills.

Summarize the local pattern in one or two sentences before proposing changes.

### 2) Research upstream inspiration

Use web research when available. Prioritize sources that match the user's target agent, then cross-check against the portable Agent Skills format.

Recommended sources:

- Anthropic/Claude Code skills docs and example repositories for progressive disclosure, invocation control, supporting files, and eval guidance.
- OpenAI Codex skills docs and `openai/skills` examples for concise descriptions, local discovery, plugin distribution, and record/replay patterns.
- [`agentskills.io`](https://agentskills.io) specification and skill-creation guides for portable `SKILL.md` constraints.
- [`cursor-team-kit/skills`](https://github.com/cursor/plugins/tree/main/cursor-team-kit/skills) for advanced developer workflow patterns.
- opencode skills docs for frontmatter constraints, discovery paths, and permission behavior.
- `agents.md` and high-quality public `AGENTS.md` examples for instruction scoping, nested overrides, and agent-facing repo guidance.
- User-named sources, for example Matt Pocock repos, blog posts, or course materials, when the requested skill concerns TypeScript, teaching style, or a specific upstream pattern.

Extract patterns, not boilerplate. Record source URLs in the recommendation summary when they materially influenced the design.

### 3) Decide the artifact type

Recommend one of these outcomes:

- Create a new skill when the workflow is repeatable, procedural, and worth loading on demand.
- Improve an existing skill when an adjacent local skill already owns the workflow.
- Add or update `AGENTS.md` when the content is broad standing guidance rather than a task workflow.
- Create an agent when the behavior needs a distinct persona, tool policy, or delegation mode rather than a reusable procedure.
- Create a command when the environment expects commands and the task is explicitly user-invoked with simple arguments.
- Defer or keep as documentation when the workflow is one-off, unstable, or lacks clear triggers.

## Skill design rules

Use these defaults unless the user asks otherwise:

- `name`: lowercase alphanumeric with single hyphen separators, matching the folder name, max 64 characters.
- `description`: one sentence, 1-1024 characters, front-loaded with concrete trigger words and clear boundaries.
- Body: concise Markdown with `When to use`, required inputs, workflow, validation, and output expectations.
- Supporting files: add only when they reduce repeated context or provide executable validation.
- Scripts: add only for deterministic work that natural-language instructions cannot reliably perform.
- References: use for long examples, source-specific notes, schemas, or templates that should not load every time.
- Compatibility: preserve the Agent Skills spec first; avoid product-specific frontmatter unless the target product supports it and the user wants it.
- Safety: require confirmations before destructive, credential-touching, publishing, deployment, or broad permission changes.

## Recommendation format

Before invoking `plan-and-execute`, present a compact recommendation:

```markdown
Recommended shape: <new skill | update existing skill | AGENTS.md | agent | command | defer>
Target path: `<path>`
Why: <one sentence>
Upstream patterns used: <source names or URLs>
Artifacts: <files/directories to create or update>
Validation: <checks/evals to run>
Open question: <only if blocked>
```

If not blocked, continue directly to `plan-and-execute`.

## Implementation handoff

Invoke `plan-and-execute` after discovery and recommendations. The plan must include:

- Local convention checks.
- Upstream source checks or a note explaining why they were skipped.
- File creation or edits.
- Manifest/config updates if the repo uses them.
- Validation of path, frontmatter, description length, and name constraints.
- Trigger behavior review with at least two should-trigger prompts and two should-not-trigger prompts for non-trivial skills.
- Final diff review.

Do not spawn a planner subagent for the handoff; `plan-and-execute` requires planning in the primary session.

## Validation checklist

- Skill folder name matches `name` frontmatter.
- `SKILL.md` starts with YAML frontmatter containing `name` and `description`.
- Description explains what the skill does and when to use it.
- Trigger scope is specific enough to avoid unwanted activation.
- The body tells the agent exactly what to do, what to inspect, when to ask questions, and how to verify success.
- Any supporting files are referenced from `SKILL.md` and have a clear purpose.
- The skill is registered in local manifests or config when this repo requires it.
- The user is told to restart opencode if config-time skill loading requires it for the current session.

## Output

Return:

- What was created or changed.
- Why the chosen shape fits the user's workflow.
- Upstream sources consulted or skipped.
- Validation performed and remaining risks.
