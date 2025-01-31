# Compute

> see https://aka.ms/autorest

This is the AutoRest configuration file for Compute.

The compute RP comprises of small services where each service has its own tag.
Hence, each sub-service has its own swagger spec.

All of them are tied together using this configuration and are packaged together into one compute client library.
This makes it easier for customers to download one (NuGet/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.

---

## Getting Started

To build the SDK for Compute, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Compute API.

```yaml
title: ComputeManagementClient
description: Compute Client
openapi-type: arm
tag: package-2024-07-01

directive:
  - from: diskRPCommon.json
    where: $.definitions
    transform: >
      $.PurchasePlan["x-ms-client-name"] = "DiskPurchasePlan";
      $.GrantAccessData.properties.access.description = "The Access Level, accepted values include None, Read, Write.";
  - where:
      - $.definitions.VirtualMachine.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.VirtualMachineScaleSetVM.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.ImageReference.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.ManagedDiskParameters.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.Disk.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.Snapshot.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.RestorePointCreate.properties
    suppress:
      - BodyTopLevelProperties
    reason: CRP has already been using existing ‘RestorePoint’ model definition with these properties as top level properties for many years now.
  - where:
      - $.definitions.RestorePoint.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.VirtualMachineScaleSetExtension
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineImageResource
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineImage
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.ImageReference
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.ManagedDiskParameters
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.NetworkInterfaceReference
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetIPConfiguration
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetUpdateIPConfiguration
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetNetworkConfiguration
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetUpdateNetworkConfiguration
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.AvailabilitySetUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.ProximityPlacementGroupUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineExtensionUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.ImageUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.DedicatedHostGroupUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.DedicatedHostUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.DiskEncryptionSetParameters
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetVM
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.VirtualMachineExtensionImage
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.RollingUpgradeStatusInfo
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.VirtualMachineImageResource
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.VirtualMachineImage
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.Gallery
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.GalleryImage
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.GalleryImageVersion
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.VirtualMachineImageResource
    suppress:
      - TrackedResourceGetOperation
  - where:
      - $.definitions.AdditionalCapabilities.properties.ultraSSDEnabled
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DiskProperties.properties.diskIOPSReadWrite
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DiskUpdateProperties.properties.diskIOPSReadWrite
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DiskProperties.properties.diskIOPSReadOnly
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DiskUpdateProperties.properties.diskIOPSReadOnly
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DataDisk.properties.diskIOPSReadWrite
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.VirtualMachineScaleSetDataDisk.properties.diskIOPSReadWrite
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.ContainerService
    suppress:
      - TrackedResourcePatchOperation
    reason: ACS service is deprecated so a PATCH endpoint won't be implemented
  - where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/remoteDesktopFile"].get
    suppress:
      - D5001
    reason: The API response has binary format and file type which is valid Swagger format. However, the example must be a JSON file which does not support specifying this response format.
  - where:
      - $.definitions.RestorePoint
    suppress:
      - NestedResourcesMustHaveListOperation
    reason: CRP supports the list /restorePoint operation by allowing customers to call Get RestorePointCollection with $expand=RestorePoints
  - where:
      - $.definitions.SubResourceWithColocationStatus.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.SubResourceWithColocationStatus
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - suppress: APIVersionPattern
    from:
      - common.json
  - suppress: XmsResourceInPutResponse
    from: virtualMachineScaleSet.json
    reason: x-ms-azure-resource tag makes 'ID' property required. However, VmssExtension is part of the VMSS property, not necessary a resource. So it does not always have ID.
  - suppress: ResourceNameRestriction
    from: virtualMachineScaleSet.json
    reason: there is no VMSS naming requirement. It only follows ARM resource naming requirement.
  - suppress: ResourceNameRestriction
    from: virtualMachine.json
    reason: there is no Compute VM naming requirement. It only follows ARM resource naming requirement.
  - suppress: ArmResourcePropertiesBag
    reason: This was an existing definition. Too much impact to go through breaking change to address this. 
    from: virtualMachineScaleSet.json
    where:
      - $.definitions.VirtualMachineScaleSetVMExtension
  - suppress: LroErrorContent
    reason: Compute uses common types defined in our own common-types.json.
  - suppress: ResourceNameRestriction
    from: dedicatedHost.json
    reason: there is no dedicated host naming requirement. It only follows ARM resource naming requirement.

suppressions:
  - code: OperationsAPIImplementation
    reason: The operations API is defined in a separate file.
    from: diagnostic.json
  - code: PathForResourceAction
    reason: This is not a valid scenario for the diskInspection and spotPlacementRecommender API as API Path does not match ARM Lint check formatting, requesting to suppress due to approval from reviewer.
    from: diagnostic.json
  - code: PathForNestedResource
    reason: This is not a valid scenario for the diskInspection and spotPlacementRecommender API as API Path does not match ARM Lint check formatting, requesting to suppress due to approval from reviewer.
    from: diagnostic.json
  - code: XmsPageableForListCalls
    reason: False positive error as API Path does not match ARM Lint check formatting, requesting to suppress due to approval from reviewer.
    from: diagnostic.json

list-exception:
- /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/restorePointCollections/{restorePointCollectionName}/restorePoints/{restorePointName}
```

### Tag: package-2024-07-01

These settings apply only when `--tag=package-2024-07-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-07-01'
isFullCompatible: true
title: "Azure Compute resource management API."
clear-output-folder: false
guessResourceKey: false
isAzureSpec: true
namespace: "Microsoft.Compute"

input-file:
  - ../resource-manager/Microsoft.Compute/common-types/v1/common.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/computeRPCommon.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineScaleSet.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachine.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineImage.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineExtensionImage.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/availabilitySet.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/proximityPlacementGroup.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/dedicatedHost.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/sshPublicKey.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/image.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/restorePoint.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/capacityReservation.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/logAnalytic.json
  - ../resource-manager/Microsoft.Compute/ComputeRP/stable/2024-07-01/runCommand.json 
```
