# Guest Configuration

> see https://aka.ms/autorest

This is the AutoRest configuration file for Guest Configuration.

---

## Getting Started

To build the SDK for Guest Configuration, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Guest Configuration API.

``` yaml
title: GuestConfigurationClient
description: Guest Configuration Client
openapi-type: arm
tag: package-2024-04-05
```

``` yaml !$(csharp)
modelerfour:
  flatten-models: false
```

### Tag: package-2024-04-05

These settings apply only when `--tag=package-2024-04-05` is specified on the command line.

```yaml $(tag) == 'package-2024-04-05'
input-file:
  - stable/2024-04-05/guestconfiguration.json
suppressions:
  - code: DeleteOperationResponses
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: DeleteResponseBodyEmpty
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: DeleteResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: EnumInsteadOfBoolean
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ListInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingSegmentsInNestedResourceListOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingTypeObject
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiResponseSchema
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiSchemaUsesCommonTypes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: PageableOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParameterNotDefinedInGlobalParameters
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParametersOrder
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequiredPropertiesMissingInResourceModel
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ResourceNameRestriction
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: SchemaDescriptionOrTitle
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedResourcePatchOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: UniqueXmsExample
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsPageableForListCalls
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
```

### Tag: package-2022-01-25

These settings apply only when `--tag=package-2022-01-25` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-25'
input-file:
  - stable/2022-01-25/guestconfiguration.json
suppressions:
  - code: DeleteOperationResponses
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: DeleteResponseBodyEmpty
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: DeleteResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: EnumInsteadOfBoolean
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ListInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingSegmentsInNestedResourceListOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingTypeObject
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiResponseSchema
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiSchemaUsesCommonTypes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: PageableOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParameterNotDefinedInGlobalParameters
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParametersOrder
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequiredPropertiesMissingInResourceModel
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ResourceNameRestriction
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: SchemaDescriptionOrTitle
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedResourcePatchOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: UniqueXmsExample
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsPageableForListCalls
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
```

### Tag: package-2021-01-25

These settings apply only when `--tag=package-2021-01-25` is specified on the command line.

``` yaml $(tag) == 'package-2021-01-25'
input-file:
  - stable/2021-01-25/guestconfiguration.json
suppressions:
  - code: DeleteOperationResponses
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: DeleteResponseBodyEmpty
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: DeleteResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: EnumInsteadOfBoolean
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ListInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingSegmentsInNestedResourceListOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingTypeObject
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiResponseSchema
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiSchemaUsesCommonTypes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: PageableOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParameterNotDefinedInGlobalParameters
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParametersOrder
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequiredPropertiesMissingInResourceModel
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ResourceNameRestriction
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: SchemaDescriptionOrTitle
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedResourcePatchOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: UniqueXmsExample
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsIdentifierValidation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsPageableForListCalls
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
```

### Tag: package-2020-06-25

These settings apply only when `--tag=package-2020-06-25` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-25'
input-file:
  - stable/2020-06-25/guestconfiguration.json
suppressions:
  - code: DeleteOperationResponses
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: DeleteResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: EnumInsteadOfBoolean
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ListInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingSegmentsInNestedResourceListOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingTypeObject
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiResponseSchema
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiSchemaUsesCommonTypes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: PageableOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParameterNotDefinedInGlobalParameters
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParametersOrder
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequiredPropertiesMissingInResourceModel
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequiredReadOnlySystemData
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ResourceNameRestriction
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: SchemaDescriptionOrTitle
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedResourcePatchOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: UniqueXmsExample
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsIdentifierValidation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsPageableForListCalls
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
```

### Tag: package-2018-11-20

These settings apply only when `--tag=package-2018-11-20` is specified on the command line.

``` yaml $(tag) == 'package-2018-11-20'
input-file:
  - stable/2018-11-20/guestconfiguration.json
suppressions:
  - code: DeleteOperationResponses
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: DeleteResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: EnumInsteadOfBoolean
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ListInOperationName
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingSegmentsInNestedResourceListOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingTypeObject
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiResponseSchema
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiSchemaUsesCommonTypes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: PageableOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParameterNotDefinedInGlobalParameters
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParametersOrder
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequiredPropertiesMissingInResourceModel
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ResourceNameRestriction
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedResourcePatchOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: UniqueXmsExample
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsIdentifierValidation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsPageableForListCalls
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
```

