# StorageCache

> see https://aka.ms/autorest

This is the AutoRest configuration file for storagecache RP.

---

## Getting Started

To build the SDK for storagecache, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the StorageCache API.

``` yaml
openapi-type: arm
tag: package-2026-08-01
add-credentials: true
title: StorageCacheManagementClient
```

### Tag: package-2026-08-01
These settings apply only when `--tag=package-2026-08-01` is specified on the command line.

```yaml $(tag) == 'package-2026-08-01'
input-file:
  - stable/2026-08-01/openapi.json
suppressions:
  - code: ProvisioningStateMustBeReadOnly
    from: openapi.json
    reason: provisioningState is authored readOnly in TypeSpec (@visibility(Lifecycle.Read)) and emitted as { $ref, readOnly true }; the rule evaluates the resolved OpenAPI 2.0 document where a readOnly sibling of a $ref is dropped during resolution — a known TypeSpec/OpenAPI 2.0 limitation (see https://github.com/Azure/azure-openapi-validator/issues/637) confirmed by ARM review. Same generated shape as the approved GA 2026-01-01 resources.
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: openapi.json
    reason: The StorageCache spec is authored against common-types v3 across every shipped version; upgrading common-types would regenerate and break the already-released GA specs. Pre-existing across all versions and surfaced only because a newer openapi-validator was pulled in via a main-branch merge; not introduced by the RebalanceJob change.
  - code: PostResponseCodes
    from: openapi.json
    reason: LRO POST response-code shape on pre-existing operations (the deprecated caches resource) emitted by shared definitions; present in shipped versions and surfaced only by a newer openapi-validator. Not on the RebalanceJob operations and not introduced by this change.
  - code: PutResponseCodes
    from: openapi.json
    reason: LRO PUT response-code shape on pre-existing operations emitted by shared definitions; present in shipped versions and surfaced only by a newer openapi-validator. Not on the RebalanceJob operations and not introduced by this change.
  - code: DeleteResponseCodes
    from: openapi.json
    reason: LRO DELETE response-code shape on pre-existing operations emitted by shared definitions; present in shipped versions and surfaced only by a newer openapi-validator. Not on the RebalanceJob operations and not introduced by this change.
  - code: LroErrorContent
    from: openapi.json
    reason: LRO error responses use the pre-existing common-types v3 error schema shared across every StorageCache version; surfaced only by a newer openapi-validator and not introduced by the RebalanceJob change.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    reason: Boolean properties on pre-existing inherited definitions shared across shipped versions; surfaced only by a newer openapi-validator and not introduced by the RebalanceJob change.
  - code: OperationIdNounConflictingModelNames
    from: openapi.json
    reason: Operation-id noun matches a pre-existing model name on inherited operations; present in shipped versions and surfaced only by a newer openapi-validator. Not introduced by the RebalanceJob change.
  - code: AvoidAdditionalProperties
    from: openapi.json
    reason: additionalProperties on pre-existing inherited definitions shared across shipped versions; surfaced only by a newer openapi-validator and not introduced by the RebalanceJob change.
  - code: LocationMustHaveXmsMutability
    from: openapi.json
    reason: location property x-ms-mutability on pre-existing tracked resources shared across shipped versions; surfaced only by a newer openapi-validator and not introduced by the RebalanceJob change.
  - code: GuidUsage
    from: openapi.json
    reason: GUID-typed property on pre-existing inherited definitions; present in shipped versions and surfaced only by a newer openapi-validator. Not introduced by the RebalanceJob change.
  - code: ParametersSchemaAsTypeObject
    from: openapi.json
    reason: Object-typed parameter schema on pre-existing inherited operations; present in shipped versions and surfaced only by a newer openapi-validator. Not introduced by the RebalanceJob change.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: openapi.json
    reason: Tracked-resource request schema tags on pre-existing resources shared across shipped versions; surfaced only by a newer openapi-validator and not introduced by the RebalanceJob change.
```

### Tag: package-2026-01-01
These settings apply only when `--tag=package-2026-01-01` is specified on the command line.

