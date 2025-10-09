# AlertsManagement

> see https://aka.ms/autorest

This is the AutoRest configuration file for AlertManagement.

---

## Getting Started

To build the SDK for AlertManagement, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AlertManagement API.

### Suppression
``` yaml
directive:
  - suppress: R3025
    reason: The rule applied incorrectly to base class.
    where:
      - $.definitions.ManagedResource
  - suppress: R3026
    reason: The rule applied incorrectly to base class.
    where:
      - $.definitions.ManagedResource
  - suppress: TopLevelResourcesListBySubscription
    reason: The list by scope includes also list by subscription, this is an extension resource.
    from: AlertsManagement.json    
  - suppress: GuidUsage
    reason: The IDs of investigation entities are GUIDs.
    from: Issues.json
    where:
     - $.definitions.FetchInvestigationResultParameters.properties.investigationId.format
     - $.definitions.InvestigationMetadata.properties.id.format
  - suppress: AvoidAdditionalProperties
    reason: These are property bags that originate from user input (directly or indirectly), such as metric dimensions.
    from: Issues.json
    where:
     - $.definitions.AzureMetricData.properties.dimensions
     - $.definitions.TransactionEdge.properties.metadata
     - $.definitions.TransactionNode.properties.metadata
  - suppress: AvoidAdditionalProperties
    reason: The customProperties field is intentionally designed to allow user-defined key-value pairs for alert metadata.
    from: AlertsManagement.json
    where:
     - $.definitions.customProperties
  - suppress: ParametersInPost
    reason: The newState parameter is required.
    from: AlertsManagement.json
    where:
     - $.paths['/providers/Microsoft.AlertsManagement/alerts/{alertId}/changestate'].post.parameters
     - $.paths['/{scope}/providers/Microsoft.AlertsManagement/alerts/{alertId}/changestate'].post.parameters
  - suppress: XmsPageableForListCalls
    reason: List operations follow existing AlertsManagement pagination patterns.
    from: AlertsManagement.json
    where:
      - $.paths["/providers/Microsoft.AlertsManagement/alerts/{alertId}/history"].get
  - suppress: GetCollectionOnlyHasValueAndNextLink
    reason: Response models maintain compatibility with existing AlertsManagement response structures.
    from: AlertsManagement.json
  - suppress: MULTIPLE_API_VERSION
    reason: The AlertsManagement service requires multiple API versions for comprehensive functionality across different services.
```

``` yaml
title: AlertsManagementClient
description: AlertsManagement Client
openapi-type: arm
tag: package-2023-03
```

=======
### Tag: package-preview-2025-05-25-preview

These settings apply only when `--tag=package-preview-2025-05-25-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-05-25-preview'
input-file:
  - Microsoft.AlertsManagement/preview/2025-05-25-preview/AlertsManagement.json
```

#### New Features in 2025-05-25-preview

1. Added customProperties field to Alert type
   - Optional field that can hold user-defined key-value pairs
   - Can be null, empty object {}, or contain string key-value pairs
   - Available in both Alerts_GetById and Alerts_List responses

2. Added tenant-level endpoints for tenant alert management:
   - GET /providers/Microsoft.AlertsManagement/alerts
   - GET /providers/Microsoft.AlertsManagement/alerts/{alertId}
   - GET /providers/Microsoft.AlertsManagement/alerts/{alertId}/history
   - POST /providers/Microsoft.AlertsManagement/alerts/{alertId}/changestate

3. Added event details on alert history modification record:
   - New object property named "details"
   - The object contains details relevent to this specific event
   - Is  null when the event is 'AlertCreated'

   These endpoints enable tenant-level alert operations without requiring a specific scope parameter.
   The operations are available through new operationIds: Alerts_GetAllTenant, Alerts_GetByIdTenant, Alerts_GetHistoryTenant, Alerts_ChangeStateTenant.

### Tag: package-preview-2025-05-01-preview

These settings apply only when `--tag=package-preview-2025-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-05-01-preview'
input-file:
  - Microsoft.AlertsManagement/stable/2023-03-01/PrometheusRuleGroups.json
  - Microsoft.AlertsManagement/stable/2019-03-01/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json
  - Microsoft.AlertsManagement/preview/2023-08-01-preview/AlertRuleRecommendations.json
  - Microsoft.AlertsManagement/preview/2021-08-08-preview/AlertProcessingRules.json
  - Microsoft.AlertsManagement/preview/2025-03-01-preview/Issues.json
  - Microsoft.AlertsManagement/preview/2025-05-01-preview/PreviewAlertRule.json
```
### Tag: package-preview-2025-03-01-preview

