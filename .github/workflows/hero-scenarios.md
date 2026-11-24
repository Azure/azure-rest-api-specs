---
on:
  # PR label events no longer use pull_request_target. Pull Request Reviewer
  # Dispatch starts this workflow when a write-access user adds
  # hero-scenarios-needed to an open PR.
  workflow_dispatch:
    inputs:
      item_number:
        description: PR number to generate hero scenarios for
        required: true
        type: string
  roles: [admin, maintainer, write]
  # The verified dispatch runs as github-actions[bot], which has no repo role.
  bots: ["github-actions[bot]"]
  permissions:
    pull-requests: write
  steps:
    - name: Remove trigger label
      id: remove_label
      if: github.event_name == 'workflow_dispatch'
      uses: actions/github-script@v9
      with:
        script: |
          try {
            await github.rest.issues.removeLabel({
              ...context.repo,
              issue_number: Number(context.payload.inputs.item_number),
              name: 'hero-scenarios-needed'
            });
          } catch (e) {
            core.warning(`Could not remove label: ${e.message}`);
          }
if: github.event_name == 'workflow_dispatch'
description: "Hero Scenarios: Suggest hero scenarios for API specifications"
permissions:
  contents: read
  copilot-requests: write
  pull-requests: read
# The agent reads PR files through the GitHub MCP toolsets, never from disk,
# so no checkout is needed, and a privileged run must not check out fork code.
checkout: false
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
    target: "${{ inputs.item_number }}"
  create-pull-request-review-comment:
    max: 5
    side: "RIGHT"
    target: "${{ inputs.item_number }}"
  submit-pull-request-review:
    max: 1
    footer: "if-body"
    target: "${{ inputs.item_number }}"
  add-labels:
    max: 1
    target: "${{ inputs.item_number }}"
  messages:
    footer: "> 📖 *Suggested by [{workflow_name}]({run_url})*"
    run-started: "📖 [{workflow_name}]({run_url}) is generating hero scenarios for this PR…"
    run-success: "📖 [{workflow_name}]({run_url}) posted hero scenarios. ✅"
    run-failure: "📖 [{workflow_name}]({run_url}) {status}. ❌"
timeout-minutes: 10
---

# Hero Scenario Suggestion

Review pull request #${{ inputs.item_number }} and suggest
a `hero-scenarios.md` file with hero scenarios based on the API surface changed.

Follow the hero-scenarios guidelines imported above.
