---
on:
  label_command:
    name: hero-scenarios-needed
    events: [pull_request]
description: "Hero Scenarios: Suggest hero scenarios for API specifications"
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
imports:
  - ../prompts/hero-scenarios-guidelines.md
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
    run-success: "📖 [{workflow_name}]({run_url}) posted hero scenarios. ✅"
    run-failure: "📖 [{workflow_name}]({run_url}) {status}. ❌"
timeout-minutes: 10
---

# Hero Scenario Suggestion

Review pull request #${{ github.event.pull_request.number }} and suggest
a `hero-scenarios.md` file with hero scenarios based on the API surface changed.

Follow the hero-scenarios guidelines imported above.