```yaml $(tag) == 'package-2026-01-01'
input-file:
  - stable/2026-01-01/openapi.json
suppressions:
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: openapi.json
    reason: The StorageCache spec is authored against common-types v3 across every shipped version; upgrading common-types would regenerate and break this already-released GA spec. Pre-existing and surfaced only because a newer openapi-validator was pulled in via a main-branch merge on the RebalanceJob PR; not a change to this shipped version.
  - code: PostResponseCodes
    from: openapi.json
    reason: LRO POST response-code shape on pre-existing operations (the deprecated caches resource and existing jobs) emitted by shared definitions; part of the already-released GA spec and surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: PutResponseCodes
    from: openapi.json
    reason: LRO PUT response-code shape on pre-existing operations emitted by shared definitions; part of the already-released GA spec and surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: DeleteResponseCodes
    from: openapi.json
    reason: LRO DELETE response-code shape on pre-existing operations emitted by shared definitions; part of the already-released GA spec and surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: LroErrorContent
    from: openapi.json
    reason: LRO error responses use the common-types v3 error schema in this already-released GA spec; surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    reason: Boolean properties on pre-existing definitions in this already-released GA spec; surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: ProvisioningStateMustBeReadOnly
    from: openapi.json
    reason: provisioningState is authored readOnly in TypeSpec (@visibility(Lifecycle.Read)) and emitted as { $ref, readOnly true }; the rule evaluates the resolved OpenAPI 2.0 document where a readOnly sibling of a $ref is dropped during resolution — a known TypeSpec/OpenAPI 2.0 limitation (see https://github.com/Azure/azure-openapi-validator/issues/637). Part of the already-released GA spec and surfaced only by a newer openapi-validator; not a change to this shipped version.
  - code: OperationIdNounConflictingModelNames
    from: openapi.json
    reason: Operation-id noun matches a pre-existing model name in this already-released GA spec; surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: AvoidAdditionalProperties
    from: openapi.json
    reason: additionalProperties on pre-existing definitions in this already-released GA spec; surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: LocationMustHaveXmsMutability
    from: openapi.json
    reason: location property x-ms-mutability on pre-existing tracked resources in this already-released GA spec; surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: GuidUsage
    from: openapi.json
    reason: GUID-typed property on pre-existing definitions in this already-released GA spec; surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: ParametersSchemaAsTypeObject
    from: openapi.json
    reason: Object-typed parameter schema on pre-existing operations in this already-released GA spec; surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: openapi.json
    reason: Tracked-resource request schema tags on pre-existing resources in this already-released GA spec; surfaced only by a newer openapi-validator pulled in via a main-branch merge. Not a change to this shipped version.
```

### Tag: package-2025-07-01

These settings apply only when `--tag=package-2025-07-01` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01'
input-file:
  - stable/2025-07-01/amlfilesystem.json
  - stable/2025-07-01/storagecache.json
```

### Tag: package-2024-07

These settings apply only when `--tag=package-2024-07` is specified on the command line.

```yaml $(tag) == 'package-2024-07'
input-file:
  - stable/2024-07-01/amlfilesystem.json
  - stable/2024-07-01/storagecache.json
```

### Tag: package-2024-03

These settings apply only when `--tag=package-2024-03` is specified on the command line.

```yaml $(tag) == 'package-2024-03'
input-file:
  - stable/2024-03-01/amlfilesystem.json
  - stable/2024-03-01/storagecache.json
```
### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-11'
input-file:
  - preview/2023-11-01-preview/amlfilesystem.json
  - preview/2023-11-01-preview/storagecache.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
  - stable/2023-05-01/amlfilesystem.json
  - stable/2023-05-01/storagecache.json
```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-03'
input-file:
  - preview/2023-03-01-preview/storagecache.json
  - preview/2023-03-01-preview/amlfilesystem.json
```

### Tag: package-2023-01

These settings apply only when `--tag=package-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-01'
input-file:
  - stable/2023-01-01/storagecache.json
```

### Tag: package-2022-05

These settings apply only when `--tag=package-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-2022-05'
input-file:
  - stable/2022-05-01/storagecache.json
```

### Tag: package-2022-01

These settings apply only when `--tag=package-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-01'
input-file:
  - stable/2022-01-01/storagecache.json
```

### Tag: package-2021-09

These settings apply only when `--tag=package-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
input-file:
  - stable/2021-09-01/storagecache.json
```

### Tag: package-2021-05

These settings apply only when `--tag=package-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-2021-05'
input-file:
  - stable/2021-05-01/storagecache.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - stable/2021-03-01/storagecache.json
```

### Tag: package-2020-10-01

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-01'
input-file:
  - stable/2020-10-01/storagecache.json
```

### Tag: package-2020-03-01

These settings apply only when `--tag=package-2020-03-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01'
input-file:
  - stable/2020-03-01/storagecache.json
```

### Tag: package-2019-11-01

These settings apply only when `--tag=package-2019-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01'
input-file:
- stable/2019-11-01/storagecache.json
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-2019-08'
input-file:
- preview/2019-08-01-preview/storagecache.json
```

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_storagecache']
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)
