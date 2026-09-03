---
name: SDK Breaking Change Analysis
description: Analyze SDK breaking changes after SDK breaking-change labels are produced.
on:
  workflow_call:
    inputs:
      details_url:
        description: "Azure Pipelines SDK Validation build URL"
        required: true
        type: string
permissions:
  contents: read
  copilot-requests: write
  id-token: write
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
      - "/tmp/gh-aw/agent/sdk-changes:/tmp/gh-aw/agent/sdk-changes:ro"
    entrypoint: "/tmp/bin/azsdk"
    entrypointArgs: ["mcp"]
    allowed: ["azsdk_package_detect_breaking_changes"]
pre-agent-steps:
  - if: github.event.repository.name == 'azure-rest-api-specs-pr'
    name: Azure Login with Workload Identity Federation
    uses: azure/login@v3
    with:
      client-id: "205398f1-715f-40a7-8d52-856097f28281"
      tenant-id: "72f988bf-86f1-41af-91ab-2d7cd011db47"
      allow-no-subscriptions: true

  - if: github.event.repository.name == 'azure-rest-api-specs-pr'
    name: Get ADO Token via Managed Identity
    run: |
      ADO_TOKEN=$(az account get-access-token --resource "499b84ac-1321-427f-aa17-267ca6975798" --query "accessToken" -o tsv)
      echo "ADO_TOKEN=$ADO_TOKEN" >> "$GITHUB_ENV"

  - name: Install dependencies for github-script actions
    uses: ./.github/actions/install-deps-github-script

  - name: Read SDK changes from Azure Pipelines
    uses: actions/github-script@v8
    env:
      DETAILS_URL: ${{ inputs.details_url }}
    with:
      script: |
        const { downloadSdkChangesFromPipelineArtifact } =
          await import("${{ github.workspace }}/.github/workflows/src/sdk-breaking-change-analysis.js");
        await downloadSdkChangesFromPipelineArtifact({
          detailsUrl: process.env.DETAILS_URL,
          destinationPath: "/tmp/gh-aw/agent/sdk-changes/sdk-changes.json",
          core,
        });
---

# SDK Breaking Change Analysis

Read `/tmp/gh-aw/agent/sdk-changes/sdk-changes.json`. Validate that it is a JSON object containing:

- `changes`: a string containing the SDK changes in Markdown format.
- `hasBreakingChange`: a boolean.

Then call the `azsdk_package_detect_breaking_changes` tool exactly once with this input:

```json
{
  "packagePath": "the-path-to-the-sdk",
  "localSdkChangeJsonFilePath": "/tmp/gh-aw/agent/sdk-changes/sdk-changes.json"
}
```

The JSON file was extracted directly from the Azure Pipeline `spec-gen-sdk-artifact` during this workflow. Report the tool result without modifying repository files.