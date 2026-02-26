---
name: file-test-bug
description: "File a GitHub issue for local integration test failures. TRIGGERS: file test bug, report test failure, create bug for test, integration test failed, test failure issue, junit failure"
---

# File Test Bug

Creates a GitHub issue in `microsoft/github-copilot-for-azure` for integration test failures.

## Input

- **Skill name** (required): e.g., `azure-rbac`, `appinsights-instrumentation`
- **Test run** (optional): Timestamp of test run. Defaults to most recent with logs for the skill.

## Steps

1. Ask user for skill name if not provided
2. Parse `tests/reports/junit.xml` for failures matching the skill
3. Find test run directory (specified or most recent with matching logs)
4. Read `agent-metadata.md` from `tests/reports/test-run-<timestamp>/<skillname>-<testname>/`
5. For each failure, read the actual line of code from the test file using the location (file:line) from junit.xml
6. **REQUIRED - Write diagnosis BEFORE creating issue:**
   - Analyze the agent-metadata.md to understand what the agent did
   - Compare agent behavior to what the test expected (from the assertion)
   - Identify the root cause (skill issue, test issue, or model behavior)
   - Write 2-3 sentences per failed test explaining WHY it failed
   - Suggest potential fixes (update skill, update test, or update fixtures)
7. Create issue via `github-mcp-server-create_issue`:

```
owner: microsoft
repo: github-copilot-for-azure
title: Integration test failure in <skill-name>
labels: ["bug", "integration-test"]
body: |
  ## Failed Tests
  - <test-name>: <error message>
  
  ## Diagnosis
  
  ### Root Cause
  <1-2 sentences explaining WHY the test failed based on agent-metadata.md analysis>
  
  ### Analysis per Test
  - **<test-name>**: <what agent did vs what test expected>
  
  ### Suggested Fix
  <one of: update skill, update test assertions, provide test fixtures>

  ## Details
  ### <test-name>
  **Error:** <failure from junit.xml>
  **Location:** <file:line>
  ```typescript
  <actual line of code from the test file at the specified line number>
  ```
  
  <details>
  <summary>agent-metadata.md</summary>
  
  <full contents of agent-metadata.md file, verbatim>
  
  </details>
```

## Important

Include the **complete, unmodified contents** of each `agent-metadata.md` file in the issue body. Do NOT summarize or truncate the logs. Wrap each log in a `<details>` block with the test name as the summary.
