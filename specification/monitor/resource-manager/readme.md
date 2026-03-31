# MonitorClient

> see https://aka.ms/autorest

This is the AutoRest configuration file for MonitorClient.

---

## Getting Started

To build the SDK for MonitorClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the MonitorClient API.

```yaml !$(python) || !$(track2)
title: MonitorClient
```

```yaml
description: Monitor Management Client
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-08
directive:
  - suppress: Example Validations
    reason: "There are open issues (bugs) in the validator affecting some of the examples and since there is no way to selectively disable the validation for a particular example or paths, all of the example validation is being turned off."
```

### Tag: package-2025-08

These settings apply only when `--tag=package-2025-08` is specified on the command line.

```yaml $(tag) == 'package-2025-08'
input-file:
  - Microsoft.Monitor/Accounts/preview/2025-05-03-preview/azuremonitorworkspace.json
  - Microsoft.Monitor/Operations/preview/2025-05-03-preview/operations.json

suppressions:
  - code: GuidUsage
    reason: The IDs of investigation entities are GUIDs.
    from: azuremonitorworkspace.json
    where:
     - $.definitions["Azure.Core.uuid"].format

```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
input-file:
  - Microsoft.Monitor/stable/2023-04-03/monitoringAccounts_API.json
  - Microsoft.Monitor/stable/2023-04-03/operations_API.json
```

### Tag: package-python-sdk-stable

These settings apply only when `--tag=package-python-sdk-stable` is specified on the command line.

```yaml $(tag) == 'package-python-sdk-stable'
input-file:
  - Microsoft.Monitor/stable/2023-04-03/monitoringAccounts_API.json
  - Microsoft.Monitor/stable/2023-04-03/operations_API.json
```

### Tag: package-python-sdk-for-cli-only

These settings apply only when `--tag=package-python-sdk-for-cli-only` is specified on the command line.

```yaml $(tag) == 'package-python-sdk-for-cli-only'
input-file:
 - Microsoft.Monitor/stable/2023-04-03/monitoringAccounts_API.json
 - Microsoft.Monitor/stable/2023-04-03/operations_API.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Microsoft.Monitor/stable/2023-04-03/monitoringAccounts_API.json
  - Microsoft.Monitor/stable/2023-04-03/operations_API.json
```

### Tag: package-2024-03

These settings apply only when `--tag=package-2024-03` is specified on the command line.

```yaml $(tag) == 'package-2024-03'
input-file:
  - Microsoft.Monitor/stable/2023-04-03/monitoringAccounts_API.json
  - Microsoft.Monitor/stable/2023-04-03/operations_API.json
```

### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

```yaml $(tag) == 'package-2024-02'
input-file:
  - Microsoft.Monitor/stable/2023-04-03/monitoringAccounts_API.json
  - Microsoft.Monitor/stable/2023-04-03/operations_API.json
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line

``` yaml $(tag) == 'package-2023-10-01-preview'
input-file:
- Microsoft.Monitor\preview\2023-10-01-preview\azuremonitor.json
```

### Tag: package-2023-10

These settings apply only when `--tag=package-2023-10` is specified on the command line.

```yaml $(tag) == 'package-2023-10'
input-file:
  - Microsoft.Monitor/stable/2023-04-03/monitoringAccounts_API.json
  - Microsoft.Monitor/stable/2023-04-03/operations_API.json
```

### Tag: package-2023-04

These settings apply only when `--tag=package-2023-04` is specified on the command line.

```yaml $(tag) == 'package-2023-04'
input-file:
  - Microsoft.Monitor/stable/2023-04-03/monitoringAccounts_API.json
  - Microsoft.Monitor/stable/2023-04-03/operations_API.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.Monitor/preview/2021-06-03-preview/monitoringAccounts_API.json
  - Microsoft.Monitor/preview/2021-06-03-preview/operations_API.json
```

### Tag: package-preview-2023-03

These settings apply only when `--tag=package-preview-2023-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-03'
input-file:
  - Microsoft.Monitor/preview/2021-06-03-preview/monitoringAccounts_API.json
  - Microsoft.Monitor/preview/2021-06-03-preview/operations_API.json
```

