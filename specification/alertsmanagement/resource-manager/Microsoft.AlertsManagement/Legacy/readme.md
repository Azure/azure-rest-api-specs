# Legacy AlertsManagement Services

> see https://aka.ms/autorest

This is the AutoRest configuration file for Legacy AlertsManagement Services.

These services contain legacy APIs that are maintained for backward compatibility:

- **Issues** - Alert issue management
- **MigrateFromSmartDetections** - Migration from smart detection alerts
- **SmartDetectorAlertRulesApi** - Smart detector alert rule management
- **SmartGroups** - Alert smart grouping functionality

---

## Getting Started

To build the SDK for Legacy AlertsManagement Services, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Legacy AlertsManagement Services.

### Suppression
``` yaml
directive:
  - suppress: MULTIPLE_API_VERSION
    reason: The legacy services are on deprecation path
```

``` yaml
title: LegacyAlertsManagementClient
description: Legacy AlertsManagement Client
openapi-type: arm
tag: package-legacy-combined
```

### Tag: package-legacy-combined

These settings apply only when `--tag=package-legacy-combined` is specified on the command line.
This tag includes all Legacy services with their latest versions.

```yaml $(tag) == 'package-legacy-combined'
input-file:
  - preview/2025-03-01-preview/Issues.json
  - preview/2021-01-01-preview/MigrateFromSmartDetections.json
  - stable/2021-04-01/SmartDetectorAlertRulesApi.json
  - preview/2019-05-05-preview/SmartGroups.json
```

### Tag: package-issues-preview-2025-03

These settings apply only when `--tag=package-issues-preview-2025-03` is specified on the command line.

```yaml $(tag) == 'package-issues-preview-2025-03'
input-file:
  - preview/2025-03-01-preview/Issues.json
```

### Tag: package-migrate-preview-2021-01

These settings apply only when `--tag=package-migrate-preview-2021-01` is specified on the command line.

```yaml $(tag) == 'package-migrate-preview-2021-01'
input-file:
  - preview/2021-01-01-preview/MigrateFromSmartDetections.json
```

### Tag: package-smartdetector-stable-2021-04

These settings apply only when `--tag=package-smartdetector-stable-2021-04` is specified on the command line.

```yaml $(tag) == 'package-smartdetector-stable-2021-04'
input-file:
  - stable/2021-04-01/SmartDetectorAlertRulesApi.json
```

### Tag: package-smartdetector-stable-2019-06

These settings apply only when `--tag=package-smartdetector-stable-2019-06` is specified on the command line.

```yaml $(tag) == 'package-smartdetector-stable-2019-06'
input-file:
  - stable/2019-06-01/SmartDetectorAlertRulesApi.json
```

### Tag: package-smartdetector-stable-2019-03

These settings apply only when `--tag=package-smartdetector-stable-2019-03` is specified on the command line.

```yaml $(tag) == 'package-smartdetector-stable-2019-03'
input-file:
  - stable/2019-03-01/SmartDetectorAlertRulesApi.json
```

### Tag: package-smartgroups-preview-2019-05

These settings apply only when `--tag=package-smartgroups-preview-2019-05` is specified on the command line.

```yaml $(tag) == 'package-smartgroups-preview-2019-05'
input-file:
  - preview/2019-05-05-preview/SmartGroups.json
```
