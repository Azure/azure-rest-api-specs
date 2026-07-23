# ContainerInstance

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerInstance.

---

## Getting Started

To build the SDK for ContainerInstance, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the ContainerInstance API.

``` yaml
openapi-type: arm
tag: package-2026-07-01
```

### Tag: package-preview-2026-08

These settings apply only when `--tag=package-preview-2026-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-08'
input-file:
  - ./preview/2026-08-01-preview/containerInstance.json
directive:
  - suppress: AvoidAdditionalProperties
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: ArmResourcePropertiesBag
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: DeleteResponseBodyEmpty
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: DeleteResponseCodes
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: DescriptionMustNotBeNodeName
    reason: These enum value descriptions are carried forward from the existing service contract.
  - suppress: EnumInsteadOfBoolean
    reason: The boolean shapes in this generated OpenAPI are carried forward from earlier preview and stable API contracts. Changing them to string enums in this preview version would be a breaking contract change.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: LatestVersionOfCommonTypesMustBeUsed
    reason: This TypeSpec project intentionally continues to emit ARM common-types v5 for compatibility with the service's existing API shapes. Moving the entire service to v6 is outside the scope of this preview.
  - suppress: LocationMustHaveXmsMutability
    reason: This generated swagger preserves legacy custom and proxy resource shapes for backward compatibility. Changing location mutability here would alter the existing contract.
  - suppress: LroErrorContent
    reason: The long-running operations on this provider use the existing CloudError shape, consistent with the prior stable API versions of this service. Switching to the standard ErrorResponse envelope from common-types v2+ would be a breaking change versus the published stable API.
  - suppress: OperationsApiResponseSchema
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: OperationsApiSchemaUsesCommonTypes
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: PatchIdentityProperty
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: PostResponseCodes
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: ProvisioningStateMustBeReadOnly
    reason: provisioningState is read-only by design - the property carries readOnly via the referenced enum schema (use-read-only-status-schema), and the TypeSpec source uses @visibility(Lifecycle.Read). The LintDiff rule does not follow $ref to detect the readOnly flag. Surfacing readOnly on the property reference would be inconsistent with prior API versions of this provider.
  - suppress: RequiredPropertiesMissingInResourceModel
    reason: This preview version preserves the existing service contract carried forward from the 2026-07-01 stable API version.
  - suppress: ResourceNameRestriction
    reason: These path parameter shapes are carried forward from the existing service contract.
  - suppress: SchemaDescriptionOrTitle
    reason: This preview version preserves the existing generated schema shape carried forward from the 2026-07-01 stable API version.
  - suppress: SummaryAndDescriptionMustNotBeSame
    reason: This preview version preserves the existing operation text carried forward from the 2026-07-01 stable API version.
  - suppress: UnSupportedPatchProperties
    reason: This preview version preserves the existing patch contract carried forward from the 2026-07-01 stable API version.
  - suppress: XmsIdentifierValidation
    reason: This preview version preserves the existing generated pageable shape carried forward from the 2026-07-01 stable API version.
  - suppress: XmsPageableForListCalls
    reason: This preview version preserves the existing list contract carried forward from the 2026-07-01 stable API version.
```

### Tag: package-2026-07-01

These settings apply only when `--tag=package-2026-07-01` is specified on the command line.

```yaml $(tag) == 'package-2026-07-01'
input-file:
  - ./stable/2026-07-01/containerInstance.json
directive:
  - suppress: AvoidAdditionalProperties
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: ArmResourcePropertiesBag
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: DeleteResponseBodyEmpty
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: DeleteResponseCodes
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: DescriptionMustNotBeNodeName
    reason: These enum value descriptions are carried forward from the existing service contract.
  - suppress: EnumInsteadOfBoolean
    reason: The boolean shapes in this generated OpenAPI are carried forward from earlier preview and stable API contracts. Changing them to string enums in this stable version would be a breaking contract change.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: LatestVersionOfCommonTypesMustBeUsed
    reason: This TypeSpec project intentionally continues to emit ARM common-types v5 for compatibility with the service's existing API shapes. Moving the entire service to v6 is outside the scope of this fix.
  - suppress: LocationMustHaveXmsMutability
    reason: This generated swagger preserves legacy custom and proxy resource shapes for backward compatibility. Changing location mutability here would alter the existing contract.
  - suppress: LroErrorContent
    reason: The long-running operations in this stable version continue to use the service's existing CloudError shape for backward compatibility.
  - suppress: OperationsApiResponseSchema
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: OperationsApiSchemaUsesCommonTypes
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: PatchIdentityProperty
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: PostResponseCodes
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: ProvisioningStateMustBeReadOnly
    reason: provisioningState is read-only by design and is carried forward from the existing generated contract.
  - suppress: RequiredPropertiesMissingInResourceModel
    reason: This stable version preserves the existing service contract carried forward from preview.
  - suppress: ResourceNameRestriction
    reason: These path parameter shapes are carried forward from the existing service contract.
  - suppress: SchemaDescriptionOrTitle
    reason: This stable version preserves the existing generated schema shape carried forward from preview.
  - suppress: SummaryAndDescriptionMustNotBeSame
    reason: This stable version preserves the existing operation text carried forward from preview.
  - suppress: UnSupportedPatchProperties
    reason: This stable version preserves the existing patch contract carried forward from preview.
  - suppress: XmsIdentifierValidation
    reason: This stable version preserves the existing generated pageable shape carried forward from preview.
  - suppress: XmsPageableForListCalls
    reason: This stable version preserves the existing list contract carried forward from preview.
```

### Tag: package-2025-09-01

