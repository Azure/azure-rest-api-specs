---
name: SDK Breaking Change Analysis
description: Analyze SDK breaking changes after SDK breaking-change labels are produced.
on:
  issue_comment:
    types: [created]
  workflow_dispatch:
    inputs:
      pr_number:
        description: "Pull request number to analyze"
        required: true
        type: string
  roles: [admin, maintainer, write]
if: >-
  github.event_name == 'workflow_dispatch' ||
  (github.event_name == 'issue_comment' &&
  github.event.action == 'created' &&
  github.event.issue.pull_request != null &&
  github.event.comment.body == '/azsdk sdk-breaking-analysis')
permissions:
  checks: read
  contents: read
  copilot-requests: write
  pull-requests: read
engine:
  id: copilot
imports:
  - shared-github-aw-imports/install_azsdk_cli_import.md
mcp-servers:
  azure-sdk:
    container: "ubuntu:24.04"
    args:
      - "-v"
      - "/tmp/bin:/tmp/bin:ro"
      - "-v"
      - "${{ github.workspace }}/repositories:/workspace/repositories"
    entrypoint: "/tmp/bin/azsdk"
    entrypointArgs: ["mcp"]
    allowed:
      - "azsdk_package_generate_code"
      - "azsdk_package_build_code"
      - "azsdk_package_detect_breaking_changes"
pre-agent-steps:
  - name: Install dependencies for github-script actions
    uses: ./.github/actions/install-deps-github-script

  - name: Resolve repositories
    id: resolve-source
    uses: actions/github-script@v8
    env:
      PR_NUMBER: ${{ github.event.issue.number || inputs.pr_number }}
    with:
      script: |
        const pullNumber = Number(process.env.PR_NUMBER);
        if (!Number.isSafeInteger(pullNumber) || pullNumber <= 0) {
          throw new Error(`Invalid pull request number: ${process.env.PR_NUMBER}`);
        }
        const { data: pull } = await github.rest.pulls.get({
          ...context.repo,
          pull_number: pullNumber,
        });
        // const { resolveSdkValidationRepository } =
        //   await import("${{ github.workspace }}/.github/workflows/src/sdk-breaking-change-analysis.js");
        // const sdkRepository = await resolveSdkValidationRepository({
        //   github,
        //   owner: context.repo.owner,
        //   repo: context.repo.repo,
        //   headSha: pull.head.sha,
        //   pullNumber,
        // });
        core.setOutput("repository", pull.head.repo.full_name);
        core.setOutput("ref", pull.head.sha);
        // core.setOutput("sdk-repository", sdkRepository);
        core.setOutput("sdk-repository", "azure-sdk-for-go");

  - name: Checkout specification PR source
    uses: actions/checkout@v7
    with:
      repository: ${{ steps.resolve-source.outputs.repository }}
      ref: ${{ steps.resolve-source.outputs.ref }}
      path: "repositories"
      persist-credentials: false

  - name: Checkout target SDK repository
    uses: actions/checkout@v7
    with:
      repository: Azure/${{ steps.resolve-source.outputs.sdk-repository }}
      ref: "main"
      path: "repositories"
      persist-credentials: false
---

# SDK Breaking Change Analysis

This workflow runs when an authorized user comments `/azsdk sdk-breaking-change-analysis` on a pull request, or through manual dispatch.



Use these paths:

- TypeSpec configuration: `/workspace/repositories/azure-rest-api-specs/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/tspconfig.yaml`

Perform these steps in order. Stop and report the error if any step fails.

1. Call `azsdk_package_generate_code` exactly once with the TypeSpec configuration path.
2. Read `packagePath`_package_generate_code` result.
3. Call `azsdk_package_build_code` exactly  from the successful `azsdkonce with that `packagePath`.
4. Call `azsdk_package_detect_breaking_changes` exactly once with both parameters:

```json
{
  "packagePath": "<packagePath returned by azsdk_package_generate_code>",
  "tspConfigPath": "/workspace/repositories/azure-rest-api-specs/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/tspconfig.yaml"
}
```

Use the returned `packagePath` unchanged for both subsequent tool calls. Do not guess or derive it from the SDK repository name. Report the generation, build, and breaking-change detection results. Do not modify files outside the generated SDK package.