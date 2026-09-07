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
    env:
      DOTNET_SYSTEM_GLOBALIZATION_INVARIANT: "1"
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
        //const { resolveSdkValidationRepository } =
        //  await import("${{ github.workspace }}/.github/workflows/src/sdk-breaking-change-analysis.js");
        //const sdkRepository = await resolveSdkValidationRepository({
        //  github,
        //  owner: context.repo.owner,
        //  repo: context.repo.repo,
        //  headSha: pull.head.sha,
        //  pullNumber,
        //});
        const sdkRepository = "azure-sdk-for-go";
        core.setOutput("repository", pull.head.repo.full_name);
        core.setOutput("ref", pull.head.sha);
        core.setOutput("sdk-repository", sdkRepository);

  - name: Checkout specification PR source
    uses: actions/checkout@v7
    with:
      repository: ${{ steps.resolve-source.outputs.repository }}
      ref: ${{ steps.resolve-source.outputs.ref }}
      path: "repositories/azure-rest-api-specs"
      persist-credentials: false

  - name: Checkout target SDK repository
    uses: actions/checkout@v7
    with:
      repository: Azure/${{ steps.resolve-source.outputs.sdk-repository }}
      ref: "main"
      path: "repositories/${{ steps.resolve-source.outputs.sdk-repository }}"
      persist-credentials: false

  - name: Write SDK analysis context
    uses: actions/github-script@v8
    env:
      SDK_REPOSITORY: ${{ steps.resolve-source.outputs.sdk-repository }}
    with:
      script: |
        const fs = await import("node:fs/promises");
        const contextPath = "/tmp/gh-aw/sdk-breaking-change-context.json";
        await fs.writeFile(
          contextPath,
          JSON.stringify({
            sdkRepository: process.env.SDK_REPOSITORY,
            localSdkRepoPath: `/workspace/repositories/${process.env.SDK_REPOSITORY}`,
            tspConfigPath: "/workspace/repositories/azure-rest-api-specs/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/tspconfig.yaml",
          }),
        );

  - name: Upload SDK analysis context
    uses: actions/upload-artifact@v7
    with:
      name: "sdk-breaking-change-context"
      path: "/tmp/gh-aw/sdk-breaking-change-context.json"
      retention-days: 7
---

# SDK Breaking Change Analysis

This workflow runs when an authorized user comments `/azsdk sdk-breaking-change-analysis` on a pull request, or through manual dispatch.



Read `/tmp/gh-aw/sdk-breaking-change-context.json`. Use its `localSdkRepoPath` and `tspConfigPath` values unchanged in the tool calls below.

Perform these steps in order. Stop and report the error if any step fails.
Immediately before each tool call, log the tool name and exact parameters as JSON, then invoke the tool with that same JSON object.

1. Call `azsdk_package_generate_code` exactly once with this input shape and the values from the context file:

```json
{
  "localSdkRepoPath": "<localSdkRepoPath from the context file>",
  "tspConfigPath": "<tspConfigPath from the context file>",
  "tspLocationPath": "",
  "emitterOptions": ""
}
```

2. Read `packagePath` from the successful `azsdk_package_generate_code` result.
3. Call `azsdk_package_build_code` exactly once with that `packagePath`.
4. Call `azsdk_package_detect_breaking_changes` exactly once with both parameters:

```json
{
  "packagePath": "<packagePath returned by azsdk_package_generate_code>",
  "tspConfigPath": "<tspConfigPath from the context file>"
}
```

Use the returned `packagePath` unchanged for both subsequent tool calls. Do not guess or derive it from the SDK repository name. Report the generation, build, and breaking-change detection results. Do not modify files outside the generated SDK package.