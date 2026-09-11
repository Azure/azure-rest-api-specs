# AKS Scheduled Events

> see https://aka.ms/autorest

This is the AutoRest configuration file for AKS scheduled events.

The emitted schema describes the Azure Resource Notifications / Azure Resource Graph / Event Grid payload for ARM resource type `Microsoft.ContainerService/managedClusters/scheduledEvents`. It is intentionally not a customer-callable AKS RP operation surface.

``` yaml
openapi-type: arm
tag: package-2026-06
suppressions:
  - code: OperationsAPIImplementation
    from: scheduledEvents.json
    reason: scheduledEvents is a schema-only Azure Resource Notifications / Azure Resource Graph / Event Grid contract for Microsoft.ContainerService/managedClusters/scheduledEvents and intentionally does not define customer-callable ARM operations.
```

### Tag: package-2026-06

These settings apply only when `--tag=package-2026-06` is specified on the command line.

``` yaml $(tag) == 'package-2026-06'
input-file:
  - stable/2026-06-01/scheduledEvents.json
```
