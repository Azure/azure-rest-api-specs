---
on:
  pull_request:
    types: [labeled]
labels: [hero-scenarios-needed]
if: github.event.label.name == 'hero-scenarios-needed'
description: "Hero Scenarios: Suggest a service README with hero scenarios for API specifications"
permissions:
  contents: read
  pull-requests: read
tools:
  github:
    toolsets: [context, repos, pull_requests]
    min-integrity: unapproved
  bash: ["cat", "echo", "grep", "head", "ls", "pwd", "sort", "tail", "wc"]
  cache-memory:
  repo-memory:
safe-outputs:
  add-comment:
    max: 1
    target: "${{ github.event.pull_request.number }}"
  create-pull-request-review-comment:
    max: 5
    side: "RIGHT"
    target: "${{ github.event.pull_request.number }}"
  submit-pull-request-review:
    max: 1
    footer: "if-body"
    target: "${{ github.event.pull_request.number }}"
  messages:
    footer: "> 📖 *Suggested by [{workflow_name}]({run_url})*"
    run-started: "📖 [{workflow_name}]({run_url}) is generating hero scenarios for this PR…"
    run-success: "📖 [{workflow_name}]({run_url}) posted a README suggestion. ✅"
    run-failure: "📖 [{workflow_name}]({run_url}) {status}. ❌"
timeout-minutes: 10
---

# Hero Scenario Suggestion

Review pull request #${{ github.event.pull_request.number }} and suggest
a service README with hero scenarios based on the API surface changed.

Follow the procedure in [hero-scenarios-guidelines.md](../prompts/hero-scenarios-guidelines.md).
