# AKS Scheduled Events 2026-06-01

> see https://aka.ms/autorest

This folder contains the generated OpenAPI schema for the `2026-06-01` AKS scheduled events Azure Resource Notifications / Azure Resource Graph / Event Grid contract.

The AutoRest configuration for this schema lives in `../../readme.md`.

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
  - scheduledEvents.json
```
