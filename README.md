# shared-agents

[![Grill Workflow Tests](https://github.com/mrlunchbox777/shared-agents/actions/workflows/grill-workflow-tests.yaml/badge.svg)](https://github.com/mrlunchbox777/shared-agents/actions/workflows/grill-workflow-tests.yaml)

Shared AGENTS.md configuration, instruction scaffolding, and reusable skills for multiple projects.

## Structure

- `AGENTS.md`: top-level shared instruction entrypoint
- `.agents/README.md`: index for shared instruction files
- `.agents/instructions.md`: cross-project operating defaults
- `.agents/skills/manifest.md`: shared skills catalog
- `.agents/skills/_template/SKILL.md`: starter template for new skills
- `.agents/skills/<name>/scripts/`: optional skill-owned automation
- `skills.sh`: repo-level helper for skill ecosystem commands, such as `bash skills.sh validate`

## Global Configuration

To use these skills in your local `opencode` instance, ensure your `~/.config/opencode/opencode.json` is configured to include the path to this repository's skills directory:

```json
{
  "skills": {
    "paths": ["/path/to/shared-agents/.agents/skills"]
  }
}
```
