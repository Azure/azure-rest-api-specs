---
on:
  pull_request_target:
    types: [labeled]
    forks: ["*"]
  workflow_dispatch:
    inputs:
      item_number:
        description: PR number to generate hero scenarios for
        required: true
        type: string
  permissions:
    pull-requests: write
  steps:
    - name: Remove trigger label
      id: remove_label
      if: github.event_name == 'pull_request_target' && github.event.label.name == 'hero-scenarios-needed'
      uses: actions/github-script@v9
      with:
        script: |
          try {
            await github.rest.issues.removeLabel({
              ...context.repo,
              issue_number: context.payload.pull_request.number,
              name: 'hero-scenarios-needed'
            });
          } catch (e) {
            core.warning(`Could not remove label: ${e.message}`);
          }
if: github.event.label.name == 'hero-scenarios-needed'
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
