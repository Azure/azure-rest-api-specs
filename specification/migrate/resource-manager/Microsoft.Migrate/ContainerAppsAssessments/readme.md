# Azure Migrate

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Migrate - Azure Container Apps Assessment.

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
tag: package-preview-2025-09
```

### Tag: package-preview-2025-09

These settings apply only when `--tag=package-preview-2025-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-09'
input-file:
  - preview/2025-09-09-preview/containerAppsAssessments.json
suppressions:
  - code: OperationsAPIImplementation
    reason: Microsoft.Migrate resource provider has one RP with multiple SDKs. Operations API is centrally implemented at the AssessmentProjects level and intentionally excluded from individual service specifications to avoid duplication across multiple SDK instances.
  - code: AvoidAdditionalProperties
    from: containerAppsAssessments.json
    reason: The set of key-value pairs depend on the type of the workload and is not user-defined. Service uses this field to perform workload-specific validations and provide custom functionality based on the type of the workload.
    where:
      - $.definitions.ContainerAppsAssessmentOptionsProperties.properties.edges
  - code: XMSSecretInResponse
    from: containerAppsAssessments.json
    reason: The property contextKey is not a secret. It is used to convey a reasoning context key for migration guideline context and does not contain sensitive information.
    where:
      - $.definitions.MigrationGuidelineContext.properties.contextKey
  - code: MissingSegmentsInNestedResourceListOperation
    from: containerAppsAssessments.json
    reason: Azure Container Apps Assessment Options and Assessments are direct children of the assessment project and follow the same pattern as other Assessment Projects workloads (AKS, WebApp, etc.).
  - code: EnumInsteadOfBoolean
    from: containerAppsAssessments.json
    reason: The isolationRequired boolean property is part of the shared Common standardized contract inherited from other assessment workloads. Changing to an enum would break consistency across all assessment types.
```
