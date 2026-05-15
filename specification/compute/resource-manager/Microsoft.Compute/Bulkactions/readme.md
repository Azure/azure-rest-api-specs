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
  - code: PostResponseCodes
    reason:
      Cancel LRO on LaunchBulkInstancesOperation uses the ArmResourceActionNoResponseContentAsync
      pattern, mirroring the source Microsoft.ComputeBulkActions RP where the same suppression
      is in effect.
    from: Bulkactions.json
  - code: ParameterNotUsingCommonTypes
    reason: >
      LaunchBulkInstancesOperation uses location as a resource path segment key
      (location is azureLocation in the resource model), so the location parameter
      cannot be a $ref to common-types LocationParameter without losing the resource key binding.
    from: Bulkactions.json
  - code: MissingSegmentsInNestedResourceListOperation
    reason:
      listVirtualMachines is the canonical child resource list URL pattern emitted by
      ArmResourceList for VirtualMachine under LaunchBulkInstancesOperation; the path
      already includes all parent segments emitted by the ARM TypeSpec library.
    from: Bulkactions.json
  - code: EnumInsteadOfBoolean
    reason:
      deleteInstances is a binary on-off flag with no foreseeable additional values
      (cascade-delete VMs yes or no), so an enum would add no expressive power.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/{name}"].delete.parameters[*]
  - code: AddedPath
    reason:
      Adding the /launchBulkInstancesOperations/{name}/virtualMachines child resource list
      under the existing 2026-04-06-preview api-version is intentional. The resource is being
      introduced in this preview revision and clients have not yet adopted prior shapes.
    from: Bulkactions.json
  - code: AddedOptionalProperty
    reason:
      The existing PriorityProfile model gains two optional Spot-related fields
      (maxPricePerVM, evictionPolicy) needed by the new LaunchBulkInstancesOperation resource.
      Both are optional, default to omitted, and are non-breaking for existing BulkCreate
      / BulkVdiFlexCreate consumers of PriorityProfile.
    from: Bulkactions.json
    where: $.definitions.PriorityProfile.properties
```

### Tag: package-2026-04-06-preview

These settings apply only when `--tag=package-2026-04-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-04-06-preview'
input-file:
  - preview/2026-04-06-preview/Bulkactions.json
```
