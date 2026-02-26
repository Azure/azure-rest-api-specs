# Durable Task Service

> see https://aka.ms/autorest

This is the AutoRest configuration file for durabletask.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the durabletask.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-02-01
```

### Tag: package-2026-02-01

These settings apply only when `--tag=package-2026-02-01` is specified on the command line.

```yaml $(tag) == 'package-2026-02-01'
input-file:
  - Microsoft.DurableTask/stable/2026-02-01/durabletask.json
suppressions:
  - code: ArmResourcePropertiesBag
    reason: Changing this property would constitute a breaking change. SKU property was approved in previous API versions.
    from:
      - durabletask.json
    where:
      - $.definitions.Scheduler
      - $.definitions.SchedulerUpdate
      - $.definitions.Scheduler.properties.sku
      - $.definitions.Scheduler.properties.properties.sku
      - $.definitions.SchedulerUpdate.properties.sku
      - $.definition.SchedulerUpdate.properties.properties.sku
      - $.definitions.SchedulerListResult
      - $.definitions.SchedulerSku
      - $.definitions.SchedulerSkuUpdate
      - $.definitions.Scheduler.properties
      - $.definitions.SchedulerUpdate.properties
      - $.definitions.SchedulerProperties
      - $.definitions.SchedulerPropertiesUpdate
      - $.definitions.SchedulerProperties.properties
      - $.definitions.SchedulerPropertiesUpdate.properties
  - code: XMSSecretInResponse
    reason: publicNetworkAccess is not a secret - it is a network configuration setting that controls public endpoint access.
    from:
      - durabletask.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DurableTask/schedulers/{schedulerName}"].put.responses["200"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DurableTask/schedulers/{schedulerName}"].put.responses["201"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DurableTask/schedulers/{schedulerName}"].get.responses["200"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DurableTask/schedulers/{schedulerName}"].patch.responses["200"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DurableTask/schedulers"].get.responses["200"].schema.properties.properties.properties.publicNetworkAccess
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.DurableTask/schedulers"].get.responses["200"].schema.properties.properties.properties.publicNetworkAccess
  - code: ResourceNameRestriction
    reason: The privateLinkResourceName parameter is determined by the Network Resource Provider service and does not require a pattern restriction.
    from:
      - durabletask.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DurableTask/schedulers/{schedulerName}/privateLinkResources/{privateLinkResourceName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DurableTask/schedulers/{schedulerName}/privateLinkResources/{privateLinkResourceName}"]
```

### Tag: package-2025-11-01

These settings apply only when `--tag=package-2025-11-01` is specified on the command line.

```yaml $(tag) == 'package-2025-11-01'
input-file:
  - Microsoft.DurableTask/stable/2025-11-01/durabletask.json
```


### Tag: package-2025-04-01-preview

These settings apply only when `--tag=package-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01-preview'
input-file:
  - Microsoft.DurableTask/preview/2025-04-01-preview/durabletask.json
```

### Tag: package-2024-10-01-preview

These settings apply only when `--tag=package-2024-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01-preview'
input-file:
  - Microsoft.DurableTask/preview/2024-10-01-preview/durabletask.json
```

---
