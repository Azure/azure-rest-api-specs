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
tag: package-2025-04-01

directive:
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
  - where:
      - $.definitions.VirtualMachine
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.VirtualMachineScaleSet
    suppress:
      - BodyTopLevelProperties
    reason: Placement (introduced in version 2025-04-01) is an ARM level property
  - where:
      - $.definitions.StorageProfile.properties.alignRegionalDisksToVMZone
    suppress:
      - EnumInsteadOfBoolean
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
# Do suppression for generated swagger
  - suppress: XmsResourceInPutResponse
    from: ComputeRP.json
    reason: x-ms-azure-resource tag makes 'ID' property required. However, VmssExtension is part of the VMSS property, not necessary a resource. So it does not always have ID.
  - suppress: ResourceNameRestriction
    from: ComputeRP.json
    reason: there is no VMSS naming requirement. It only follows ARM resource naming requirement.
  - suppress: ResourceNameRestriction
    from: ComputeRP.json
    reason: there is no Compute VM naming requirement. It only follows ARM resource naming requirement.
  - suppress: ArmResourcePropertiesBag
    reason: This was an existing definition. Too much impact to go through breaking change to address this.
    from: ComputeRP.json
    where:
      - $.definitions.VirtualMachineScaleSetVMExtension
  - suppress: ResourceNameRestriction
    from: ComputeRP.json
    reason: there is no dedicated host naming requirement. It only follows ARM resource naming requirement.
  - suppress: ResourceNameRestriction
    from: availabilitySet.json
    reason: there is no availability set naming requirement. It only follows ARM resource naming requirement.

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
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The property name contains abbreviations and need to keep it as upper case.
    from: diagnostic.json
  - code: BodyTopLevelProperties
    reason: The is the additional property bag to introduce new nonbreaking properties.
    from: diagnostic.json
  - code: PatchResponseCodes
    reason: PATCH and PUT follow the same behavior and response codes in Compute. Keeping it for legacy reasons.
    from: gallery.json
  - code: PatchBodyParametersSchema
    reason: PATCH and PUT follow the same behavior and response codes in Compute. Keeping it for legacy reasons.
    from: gallery.json
  - code: LroPatch202
    reason: PATCH and PUT follow the same behavior and response codes in Compute. Keeping it for legacy reasons.
    from: gallery.json
  - code: AvoidAdditionalProperties
    reason: The gallery backend service just treats this as a bag of properties to pass to downstream services.
    from: gallery.json
    where: $.definitions.AccessControlRulesPrivilege.properties.queryParameters
  - code: GetCollectionOnlyHasValueAndNextLink
    from: gallery.json
    reason: Existing issue from last version.
# Do suppression for generated swagger
  - code: PatchResponseCodes
    reason: PATCH and PUT follow the same behavior and response codes in Compute. Keeping it for legacy reasons.
    from: GalleryRP.json
  - code: PatchBodyParametersSchema
    reason: PATCH and PUT follow the same behavior and response codes in Compute. Keeping it for legacy reasons.
    from: GalleryRP.json
  - code: LroPatch202
    reason: PATCH and PUT follow the same behavior and response codes in Compute. Keeping it for legacy reasons.
    from: GalleryRP.json
  - code: AvoidAdditionalProperties
    reason: The gallery backend service just treats this as a bag of properties to pass to downstream services.
    from: GalleryRP.json
    where: $.definitions.AccessControlRulesPrivilege.properties.queryParameters
  - code: GetCollectionOnlyHasValueAndNextLink
    from: GalleryRP.json
    reason: Existing issue from last version.
  - code: XmsPageableForListCalls
    from: ComputeRP.json
    reason: VirtualMachineImages_ListWithProperties, which derives from VirtualMachineImages_List operation, returns a fixed list and does not support paging as it is a legacy operation. 
  - code: PostResponseCodes
    reason: ScaleOut operation returns both 200 and 202, but 200 will not return schema. This is a common pattern for VMSS action operations. 
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/scaleOut"].post
  - code: LroAzureAsyncOperationHeader
    from: ComputeRP.json
    reason: Compute does not include the LroAzureAsyncOperationHeader header
