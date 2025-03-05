# dynatrace

> see https://aka.ms/autorest

This is the AutoRest configuration file for dynatrace.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the dynatrace.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2023-04-27
```

### Tag: package-2024-04-24-preview

These settings apply only when `--tag=package-2024-04-24-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-04-24-preview'
input-file:
  - Dynatrace.Observability/preview/2024-04-24-preview/dynatrace.json
suppressions:
    - code: UnSupportedPatchProperties
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: ProvisioningStateMustBeReadOnly
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: BodyTopLevelProperties
      from: dynatrace.json
      reason: Existing service design behavior. Fixing this causes breaking changes.
    - code: PatchBodyParametersSchema
      from: dynatrace.json
      reason: Empty object can still be passed, properties are not mandatory for the update schema.
```

### Tag: package-2023-11-24-preview

These settings apply only when `--tag=package-2023-11-24-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-11-24-preview'
input-file:
  - Dynatrace.Observability/preview/2023-11-24-preview/dynatrace.json
suppressions:
    - code: UnSupportedPatchProperties
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: ProvisioningStateMustBeReadOnly
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: BodyTopLevelProperties
      from: dynatrace.json
      reason: Existing service design behavior. Fixing this causes breaking changes.
```

### Tag: package-2023-11-11-preview

These settings apply only when `--tag=package-2023-11-11-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-11-11-preview'
input-file:
  - Dynatrace.Observability/preview/2023-11-11-preview/dynatrace.json
suppressions:
    - code: UnSupportedPatchProperties
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: ProvisioningStateMustBeReadOnly
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: BodyTopLevelProperties
      from: dynatrace.json
      reason: Existing service design behavior. Fixing this causes breaking changes.
```

### Tag: package-2023-09-20-preview

These settings apply only when `--tag=package-2023-09-20-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-09-20-preview'
input-file:
  - Dynatrace.Observability/preview/2023-09-20-preview/dynatrace.json
suppressions:
    - code: PostResponseCodes
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: LroExtension
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: ResourceNameRestriction
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
```

### Tag: package-2023-09-12-preview

These settings apply only when `--tag=package-2023-09-12-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-09-12-preview'
input-file:
  - Dynatrace.Observability/preview/2023-09-12-preview/dynatrace.json
suppressions:
    - code: ProvisioningStateMustBeReadOnly
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: UnSupportedPatchProperties
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: BodyTopLevelProperties
      from: dynatrace.json
      reason: Existing service design behavior. Fixing this causes breaking changes.
```

### Tag: package-2023-08-22-preview

These settings apply only when `--tag=package-2023-08-22-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-08-22-preview'
input-file:
  - Dynatrace.Observability/preview/2023-08-22-preview/dynatrace.json
```

### Tag: package-2023-08-14-preview

These settings apply only when `--tag=package-2023-08-14-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-08-14-preview'
input-file:
  - Dynatrace.Observability/preview/2023-08-14-preview/dynatrace.json
```

### Tag: package-2023-04-27

These settings apply only when `--tag=package-2023-04-27` is specified on the command line.

```yaml $(tag) == 'package-2023-04-27'
input-file:
  - Dynatrace.Observability/stable/2023-04-27/dynatrace.json
```

### Tag: package-2021-09-01

These settings apply only when `--tag=package-2021-09-01` is specified on the command line.

```yaml $(tag) == 'package-2021-09-01'
input-file:
  - Dynatrace.Observability/stable/2021-09-01/dynatrace.json
```

### Tag: package-2022-10-01-preview

These settings apply only when `--tag=package-2022-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-10-01-preview'
input-file:
  - Dynatrace.Observability/preview/2022-10-01-preview/dynatrace.json
suppressions:
    - code: ProvisioningStateMustBeReadOnly
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: ResourceNameRestriction
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: OperationIdNounVerb
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: PatchIdentityProperty
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: DeleteResponseCodes
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
```

### Tag: package-2023-03-01-preview

These settings apply only when `--tag=package-2023-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-03-01-preview'
input-file:
  - Dynatrace.Observability/preview/2023-03-01-preview/dynatrace.json
suppressions:
    - code: PostResponseCodes
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: ProvisioningStateMustBeReadOnly
      from: dynatrace.json
      reason: 1. Issue in LintDiff tool. 2. All of the provisioningStates are marked as readOnly, we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/637
    - code: ResourceNameRestriction
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: OperationIdNounVerb
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: PatchIdentityProperty
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: DeleteResponseCodes
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
    - code: NoErrorCodeResponses
      from: dynatrace.json
      reason: Existing service design behavior. Fixed in latest version.
```

### Tag: package-2023-04-20-preview

These settings apply only when `--tag=package-2023-04-20-preview` is specified on the command line.

``` yaml $(tag) == 'package--2023-04-20-preview'
input-file:
  - Dynatrace.Observability/preview/2023-04-20-preview/dynatrace.json
```

### Tag: package-2021-09-01-preview

These settings apply only when `--tag=package-2021-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-09-01-preview'
input-file:
  - Dynatrace.Observability/preview/2021-09-01-preview/dynatrace.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_dynatrace']
```

## Suppression

``` yaml
suppressions:
  - code: SECRET_PROPERTY
    from: Dynatrace.Observability/preview/2021-06-01-preview/dynatrace.json
    where: $.definitions.VMIngestionDetailsResponse.properties.ingestionKey
    reason: Secrets are OK to return in a POST response.
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
