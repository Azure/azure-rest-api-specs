# AzureComputeScheduledActionsClient

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureComputeScheduledActionsClient.

---

## Getting Started

To build the SDK for AzureComputeScheduledActionsClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AzureComputeScheduledActionsClient API.

```yaml !$(python) || !$(track2)
title: ComputeScheduledActionsResourceProviderClient
```

```yaml
description: The Compute Scheduled Actions Resource Provider Client
openapi-type: arm
tag: package-2026-06-24-preview
```

### Tag: package-2026-06-24-preview

These settings apply only when `--tag=package-2026-06-24-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-06-24-preview'
input-file:
  - preview/2026-06-24-preview/scheduledActions.json
suppressions:
  - code: PostResponseCodes
    reason: ScheduledActions disable is an async void action (ArmResourceActionNoResponseContentAsync, final-state-via Location). The POST returns 202 with the Azure-AsyncOperation and Location polling headers; the terminal no-content (204) result is delivered by polling the Location status URL per the ARM async contract (RPC-Async-V1-07). No library template emits an explicit 202+204 for async-void actions; mirrors the Microsoft.Compute BulkActions / ComputeBulkActions precedent for the same pattern.
    from: scheduledActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/scheduledActions/{scheduledActionName}/disable"].post
  - code: PostResponseCodes
    reason: ScheduledActions enable is an async void action (ArmResourceActionNoResponseContentAsync, final-state-via Location). The POST returns 202 with the Azure-AsyncOperation and Location polling headers; the terminal no-content (204) result is delivered by polling the Location status URL per the ARM async contract (RPC-Async-V1-07). No library template emits an explicit 202+204 for async-void actions; mirrors the Microsoft.Compute BulkActions / ComputeBulkActions precedent for the same pattern.
    from: scheduledActions.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/scheduledActions/{scheduledActionName}/enable"].post
  - code: EnumInsteadOfBoolean
    reason: The disabled property is a binary on/off flag (whether the scheduled action / notification is disabled) with no foreseeable additional states, so a boolean is the clearest representation and an enum would add no expressive value; mirrors the Microsoft.Compute BulkActions precedent for binary flags.
    from: scheduledActions.json
    where:
      - $.definitions.NotificationProperties.properties.disabled
      - $.definitions.ScheduledActionProperties.properties.disabled
      - $.definitions.ScheduledActionUpdateProperties.properties.disabled
      - $.definitions.ScheduledActionsExtensionProperties.properties.disabled
  - code: ParameterNotUsingCommonTypes
    reason: The operationStatuses status-monitor is a manually-routed GET (mirroring the BulkActions getOperationStatus pattern); its location and operationId path parameters are declared inline and bound to the explicit route; mirrors the Microsoft.Compute BulkActions precedent.
    from: scheduledActions.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/operationStatuses/{operationId}"].get.parameters[?(@.name=='location')]
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/operationStatuses/{operationId}"].get.parameters[?(@.name=='operationId')]
```
