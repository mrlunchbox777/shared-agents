---
name: plan-and-execute
description: Use for complex software tasks that need interactive main-session planning followed by structured checklist execution.
---

# Plan-and-Execute Skill

A specialized skill that orchestrates a two-stage workflow for complex software engineering tasks: interactive planning in the primary session, then structured checklist execution.

## When to use

- Use when the user presents a complex task requiring decomposition into multiple steps.
- Use when there is a need for rigorous planning before any files are modified or commands are run.
- Do not use for simple, single-step requests that do not require decomposition.

## Required behaviors

1. **Identify Planning Needs**: Determine if the request can be decomposed into an actionable checklist.
2. **Plan in the Primary Session**: Do not spawn a planner sub-agent. The planner must remain the current assistant so it can ask the user clarifying questions and incorporate answers before execution begins.
3. **Prefer Grilling When Useful**: When the request is ambiguous, high-risk, or architecture-sensitive, use the `grill-with-docs` skill to pressure-test the requirement and refine the plan against existing codebase documentation before final decomposition.
4. **Enforce Planning Standards**: Produce the final plan in Markdown checklist format (`- [ ]`).
5. **Validate Hand-off**: Ensure the checklist is specific enough for execution and includes verification steps.
6. **Execute Iteratively**: The primary agent (the "Executor") must process each task in the checklist one by one, updating it to `- [x]` as tasks are completed.

## Workflow

### 1) Planning Phase (Primary Session Planner)

The primary agent performs planning directly in the current conversation. Do not use the `task` tool for planning, because sub-agents cannot interact with the user while refining requirements.

Planning requirements:

- Analyze requirements, identify risks, and determine dependencies.
- Inspect the codebase before making implementation assumptions when the task depends on existing behavior.
- Ask concise clarifying questions in the current session when user input is required to make a safe plan.
- If no clarification is needed, proceed directly to the checklist.
- Output the final plan as a Markdown checklist using `- [ ]` for tasks.
- Each task must be atomic and actionable.
- Include verification steps, such as targeted tests, builds, or manual checks.

Planner model requirement: use the current high-reasoning primary model. Do not delegate planning to a sub-agent.

### 2) Execution Phase (Primary Agent Executor)

1. **Parse Checklist**: Use regex or a parser to extract tasks from the Planner's output.
2. **Track Progress**: Maintain an internal or external list of pending and completed tasks.
3. **Step-by-step execution**: Pick the next `- [ ]` task, execute it using relevant tools (`bash`, `read`, `apply_patch`, etc.), then mark it as `- [x]`.
4. **Termination**: The skill finishes when all tasks in the original checklist are marked as completed.

## Hand-off Format

The hand-off must strictly adhere to this structure:

```markdown
- [ ] Task 1 description
- [ ] Task 2 description
  - [ ] Sub-task 2a
- [x] Already completed task (if applicable)
```

## Verification

- Confirm no Planner sub-agent was used.
- Verify that the final plan is a Markdown checklist.
- Ensure the executor correctly identifies and processes each item in the list.
- For regression checks after editing checklist parsing behavior, run `.agents/skills/plan-and-execute/scripts/test-plan-parsing.py`.
