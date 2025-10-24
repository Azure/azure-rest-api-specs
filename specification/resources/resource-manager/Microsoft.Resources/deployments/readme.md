# Deployments

> see https://aka.ms/autorest

This is the AutoRest configuration file for Deployments.

## Getting Started

To build the SDKs for Deployments, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Deployments client.

``` yaml
title: DeploymentsClient
description: Deployments Client
openapi-type: arm
tag: package-2025-04
```

---

### Tag: package-2015-11

These settings apply only when `--tag=package-2015-11` is specified on the command line.

``` yaml $(tag) == 'package-2015-11'
input-file:
  - stable/2015-11-01/deployments.json
```

### Tag: package-2016-02

These settings apply only when `--tag=package-2016-02` is specified on the command line.

``` yaml $(tag) == 'package-2016-02'
input-file:
  - stable/2016-02-01/deployments.json
```

### Tag: package-2016-07

These settings apply only when `--tag=package-2016-07` is specified on the command line.

``` yaml $(tag) == 'package-2016-07'
input-file:
  - stable/2016-07-01/deployments.json
```

### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
  - stable/2016-09-01/deployments.json
```

### Tag: package-2017-0510

These settings apply only when `--tag=package-2017-0510` is specified on the command line.

``` yaml $(tag) == 'package-2017-0510'
input-file:
  - stable/2017-05-10/deployments.json
```

### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
input-file:
  - stable/2018-02-01/deployments.json
```

### Tag: package-2018-05

These settings apply only when `--tag=package-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-2018-05'
input-file:
  - stable/2018-05-01/deployments.json
```

### Tag: package-2019-03

These settings apply only when `--tag=package-2019-03` is specified on the command line.

``` yaml $(tag) == 'package-2019-03'
input-file:
  - stable/2019-03-01/deployments.json
```

### Tag: package-2019-05

These settings apply only when `--tag=package-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-2019-05'
input-file:
  - stable/2019-05-01/deployments.json
```

### Tag: package-2019-0510

These settings apply only when `--tag=package-2019-0510` is specified on the command line.

``` yaml $(tag) == 'package-2019-0510'
input-file:
  - stable/2019-05-10/deployments.json
```

### Tag: package-2019-07

These settings apply only when `--tag=package-2019-07` is specified on the command line.

``` yaml $(tag) == 'package-2019-07'
input-file:
  - stable/2019-07-01/deployments.json
```

### Tag: package-2019-08

These settings apply only when `--tag=package-2019-08` is specified on the command line.

``` yaml $(tag) == 'package-2019-08'
input-file:
  - stable/2019-08-01/deployments.json
```

### Tag: package-2019-10

These settings apply only when `--tag=package-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-2019-10'
input-file:
  - stable/2019-10-01/deployments.json
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06'
input-file:
  - stable/2020-06-01/deployments.json
```

### Tag: package-2020-08

These settings apply only when `--tag=package-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-2020-08'
input-file:
  - stable/2020-08-01/deployments.json
```

### Tag: package-2020-10

These settings apply only when `--tag=package-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-2020-10'
input-file:
  - stable/2020-10-01/deployments.json
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01'
input-file:
  - stable/2021-01-01/deployments.json
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

``` yaml $(tag) == 'package-2021-04'
input-file:
  - stable/2021-04-01/deployments.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

``` yaml $(tag) == 'package-2022-09'
input-file:
  - stable/2022-09-01/deployments.json
```

### Tag: package-2023-07

These settings apply only when `--tag=package-2023-07` is specified on the command line.

``` yaml $(tag) == 'package-2023-07'
input-file:
  - stable/2023-07-01/deployments.json
```

### Tag: package-2024-03

These settings apply only when `--tag=package-2024-03` is specified on the command line.

``` yaml $(tag) == 'package-2024-03'
input-file:
  - stable/2024-03-01/deployments.json
```

### Tag: package-2024-07

These settings apply only when `--tag=package-2024-07` is specified on the command line.

``` yaml $(tag) == 'package-2024-07'
input-file:
  - stable/2024-07-01/deployments.json
```

### Tag: package-2024-11

These settings apply only when `--tag=package-2024-11` is specified on the command line.

``` yaml $(tag) == 'package-2024-11'
input-file:
  - stable/2024-11-01/deployments.json
```

### Tag: package-2025-03

