# Microsoft.ResourceIntelligence

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.ResourceIntelligence.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Microsoft.ResourceIntelligence.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2026-02
```

### Tag: package-preview-2026-02

These settings apply only when `--tag=package-preview-2026-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-02'
input-file:
  - Microsoft.ResourceIntelligence/preview/2026-02-01-preview/resourceintelligence.json
suppressions:
  - code: PathForNestedResource
    from: resourceintelligence.json
    reason: "The /runs/latest endpoint is a custom singleton-like route for retrieving the latest run for an agent."
  - code: AvoidAdditionalProperties
    from: resourceintelligence.json
    reason: "The inputOverrides property requires a flexible key-value dictionary structure for passing runtime overrides, matching the previous API version."
  - code: PutRequestResponseSchemeArm
    from: resourceintelligence.json
    reason: "The Runs_CreateOrUpdate PUT operation intentionally uses RunRequest as the request body per API design review, while returning the Run resource in the response."
  - code: PostResponseCodes
    from: resourceintelligence.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceIntelligence/agents/{agentName}/execute"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceIntelligence/agents/{agentName}/threads/{threadId}/execute"].post
    reason: "Per API review: execute operations use 200+201 LRO pattern instead of standard 202."
```

### Tag: package-preview-2025-08

These settings apply only when `--tag=package-preview-2025-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-08'
input-file:
  - Microsoft.ResourceIntelligence/preview/2025-08-01-preview/resourcecopilot.json
```
