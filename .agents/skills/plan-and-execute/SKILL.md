---
name: plan-and-execute
description: Uses OpenAI GPT 5.5 for high-reasoning planning and a local model (Gemma 4) for execution of structured tasks via a Markdown checklist hand-off.
---

# Plan-and-Execute Skill

A specialized skill that orchestrates a two-stage workflow for complex software engineering tasks, leveraging a high-reasoning planner and an agile executor.

## When to use

- Use when the user presents a complex task requiring decomposition into multiple steps.
- Use when there is a need for rigorous planning before any files are modified or commands are run.
- Do not use for simple, single-step requests that do not require decomposition.

## Required behaviors

1. **Identify Planning Needs**: Determine if the request can be decomposed into an actionable checklist.
2. **Invoke Planner (Prefer grilling)**: Whenever possible, use the `grill-with-docs` skill to pressure-test the user requirement and refine the plan against existing codebase documentation before final decomposition.
3. **Invoke Planner**: Use the `task` tool to spawn a `general` type sub-agent (the "Planner").
4. **Enforce Prompting Standards**: The Planner must use the specified prompt template and provide output in Markdown checklist format (`- [ ]`).
5. **Validate Hand-off**: Ensure the returned content is a valid Markdown checklist that the primary agent can parse and iterate upon.
6. **Execute Iteratively**: The primary agent (the "Executor") must process each task in the checklist one by one, updating it to `- [x]` as tasks are completed.

## Workflow

### 1) Planning Phase (Sub-agent: Planner)

The primary agent triggers a sub-agent with the following prompt template:

**Planner Prompt Template:**
> You are an expert software architect. Your goal is to take the following user request and decompose it into a highly detailed, step-by-step implementation plan. 
> 
> **User Request:** {{user_request}}
> 
> **Instructions:**
> - Analyze requirements, identify potential risks, and determine necessary dependencies.
> - Output your response as a Markdown checklist using `- [ ]` for tasks.
> - Each task must be atomic and actionable.
> - Ensure the plan includes verification steps (e.g., running tests).
> - Return ONLY the Markdown checklist.

**Planner Model Requirement**: OpenAI GPT 5.5 (or configured high-reasoning model).

### 2) Execution Phase (Sub-agent: Executor/Primary Agent)

1. **Parse Checklist**: Use regex or a parser to extract tasks from the Planner's output.
2. **Track Progress**: Maintain an internal or external list of pending and completed tasks.
3. **Step-by-step execution**:
   - Pick the next `- [ ]` task.
   - Execute it using relevant tools (`bash`, `read`, `edit`, etc.).
   - Once finished, mark the task as `- [x]`.
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

- Confirm the Planner sub-agent was called with the `task` tool.
- Verify that the output from the Planner consists only of a Markdown checklist.
- Ensure the executor correctly identifies and processes each item in the list.
