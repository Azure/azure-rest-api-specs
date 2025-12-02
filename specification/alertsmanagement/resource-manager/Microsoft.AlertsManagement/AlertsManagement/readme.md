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
  - suppress: MISSING_APIS_IN_DEFAULT_TAG
    reason: These APIs were moved from AlertsManagement to other services
    from: preview/2018-11-02-privatepreview/AlertsManagement.json
```

``` yaml
title: AlertsManagementClient
description: AlertsManagement Client
openapi-type: arm
tag: package-preview-2025-05-25-preview
```

### Tag: package-preview-2025-05-25-preview

These settings apply only when `--tag=package-preview-2025-05-25-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-05-25-preview'
input-file:
  - preview/2025-05-25-preview/AlertsManagement.json
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

### Important Note
The following preview versions have been deprecated and their functionality is available in the stable version (stable/2019-03-01/AlertsManagement.json):
- 2023-07-12-preview/AlertsManagement.json
- 2024-01-01-preview/AlertsManagement.json

Please use the stable version for all Alerts Management operations.

### Tag: package-2019-03

These settings apply only when `--tag=package-2019-03` is specified on the command line.

```yaml $(tag) == 'package-2019-03'
input-file:
  - stable/2019-03-01/AlertsManagement.json
```

### Tag: package-preview-2021-01

These settings apply only when `--tag=package-preview-2021-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-01'
input-file:
  - preview/2021-01-01-preview/AlertsManagement.json
```

### Tag: package-preview-2019-05

These settings apply only when `--tag=package-preview-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2019-05'
input-file:
  - preview/2019-05-05-preview/AlertsManagement.json
```

### Tag: package-2018-05

These settings apply only when `--tag=package-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-2018-05'
input-file:
- stable/2018-05-05/AlertsManagement.json
```

### Tag: package-2018-05-preview

These settings apply only when `--tag=package-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-2018-05-preview'
input-file:
- preview/2018-05-05-preview/AlertsManagement.json
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

## CLI

See configuration in [readme.cli.md](./readme.cli.md)