### Tag: package-preview-2022-08

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-08'
input-file:
  - Microsoft.Monitor/preview/2021-06-03-preview/monitoringAccounts_API.json
  - Microsoft.Monitor/preview/2021-06-03-preview/operations_API.json
```

### Tag: package-composite-v1

These settings apply only when `--tag=package-composite-v1` is specified on the command line.

```yaml $(tag) == 'package-composite-v1'
input-file:
  - Microsoft.Monitor/preview/2021-06-03-preview/monitoringAccounts_API.json
  - Microsoft.Monitor/preview/2021-06-03-preview/operations_API.json
```

### Tag: package-2021-06-03-preview-only

These settings apply only when `--tag=package-2021-06-03-preview-only` is specified on the command line.

```yaml $(tag) == 'package-2021-06-03-preview-only'
input-file:
  - Microsoft.Monitor/preview/2021-06-03-preview/monitoringAccounts_API.json
  - Microsoft.Monitor/preview/2021-06-03-preview/operations_API.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_monitor']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

# Validation

## Suppression

```yaml
directive:
  - suppress: R4009
    from: privateLinkScopes_API.json
    reason: "Contract is defined in the Network RP private endpoint spec, can be updated by internal calls from Network RP. "
  - suppress: R3018
    from: privateLinkScopes_API.json
    where: $.definitions.PrivateEndpointConnectionProperties.properties.queryOnlyPrivateLinkResources
    reason: "This property indicates whether data coming through this private endpoint should restrict itself only to resources in the scope - it has only ''true'' or ''false'' options, so it fits boolean type."
  - suppress: R3018
    from: privateLinkScopes_API.json
    where: $.definitions.PrivateEndpointConnectionProperties.properties.ingestOnlyToPrivateLinkResources
    reason: "This property indicates whether data coming through this private endpoint should restrict itself only to resources in the scope - it has only ''true'' or ''false'' options, so it fits boolean type."
  - suppress: OperationsAPIImplementation
    from: privateLinkScopes_API.json
    where: $.paths
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: R3016
    reason: The feature (polymorphic types) is in the process of deprecation and fixing this will require changes in the backend.
  - suppress: OperationsAPIImplementation
    from: dataCollectionEndpoints_API.json
    where: $.paths
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: OperationsAPIImplementation
    from: dataCollectionRules_API.json
    where: $.paths
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: OperationsAPIImplementation
    from: dataCollectionRuleAssociations_API.json
    where: $.paths
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: MissingTypeObject
    from: metrics_API.json
    where: $.definitions.LocalizableString
    reason: "LocalizableString exists in other swaggers my team can not modify"
  - suppress: MissingTypeObject
    from: metricDefinitions_API.json
    where: $.definitions.LocalizableString
    reason: "LocalizableString exists in other swaggers my team can not modify"
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: activityLogAlerts_API.json
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: OperationsAPIImplementation
    where: $.paths
    from: scheduledQueryRule_API.json
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: R4005
    where: $.definitions.Dimension.properties.operator
    from: scheduledQueryRule_API.json
    reason: "The discrepancy in the enum values is with an enum which is defined for a different service of a different team"
  - suppress: R3016
    where: $.definitions.Action.properties["odata.type"]
    reason: "This is an old field in a stable api version which is not camel cased"
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.AlertRuleProperties.properties.enabled
    from: activityLogAlerts_API.json
    reason: "This property indicates whether the alert rule is enabled or not  - it has only ''true'' or ''false'' options, so it fits boolean type."
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.AlertRulePatchProperties.properties.enabled
    from: activityLogAlerts_API.json
    reason: "This property indicates whether the alert rule is enabled or not  - it has only ''true'' or ''false'' options, so it fits boolean type."
  - suppress: DefaultErrorResponseSchema
    from: activityLogAlerts_API.json
    reason: "Updating the error response to the new format would be a breaking change."
  - suppress: DefaultErrorResponseSchema
    from: metricNamespaces_API.json
    reason: "Updating the error response to the new format would be a breaking change."
  - suppress: DefaultErrorResponseSchema
    from: metrics_API.json
    reason: "Updating the error response to the new format would be a breaking change."
  - suppress: DefaultErrorResponseSchema
    from: metricDefinitions_API.json
    reason: "Updating the error response to the new format would be a breaking change."
  - suppress: DefaultErrorResponseSchema
    from: actionGroups_API.json
    reason: "Updating the error response to the new format would be a breaking change."
  - suppress: DefaultErrorResponseSchema
    from: metricBaselines_API.json
    reason: "Updating the error response to the new format would be a breaking change."
  - suppress: OperationsAPIImplementation
    from: operations_API.json
    where: $.paths
    reason: "The operations API is implemented however the tool is still firing due to the casing being different"
  - suppress: OperationsAPIImplementation
    from: serviceDiagnosticsSettings_API.json
    where: $.paths
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: OperationsAPIImplementation
    from: subscriptionDiagnosticsSettings_API.json
    where: $.paths
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: OperationsAPIImplementation
    from: autoscale_API.json
    where: $.paths
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: OperationsAPIImplementation
    from: actionGroups_API.json
    where: $.paths
    reason: "Operations API is defined in a separate swagger spec for Microsoft.Insights namespace (https://github.com/Azure/azure-rest-api-specs/blob/master/specification/monitor/resource-manager/Microsoft.Insights/stable/2015-04-01/operations_API.json)"
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: metricDefinitions_API.json
    reason: "Breaking change to modify metricDefinitions now"
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: metrics_API.json
    reason: "Due to the ability to sort and order the list, this is incompatible with paging. It would also be a breaking change to modify this now"
  - suppress: ParametersInPost
    from: metrics_API.json
    reason: "metrics API is really a GET action that allows some parameters to be in the body due to length concerns. It would also be a breaking change to modify this now"
  - suppress: AvoidAdditionalProperties
    from: scheduledQueryRule_API.json
    where: $.definitions.Actions.properties.actionProperties
    reason: "This is a key-value collection which we do not validate and just pass as-is to a service which is several hops down the pipe where they are interpreted. Unknown keys are ignored and there are no invalid values."
  - suppress: INVALID_TYPE
    from: metricAlert_API.json
    reason: "Requires Swagger version update to resolve the types issue"
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: metricAlert_API.json
    reason: "This suppression is required because the nextLink property is not applicable"
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: metricBaselines_API.json
    reason: "This suppression is required because the nextLink property is not applicable"
  - suppress: GetCollectionResponseSchema
    from: metricAlert_API.json
    reason: "both list and single get requests, have an array response."
  - suppress: XmsPageableForListCalls
    from: metricAlert_API.json
    reason: "x-ms-pageable is not applicable."
  - suppress: PutResponseCodes
    from: metricAlert_API.json
    reason: "response 201 is not required."
```