These settings apply only when `--tag=package-preview-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-03-01-preview'
input-file:
  - Microsoft.AlertsManagement/preview/2025-03-01-preview/Issues.json
```
### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.AlertsManagement/preview/2023-08-01-preview/AlertRuleRecommendations.json 
```
### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.AlertsManagement/preview/2023-04-01-preview/TenantActivityLogAlerts.json
```
### Tag: package-preview-2023-01

These settings apply only when `--tag=package-preview-2023-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-01'
input-file:
  - Microsoft.AlertsManagement/preview/2023-01-01-preview/AlertRuleRecommendations.json
```
### Tag: package-2023-03

These settings apply only when `--tag=package-2023-03` is specified on the command line.

```yaml $(tag) == 'package-2023-03'
input-file:
  - Microsoft.AlertsManagement/stable/2023-03-01/PrometheusRuleGroups.json
  - Microsoft.AlertsManagement/preview/2025-05-25-preview/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json
  - Microsoft.AlertsManagement/preview/2023-08-01-preview/AlertRuleRecommendations.json
  - Microsoft.AlertsManagement/preview/2021-08-08-preview/AlertProcessingRules.json
  - Microsoft.AlertsManagement/preview/2025-03-01-preview/Issues.json
```

### Important Note
The following preview versions have been deprecated and their functionality is available in the stable version (Microsoft.AlertsManagement/stable/2019-03-01/AlertsManagement.json):
- 2023-07-12-preview/AlertsManagement.json
- 2024-01-01-preview/AlertsManagement.json

Please use the stable version for all Alerts Management operations.
### Tag: package-2021-08

These settings apply only when `--tag=package-2021-08` is specified on the command line.

```yaml $(tag) == 'package-2021-08'
input-file:
  - Microsoft.AlertsManagement/stable/2021-08-08/AlertProcessingRules.json
  - Microsoft.AlertsManagement/preview/2021-07-22-preview/PrometheusRuleGroups.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json
  - Microsoft.AlertsManagement/preview/2023-01-01-preview/AlertRuleRecommendations.json
  - Microsoft.AlertsManagement/preview/2023-04-01-preview/TenantActivityLogAlerts.json
```

### Tag: package-preview-2021-08

These settings apply only when `--tag=package-preview-2021-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-08'
input-file:
  - Microsoft.AlertsManagement/preview/2021-08-08-preview/AlertProcessingRules.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json
```

### Tag: package-preview-2021-07

These settings apply only when `--tag=package-preview-2021-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-07'
input-file:
  - Microsoft.AlertsManagement/preview/2021-07-22-preview/PrometheusRuleGroups.json
```

### Tag: package-2021-04-only

These settings apply only when `--tag=package-2021-04-only` is specified on the command line.

```yaml $(tag) == 'package-2021-04-only'
input-file:
  - Microsoft.AlertsManagement/stable/2019-03-01/AlertsManagement.json
  - Microsoft.AlertsManagement/stable/2021-04-01/SmartDetectorAlertRulesApi.json
```

### Tag: package-preview-2021-01

These settings apply only when `--tag=package-preview-2021-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-01'
input-file:
  - Microsoft.AlertsManagement/preview/2021-01-01-preview/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2021-01-01-preview/MigrateFromSmartDetections.json
```
### Tag: package-2019-06-preview

These settings apply only when `--tag=package-2019-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-06-preview'
input-file:
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/ActionRules.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json
  - Microsoft.AlertsManagement/stable/2019-06-01/SmartDetectorAlertRulesApi.json
```

### Tag: package-2019-06

These settings apply only when `--tag=package-2019-06` is specified on the command line.

```yaml $(tag) == 'package-2019-06'
input-file:
  - Microsoft.AlertsManagement/stable/2019-06-01/SmartDetectorAlertRulesApi.json
```

### Tag: package-2019-03

These settings apply only when `--tag=package-2019-03` is specified on the command line.

```yaml $(tag) == 'package-2019-03'
input-file:
  - Microsoft.AlertsManagement/stable/2019-03-01/AlertsManagement.json
  - Microsoft.AlertsManagement/stable/2019-03-01/SmartDetectorAlertRulesApi.json
```

### Tag: package-preview-2019-05

These settings apply only when `--tag=package-preview-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2019-05'
input-file:
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/ActionRules.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json
```

### Tag: package-2018-05

These settings apply only when `--tag=package-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-2018-05'
input-file:
- Microsoft.AlertsManagement/stable/2018-05-05/AlertsManagement.json
```

### Tag: package-2018-05-preview

These settings apply only when `--tag=package-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-2018-05-preview'
input-file:
- Microsoft.AlertsManagement/preview/2018-05-05-preview/AlertsManagement.json
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
  - repo: azure-libraries-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-trenton
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

---

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