```

### Tag: package-2025-04-01

These settings apply only when `--tag=package-2025-04-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-04-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2025-04-01/ComputeRP.json
  - Microsoft.Compute/DiskRP/stable/2025-01-02/DiskRP.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2024-03-03/GalleryRP.json
  - Microsoft.Compute/CloudserviceRP/stable/2024-11-04/cloudService.json
```

### Tag: package-2025-04-01-only

These settings apply only when `--tag=package-2025-04-01-only` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2025-04-01/ComputeRP.json
```

### Tag: package-2025-03-01

These settings apply only when `--tag=package-2025-03-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-03-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2024-11-01/ComputeRP.json
  - Microsoft.Compute/DiskRP/stable/2025-01-02/DiskRP.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2024-03-03/GalleryRP.json
  - Microsoft.Compute/CloudserviceRP/stable/2024-11-04/cloudService.json
```

### Tag: package-2025-03-01-only

These settings apply only when `--tag=package-2025-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/DiskRP/stable/2025-01-02/DiskRP.json
```

### Tag: package-2025-02-01

These settings apply only when `--tag=package-2025-02-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-02-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2024-11-01/ComputeRP.json
  - Microsoft.Compute/DiskRP/stable/2024-03-02/DiskRP.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2024-03-03/GalleryRP.json
  - Microsoft.Compute/CloudserviceRP/stable/2024-11-04/cloudService.json
```

### Tag: package-2025-02-01-only

These settings apply only when `--tag=package-2025-02-01-only` is specified on the command line.

```yaml $(tag) == 'package-2025-02-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2024-11-01/ComputeRP.json
```

### Tag: package-2025-02-01-preview

These settings apply only when `--tag=package-2025-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-02-01-preview'
input-file:
  - Microsoft.Compute/DiagnosticRP/preview/2025-02-01-preview/diagnostic.json
```

### Tag: package-python-sdk

These settings apply only when `--tag=package-python-sdk` is specified on the command line.

```yaml $(tag) == 'package-python-sdk'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2024-11-01/ComputeRP.json
  - Microsoft.Compute/CloudserviceRP/stable/2024-11-04/cloudService.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/communityGallery.json
```

### Tag: package-2024-11-04

These settings apply only when `--tag=package-2024-11-04` is specified on the command line.

```yaml $(tag) == 'package-2024-11-04'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/runCommand.json 
  - Microsoft.Compute/DiskRP/stable/2024-03-02/DiskRP.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2024-03-03/GalleryRP.json
  - Microsoft.Compute/CloudserviceRP/stable/2024-11-04/cloudService.json
```

### Tag: package-2024-11-04-only

These settings apply only when `--tag=package-2024-11-04-only` is specified on the command line.

```yaml $(tag) == 'package-2024-11-04-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/CloudserviceRP/stable/2024-11-04/cloudService.json
```

### Tag: package-2024-11-01-only

These settings apply only when `--tag=package-2024-11-01-only` is specified on the command line.

```yaml $(tag) == 'package-2024-11-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2024-11-01/ComputeRP.json
```

### Tag: package-2024-10-01

These settings apply only when `--tag=package-2024-10-01` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/runCommand.json 
  - Microsoft.Compute/DiskRP/stable/2024-03-02/DiskRP.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2024-03-03/GalleryRP.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2024-03-03-only

These settings apply only when `--tag=package-2024-03-03-only` is specified on the command line.

```yaml $(tag) == 'package-2024-03-03-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/GalleryRP/stable/2024-03-03/GalleryRP.json
```

### Tag: package-2024-07-01

These settings apply only when `--tag=package-2024-07-01` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/runCommand.json 
  - Microsoft.Compute/DiskRP/stable/2024-03-02/DiskRP.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2024-07-01-only

These settings apply only when `--tag=package-2024-07-01-only` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2024-07-01/runCommand.json 
```

### Tag: package-2024-03-02

These settings apply only when `--tag=package-2024-03-02` is specified on the command line.

```yaml $(tag) == 'package-2024-03-02'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2024-03-02/DiskRP.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2024-03-02-only

These settings apply only when `--tag=package-2024-03-02-only` is specified on the command line.

```yaml $(tag) == 'package-2024-03-02-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/DiskRP/stable/2024-03-02/DiskRP.json
```