These settings apply only when `--tag=package-2025-09-01` is specified on the command line.

```yaml $(tag) == 'package-2025-09-01'
input-file:
  - ./stable/2025-09-01/containerInstance.json
```

### Tag: package-preview-2026-06-01

These settings apply only when `--tag=package-preview-2026-06-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-06-01'
input-file:
  - ./preview/2026-06-01-preview/containerInstance.json
directive:
  - suppress: ProvisioningStateMustBeReadOnly
    reason: provisioningState is read-only by design - the property carries readOnly via the referenced enum schema (use-read-only-status-schema), and the TypeSpec source uses @visibility(Lifecycle.Read). The LintDiff rule does not follow $ref to detect the readOnly flag. Surfacing readOnly on the property reference would be inconsistent with prior API versions of this provider.
  - suppress: LroErrorContent
    reason: The long-running operations on this provider use the existing CloudError shape, consistent with the prior 2025-09-01 stable API version of this service. Switching to the standard ErrorResponse envelope from common-types v2+ would be a breaking change versus the published stable API.
```

### Tag: package-preview-2024-11

These settings apply only when `--tag=package-preview-2024-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-11'
input-file:
  - ./preview/2024-11-01-preview/containerInstance.json
```

### Tag: package-preview-2024-10

These settings apply only when `--tag=package-preview-2024-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10'
input-file:
  - ./preview/2024-10-01-preview/containerInstance.json
```

### Tag: package-preview-2024-09

These settings apply only when `--tag=package-preview-2024-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-09'
input-file:
  - ./preview/2024-09-01-preview/containerInstance.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - ./preview/2024-05-01-preview/containerInstance.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

```yaml $(tag) == 'package-2023-05'
input-file:
  - ./stable/2023-05-01/containerInstance.json
```

### Tag: package-preview-2023-02

These settings apply only when `--tag=package-preview-2023-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-02'
input-file:
  - ./preview/2023-02-01-preview/containerInstance.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - ./preview/2022-10-01-preview/containerInstance.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-2022-09'
input-file:
  - ./stable/2022-09-01/containerInstance.json
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-2021-10'
input-file:
  - ./stable/2021-10-01/containerInstance.json
```

### Tag: package-2021-09

These settings apply only when `--tag=package-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
input-file:
  - ./stable/2021-09-01/containerInstance.json
```

### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

``` yaml $(tag) == 'package-2021-07'
input-file:
  - ./stable/2021-07-01/containerInstance.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - ./stable/2021-03-01/containerInstance.json
```

### Tag: package-2020-11

These settings apply only when `--tag=package-2020-11` is specified on the command line.

``` yaml $(tag) == 'package-2020-11'
input-file:
  - ./stable/2020-11-01/containerInstance.json
```

### Tag: package-2019-12

These settings apply only when `--tag=package-2019-12` is specified on the command line.

``` yaml $(tag) == 'package-2019-12'
input-file:
  - ./stable/2019-12-01/containerInstance.json
```

### Tag: package-2018-10

These settings apply only when `--tag=package-2018-10` is specified on the command line.

``` yaml $(tag) == 'package-2018-10'
input-file:
- ./stable/2018-10-01/containerInstance.json
```

### Tag: package-2018-09

These settings apply only when `--tag=package-2018-09` is specified on the command line.

``` yaml $(tag) == 'package-2018-09'
input-file:
- ./stable/2018-09-01/containerInstance.json
```

### Tag: package-2018-06

These settings apply only when `--tag=package-2018-06` is specified on the command line.

``` yaml $(tag) == 'package-2018-06'
input-file:
- ./stable/2018-06-01/containerInstance.json
```

### Tag: package-2018-04

These settings apply only when `--tag=package-2018-04` is specified on the command line.

``` yaml $(tag) == 'package-2018-04'
input-file:
- ./stable/2018-04-01/containerInstance.json
```

### Tag: package-2018-02-preview

These settings apply only when `--tag=package-2018-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-preview'
input-file:
- ./preview/2018-02-01-preview/containerInstance.json
```

### Tag: package-2017-12-preview

These settings apply only when `--tag=package-2017-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-12-preview'
input-file:
- ./preview/2017-12-01-preview/containerInstance.json
```

### Tag: package-2017-10-preview

These settings apply only when `--tag=package-2017-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-10-preview'
input-file:
- ./preview/2017-10-01-preview/containerInstance.json
```

### Tag: package-2017-08-preview

These settings apply only when `--tag=package-2017-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-08-preview'
input-file:
- ./preview/2017-08-01-preview/containerInstance.json
```

## Suppression

``` yaml
directive:
  - suppress: UniqueResourcePaths
    from: containerInstance.json
    reason: false positive, see https://github.com/Azure/azure-openapi-validator/issues/176
suppressions:
  - code: AvoidAdditionalProperties
    reason: Using additionalProperties type as the object is user-defined and not subject to any validations at RP level.
    from:
      - containerInstance.json
    where:
      - $.definitions.ConfigMap.properties.keyValuePairs
  - code: AvoidAdditionalProperties
    reason: additional feature addition to existing secretVolumes which is defined as a dictionary
    from:
      - containerInstance.json
    where:
      - $.definitions.SecretReferenceVolume
  - code: GetCollectionResponseSchema
    reason: We do not return the instanceView property in our List operation, we just return this
            property for our Get operations. This change has been part of our stable api versions for a couple of years
    from:
      - containerInstance.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.ContainerInstance/containerGroups"]
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_container_instance']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Node.js

See configuration in [readme.nodejs.md](./readme.nodejs.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)
