# Azure Migrate

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Migrate - Assessment.

---

## Getting Started

To build the SDK for Migrate, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the API.

``` yaml
openapi-type: arm
tag: package-preview-2026-02
```

### Tag: package-preview-2026-02

These settings apply only when `--tag=package-preview-2026-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-02'
input-file:
  - preview/2026-02-02-preview/networkAssessments.json
suppressions:
  - code: OperationsAPIImplementation
    reason: Microsoft.Migrate resource provider has one RP with multiple SDKs. Operations API is centrally implemented at the AssessmentProjects level and intentionally excluded from individual service specifications to avoid duplication across multiple SDK instances.
  - code: XMSSecretInResponse
    where: $.definitions.MigrationGuidelineContext.properties.contextKey
    reason: The property 'contextKey' refers to a migration guideline reasoning context identifier (e.g. category name), not a cryptographic key or secret value. No sensitive data is exposed.
```
