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
env:
  AZSDK_CLI_PATH: /tmp/bin
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
        const sdkLanguage = "go";
        core.setOutput("repository", pull.head.repo.full_name);
        core.setOutput("ref", pull.head.sha);
        core.setOutput("sdk-repository", sdkRepository);
        core.setOutput("sdk-language", sdkLanguage);

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

  - name: Set up Go
    uses: actions/setup-go@v7
    with:
      go-version: "1.25.x"
      cache: false

  - name: Set up .NET
    uses: actions/setup-dotnet@v6
    with:
      dotnet-version: "10.0.x"

  - name: Set up SDK development environment
    shell: bash
    env:
      SDK_REPOSITORY_PATH: ${{ github.workspace }}/repositories/${{ steps.resolve-source.outputs.sdk-repository }}
      SDK_LANGUAGE: ${{ steps.resolve-source.outputs.sdk-language }}
    run: |
      set -euo pipefail
      echo "$AZSDK_CLI_PATH" >> "$GITHUB_PATH"
      export PATH="$AZSDK_CLI_PATH:$PATH"
      azsdk verify setup install --languages "$SDK_LANGUAGE" --package-path "$SDK_REPOSITORY_PATH" --yes

  - name: Write SDK analysis context
    uses: actions/github-script@v8
    env:
      SDK_REPOSITORY: ${{ steps.resolve-source.outputs.sdk-repository }}
    with:
      script: |
        const fs = await import("node:fs/promises");
        const contextPath = "/tmp/gh-aw/sdk-breaking-change-context.json";
        const repositoryRoot = `${{ github.workspace }}/repositories`;
        await fs.writeFile(
          contextPath,
          JSON.stringify({
            sdkRepository: process.env.SDK_REPOSITORY,
            localSdkRepoPath: `${repositoryRoot}/${process.env.SDK_REPOSITORY}`,
            tspConfigPath: `${repositoryRoot}/azure-rest-api-specs/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/tspconfig.yaml`,
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



Read `/tmp/gh-aw/sdk-breaking-change-context.json`. Use its `localSdkRepoPath` and `tspConfigPath` values unchanged in the commands below.

The workflow has installed the `azsdk` CLI in `$AZSDK_CLI_PATH`. Add that directory to `PATH`, then run `command -v azsdk` exactly once to verify that the CLI is available. Do not invoke an MCP server or use MCP tools.

Run `test -d "<localSdkRepoPath from the context file>"` and `test -f "<tspConfigPath from the context file>"` before running any `azsdk package` command. If either check fails, stop and report the missing path.

Perform these steps in order. Run each command exactly once, capture its complete output, and stop and report the error if it exits with a nonzero status.

1. Generate the SDK and request machine-readable output:

```bash
azsdk package generate \
  --local-sdk-repo-path "<localSdkRepoPath from the context file>" \
  --tsp-config-path "<tspConfigPath from the context file>" \
  --output json
```

2. Read the generated package path from the successful JSON output. Accept the CLI's package-path property name as emitted. Require it to be a non-empty absolute path to an existing directory; otherwise stop and report the invalid generation result. Do not guess or derive the package path from the SDK repository name.
3. Build that generated package:

```bash
azsdk package build \
  --package-path "<package path returned by azsdk package generate>" \
  --output json
```

4. Detect SDK breaking changes:

```bash
azsdk package detect-breaking-change \
  --package-path "<package path returned by azsdk package generate>" \
  --tsp-config-path "<tspConfigPath from the context file>" \
  --output json
```

Use the generated package path unchanged for both subsequent commands. Report the generation, build, and breaking-change detection results. Do not modify files outside the generated SDK package.