# AzureComputeBulkActionsClient

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureComputeBulkActionsClient.

---

## Getting Started

To build the SDK for AzureComputeBulkActionsClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureComputeBulkActionsClient API.

```yaml !$(python) || !$(track2)
title: ComputeBulkActionsResourceProviderClient
```

```yaml
description: The Compute Bulk Actions Resource Provider Client
openapi-type: arm
tag: package-2026-04-06-preview

suppressions:
  - code: DefinitionsPropertiesNamesCamelCase
    reason: SSD is the abbreviation for solid state drive used in the property name.
    from: Bulkactions.json
    where: $.definitions.AdditionalCapabilities.properties.ultraSSDEnabled
  - code: AvoidAdditionalProperties
    reason:
      Tags are mimicing the existing object structure from compute, bulkactions is a
      passthrough API and will deliver the object as is to compute.
    from: Bulkactions.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.settings
  - code: AvoidAdditionalProperties
    reason:
      Tags are mimicing the existing object structure from compute, bulkactions is a
      passthrough API and will deliver the object as is to compute.
    from: Bulkactions.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.protectedSettings
  - code: PathForNestedResource
    reason:
      bulkVmOperations is a singleton proxy endpoint used for service-level read status and is not a standard ARM nested tracked resource path.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations"]
  - code: PathForResourceAction
    reason:
      bulkactions is an API that executes operation on batch of VMs so they won't be within scope of a specific resource.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations/cancel"]
  - code: PathForResourceAction
    reason:
      bulkactions is an API that executes operation on batch of VMs so they won't be within scope of a specific resource.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations/create"]
  - code: PathForResourceAction
    reason:
      bulkactions is an API that executes operation on batch of VMs so they won't be within scope of a specific resource.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations/deallocate"]
  - code: PathForResourceAction
    reason:
      bulkactions is an API that executes operation on batch of VMs so they won't be within scope of a specific resource.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations/delete"]
  - code: PathForResourceAction
    reason:
      bulkactions is an API that executes operation on batch of VMs so they won't be within scope of a specific resource.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations/getOperationsStatus"]
  - code: PathForResourceAction
    reason:
      bulkactions is an API that executes operation on batch of VMs so they won't be within scope of a specific resource.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations/hibernate"]
  - code: PathForResourceAction
    reason:
      bulkactions is an API that executes operation on batch of VMs so they won't be within scope of a specific resource.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations/reimage"]
  - code: PathForResourceAction
    reason:
      bulkactions is an API that executes operation on batch of VMs so they won't be within scope of a specific resource.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations/start"]
  - code: PathForResourceAction
    reason:
      bulkactions is an API that executes operation on batch of VMs so they won't be within scope of a specific resource.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{locationparameter}/virtualMachines/bulkVmOperations/vdiFlexCreate"]
        
```

### Tag: package-2026-04-06-preview

These settings apply only when `--tag=package-2026-04-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-04-06-preview'
input-file:
  - preview/2026-04-06-preview/Bulkactions.json
```