### Tag: package-2024-06-01-preview

These settings apply only when `--tag=package-2024-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-06-01-preview'
input-file:
  - Microsoft.Compute/DiagnosticRP/preview/2024-06-01-preview/diagnostic.json
```

### Tag: package-2024-03-01

These settings apply only when `--tag=package-2024-03-01` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2024-03-01-only

These settings apply only when `--tag=package-2024-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2024-03-01/runCommand.json
```

### Tag: package-2024-03-01-preview

These settings apply only when `--tag=package-2024-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01-preview'
input-file:
  - Microsoft.Compute/DiagnosticRP/preview/2024-03-01-preview/diagnostic.json
```

### Tag: package-2024-03-01-preview-only

These settings apply only when `--tag=package-2024-03-01-preview-only` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01-preview-only'
input-file:
  - Microsoft.Compute/DiagnosticRP/preview/2024-03-01-preview/diagnostic.json
```

### Tag: package-2023-07-03

These settings apply only when `--tag=package-2023-07-03` is specified on the command line.

```yaml $(tag) == 'package-2023-07-03'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-07-03-only

These settings apply only when `--tag=package-2023-07-03-only` is specified on the command line.

```yaml $(tag) == 'package-2023-07-03-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2023-07-03/communityGallery.json
```

### Tag: package-2023-10-02

These settings apply only when `--tag=package-2023-10-02` is specified on the command line.

```yaml $(tag) == 'package-2023-10-02'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-10-02-only

These settings apply only when `--tag=package-2023-10-02-only` is specified on the command line.

```yaml $(tag) == 'package-2023-10-02-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-10-02/snapshot.json
```

### Tag: package-2023-09-01

These settings apply only when `--tag=package-2023-09-01` is specified on the command line.

```yaml $(tag) == 'package-2023-09-01'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-09-01-only

These settings apply only when `--tag=package-2023-09-01-only` is specified on the command line.

```yaml $(tag) == 'package-2023-09-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-09-01/runCommand.json
```

### Tag: package-2022-08-03

These settings apply only when `--tag=package-2022-08-03` is specified on the command line.

```yaml $(tag) == 'package-2022-08-03'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2022-08-03-only

These settings apply only when `--tag=package-2022-08-03-only` is specified on the command line.

```yaml $(tag) == 'package-2022-08-03-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-08-03/communityGallery.json
```

### Tag: package-2023-07-01

These settings apply only when `--tag=package-2023-07-01` is specified on the command line.

```yaml $(tag) == 'package-2023-07-01'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-07-01-only

These settings apply only when `--tag=package-2023-07-01-only` is specified on the command line.

```yaml $(tag) == 'package-2023-07-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-07-01/runCommand.json
```

### Tag: package-2023-04-02

These settings apply only when `--tag=package-2023-04-02` is specified on the command line.

```yaml $(tag) == 'package-2023-04-02'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-04-02-only

These settings apply only when `--tag=package-2023-04-02-only` is specified on the command line.

```yaml $(tag) == 'package-2023-04-02-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-04-02/snapshot.json
```

### Tag: package-2023-01-02

These settings apply only when `--tag=package-2023-01-02` is specified on the command line.

```yaml $(tag) == 'package-2023-01-02'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-01-02-only

These settings apply only when `--tag=package-2023-01-02-only` is specified on the command line.

```yaml $(tag) == 'package-2023-01-02-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2023-01-02/snapshot.json
```

### Tag: package-2023-03-01

These settings apply only when `--tag=package-2023-03-01` is specified on the command line.

```yaml $(tag) == 'package-2023-03-01'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-03-01-only

These settings apply only when `--tag=package-2023-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2023-03-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2023-03-01/runCommand.json
```

### Tag: package-2022-11-01

These settings apply only when `--tag=package-2022-11-01` is specified on the command line.

```yaml $(tag) == 'package-2022-11-01'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2022-11-01-only

These settings apply only when `--tag=package-2022-11-01-only` is specified on the command line.

```yaml $(tag) == 'package-2022-11-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-11-01/runCommand.json
```

### Tag: package-2022-09-04

These settings apply only when `--tag=package-2022-09-04` is specified on the command line.

