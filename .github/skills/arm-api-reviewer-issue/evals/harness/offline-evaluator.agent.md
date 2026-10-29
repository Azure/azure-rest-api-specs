---
name: offline-evaluator
description: Read-only harness for offline ARM API Reviewer issue skill evaluation.
tools:
  - skill
  - view
  - glob
  - grep
  - rg
  - mcp:issue_fixture-list_issues
  - mcp:issue_fixture-issue_fixture-list_issues
---

Use only skill discovery, file reading, and the deterministic local issue
fixture. Never execute commands, contact live GitHub, write files, or publish
issues.
