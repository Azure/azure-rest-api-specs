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

  - name: Install golangci-lint
    shell: bash
    run: |
      set -euo pipefail
      GO_BIN="$(go env GOPATH)/bin"
      echo "$GO_BIN" >> "$GITHUB_PATH"
      export PATH="$GO_BIN:$PATH"
      go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.11.2
      golangci-lint --version

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

  - name: Generate SDK
    id: generate-sdk
    shell: bash
    env:
      LOCAL_SDK_REPO_PATH: ${{ github.workspace }}/repositories/${{ steps.resolve-source.outputs.sdk-repository }}
      TSP_CONFIG_PATH: ${{ github.workspace }}/repositories/azure-rest-api-specs/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/tspconfig.yaml
    run: |
      set -euo pipefail
      export PATH="$AZSDK_CLI_PATH:$PATH"
      results_dir="/tmp/gh-aw/sdk-breaking-change-results"
      marker="$RUNNER_TEMP/azsdk-generation-started"
      mkdir -p "$results_dir"
      touch "$marker"

      azsdk package generate \
        --local-sdk-repo-path "$LOCAL_SDK_REPO_PATH" \
        --tsp-config-path "$TSP_CONFIG_PATH" \
        --output json | tee "$results_dir/generate.json"

      mapfile -d '' generated_configs < <(
        find "$LOCAL_SDK_REPO_PATH" -type f -name tsp-location.yaml -newer "$marker" -print0
      )
      if [[ ${#generated_configs[@]} -ne 1 ]]; then
        echo "Expected exactly one generated tsp-location.yaml, found ${#generated_configs[@]}." >&2
        printf '  %s\n' "${generated_configs[@]}" >&2
        exit 1
      fi

      package_path="$(realpath "$(dirname "${generated_configs[0]}")")"
      if [[ ! -d "$package_path" || "$package_path" != "$LOCAL_SDK_REPO_PATH"/* ]]; then
        echo "Invalid generated package path: $package_path" >&2
        exit 1
      fi
      echo "package-path=$package_path" >> "$GITHUB_OUTPUT"
      printf '%s\n' "$package_path" | tee "$results_dir/package-path.txt"

  - name: Build generated SDK
    shell: bash
    env:
      PACKAGE_PATH: ${{ steps.generate-sdk.outputs.package-path }}
    run: |
      set -euo pipefail
      export PATH="$AZSDK_CLI_PATH:$PATH"
      azsdk package build \
        --package-path "$PACKAGE_PATH" \
        --output json | tee /tmp/gh-aw/sdk-breaking-change-results/build.json

  - name: Detect SDK breaking changes
    shell: bash
    env:
      PACKAGE_PATH: ${{ steps.generate-sdk.outputs.package-path }}
      TSP_CONFIG_PATH: ${{ github.workspace }}/repositories/azure-rest-api-specs/specification/webpubsub/resource-manager/Microsoft.SignalRService/SignalRService/tspconfig.yaml
    run: |
      set -euo pipefail
      export PATH="$AZSDK_CLI_PATH:$PATH"
      azsdk package detect-breaking-change \
        --package-path "$PACKAGE_PATH" \
        --tsp-config-path "$TSP_CONFIG_PATH" \
        --output json | tee /tmp/gh-aw/sdk-breaking-change-results/breaking-changes.json

  - name: Upload SDK analysis context
    uses: actions/upload-artifact@v7
    with:
      name: "sdk-breaking-change-context"
      path: |
        /tmp/gh-aw/sdk-breaking-change-context.json
        /tmp/gh-aw/sdk-breaking-change-results
      retention-days: 7
---

# SDK Breaking Change Analysis

This workflow runs when an authorized user comments `/azsdk sdk-breaking-change-analysis` on a pull request, or through manual dispatch.



SDK generation, build, and breaking-change detection have already run in deterministic workflow steps. Do not run `azsdk`, invoke an MCP server, or repeat any of those operations.

Read `/tmp/gh-aw/sdk-breaking-change-context.json` and all files under `/tmp/gh-aw/sdk-breaking-change-results`. Report the package path and concise generation, build, and breaking-change detection results. Include all detected breaking changes and clearly state when none were detected.