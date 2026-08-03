# AlertsManagement

This sample was selected for multiple tags.

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
```

``` yaml
title: AlertsManagementClient
description: AlertsManagement Client
openapi-type: arm
tag: package-2023-03
```

### Tag: package-preview-2024-01

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-01'
input-file:
  - Microsoft.AlertsManagement/preview/2024-01-01-preview/AlertsManagement.json  
```
### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.AlertsManagement/preview/2023-08-01-preview/AlertRuleRecommendations.json
```
### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-07'
input-file:
  - Microsoft.AlertsManagement/preview/2023-07-12-preview/AlertsManagement.json  
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
  - Microsoft.AlertsManagement/preview/2024-01-01-preview/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json
  - Microsoft.AlertsManagement/preview/2023-08-01-preview/AlertRuleRecommendations.json
  - Microsoft.AlertsManagement/preview/2021-08-08-preview/AlertProcessingRules.json
```
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