### Tag: package-2018-06-30-preview

These settings apply only when `--tag=package-2018-06-30-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-30-preview'
input-file:
- preview/2018-06-30-preview/guestconfiguration.json
suppressions:
  - code: ResourceNameRestriction
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: ParametersOrder
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: DeleteResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: DeleteOperationResponses
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: XmsPageableForListCalls
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: OperationsApiResponseSchema
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: OperationsApiSchemaUsesCommonTypes
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: MissingTypeObject
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: RequiredPropertiesMissingInResourceModel
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: TrackedResourcePatchOperation
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: DeleteOperationResponses
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: DeleteResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: EnumInsteadOfBoolean
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingSegmentsInNestedResourceListOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingTypeObject
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiResponseSchema
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: OperationsApiSchemaUsesCommonTypes
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: PageableOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParameterNotDefinedInGlobalParameters
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParametersOrder
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: PreviewVersionOverOneYear
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: RequiredPropertiesMissingInResourceModel
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ResourceNameRestriction
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: TrackedResourcePatchOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: UniqueXmsExample
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsIdentifierValidation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsPageableForListCalls
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
```

### Tag: package-2018-01-20-preview

These settings apply only when `--tag=package-2018-01-20-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-01-20-preview'
input-file:
- preview/2018-01-20-preview/guestconfiguration.json

suppressions:
  - code: AllTrackedResourcesMustHaveDelete
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: ArmResourcePropertiesBag
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: BodyTopLevelProperties
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: DeleteOperationResponses
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: DeleteResponseCodes
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: GetCollectionOnlyHasValueAndNextLink
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: MissingTypeObject
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: OperationsApiResponseSchema
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: OperationsApiSchemaUsesCommonTypes
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: ParametersOrder
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: ProvisioningStateValidation
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: RequiredPropertiesMissingInResourceModel
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: ResourceNameRestriction
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: TrackedResourcePatchOperation
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: XmsPageableForListCalls
    from: guestconfiguration.json
    reason: Newer rule and this is a legacy API that is not being updated.
  - code: LocationMustHaveXmsMutability
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: MissingSegmentsInNestedResourceListOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: PageableOperation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: ParameterNotDefinedInGlobalParameters
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: PreviewVersionOverOneYear
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
  - code: XmsIdentifierValidation
    from: guestconfiguration.json
    reason: Newer rule and this API is not being updated.
```

## Suppression

``` yaml
directive:
  - suppress: UniqueResourcePaths
    from: guestconfiguration.json
    where: $.paths
    reason: 'Microsoft.GuestConfiguration is a proxy resource provider under Microsoft. Please refer PR https://github.com/Azure/azure-rest-api-specs-pr/pull/540'
  - suppress: OperationsAPIImplementation
    from: guestconfiguration.json
    where: $.paths
    reason: 'Microsoft.GuestConfiguration is a proxy resource provider under Microsoft.Compute. However, Operations API for is implemented. So, suppressing the false positive. Please refer PR https://github.com/Azure/azure-rest-api-specs-pr/pull/540'
  - suppress: OperationsAPIImplementation
    from: guestconfiguration_NotImplemented.json
    where: $.paths
    reason: |-
      - APIs are approved here https://github.com/Azure/azure-rest-api-specs-pr/pull/540 
      - They were suppressed https://github.com/Azure/azure-rest-api-specs-pr/pull/559 
  - suppress: UniqueResourcePaths
    from: guestconfiguration_NotImplemented.json
    where: $.paths
    reason: |-
      - APIs are approved here https://github.com/Azure/azure-rest-api-specs-pr/pull/540 
      - They were suppressed https://github.com/Azure/azure-rest-api-specs-pr/pull/559 
  - suppress: TrackedResourceListByImmediateParent
    from: guestconfiguration_NotImplemented.json
    where: $.definitions
    reason: |-
      - APIs are approved here https://github.com/Azure/azure-rest-api-specs-pr/pull/540 
      - They were suppressed https://github.com/Azure/azure-rest-api-specs-pr/pull/559
  
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
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)