```yaml $(tag) == 'package-2022-09-04'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2022-09-04-only

These settings apply only when `--tag=package-2022-09-04-only` is specified on the command line.

```yaml $(tag) == 'package-2022-09-04-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-09-04/cloudService.json
```

### Tag: package-2022-03-03

These settings apply only when `--tag=package-2022-03-03` is specified on the command line.

```yaml $(tag) == 'package-2022-03-03'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-03-03-only

These settings apply only when `--tag=package-2022-03-03-only` is specified on the command line.

```yaml $(tag) == 'package-2022-03-03-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-03-03/communityGallery.json
```

### Tag: package-2022-08-01

These settings apply only when `--tag=package-2022-08-01` is specified on the command line.

```yaml $(tag) == 'package-2022-08-01'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-08-01-only

These settings apply only when `--tag=package-2022-08-01-only` is specified on the command line.

```yaml $(tag) == 'package-2022-08-01-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-08-01/runCommand.json
```

### Tag: package-2022-07-02

These settings apply only when `--tag=package-2022-07-02` is specified on the command line.

```yaml $(tag) == 'package-2022-07-02'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-07-02-only

These settings apply only when `--tag=package-2022-07-02-only` is specified on the command line.

```yaml $(tag) == 'package-2022-07-02-only'
input-file:
  - Microsoft.Compute/common-types/v1/common.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-07-02/snapshot.json
```

### Tag: package-2022-04-04

These settings apply only when `--tag=package-2022-04-04` is specified on the command line.

```yaml $(tag) == 'package-2022-04-04'
input-file:
  - Microsoft.Compute/CloudserviceRP/stable/2022-04-04/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-04-04-only

These settings apply only when `--tag=package-2022-04-04-only` is specified on the command line.

```yaml $(tag) == 'package-2022-04-04-only'
input-file:
  - Microsoft.Compute/CloudserviceRP/stable/2022-04-04/common.json
  - Microsoft.Compute/CloudserviceRP/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-03-02

These settings apply only when `--tag=package-2022-03-02` is specified on the command line.

```yaml $(tag) == 'package-2022-03-02'
input-file:
  - Microsoft.Compute/DiskRP/stable/2022-03-02/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/runCommand.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/snapshot.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2022-03-02-only

These settings apply only when `--tag=package-2022-03-02-only` is specified on the command line.

```yaml $(tag) == 'package-2022-03-02-only'
input-file:
  - Microsoft.Compute/DiskRP/stable/2022-03-02/common.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskRPCommon.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/disk.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskAccess.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskEncryptionSet.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/diskRestorePoint.json
  - Microsoft.Compute/DiskRP/stable/2022-03-02/snapshot.json
```

### Tag: package-2022-01-03

These settings apply only when `--tag=package-2022-01-03` is specified on the command line.

```yaml $(tag) == 'package-2022-01-03'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/runCommand.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2021-12-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/common.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2022-01-03-only

These settings apply only when `--tag=package-2022-01-03-only` is specified on the command line.

```yaml $(tag) == 'package-2022-01-03-only'
input-file:
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/common.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/galleryRPCommon.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2022-01-03/communityGallery.json
```

### Tag: package-2022-03-01

These settings apply only when `--tag=package-2022-03-01` is specified on the command line.

```yaml $(tag) == 'package-2022-03-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/runCommand.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2021-12-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2021-10-01/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2022-03-01-only

These settings apply only when `--tag=package-2022-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2022-03-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/common.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/computeRPCommon.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineScaleSet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachine.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/virtualMachineExtensionImage.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/availabilitySet.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/proximityPlacementGroup.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/dedicatedHost.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/sshPublicKey.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/image.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/restorePoint.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/capacityReservation.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/logAnalytic.json
  - Microsoft.Compute/ComputeRP/stable/2022-03-01/runCommand.json
```

### Tag: package-2021-12-01

These settings apply only when `--tag=package-2021-12-01` is specified on the command line.

```yaml $(tag) == 'package-2021-12-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-11-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-11-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2021-12-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2021-10-01/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-12-01-only

These settings apply only when `--tag=package-2021-12-01-oly` is specified on the command line.

