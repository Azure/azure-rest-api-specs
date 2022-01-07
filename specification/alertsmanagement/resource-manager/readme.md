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
```

``` yaml
title: AlertsManagementClient
description: AlertsManagement Client
openapi-type: arm
tag: package-2021-07-22-preview
openapi-subtype: providerHub
```

### Tag: package-2021-07-22-preview


These settings apply only when `--tag=package-2021-07-22-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-07-22-preview'
input-file:
- Microsoft.AlertsManagement/preview/2021-07-22-preview/PrometheusRuleGroups.json
```

---
