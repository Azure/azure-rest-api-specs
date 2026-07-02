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
tag: package-2026-06-06

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
```

### Tag: package-2026-04-06-preview

These settings apply only when `--tag=package-2026-04-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-04-06-preview'
input-file:
  - preview/2026-04-06-preview/Bulkactions.json
suppressions:
  - code: PostResponseCodes
    reason: >
      Cancel LRO on LaunchBulkInstancesOperation uses the ArmResourceActionNoResponseContentAsync
      pattern, mirroring the source Microsoft.ComputeBulkActions RP where the same suppression
      is in effect.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/{name}/cancel"].post
  - code: ParameterNotUsingCommonTypes
    reason: >
      The location parameter is a resource path segment key (location is azureLocation in the
      resource model) for LaunchBulkInstancesOperation, and is also used as a segment-bound
      parameter in the existing VirtualMachineBulkOperations action paths. In both cases the
      parameter cannot be a $ref to common-types LocationParameter without losing the resource
      key binding.
    from: Bulkactions.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations"].get.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations"].get.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/{name}"].get.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/{name}"].put.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/{name}"].delete.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/{name}/cancel"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/{name}/virtualMachines"].get.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/asyncOperations/{asyncOperationId}"].get.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkCancel"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkCreate"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkDeallocate"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkDelete"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkGetOperationStatus"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkHibernate"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkReimage"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkStart"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkVdiFlexCreate"].post.parameters[?(@.name=='location')]
  - code: MissingSegmentsInNestedResourceListOperation
    reason: >
      listVirtualMachines is the canonical child resource list URL pattern emitted by
      ArmResourceList for VirtualMachine under LaunchBulkInstancesOperation; the path
      already includes all parent segments emitted by the ARM TypeSpec library.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/{name}/virtualMachines"].get
  - code: EnumInsteadOfBoolean
    reason: >
      deleteInstances is a binary on-off flag with no foreseeable additional values
      (cascade-delete VMs yes or no), so an enum would add no expressive power.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/{name}"].delete.parameters[*]
  - code: PathForNestedResource
    reason: >
      The GetOperationStatus endpoint is the async operation poller URL for
      LaunchBulkInstancesOperation. The path intentionally uses the launchBulkInstancesOperations
      collection name as a fixed segment followed by asyncOperations/{asyncOperationId} to mirror
      the service-side routing contract. This is the documented exception case for the
      PathForNestedResource rule (see
      https://github.com/Azure/azure-openapi-validator/blob/main/docs/path-for-nested-resource.md#pathfornestedresource).
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/asyncOperations/{asyncOperationId}"]
```

### Tag: package-2026-06-06

These settings apply only when `--tag=package-2026-06-06` is specified on the command line.

```yaml $(tag) == 'package-2026-06-06'
input-file:
  - stable/2026-06-06/Bulkactions.json
suppressions:
  - code: ParameterNotUsingCommonTypes
    reason: >
      The location parameter is used as a segment-bound parameter in the
      VirtualMachineBulkOperations action paths and cannot be a $ref to common-types
      LocationParameter without losing the resource key binding.
    from: Bulkactions.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkCancel"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkDeallocate"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkDelete"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkGetOperationStatus"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkHibernate"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkStart"].post.parameters[?(@.name=='location')]
```

### Tag: package-2026-07-06-preview

These settings apply only when `--tag=package-2026-07-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-07-06-preview'
input-file:
  - preview/2026-07-06-preview/Bulkactions.json
suppressions:
  - code: ParameterNotUsingCommonTypes
    reason: >
      The location parameter is used as a segment-bound parameter in the
      VirtualMachineBulkOperations action paths and cannot be a $ref to common-types
      LocationParameter without losing the resource key binding.
    from: Bulkactions.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkCancel"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkDeallocate"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkDelete"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkGetOperationStatus"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkHibernate"].post.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/locations/{location}/virtualMachinesBulkStart"].post.parameters[?(@.name=='location')]
  - code: PostResponseCodes
    reason: ScheduledActions disable is an async void action (ArmResourceActionNoResponseContentAsync, final-state-via Location). The POST returns 202 with the Azure-AsyncOperation and Location polling headers; the terminal no-content (204) result is delivered by polling the Location status URL per the ARM async contract (RPC-Async-V1-07). No library template emits an explicit 202+204 for async-void actions; mirrors the Microsoft.Compute BulkActions / ComputeBulkActions precedent for the same pattern.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/scheduledActions/{scheduledActionName}/disable"].post
  - code: PostResponseCodes
    reason: ScheduledActions enable is an async void action (ArmResourceActionNoResponseContentAsync, final-state-via Location). The POST returns 202 with the Azure-AsyncOperation and Location polling headers; the terminal no-content (204) result is delivered by polling the Location status URL per the ARM async contract (RPC-Async-V1-07). No library template emits an explicit 202+204 for async-void actions; mirrors the Microsoft.Compute BulkActions / ComputeBulkActions precedent for the same pattern.
    from: Bulkactions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/scheduledActions/{scheduledActionName}/enable"].post
  - code: EnumInsteadOfBoolean
    reason: The disabled property is a binary on/off flag (whether the scheduled action / notification is disabled) with no foreseeable additional states, so a boolean is the clearest representation and an enum would add no expressive value; mirrors the Microsoft.Compute BulkActions precedent for binary flags.
    from: Bulkactions.json
    where:
      - $.definitions.NotificationProperties.properties.disabled
      - $.definitions.ScheduledActionProperties.properties.disabled
      - $.definitions.ScheduledActionUpdateProperties.properties.disabled
      - $.definitions.ScheduledActionsExtensionProperties.properties.disabled
  - code: ParameterNotUsingCommonTypes
    reason: The operationStatuses status-monitor is a manually-routed GET (mirroring the BulkActions getOperationStatus pattern); its location and operationId path parameters are declared inline and bound to the explicit route; mirrors the Microsoft.Compute BulkActions precedent.
    from: Bulkactions.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/operationStatuses/{operationId}"].get.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/operationStatuses/{operationId}"].get.parameters[?(@.name=='operationId')]
```