```yaml $(tag) == 'package-2021-12-01-only'
input-file:
  - Microsoft.Compute/DiskRP/stable/2021-12-01/disk.json
```

### Tag: package-2021-11-01

These settings apply only when `--tag=package-2021-11-01` is specified on the command line.

```yaml $(tag) == 'package-2021-11-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-11-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-11-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2021-08-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2021-10-01/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-11-01-only

These settings apply only when `--tag=package-2021-11-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-11-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-11-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-11-01/runCommands.json
```

### Tag: package-2021-08-01-only

These settings apply only when `--tag=package-2021-08-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-08-01-only'
input-file:
  - Microsoft.Compute/DiskRP/stable/2021-08-01/disk.json
```

### Tag: package-2021-08-01

These settings apply only when `--tag=package-2021-08-01` is specified on the command line.

```yaml $(tag) == 'package-2021-08-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-07-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-07-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2021-08-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-10-01

These settings apply only when `--tag=package-2021-10-01` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-07-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-07-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2021-04-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2021-10-01/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-10-01-only

These settings apply only when `--tag=package-2021-10-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-only'
input-file:
  - Microsoft.Compute/GalleryRP/stable/2021-10-01/gallery.json
```

### Tag: package-2021-07-01

These settings apply only when `--tag=package-2021-07-01` is specified on the command line.

```yaml $(tag) == 'package-2021-07-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-07-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-07-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2021-04-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-07-01-only

These settings apply only when `--tag=package-2021-07-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-07-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-07-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-07-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/communityGallery.json
```

### Tag: package-2021-06-01-preview

These settings apply only when `--tag=2021-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-06-01-preview'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-11-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-11-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2021-12-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2021-10-01/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/sharedGallery.json
  - Microsoft.Compute/GalleryRP/stable/2021-07-01/communityGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
  - Microsoft.Compute/DiagnosticRP/preview/2021-06-01-preview/diagnostic.json
```

### Tag: package-2021-06-01-preview-only

These settings apply only when `--tag=package-2021-06-01-preview-only` is specified on the command line.

```yaml $(tag) == 'package-2021-06-01-preview-only'
input-file:
  - Microsoft.Compute/DiagnosticRP/preview/2021-06-01-preview/diagnostic.json
```

### Tag: package-2021-04-01

These settings apply only when `--tag=package-2021-04-01` is specified on the command line.

```yaml $(tag) == 'package-2021-04-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-04-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-04-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2021-04-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2020-09-30/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2020-09-30/sharedGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-04-01-only

These settings apply only when `--tag=package-2021-04-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-04-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-04-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-04-01/runCommands.json
  - Microsoft.Compute/DiskRP/stable/2021-04-01/disk.json
```

### Tag: package-2021-03-01

These settings apply only when `--tag=package-2021-03-01` is specified on the command line.

```yaml $(tag) == 'package-2021-03-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2021-03-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-03-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2020-12-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2020-09-30/gallery.json
  - Microsoft.Compute/GalleryRP/stable/2020-09-30/sharedGallery.json
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-03-01-only

These settings apply only when `--tag=package-2021-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-03-01-only'
input-file:
  - Microsoft.Compute/CloudserviceRP/stable/2021-03-01/cloudService.json
  - Microsoft.Compute/ComputeRP/stable/2021-03-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2021-03-01/runCommands.json
```

### Tag: package-2020-12-01

These settings apply only when `--tag=package-2020-12-01` is specified on the command line.

```yaml $(tag) == 'package-2020-12-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2020-12-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2020-12-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2020-12-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-12-01/gallery.json
```

### Tag: package-2020-12-01-only

These settings apply only when `--tag=package-2020-12-01-only` is specified on the command line.

```yaml $(tag) == 'package-2020-12-01-only'
input-file:
  - Microsoft.Compute/DiskRP/stable/2020-12-01/disk.json
  - Microsoft.Compute/ComputeRP/stable/2020-12-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2020-12-01/runCommands.json
```

### Tag: package-2020-10-01-preview

These settings apply only when `--tag=package-2020-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-10-01-preview'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2020-09-30/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-12-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
  - Microsoft.Compute/CloudserviceRP/preview/2020-10-01-preview/cloudService.json
