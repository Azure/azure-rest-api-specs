# ApplicationInsights

> see https://aka.ms/autorest

This is the AutoRest configuration file for ApplicationInsights.

---

## Getting Started

To build the SDK for ApplicationInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the ApplicationInsights API.

``` yaml
title: ApplicationInsightsManagementClient
description: Composite Swagger for Application Insights Management Client
openapi-type: arm
tag: package-2021-11-01
```

### Suppression

``` yaml
directive:
  - suppress: LongRunningOperationsWithLongRunningExtension
    where:
      - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/purge"].post'
    reason: Original creation of the service did not comply with current ARM schema standards. The team is aware of it and any future updates should rectify the issue.
  - suppress: TrackedResourceListByImmediateParent
    where:
      - $.definitions
    reason:
      - we do have list operations available for our operations on individual instances of objects returned. False positives.
  - suppress: PutRequestResponseScheme
    reason: 'This api was existing there from 2015, it will break existing client if we change the request/response format'
  - suppress: ListInOperationName
    reason: 'The return value is an object, not an array. Looks like a false positive of the validation tool.'
  - suppress: PutInOperationName
    reason: 'We are not doing create on this api, it is only doing update in this PUT api call.'
  - suppress: XmsResourceInPutResponse
    reason: 'This api was existing there from 2015, it will break existing client if we change the request/response format'
  - suppress: RequiredPropertiesMissingInResourceModel
    reason: 'This api was existing there from 2015, it will break existing client if we change the response format'
  - suppress: BodyTopLevelProperties
    reason: 'This api was existing there from 2015, it will break existing client if we change the response format'
  - suppress: EnumInsteadOfBoolean
    reason: 'This api was existing there from 2015, it will break existing client if we change the type'
  - suppress: DescriptionAndTitleMissing
    reason: Error addresses missing description/title in inner reference. Referenced model contains title and description. Redundant.
    from: componentAnnotations_API.json
    where:
      - $.definitions.AnnotationError.properties.innererror
  - suppress: DescriptionAndTitleMissing
    reason: Error addresses missing description/title in inner reference. Referenced model contains title and description. Redundant.
    from: componentWorkItemConfigs_API.json
    where:
      - $.definitions.WorkItemConfigurationError.properties.innererror
  - suppress: LROStatusCodesReturnTypeSchema
    reason: The response for 200 does define a schema in place. The test likely expects a 'ref' member. False failure.
    from: componentAnnotations_API.json
    where:
      - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/components/{resourceName}/Annotations"].put.responses["200"]'
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: 'This api was existing there from 2015, it will break existing client if we change the name'
  - suppress: R2066
    reason: There are a bug in this rule. "ExportConfigurations_Create" is a valid operation id.
  - suppress: OBJECT_ADDITIONAL_PROPERTIES
    where: $.definitions.Workbook
    from: workbooks_API.json
    reason: 'This property is already a part of our API, so we cannot remove it'
  - suppress: READONLY_PROPERTY_NOT_ALLOWED_IN_REQUEST
    where: $.definitions.Resource.properties.name
    from: types.json
    reason: 'This property is already a part of our API, cannot remove it'
  - suppress: READONLY_PROPERTY_NOT_ALLOWED_IN_REQUEST
    where: $.definitions.Resource.properties.id
    from: types.json
    reason: 'This property is already a part of our API, cannot remove it'
  - suppress: READONLY_PROPERTY_NOT_ALLOWED_IN_REQUEST
    where: $.definitions.WorkbookResource.properties.id
    from: workbooks_API.json
    reason: 'This property is already a part of our API, cannot remove it'
  - suppress: READONLY_PROPERTY_NOT_ALLOWED_IN_REQUEST
    where: $.definitions.WorkbookResource.properties.name
    from: workbooks_API.json
    reason: 'This property is already a part of our API, cannot remove it'
  - suppress: DefaultErrorResponseSchema
    from: myworkbooks_API.json
    reason: 'this error format is already part of the previous api, cannot change it'
  - suppress: DeleteOperationResponses
    from: myworkbooks_API.json
    reason: 'delete API returns empty response and is already part of the previous api, cannot change it'
  - suppress: DeleteOperationResponses
    from: analyticsItems_API.json
    reason: 'consistent with existing delete response | owned by another team'
  - suppress: DeleteOperationResponses
    from: componentAnnotations_API.json
    reason: 'consistent with existing delete response | owned by another team'
  - suppress: DeleteOperationResponses
    from: componentApiKeys_API.json
    reason: 'consistent with existing delete response | owned by another team'
  - suppress: DeleteOperationResponses
    from: componentContinuousExport_API.json
    reason: 'consistent with existing delete response | owned by another team'
  - suppress: DeleteOperationResponses
    from: componentWorkItemConfigs_API.json
    reason: 'consistent with existing delete response | owned by another team'
  - suppress: DeleteOperationResponses
    from: favorites_API.json
    reason: 'consistent with existing delete response | owned by another team'
  - suppress: DeleteOperationResponses
    from: workbooks_API.json
    reason: 'consistent with existing delete response'
  - suppress: DefaultErrorResponseSchema
    from: componentAnnotations_API.json
    reason: 'consistent with existing default error response | owned by another team'
  - suppress: DefaultErrorResponseSchema
    from: componentWorkItemConfigs_API.json
    reason: 'consistent with existing default error response | owned by another team'
  - suppress: DefaultErrorResponseSchema
    from: workbooks_API.json
    reason: 'consistent with existing default error response'
  - suppress: R4009
    from: workbookTemplates_API.json
    reason: Existing APIs don't have systemData attribute. Suppressing so don't have to make breaking change
  - suppress: R4017
    from: workbookTemplates_API.json
    reason: Does not support list by subscription
  - suppress: DefaultErrorResponseSchema
    from: workbookOperations_API.json
    reason: 'consistent with existing default error response'
  - suppress: RequiredDefaultResponse
    from: analyticsItems_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: componentAnnotations_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: componentApiKeys_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: componentContinuousExport_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: componentFeaturesAndPricing_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: componentProactiveDetection_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: components_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: componentWorkItemConfigs_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: favorites_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: webTestLocations_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: webTestLocations_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: RequiredDefaultResponse
    from: webTests_API.json
    reason: 'consistent with existing default response | owned by another team'
  - suppress: PathResourceTypeNameCamelCase
    from: componentAnnotations_API.json
    reason: 'consistent with existing path | owned by another team'
  - suppress: PathResourceTypeNameCamelCase
    from: componentApiKeys_API.json
    reason: 'consistent with existing path | owned by another team'
  - suppress: PathResourceTypeNameCamelCase
    from: componentProactiveDetection_API.json
    reason: 'consistent with existing path | owned by another team'
  - suppress: PathResourceTypeNameCamelCase
    from: componentWorkItemConfigs_API.json
    reason: 'consistent with existing path | owned by another team'
  - suppress: PathResourceProviderNamePascalCase
    from: analyticsItems_API.json
    reason: 'consistent with existing path | owned by another team'
  - suppress: GetCollectionResponseSchema
    from: componentProactiveDetection_API.json
    reason: 'consistent with existing response schema | owned by another team'
  - suppress: IntegerTypeMustHaveFormat
    from: componentFeaturesAndPricing_API.json
    reason: 'consistent with existing format | owned by another team'
  - suppress: IntegerTypeMustHaveFormat
    from: components_API.json
    reason: 'consistent with existing format | owned by another team'
  - suppress: TopLevelResourcesListBySubscription
    from: workbooks_API.json
    reason: 'get workbook list by subscription is not supported'
  - suppress: OperationsAPIImplementation
    reason: 'Previously implemented operation apis are using an incorrect RP case format which I cannot change.'
  - suppress: SECRET_PROPERTY
    from: diagnosticServicesToken_API.json
    where:
      - $.definitions.DiagnosticServicesTokenResponse.properties.token
    reason: 'Secrets are OK to return in a POST response.'
  - suppress: DefaultErrorResponseSchema
    from: aiOperations_API
    reason: 'consistent with existing default error response | owned by another team'
  - suppress: OperationsApiResponseSchema
    from: aiOperations_API
    reason: 'consistent with existing response schema | owned by another team'
  - suppress: RequiredReadOnlySystemData
  
```