### Suppressions

```yaml
suppressions:
  - code: AvoidAdditionalProperties
  - code: BodyTopLevelProperties
  - code: DefinitionsPropertiesNamesCamelCase
  - code: LroErrorContent
  - code: NoErrorCodeResponses
  - code: OperationIdNounVerb
  - code: OperationsAPIImplementation
  - code: PatchBodyParametersSchema
  - code: PostResponseCodes
  - code: ResourceNameRestriction
```

This section is a temporary solution to resolve the failure in those pipeline that is still using modeler v1.

```yaml ($(go) && !$(track2) && ($(tag) == 'package-2021-07' || $(tag) == 'package-2021-09') || $(csharp) || $(validation)
directive:
  - from: activityLogAlerts_API.json
    where: $.definitions
    transform: delete $["Resource"]
    reason: Missing kind, etag
  - from: activityLogAlerts_API.json
    where: $.definitions
    transform: delete $["ErrorResponse"]
    reason: Incompatible values (2020-10-01)
  - from: activityLogAlerts_API.json
    where: $.definitions
    transform: delete $["AzureResource"]
    reason: Incompatible values (2020-10-01)
  - from: activityLogAlerts_API.json
    where: $.definitions
    transform: delete $["ActionGroup"]
    reason: Incompatible values (2020-10-01)
```