```

### Tag: package-2020-10-01-preview-only

These settings apply only when `--tag=package-2020-10-01-preview-only` is specified on the command line.

```yaml $(tag) == 'package-2020-10-01-preview-only'
input-file:
  - Microsoft.Compute/CloudserviceRP/preview/2020-10-01-preview/cloudService.json
```

### Tag: package-2020-09-30

These settings apply only when `--tag=package-2020-09-30` is specified on the command line.

```yaml $(tag) == 'package-2020-09-30'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2020-09-30/disk.json
  - Microsoft.Compute/GalleryRP/preview/2020-09-30/gallery.json
  - Microsoft.Compute/GalleryRP/preview/2020-09-30/sharedGallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2020-09-30-only

These settings apply only when `--tag=package-2020-09-30-only` is specified on the command line.

```yaml $(tag) == 'package-2020-09-30-only'
input-file:
  - Microsoft.Compute/DiskRP/stable/2020-09-30/disk.json
  - Microsoft.Compute/GalleryRP/preview/2020-09-30/gallery.json
  - Microsoft.Compute/GalleryRP/preview/2020-09-30/sharedGallery.json
```

### Tag: package-2020-06-30

These settings apply only when `--tag=package-2020-06-30` is specified on the command line.

```yaml $(tag) == 'package-2020-06-30'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2020-06-30/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-12-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2020-06-30-only

These settings apply only when `--tag=package-2020-06-30-only` is specified on the command line.

```yaml $(tag) == 'package-2020-06-30-only'
input-file:
  - Microsoft.Compute/DiskRP/stable/2020-06-30/disk.json
```

### Tag: package-2020-06-01

These settings apply only when `--tag=package-2020-06-01` is specified on the command line.

```yaml $(tag) == 'package-2020-06-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2020-05-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-12-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2020-06-01-only

These settings apply only when `--tag=package-2020-06-01-only` is specified on the command line.

```yaml $(tag) == 'package-2020-06-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/runCommands.json
```

### Tag: package-2020-05-01

These settings apply only when `--tag=package-2020-05-01` is specified on the command line.

```yaml $(tag) == 'package-2020-05-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2019-12-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2019-12-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2020-05-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-12-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2020-05-01-only

These settings apply only when `--tag=package-2020-05-01-only` is specified on the command line.

```yaml $(tag) == 'package-2020-05-01-only'
input-file:
  - Microsoft.Compute/DiskRP/stable/2020-05-01/disk.json
```

### Tag: package-2019-12-01

These settings apply only when `--tag=package-2019-12-01` is specified on the command line.

```yaml $(tag) == 'package-2019-12-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2019-12-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2019-12-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2019-11-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-12-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-12-01-only

These settings apply only when `--tag=package-2019-12-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-12-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2019-12-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2019-12-01/runCommands.json
  - Microsoft.Compute/GalleryRP/stable/2019-12-01/gallery.json
```

### Tag: package-2019-11-01

These settings apply only when `--package-2019-11-01` is specified on the command line.

```yaml $(tag) == 'package-2019-11-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2019-07-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2019-07-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2019-11-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-07-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-11-01-only

These settings apply only when `--package-2019-11-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-11-01-only'
input-file:
  - Microsoft.Compute/DiskRP/stable/2019-11-01/disk.json
```

### Tag: package-2019-07

These settings apply only when `--tag=package-2019-07` is specified on the command line.

```yaml $(tag) == 'package-2019-07'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2019-07-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2019-07-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2019-07-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-07-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-07-01

These settings apply only when `--tag=package-2019-07-01` is specified on the command line.

```yaml $(tag) == 'package-2019-07-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2019-03-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2019-03-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2019-07-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-07-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-07-01-only

These settings apply only when `--tag=package-2019-07-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-07-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2019-07-01/compute.json
  - Microsoft.Compute/DiskRP/stable/2019-07-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-07-01/gallery.json
  - Microsoft.Compute/ComputeRP/stable/2019-07-01/runCommands.json
```

### Tag: package-2019-03-01

These settings apply only when `--tag=package-2019-03-01` is specified on the command line.

```yaml $(tag) == 'package-2019-03-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2019-03-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2019-03-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2019-03-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2019-03-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-04-01-only