### Tag: package-2021-11-01

These settings apply only when `--tag=package-2021-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-11-01'
input-file:
  - Microsoft.Insights/stable/2015-05-01/aiOperations_API.json
  - Microsoft.Insights/stable/2015-05-01/componentAnnotations_API.json
  - Microsoft.Insights/stable/2015-05-01/componentApiKeys_API.json
  - Microsoft.Insights/stable/2015-05-01/componentContinuousExport_API.json
  - Microsoft.Insights/stable/2015-05-01/componentFeaturesAndPricing_API.json
  - Microsoft.Insights/stable/2015-05-01/componentProactiveDetection_API.json
  - Microsoft.Insights/stable/2015-05-01/componentWorkItemConfigs_API.json
  - Microsoft.Insights/stable/2015-05-01/favorites_API.json
  - Microsoft.Insights/stable/2015-05-01/webTestLocations_API.json
  - Microsoft.Insights/stable/2015-05-01/webTests_API.json
  - Microsoft.Insights/stable/2015-05-01/analyticsItems_API.json
  - Microsoft.Insights/stable/2020-11-20/workbookTemplates_API.json
  - Microsoft.Insights/stable/2021-03-08/myworkbooks_API.json
  - Microsoft.Insights/stable/2021-08-01/workbooks_API.json
  - Microsoft.Insights/preview/2018-05-01-preview/components_API.json
  - Microsoft.Insights/preview/2020-03-01-preview/componentLinkedStorageAccounts_API.json
  - Microsoft.Insights/preview/2020-06-02-preview/livetoken_API.json
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

```yaml $(tag) == 'package-2021-10'
input-file:
  - Microsoft.Insights/stable/2021-10-14/livetoken_API.json
