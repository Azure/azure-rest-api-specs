---
name: detect-go-sdk-breaking-change
description: "Detect go sdk breaking changes for a typespec project"
---

## Workflow

Follow these steps to help users review the Go SDK breaking changes.

### Inputs (parameters)

This workflow can be run using the following user-provided parameters. If these are already provided by the user (or collected earlier in the conversation), do not re-ask.

Required:

- `goSdkRoot`: Absolute path to the local `azure-sdk-for-go` repo.
  - Example (Windows): `C:\dev\azure-sdk-for-go`
- `specsRoot`: Absolute path to the local `azure-rest-api-specs` repo.
  - Example (Windows): `C:\dev\azure-rest-api-specs`
- `typeSpecProjectPath`: TypeSpec project folder path , relative to `specsRoot` (NOT an absolute path).
  - Example (Windows): `specification\webpubsub\resource-manager\Microsoft.SignalRService\SignalRService`

Optional (when known):

- `goChangelogPath`: Absolute path to the generated package changelog (used for quicker navigation when known).
- `tspConfigRelativePath`: Path to `tspconfig.yaml` relative to `specsRoot` (NOT an absolute path).
  - Example: `specification\webpubsub\resource-manager\Microsoft.SignalRService\SignalRService\tspconfig.yaml`

Validation / derivation:

- If the user provides a TypeSpec project folder path `typeSpecProjectPath` (the folder containing `tspconfig.yaml`), derive:
  - `tspConfigRelativePath = <typeSpecProjectPath>\\tspconfig.yaml`
- Confirm `tspConfigRelativePath` exists under `specsRoot` before running generation.

### Prompt template (copy/paste)

Use this to run the workflow with parameters from earlier intake:

Copy/paste prompt:

```text
Follow the detect-go-sdk-breaking-change skill.

Use these inputs (already known; do not ask again):
- goSdkRoot: C:\dev\azure-sdk-for-go
- specsRoot: C:\dev\azure-rest-api-specs
- typeSpecProjectPath: specification\<service>\resource-manager\Microsoft.<Service>\<ProjectFolder>
- tspConfigRelativePath: specification\<service>\resource-manager\Microsoft.<Service>\<ProjectFolder>\tspconfig.yaml

Run this command under the directory:
  <goSdkRoot>\eng\tools\generator

Command:
  cd <goSdkRoot>\eng\tools\generator && go run . generate <goSdkRoot> <specsRoot> --tsp-config=<tspConfigRelativePath>

Output contract:
- Return ONLY the breaking-change summary from the FIRST `## <version>` entry in the generated package CHANGELOG.md, formatted exactly like:
  ### Breaking Changes
  - ...
  ### Features Added
  - ...
```

Inputs-only snippet (YAML; optional):

```yaml
goSdkRoot: "C:\\dev\\azure-sdk-for-go"
specsRoot: "C:\\dev\\azure-rest-api-specs"
typeSpecProjectPath: "specification\\<service>\\resource-manager\\Microsoft.<Service>\\<ProjectFolder>"
tspConfigRelativePath: "specification\\<service>\\resource-manager\\Microsoft.<Service>\\<ProjectFolder>\\tspconfig.yaml"
```

Alternative (JSON):

```json
{
  "goSdkRoot": "C:\\dev\\azure-sdk-for-go",
  "specsRoot": "C:\\dev\\azure-rest-api-specs",
  "typeSpecProjectPath": "specification\\<service>\\resource-manager\\Microsoft.<Service>\\<ProjectFolder>",
  "tspConfigRelativePath": "specification\\<service>\\resource-manager\\Microsoft.<Service>\\<ProjectFolder>\\tspconfig.yaml"
}
```

### Step 1: Generate Go SDK

**Prerequisites**:

- `go` installed and available on `PATH`
- Local clone of `azure-sdk-for-go` (referred to as `<goSdkRoot>`)
- Local clone of `azure-rest-api-specs` (referred to as `<specsRoot>`)

Run the command under:

`<goSdkRoot>\eng\tools\generator`

```
go run . generate <goSdkRoot> <specsRoot> --tsp-config=<tspConfigRelativePath>
```

Example (Windows):

```
go run . generate C:\dev\azure-sdk-for-go C:\dev\azure-rest-api-specs --tsp-config=specification\webpubsub\resource-manager\Microsoft.SignalRService\SignalRService\tspconfig.yaml
```

If generation fails (missing prerequisites, generator error, changelog not produced), ask the user to paste the first `## <version>` section from the generated package changelog, including both `### Breaking Changes` and `### Features Added`, and use that pasted content as the detected breaking-change list.

### Step 2: Analyze Breaking Changes Systematically

Read the `### Breaking Changes` chapter and `### Features Added` chapter of the **first** `## <version>` entry in the generated package changelog.

For WebPubSub ARM, the changelog is typically located at:

`<goSdkRoot>\sdk\resourcemanager\webpubsub\armwebpubsub\CHANGELOG.md`