These settings apply only when `--tag=package-2019-04-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-04-01-only'
input-file:
  - Microsoft.Compute/Skus/stable/2019-04-01/skus.json
```

### Tag: package-2019-03-01-only

These settings apply only when `--tag=package-2019-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-03-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2019-03-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2019-03-01/runCommands.json
  - Microsoft.Compute/GalleryRP/stable/2019-03-01/gallery.json
  - Microsoft.Compute/DiskRP/stable/2019-03-01/disk.json
```

### Tag: package-2018-10-01-Disks

These settings apply only when `--tag=package-2018-10-01-Disks` is specified on the command line.

```yaml $(tag) == 'package-2018-10-01-Disks'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2018-10-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2018-10-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2018-09-30/disk.json
  - Microsoft.Compute/GalleryRP/stable/2018-06-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2018-10-01

These settings apply only when `--tag=package-2018-10-01` is specified on the command line.

```yaml $(tag) == 'package-2018-10-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2018-10-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2018-10-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2018-06-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2018-06-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2018-10-01-only

These settings apply only when `--tag=package-2018-10-01-only` is specified on the command line.

```yaml $(tag) == 'package-2018-10-01-only'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2018-10-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2018-10-01/runCommands.json
```

### Tag: package-2018-09-30-only

These settings apply only when `--tag=package-2018-09-30-only` is specified on the command line.

```yaml $(tag) == 'package-2018-09-30-only'
input-file:
  - Microsoft.Compute/DiskRP/stable/2018-09-30/disk.json
```

### Tag: package-2018-06-exclude-gallery

These settings apply only when `--tag=package-2018-06-exclude-gallery` is specified on the command line.

```yaml $(tag) == 'package-2018-06-exclude-gallery'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2018-06-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2018-06-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2018-06-01/disk.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2018-06

These settings apply only when `--tag=package-2018-06` is specified on the command line.

```yaml $(tag) == 'package-2018-06'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2018-06-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2018-06-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2018-06-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2018-06-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2018-06-01

These settings apply only when `--tag=package-2018-06-01` is specified on the command line.

```yaml $(tag) == 'package-2018-06-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2018-04-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2018-04-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2018-06-01/disk.json
  - Microsoft.Compute/GalleryRP/stable/2018-06-01/gallery.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-compute-only-2018-06

These settings apply only when `--tag=package-compute-only-2018-06` is specified on the command line.

```yaml $(tag) == 'package-compute-only-2018-06'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2018-06-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2018-06-01/runCommands.json
  - Microsoft.Compute/GalleryRP/stable/2018-06-01/gallery.json
  - Microsoft.Compute/DiskRP/stable/2018-06-01/disk.json
```

### Tag: package-2018-04-01

These settings apply only when `--tag=package-2018-04-01` is specified on the command line.

```yaml $(tag) == 'package-2018-04-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2018-04-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2018-04-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2018-04-01/disk.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2018-04

These settings apply only when `--tag=package-2018-04` is specified on the command line.

```yaml $(tag) == 'package-2018-04'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2017-12-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2017-12-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2018-04-01/disk.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-compute-2018-04

These settings apply only when `--tag=package-compute-2018-04` is specified on the command line.

```yaml $(tag) == 'package-compute-2018-04'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2018-04-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2018-04-01/runCommands.json
  - Microsoft.Compute/DiskRP/stable/2018-04-01/disk.json
```

### Tag: package-disks-2018-04

These settings apply only when `--tag=package-disks-2018-04` is specified on the command line.

```yaml $(tag) == 'package-disks-2018-04'
input-file:
  - Microsoft.Compute/DiskRP/stable/2018-04-01/disk.json
```

### Tag: package-2017-12

These settings apply only when `--tag=package-2017-12` is specified on the command line.

```yaml $(tag) == 'package-2017-12'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2017-12-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2017-12-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2017-03-30/disk.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-compute-2017-12

These settings apply only when `--tag=package-compute-2017-12` is specified on the command line.

```yaml $(tag) == 'package-compute-2017-12'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2017-12-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2017-12-01/runCommands.json
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
  - Microsoft.Compute/DiskRP/stable/2017-03-30/disk.json
```

