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
tag: package-preview-2024-03
```

### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - preview/2024-03-03-preview/businessCases.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: Dictionary is used only in the AssessmentOptions proxy resource, which is a singleton and immutable across the assessment Project.
  - code: OperationsAPIImplementation
    reason: Microsoft.Migrate resource provider has one RP with multiple SDKs. Operations API is centrally implemented at the AssessmentProjects level and intentionally excluded from individual service specifications to avoid duplication across multiple SDK instances.
```