```

### Tag: package-2021-03-only

These settings apply only when `--tag=package-2021-03-only` is specified on the command line.

``` yaml $(tag) == 'package-2021-03-only'
input-file:
  - Microsoft.Insights/stable/2021-03-08/myworkbooks_API.json
  - Microsoft.Insights/stable/2021-03-08/workbooks_API.json
  - Microsoft.Insights/stable/2021-03-08/workbookOperations_API.json
```

### Tag: package-preview-2021-03-only

These settings apply only when `--tag=package-preview-2021-03-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-03-only'
input-file:
  - Microsoft.Insights/preview/2021-03-03-preview/diagnosticServicesToken_API.json
```

### Tag: package-2020-11-only

These settings apply only when `--tag=package-2020-11-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-11-only'
input-file:
  - Microsoft.Insights/stable/2020-11-20/workbookTemplates_API.json
```

### Tag: package-2020-10-only

These settings apply only when `--tag=package-2020-10-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-10-only'
input-file:
  - Microsoft.Insights/stable/2020-10-20/workbookOperations_API.json
  - Microsoft.Insights/stable/2020-10-20/myworkbooks_API.json
  - Microsoft.Insights/stable/2020-10-20/workbooks_API.json
```

### Tag: package-preview-2020-10-only

These settings apply only when `--tag=package-preview-2020-10-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-10-only'
input-file:
  - Microsoft.Insights/preview/2020-10-05-preview/webTests_API.json
```

### Tag: package-preview-2020-06-only

These settings apply only when `--tag=package-preview-2020-06-only` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-06-only'
input-file:
  - Microsoft.Insights/preview/2020-06-02-preview/livetoken_API.json
```

### Tag: package-preview-2020-06

