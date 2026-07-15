#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: bash skills.sh validate [skill-root] [manifest]\n' >&2
}

command="${1:-}"
case "$command" in
  validate)
    shift
    bash "$(dirname "$0")/.agents/skills/skill-validator/scripts/validate-skills.sh" "$@"
    ;;
  -h|--help|help|"")
    usage
    ;;
  *)
    printf 'Unknown command: %s\n' "$command" >&2
    usage
    exit 2
    ;;
esac