These settings apply only when `--tag=package-2025-03` is specified on the command line.

``` yaml $(tag) == 'package-2025-03'
input-file:
  - stable/2025-03-01/deployments.json
```

### Tag: package-2025-04

These settings apply only when `--tag=package-2025-04` is specified on the command line.

``` yaml $(tag) == 'package-2025-04'
input-file:
  - stable/2025-04-01/deployments.json
```

## Suppression

``` yaml
directive:
  - suppress: UniqueResourcePaths
    from: deployments.json
    where: $.paths
    reason: route definitions under an extension resource with Microsoft.Management
  - suppress: DescriptionAndTitleMissing
    where: $.definitions.AliasPathMetadata
    from: deployments.json
    reason: This was already checked in - not my code
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    where: $.paths
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: OperationsApiResponseSchema
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: OperationsApiSchemaUsesCommonTypes
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: NoDuplicatePathsForScopeParameter
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: LroLocationHeader
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: LroErrorContent
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: NoErrorCodeResponses
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PutRequestResponseSchemeArm
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PutResponseSchemaDescription
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PostOperationAsyncResponseValidation
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: MissingXmsErrorResponse
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathForPutOperation
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathResourceProviderMatchNamespace
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ParametersOrder
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: SyncPostReturn
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathContainsResourceType
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: OperationIdNounVerb
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathForResourceAction
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: UnSupportedPatchProperties
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: LroPostReturn
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ProvisioningStateSpecifiedForLROPut
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ProvisioningStateSpecifiedForLROPatch
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: SubscriptionsAndResourceGroupCasing
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ResourceNameRestriction
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: ConsistentPatchProperties
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: MissingTypeObject
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: TrackedResourcePatchOperation
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: IntegerTypeMustHaveFormat
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: BodyTopLevelProperties
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: TopLevelResourcesListBySubscription
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: XmsParameterLocation
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: PathForTrackedResourceTypes
    from: deployments.json
    reason: Not a tracked resource type. Cannot change anything due to design philosophy in ARM.
  - suppress: PostResponseCodes
    from: deployments.json
    reason: Breaking change in order to change the API response code.
  - suppress: TenantLevelAPIsNotAllowed
    from: deployments.json
    reason: Tenant level API's are allowed as an exception in ARM repo. It is a breaking change to modify it.
  - suppress: XmsPageableForListCalls
    from: deployments.json
    reason: Shared swagger with other teams. We cannot make changes to the API as we don't own it.
  - suppress: EvenSegmentedPathForPutOperation
    from: deployments.json
    reason: Linter rule limitation. The API has never been changed since inception. Would be a breaking change.
  - suppress: DeleteResponseCodes
    from: deployments.json
    reason: Breaking change in order to change the API response code.
  - suppress: PutResponseCodes
    from: deployments.json
    reason: Breaking change in order to change the API response code.
  - suppress: AvoidAdditionalProperties
    from: deployments.json
    reason: Breaking change in order to change the property names for multiple API's. Will fix in the future.
  - suppress: XmsExamplesRequired
    from: deployments.json
    reason: Xms Examples required is a pre-existing lint error. Not related to this version release. Will fix in the future.
  - suppress: RequiredReadOnlySystemData
    from: deployments.json
    reason: Pre-existing lint error. Not related to this version release. Will fix in the future
  - suppress: TrackedExtensionResourcesAreNotAllowed
    from: deployments.json
    reason: "The deployments resource type is ProxyOnly."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.Provider
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.DeploymentOperation
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    where: $.definitions.DeploymentOperationsListResult
    reason: "Historically some properties have not been returned for this model and reviewer said OK to suppress."
  - suppress: OperationsAPIImplementation
    from: deployments.json
    reason: Operations API is implemented as a separate service.
  - suppress: ProvisioningStateMustBeReadOnly
    from: deployments.json
    reason: Pre-existing lint error.
  - suppress: RequiredDefaultResponse
    from: deployments.json
    reason: Pre-existing lint error.
  - suppress: RequiredPropertiesMissingInResourceModel
    from: deployments.json
    reason: Pre-existing lint error.
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: deployments.json
    reason: Pre-existing lint error.
  - suppress: DescriptionMustNotBeNodeName
    from: deployments.json
    reason: Pre-existing lint error.
```

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
  - repo: azure-powershell
```

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)