These settings apply only when `--tag=package-preview-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-06'
input-file:
  - Microsoft.Insights/stable/2015-05-01/aiOperations_API.json
  - Microsoft.Insights/stable/2015-05-01/componentAnnotations_API.json
  - Microsoft.Insights/stable/2015-05-01/componentApiKeys_API.json
  - Microsoft.Insights/stable/2015-05-01/componentContinuousExport_API.json
  - Microsoft.Insights/stable/2015-05-01/componentFeaturesAndPricing_API.json
  - Microsoft.Insights/stable/2015-05-01/componentProactiveDetection_API.json
  - Microsoft.Insights/stable/2015-05-01/componentWorkItemConfigs_API.json
  - Microsoft.Insights/stable/2015-05-01/favorites_API.json
  - Microsoft.Insights/stable/2015-05-01/webTestLocations_API.json
  - Microsoft.Insights/stable/2015-05-01/webTests_API.json
  - Microsoft.Insights/stable/2015-05-01/analyticsItems_API.json
  - Microsoft.Insights/stable/2015-05-01/workbooks_API.json
  - Microsoft.Insights/stable/2015-05-01/myworkbooks_API.json
  - Microsoft.Insights/preview/2018-05-01-preview/components_API.json
  - Microsoft.Insights/preview/2020-03-01-preview/componentLinkedStorageAccounts_API.json
  - Microsoft.Insights/preview/2020-06-02-preview/livetoken_API.json
```

### Tag: package-2020-04

These settings apply only when `--tag=package-2020-04` is specified on the command line. For Dotnet SDK generation.

``` yaml $(tag) == 'package-2020-04'
input-file:
- Microsoft.Insights/stable/2015-05-01/aiOperations_API.json
- Microsoft.Insights/stable/2015-05-01/componentAnnotations_API.json
- Microsoft.Insights/stable/2015-05-01/componentApiKeys_API.json
- Microsoft.Insights/stable/2015-05-01/componentContinuousExport_API.json
- Microsoft.Insights/stable/2015-05-01/componentFeaturesAndPricing_API.json
- Microsoft.Insights/stable/2015-05-01/componentProactiveDetection_API.json
- Microsoft.Insights/stable/2015-05-01/componentWorkItemConfigs_API.json
- Microsoft.Insights/stable/2015-05-01/favorites_API.json
- Microsoft.Insights/stable/2015-05-01/webTestLocations_API.json
- Microsoft.Insights/stable/2015-05-01/webTests_API.json
- Microsoft.Insights/stable/2015-05-01/analyticsItems_API.json
- Microsoft.Insights/stable/2015-05-01/workbooks_API.json
- Microsoft.Insights/stable/2015-05-01/myworkbooks_API.json
- Microsoft.Insights/preview/2018-05-01-preview/components_API.json
- Microsoft.Insights/preview/2020-03-01-preview/componentLinkedStorageAccounts_API.json
```

### Tag: package-2020-03-01-preview

These settings apply only when `--tag=package-2020-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-03-01-preview'
input-file:
- Microsoft.Insights/preview/2020-03-01-preview/componentLinkedStorageAccounts_API.json
```

### Tag: package-preview-2020-02

These settings apply only when `--tag=package-preview-2020-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-02'
input-file:
  - Microsoft.Insights/preview/2020-02-10-preview/WebTestResults_API.json
```

### Tag: package-2020-02-02-preview

These settings apply only when `--tag=package-2020-02-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-02-preview'
input-file:
- Microsoft.Insights/preview/2020-02-02-preview/components_API.json
```

### Tag: package-2020-02-02

These settings apply only when `--tag=package-2020-02-02` is specified on the command line.

``` yaml $(tag) == 'package-2020-02-02'
input-file:
- Microsoft.Insights/stable/2015-05-01/aiOperations_API.json
- Microsoft.Insights/stable/2015-05-01/componentAnnotations_API.json
- Microsoft.Insights/stable/2015-05-01/componentApiKeys_API.json
- Microsoft.Insights/stable/2015-05-01/componentContinuousExport_API.json
- Microsoft.Insights/stable/2015-05-01/componentFeaturesAndPricing_API.json
- Microsoft.Insights/stable/2015-05-01/componentProactiveDetection_API.json
- Microsoft.Insights/stable/2015-05-01/componentWorkItemConfigs_API.json
- Microsoft.Insights/stable/2015-05-01/favorites_API.json
- Microsoft.Insights/stable/2015-05-01/webTestLocations_API.json
- Microsoft.Insights/stable/2015-05-01/webTests_API.json
- Microsoft.Insights/stable/2015-05-01/analyticsItems_API.json
- Microsoft.Insights/stable/2015-05-01/workbooks_API.json
- Microsoft.Insights/stable/2015-05-01/myworkbooks_API.json
- Microsoft.Insights/stable/2020-02-02/components_API.json
```