### Tag: package-compute-only-2017-12

These settings apply only when `--tag=package-compute-only-2017-12` is specified on the command line.

```yaml $(tag) == 'package-compute-only-2017-12'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2017-12-01/compute.json
  - Microsoft.Compute/ComputeRP/stable/2017-12-01/runCommands.json
```

### Tag: package-skus-2017-09

These settings apply only when `--tag=package-skus-2017-09` is specified on the command line.

```yaml $(tag) == 'package-skus-2017-09'
input-file:
  - Microsoft.Compute/Skus/stable/2017-09-01/skus.json
```

### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

```yaml $(tag) == 'package-2017-03'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2017-03-30/compute.json
  - Microsoft.Compute/DiskRP/stable/2017-03-30/disk.json
  - Microsoft.Compute/ComputeRP/stable/2017-03-30/runCommands.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-compute-2017-03

These settings apply only when `--tag=package-compute-2017-03` is specified on the command line.

```yaml $(tag) == 'package-compute-2017-03'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2017-03-30/compute.json
  - Microsoft.Compute/DiskRP/stable/2017-03-30/disk.json
  - Microsoft.Compute/ComputeRP/stable/2017-03-30/runCommands.json
```

### Tag: package-container-service-2017-01

These settings apply only when `--tag=package-container-service-2017-01` is specified on the command line.

```yaml $(tag) == 'package-container-service-2017-01'
input-file:
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-container-service-2016-09

These settings apply only when `--tag=package-container-service-2016-09` is specified on the command line.

```yaml $(tag) == 'package-container-service-2016-09'
input-file:
  - Microsoft.ContainerService/stable/2016-09-30/containerService.json
```

### Tag: package-2016-04-preview

These settings apply only when `--tag=package-2016-04-preview` is specified on the command line.

```yaml $(tag) == 'package-2016-04-preview'
input-file:
  - Microsoft.Compute/ComputeRP/preview/2016-04-30-preview/compute.json
  - Microsoft.Compute/DiskRP/preview/2016-04-30-preview/disk.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-compute-2016-04-preview

These settings apply only when `--tag=package-compute-2016-04-preview` is specified on the command line.

```yaml $(tag) == 'package-compute-2016-04-preview'
input-file:
  - Microsoft.Compute/ComputeRP/preview/2016-04-30-preview/compute.json
  - Microsoft.Compute/DiskRP/preview/2016-04-30-preview/disk.json
```

### Tag: package-2016-03

These settings apply only when `--tag=package-2016-03` is specified on the command line.

```yaml $(tag) == 'package-2016-03'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2016-03-30/compute.json
  - Microsoft.ContainerService/stable/2016-03-30/containerService.json
```

### Tag: package-compute-2016-03

These settings apply only when `--tag=package-compute-2016-03` is specified on the command line.

```yaml $(tag) == 'package-compute-2016-03'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2016-03-30/compute.json
```

### Tag: package-container-service-2016-03

These settings apply only when `--tag=package-container-service-2016-03` is specified on the command line.

```yaml $(tag) == 'package-container-service-2016-03'
input-file:
  - Microsoft.ContainerService/stable/2016-03-30/containerService.json
```

### Tag: package-container-service-2015-11-preview

These settings apply only when `--tag=package-container-service-2015-11-preview` is specified on the command line.

```yaml $(tag) == 'package-container-service-2015-11-preview'
input-file:
  - Microsoft.ContainerService/preview/2015-11-01-preview/containerService.json
```

### Tag: package-compute-2015-06

These settings apply only when `--tag=package-compute-2015-06` is specified on the command line.

```yaml $(tag) == 'package-compute-2015-06'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2015-06-15/compute.json
```

### Tag: package-2015-06-preview

These settings apply only when `--tag=package-2015-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2015-06-preview'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2015-06-15/compute.json
  - Microsoft.ContainerService/preview/2015-11-01-preview/containerService.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_compute']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

### Tag: profile-hybrid-2020-09-01

These settings apply only when `--tag=profile-hybrid-2020-09-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

```yaml $(tag) == 'profile-hybrid-2020-09-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2020-06-01/compute.json
  - Microsoft.Compute/DiskRP/stable/2019-07-01/disk.json
```
