# Guest Configuration - Inventory

> see https://aka.ms/autorest

This is the AutoRest configuration file for Guest Configuration Inventory (Guest Resource Service).

---

## Getting Started

To build the SDK for Guest Configuration Inventory, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Guest Configuration Inventory API.

``` yaml
title: GuestConfigurationInventoryClient
description: Guest Configuration Inventory Client
openapi-type: arm
tag: package-preview-2026-03-19
```

### Tag: package-preview-2026-03-19

These settings apply only when `--tag=package-preview-2026-03-19` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-03-19'
input-file:
  - preview/2026-03-19-preview/guestconfiguration.json
suppressions:
  - code: RequiredPropertiesMissingInResourceModel
    from: guestconfiguration.json
    where:
      - $.definitions.ApplicationList
      - $.definitions.CertificateList
      - $.definitions.DeviceInfoList
      - $.definitions.FirmwareResourceList
      - $.definitions.GroupList
      - $.definitions.ServiceList
      - $.definitions.UserList
      - $.definitions.WindowsRoleList
    reason: List response models are not ARM resources; they are pagination wrappers.
  - code: MissingSegmentsInNestedResourceListOperation
    from: guestconfiguration.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/applications"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/certificates"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/deviceInfos"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/firmwareResources"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/groups"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/services"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/users"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/providers/Microsoft.GuestConfiguration/windowsRoles"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/applications"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/certificates"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/deviceInfos"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/firmwareResources"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/groups"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/services"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/users"].get
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/providers/Microsoft.GuestConfiguration/windowsRoles"].get
    reason: These are ARM extension resources scoped to Microsoft.Compute/virtualMachines and Microsoft.HybridCompute/machines. The parent resource GET is owned by those resource providers and is defined in their specs, not in the Microsoft.GuestConfiguration spec.
```