### Tag: package-2019-10-17-preview

These settings apply only when `--tag=package-2019-10-17-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-10-17-preview'
input-file:
  - Microsoft.Insights/preview/2019-10-17-preview/workbookTemplates_API.json
```

### Tag: package-2018-06-17-preview

These settings apply only when `--tag=package-2018-06-17-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-17-preview'
input-file:
- Microsoft.Insights/preview/2018-06-17-preview/workbooks_API.json
- Microsoft.Insights/preview/2018-06-17-preview/workbookOperations_API.json
```

### Tag: package-2018-05-01-preview

These settings apply only when `--tag=package-2018-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-05-01-preview'
input-file:
- Microsoft.Insights/preview/2018-05-01-preview/componentProactiveDetection_API.json
- Microsoft.Insights/preview/2018-05-01-preview/components_API.json
- Microsoft.Insights/preview/2018-05-01-preview/webTests_API.json
```

### Tag: package-2017-10

These settings apply only when `--tag=package-2017-10` is specified on the command line.

``` yaml $(tag) == 'package-2017-10'
input-file:
- Microsoft.Insights/preview/2017-10-01/eaSubscriptionMigration_API.json
- Microsoft.Insights/preview/2017-10-01/componentFeaturesAndPricing_API.json
```

### Tag: package-2015-05

These settings apply only when `--tag=package-2015-05` is specified on the command line.

``` yaml $(tag) == 'package-2015-05'
input-file:
- Microsoft.Insights/stable/2015-05-01/aiOperations_API.json
- Microsoft.Insights/stable/2015-05-01/componentAnnotations_API.json
- Microsoft.Insights/stable/2015-05-01/componentApiKeys_API.json
- Microsoft.Insights/stable/2015-05-01/componentContinuousExport_API.json
- Microsoft.Insights/stable/2015-05-01/componentFeaturesAndPricing_API.json
- Microsoft.Insights/stable/2015-05-01/componentProactiveDetection_API.json
- Microsoft.Insights/stable/2015-05-01/components_API.json
- Microsoft.Insights/stable/2015-05-01/componentWorkItemConfigs_API.json
- Microsoft.Insights/stable/2015-05-01/favorites_API.json
- Microsoft.Insights/stable/2015-05-01/webTestLocations_API.json
- Microsoft.Insights/stable/2015-05-01/webTests_API.json
- Microsoft.Insights/stable/2015-05-01/analyticsItems_API.json
- Microsoft.Insights/stable/2015-05-01/workbooks_API.json
- Microsoft.Insights/stable/2015-05-01/myworkbooks_API.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  payload-flattening-threshold: 1
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ApplicationInsights.Management
  output-folder: $(csharp-sdks-folder)/applicationinsights/Microsoft.Azure.ApplicationInsights/src/Generated
  clear-output-folder: true
```

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
  azure-arm: true
  fluent: true
  namespace: com.microsoft.azure.management.applicationinsights
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-applicationinsights
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2015-05
```

### Tag: package-2015-05 and java

These settings apply only when `--tag=package-2015-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2015-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.applicationinsights.v2015_05_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/applicationinsights/mgmt-v2015_05_01
regenerate-manager: true
generate-interface: true
```

### Tag: schema-2018-06-17-preview

These settings apply only when `--tag=schema-2018-06-17-preview` is specified on the command line.

``` yaml $(tag) == 'schema-2018-06-17-preview'
input-file:
- Microsoft.Insights/preview/2018-06-17-preview/workbooks_API.json
- Microsoft.Insights/preview/2018-06-17-preview/workbookOperations_API.json
```
