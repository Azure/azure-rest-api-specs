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
      sdk_language:
        description: "SDK language: Cpp, DotNet, Go, Java, JavaScript, Python, or Rust"
        required: true
        type: string
      tsp_config_path:
        description: "Repository-relative path to tspconfig.yaml under specification/"
        required: true
        type: string
  roles: [admin, maintainer, write]
if: >-
  github.event_name == 'workflow_dispatch' ||
  (github.event_name == 'issue_comment' &&
  github.event.action == 'created' &&
  github.event.issue.pull_request != null &&
  startsWith(github.event.comment.body, '/azsdk sdk-breaking-analysis '))
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
      SDK_LANGUAGE_INPUT: ${{ inputs.sdk_language }}
      TSP_CONFIG_PATH_INPUT: ${{ inputs.tsp_config_path }}
      TRIGGER_NAME: ${{ github.event_name }}
      TRIGGER_COMMENT: ${{ github.event.comment.body }}
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

        let sdkLanguageInput;
        let tspConfigPath;
        if (process.env.TRIGGER_NAME === "workflow_dispatch") {
          sdkLanguageInput = process.env.SDK_LANGUAGE_INPUT;
          tspConfigPath = process.env.TSP_CONFIG_PATH_INPUT;
        } else {
          const parts = process.env.TRIGGER_COMMENT.trim().split(/\s+/);
          if (
            parts.length !== 4 ||
            parts[0] !== "/azsdk" ||
            parts[1] !== "sdk-breaking-analysis"
          ) {
            throw new Error(
              "Expected comment: /azsdk sdk-breaking-analysis <tsp-config-path> <sdk-language>",
            );
          }
          [, , tspConfigPath, sdkLanguageInput] = parts;
        }

        const languages = {
          cpp: { language: "Cpp", repository: "azure-sdk-for-cpp" },
          csharp: { language: "DotNet", repository: "azure-sdk-for-net" },
          ".net": { language: "DotNet", repository: "azure-sdk-for-net" },
          dotnet: { language: "DotNet", repository: "azure-sdk-for-net" },
          go: { language: "Go", repository: "azure-sdk-for-go" },
          java: { language: "Java", repository: "azure-sdk-for-java" },
          javascript: { language: "JavaScript", repository: "azure-sdk-for-js" },
          js: { language: "JavaScript", repository: "azure-sdk-for-js" },
          python: { language: "Python", repository: "azure-sdk-for-python" },
          rust: { language: "Rust", repository: "azure-sdk-for-rust" },
          typescript: { language: "JavaScript", repository: "azure-sdk-for-js" },
          ts: { language: "JavaScript", repository: "azure-sdk-for-js" },
        };
        const languageConfig = languages[sdkLanguageInput?.trim().toLowerCase()];
        if (!languageConfig) {
          throw new Error(`Unsupported SDK language: ${sdkLanguageInput}`);
        }

        tspConfigPath = tspConfigPath?.trim().replaceAll("\\", "/");
        if (
          !tspConfigPath?.startsWith("specification/") ||
          !tspConfigPath.endsWith("/tspconfig.yaml") ||
          tspConfigPath.split("/").includes("..")
        ) {
          throw new Error(`Invalid TypeSpec config path: ${tspConfigPath}`);
        }

        core.setOutput("repository", pull.head.repo.full_name);
        core.setOutput("ref", pull.head.sha);
        core.setOutput("sdk-repository", languageConfig.repository);
        core.setOutput("sdk-language", languageConfig.language);
        core.setOutput("tsp-config-path", tspConfigPath);

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

  - name: Resolve TypeSpec config path
    id: resolve-tsp-config
    shell: bash
    env:
      SPEC_REPOSITORY_PATH: ${{ github.workspace }}/repositories/azure-rest-api-specs
      TSP_CONFIG_RELATIVE_PATH: ${{ steps.resolve-source.outputs.tsp-config-path }}
    run: |
      set -euo pipefail
      tsp_config_path="$(realpath "$SPEC_REPOSITORY_PATH/$TSP_CONFIG_RELATIVE_PATH")"
      if [[ ! -f "$tsp_config_path" || "$tsp_config_path" != "$SPEC_REPOSITORY_PATH"/specification/*/tspconfig.yaml ]]; then
        echo "Invalid or missing TypeSpec config: $TSP_CONFIG_RELATIVE_PATH" >&2
        exit 1
      fi
      echo "path=$tsp_config_path" >> "$GITHUB_OUTPUT"

  - name: Set up Go
    if: steps.resolve-source.outputs.sdk-language == 'Go'
    uses: actions/setup-go@v7
    with:
      go-version: "1.25.x"
      cache: false

  - name: Set up .NET
    if: steps.resolve-source.outputs.sdk-language == 'DotNet'
    uses: actions/setup-dotnet@v6
    with:
      dotnet-version: "10.0.x"

  - name: Install golangci-lint
    if: steps.resolve-source.outputs.sdk-language == 'Go'
    shell: bash
    run: |
      set -euo pipefail
      GO_BIN="$(go env GOPATH)/bin"
      echo "$GO_BIN" >> "$GITHUB_PATH"
      export PATH="$GO_BIN:$PATH"
      go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.11.2
      golangci-lint --version

  - name: Set up GitHub Copilot CLI
    id: setup-copilot-cli
    shell: bash
    run: |
      set -euo pipefail
      npm_config_ignore_scripts=false npm install --global @github/copilot
      copilot_path="$(command -v copilot)"
      test -x "$copilot_path"
      copilot --version
      echo "path=$copilot_path" >> "$GITHUB_OUTPUT"

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
      SDK_LANGUAGE: ${{ steps.resolve-source.outputs.sdk-language }}
      TSP_CONFIG_PATH: ${{ steps.resolve-tsp-config.outputs.path }}
    with:
      script: |
        const fs = await import("node:fs/promises");
        const contextPath = "/tmp/gh-aw/sdk-breaking-change-context.json";
        const repositoryRoot = `${{ github.workspace }}/repositories`;
        await fs.writeFile(
          contextPath,
          JSON.stringify({
            sdkRepository: process.env.SDK_REPOSITORY,
            sdkLanguage: process.env.SDK_LANGUAGE,
            localSdkRepoPath: `${repositoryRoot}/${process.env.SDK_REPOSITORY}`,
            tspConfigPath: process.env.TSP_CONFIG_PATH,
          }),
        );

  - name: Generate SDK
    id: generate-sdk
    shell: bash
    env:
      LOCAL_SDK_REPO_PATH: ${{ github.workspace }}/repositories/${{ steps.resolve-source.outputs.sdk-repository }}
      TSP_CONFIG_PATH: ${{ steps.resolve-tsp-config.outputs.path }}
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
      AZSDK_COPILOT_CLI_PATH: ${{ steps.setup-copilot-cli.outputs.path }}
      AZSDK_COPILOT_GITHUB_TOKEN: ${{ github.token }}
      PACKAGE_PATH: ${{ steps.generate-sdk.outputs.package-path }}
      TSP_CONFIG_PATH: ${{ steps.resolve-tsp-config.outputs.path }}
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