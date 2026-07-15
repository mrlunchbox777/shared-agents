import re
from pathlib import Path

def parse_markdown_checklist(content: str) -> list[str]:
    """Parses a markdown checklist and returns a list of completed and pending tasks."""
    tasks = []
    # Matches - [ ] task or - [x] task
    pattern = re.compile(r'^- \[( |x|X)\] (.*)$', re.MULTILINE)
    for match in pattern.finditer(content):
        status = 'completed' if match.group(1).lower() == 'x' else 'pending'
        task_text = match.group(2).strip()
        tasks.append(f"{status}: {task_text}")
    return tasks

def test_parsing():
    sample_input = """
# Implementation Plan
- [x] Task 1: Already done
- [ ] Task 2: Not done yet
- [ ] Task 3: Another pending task
- [X] Task 4: Case insensitive check
"""
    print("Parsing sample input...")
    parsed_tasks = parse_markdown_checklist(sample_input)
    for t in parsed_tasks:
        print(f"Parsed: {t}")

    assert len(parsed_tasks) == 4
    assert "completed: Task 1: Already done" in parsed_tasks
    assert "pending: Task 2: Not done yet" in parsed_tasks
    assert "completed: Task 4: Case insensitive check" in parsed_tasks
    print("Parsing test passed!")

if __name__ == "__main__":
    test_parsing()
