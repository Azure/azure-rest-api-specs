# HealthDataAIServices Management TypeSpec Project

This TypeSpec project defines the Azure Resource Manager (ARM) API for the HealthDataAIServices DeidService.

## Project Structure

| File | Description |
|------|-------------|
| `main.tsp` | Main service definition with resource models and operations |
| `client.tsp` | Client customizations for SDK generation |
| `tspconfig.yaml` | Emitter configuration for OpenAPI and language SDKs |
| `examples/` | Example JSON files for API operations |

## Getting Started

```powershell
# From the repository root, install dependencies
npm ci

# Compile the TypeSpec project
cd specification/healthdataaiservices/HealthDataAIServices.Management
npx tsp compile .
```

---

## Proposed API Change: Add SKU Support with New API Version

### Overview

Add pricing tier (SKU) support to the DeidService resource, introduced in a new preview API version `2026-02-01-preview`. This document covers the **complete end-to-end process** from API spec changes through SDK generation and release.

### Proposed Changes

1. **Add new API version** `2026-02-01-preview` to the `Versions` enum
2. **Define SKU tier options**: Free, Basic, Standard
3. **Add `Sku` model** with `name`, `tier`, and `capacity` properties
4. **Add `sku` property** to `DeidService` resource (available from the new version)
5. **Add `sku` to `DeidUpdate`** for PATCH operations

### Why a New Version?

- SKU support is a significant new capability
- Cleaner versioning for customers to adopt new features explicitly
- Follows Azure best practices for API evolution

### End-to-End Process

The complete workflow includes:

1. **API Spec Update** - Modify TypeSpec, compile, and validate
2. **Create API Spec PR** - Submit changes to `Azure/azure-rest-api-specs`
3. **API Review** - Get approval from API reviewers
4. **SDK Generation** - Generate SDKs in parallel using separate subagents for each language (.NET, Python, Java, JavaScript, Go)
5. **SDK PR Review** - Review generated SDK pull requests
6. **Release Planning** - Create release plan and link SDK PRs
7. **SDK Release** - Publish packages to public registries

---

## Sample Copilot Prompt

Use this prompt with GitHub Copilot to implement the proposed changes. The Azure SDK MCP tools will guide you through the complete process.

```
This is a demo environment. Any pull requests opened should have their title prefixed with "DO NOT MERGE" before the actual title. Since this is a demo of the local development experience, do not create a release plan.

Add SKU support to the HealthDataAIServices DeidService with a new API version "2026-02-01-preview".

I need:
- A SkuTier union with Free, Basic, and Standard options
- A Sku model with name, tier, and capacity properties  
- The sku property added to DeidService (marked as added in the new version)
- The sku property added to DeidUpdate for PATCH operations

After making the TypeSpec changes, guide me through creating the API spec PR and generating SDKs locally. Create a branch named "ronniegeraghty/azsdktoolsagent-demo-#" (where # is the lowest number available that hasn't already been used) in the azure-rest-api-specs repo for the API spec changes. All SDK language repositories (azure-sdk-for-net, azure-sdk-for-python, azure-sdk-for-java, azure-sdk-for-js, azure-sdk-for-go) are already cloned locally in the same parent directory as the azure-rest-api-specs repo. Create a branch with the same name in each SDK repo to work on the new library generations. Use separate subagents in parallel for each SDK language.

Create a markdown file in the typespec project dir to track the progress of each step throughout this process.
```

---

## Sample Prompts (Step-by-Step)

Use these prompts to work through the process in separate steps.

### Prompt 1: TypeSpec Changes, Validation, and API Spec PR

Use this prompt to implement the TypeSpec changes, validate the spec, and create the API spec pull request:

```
This is a demo environment. Any pull requests opened should have their title prefixed with "DO NOT MERGE" before the actual title.

Add SKU support to the HealthDataAIServices DeidService with a new API version "2026-02-01-preview".

I need:
- A SkuTier union with Free, Basic, and Standard options
- A Sku model with name, tier, and capacity properties  
- The sku property added to DeidService (marked as added in the new version)
- The sku property added to DeidUpdate for PATCH operations

After making the TypeSpec changes:
1. Compile and validate the TypeSpec project
2. Create a branch named "ronniegeraghty/azsdktoolsagent-demo-#" (where # is the lowest number available that hasn't already been used)
3. Commit the changes and create the API spec pull request

Create a markdown file in the typespec project dir to track the progress of each step throughout this process.
```

### Prompt 2: Generate SDK for a Specific Language

Use this prompt template to generate an SDK for a specific language. Replace `<LANGUAGE>` with one of: `.NET`, `Python`, `Java`, `JavaScript`, or `Go`.

```
This is a demo environment. Any pull requests opened should have their title prefixed with "DO NOT MERGE" before the actual title. Since this is a demo of the local development experience, do not create a release plan.

Generate the <LANGUAGE> SDK locally from the TypeSpec changes in the current branch.

The azure-sdk-for-<language-repo> repository is already cloned locally in the same parent directory as the azure-rest-api-specs repo. Create a branch with the same name as the current API spec branch in the SDK repo.

Follow the local SDK generation workflow:
1. Generate the SDK code
2. Build/compile the SDK
3. Run package validation checks
4. Update changelog, metadata, and version
5. Commit the changes and create a pull request

Update the progress tracking markdown file with the status.
```

#### Language-Specific Examples

**For .NET:**
```
Generate the .NET SDK locally from the TypeSpec changes in the current branch.

The azure-sdk-for-net repository is already cloned locally in the same parent directory as the azure-rest-api-specs repo. Create a branch with the same name as the current API spec branch in the SDK repo.
```

**For Python:**
```
Generate the Python SDK locally from the TypeSpec changes in the current branch.

The azure-sdk-for-python repository is already cloned locally in the same parent directory as the azure-rest-api-specs repo. Create a branch with the same name as the current API spec branch in the SDK repo.
```

**For Java:**
```
Generate the Java SDK locally from the TypeSpec changes in the current branch.

The azure-sdk-for-java repository is already cloned locally in the same parent directory as the azure-rest-api-specs repo. Create a branch with the same name as the current API spec branch in the SDK repo.
```

**For JavaScript:**
```
Generate the JavaScript SDK locally from the TypeSpec changes in the current branch.

The azure-sdk-for-js repository is already cloned locally in the same parent directory as the azure-rest-api-specs repo. Create a branch with the same name as the current API spec branch in the SDK repo.
```

**For Go:**
```
Generate the Go SDK locally from the TypeSpec changes in the current branch.

The azure-sdk-for-go repository is already cloned locally in the same parent directory as the azure-rest-api-specs repo. Create a branch with the same name as the current API spec branch in the SDK repo.
```

---

## SDK Generation

This project is configured to generate SDKs for:

| Language | Package Name |
|----------|--------------|
| **.NET** | `Azure.ResourceManager.HealthDataAIServices` |
| **Python** | `azure-mgmt-healthdataaiservices` |
| **Java** | `azure-resourcemanager-healthdataaiservices` |
| **JavaScript** | `@azure/arm-healthdataaiservices` |
| **Go** | `armhealthdataaiservices` |

See `tspconfig.yaml` for emitter configuration details.

### SDK Generation Options

- **Pipeline Generation**: Use the Azure SDK generation pipeline for automated PR creation (supports parallel subagents per language)
- **Local Generation**: Generate SDKs locally for testing and customization before creating PRs

For more details on the SDK generation process, refer to the Azure SDK release documentation.
