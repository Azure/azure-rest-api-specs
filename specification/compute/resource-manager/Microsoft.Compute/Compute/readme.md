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
tag: package-2026-03-02

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
  - suppress: ArmResourcePropertiesBag
    reason: Lifecycle Hook Event is a notification event, created by the platform. The customer does not create/delete the resource. The "type" property is a defined enum with specified possible values.
    from: ComputeRP.json
    where:
      - $.definitions.VMScaleSetLifecycleHookEvent

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
  - code: ParametersInPost
    reason: forceDeallocate added as query parameter for consistency with hibernation in Deallocate POST API.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/deallocate"].post.parameters
# Suppressions for existing API versions for ComputeRP.json
  - code: GetCollectionResponseSchema
    reason: VirtualMachineRunCommands list returns a different schema than individual get by design.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/runCommands"]
  - code: DeleteOperationResponses
    reason: Existing delete operation response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/proximityPlacementGroups/{proximityPlacementGroupName}"].delete.responses
  - code: GetCollectionOnlyHasValueAndNextLink
    from: ComputeRP.json
    reason: Existing issue from last version.
  - code: PatchBodyParametersSchema
    reason: PATCH and PUT follow the same behavior and response codes in Compute. Keeping it for legacy reasons.
    from: ComputeRP.json
  - code: XMSSecretInResponse
    reason: Existing secret fields maintained for backward compatibility.
    from: ComputeRP.json
  - code: LroLocationHeader
    reason: Existing LRO operation does not include Location header for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/logAnalytics/apiAccess/getRequestRateByInterval"].post.responses.202.headers
  - code: LroLocationHeader
    reason: Existing LRO operation does not include Location header for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/logAnalytics/apiAccess/getThrottledRequests"].post.responses.202.headers
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/capacityReservationGroups/{capacityReservationGroupName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/capacityReservationGroups/{capacityReservationGroupName}/capacityReservations/{capacityReservationName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/hostGroups/{hostGroupName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/hostGroups/{hostGroupName}/hosts/{hostName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/proximityPlacementGroups/{proximityPlacementGroupName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/restorePointCollections/{restorePointCollectionName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/restorePointCollections/{restorePointCollectionName}/restorePoints/{restorePointName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/extensions/{vmssExtensionName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/extensions/{vmExtensionName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/extensions/{vmExtensionName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/images/{imageName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/runCommands/{runCommandName}"].get.parameters
  - code: ParametersInPointGet
    reason: Existing GET operation uses query parameters for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/runCommands/{runCommandName}"].get.parameters
  - code: ParametersInPost
    reason: Existing POST query parameter maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/delete"].post.parameters
  - code: ParametersInPost
    reason: Existing POST query parameter maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/forceRecoveryServiceFabricPlatformUpdateDomainWalk"].post.parameters
  - code: ParametersInPost
    reason: Existing POST query parameter maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/poweroff"].post.parameters
  - code: ParametersInPost
    reason: Existing POST query parameter maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/powerOff"].post.parameters
  - code: ParametersInPost
    reason: Existing POST query parameter maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/retrieveBootDiagnosticsData"].post.parameters
  - code: ParametersInPost
    reason: Existing POST query parameter maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/powerOff"].post.parameters
  - code: ParametersInPost
    reason: Existing POST query parameter maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/retrieveBootDiagnosticsData"].post.parameters
  - code: LroPatch202
    reason: PATCH and PUT follow the same behavior and response codes in Compute. Keeping it for legacy reasons.
    from: ComputeRP.json
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/capacityReservationGroups/{capacityReservationGroupName}/capacityReservations/{capacityReservationName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/hostGroups/{hostGroupName}/hosts/{hostName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/images/{imageName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/restorePointCollections/{restorePointCollectionName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/restorePointCollections/{restorePointCollectionName}/restorePoints/{restorePointName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/extensions/{vmssExtensionName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/extensions/{vmExtensionName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/extensions/{vmExtensionName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/runCommands/{runCommandName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete operation response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/proximityPlacementGroups/{proximityPlacementGroupName}"].delete
  - code: DeleteResponseCodes
    reason: Existing delete response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/runCommands/{runCommandName}"].delete
  - code: OperationIdNounVerb
    reason: Existing operation ID naming maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/capacityReservationGroups/{capacityReservationGroupName}/capacityReservations"].get.operationId
  - code: ParametersInPost
    reason: Existing query parameter kept for backwards compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/deallocate"].post.parameters

  - code: AllTrackedResourcesMustHaveDelete
    reason: Read-only tracked resource that does not support delete operations.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineExtensionImage
  - code: AllTrackedResourcesMustHaveDelete
    reason: Read-only tracked resource that does not support delete operations.
    from: ComputeRP.json
    where: $.definitions.RollingUpgradeStatusInfo
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.VmImagesInEdgeZoneListResult
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.RunCommandListResult
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.RunCommandDocument
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.ListUsagesResult
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineSizeListResult
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.DedicatedHostSizeListResult
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetExtensionListResult
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetInstanceView
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetListOSUpgradeHistory
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetListSkusResult
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetVMInstanceView
  - code: RequiredPropertiesMissingInResourceModel
    reason: List response or view model, not a standard ARM resource.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineInstanceView
  - code: ArmResourcePropertiesBag
    reason: Existing definition maintained for backward compatibility.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineExtension
  - code: ArmResourcePropertiesBag
    reason: Existing definition maintained for backward compatibility.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetExtension
  - code: BodyTopLevelProperties
    reason: Existing top-level properties for backward compatibility.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetVM
  - code: BodyTopLevelProperties
    reason: Not a standard ARM resource, extra top-level properties by design.
    from: ComputeRP.json
    where: $.definitions.RunCommandDocument
  - code: TrackedResourceBeyondsThirdLevel
    reason: Read-only resource beyond third level of nesting by design.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineExtensionImage
  - code: TrackedResourcesMustHavePut
    reason: Read-only tracked resource that does not support PUT operations.
    from: ComputeRP.json
    where: $.definitions.VirtualMachineExtensionImage
  - code: TrackedResourcesMustHavePut
    reason: Read-only tracked resource that does not support PUT operations.
    from: ComputeRP.json
    where: $.definitions.RollingUpgradeStatusInfo
  - code: PathForTrackedResourceTypes
    reason: Existing API path for tracked resource type for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/edgeZones/{edgeZone}/publishers/{publisherName}/artifacttypes/vmimage/offers/{offer}/skus/{skus}/versions/{version}"]
  - code: PathForTrackedResourceTypes
    reason: Existing API path for tracked resource type for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/publishers/{publisherName}/artifacttypes/vmextension/types/{type}/versions/{version}"]
  - code: PathForTrackedResourceTypes
    reason: Existing API path for tracked resource type for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/publishers/{publisherName}/artifacttypes/vmimage/offers/{offer}/skus/{skus}/versions/{version}"]
  - code: PathForTrackedResourceTypes
    reason: Existing API path for tracked resource type for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/rollingUpgrades/latest"]
  - code: PathForResourceAction
    reason: Existing action path maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/logAnalytics/apiAccess/getRequestRateByInterval"]
  - code: PathForResourceAction
    reason: Existing action path maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/logAnalytics/apiAccess/getThrottledRequests"]
  - code: PathForResourceAction
    reason: Existing action path maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/rollingUpgrades/cancel"]
  - code: PutResponseCodes
    reason: Existing PUT response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/availabilitySets/{availabilitySetName}"].put
  - code: PutResponseCodes
    reason: Existing PUT response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/restorePointCollections/{restorePointCollectionName}/restorePoints/{restorePointName}"].put
  - code: PutResponseCodes
    reason: Existing PUT response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}"].put

  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/availabilitySets/{availabilitySetName}/convertToVirtualMachineScaleSet"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/hostGroups/{hostGroupName}/hosts/{hostName}/redeploy"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/hostGroups/{hostGroupName}/hosts/{hostName}/restart"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/approveRollingUpgrade"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/convertToSinglePlacementGroup"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/deallocate"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/delete"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/extensionRollingUpgrade"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/manualupgrade"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/osRollingUpgrade"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/performMaintenance"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/poweroff"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/reapply"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/redeploy"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/reimage"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/reimageall"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/restart"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/rollingUpgrades/cancel"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/setOrchestrationServiceState"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/start"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/approveRollingUpgrade"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/deallocate"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/performMaintenance"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/powerOff"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/redeploy"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/reimage"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/reimageall"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/restart"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/start"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/convertToManagedDisks"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/deallocate"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/generalize"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/migrateToVirtualMachineScaleSet"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/performMaintenance"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/powerOff"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/reapply"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/redeploy"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/reimage"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/restart"].post
  - code: PostResponseCodes
    reason: Existing POST response codes maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/start"].post
  - code: PatchResponseCodes
    reason: PATCH and PUT follow the same behavior and response codes in Compute.
    from: ComputeRP.json
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Existing LRO PUT operation maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/restorePointCollections/{restorePointCollectionName}/restorePoints/{restorePointName}"].put
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Existing LRO PUT operation maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}"].put
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    reason: Existing tracked resource request schema for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualMachines/{instanceId}/extensions/{vmExtensionName}"].put
  - code: PathForNestedResource
    reason: Existing nested resource path maintained for backward compatibility.
    from: ComputeRP.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/rollingUpgrades/latest"]
  - code: DefinitionsPropertiesNamesCamelCase
    reason: Existing property name maintained for backward compatibility.
    from: ComputeRP.json
    where: $.definitions.DedicatedHostGroupPropertiesAdditionalCapabilities.properties.ultraSSDEnabled
```

### Tag: package-2025-11-01

These settings apply only when `--tag=package-2025-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-11-01'
input-file:
  - stable/2025-11-01/ComputeRP.json
  - stable/2025-01-02/DiskRP.json
  - stable/2021-07-01/skus.json
  - stable/2025-03-03/GalleryRP.json
```

### Tag: package-2025-11-01-only

These settings apply only when `--tag=package-2025-11-01-only` is specified on the command line.

```yaml $(tag) == 'package-2025-11-01-only'
input-file:
  - stable/2025-11-01/ComputeRP.json
```

### Tag: package-2026-03-02

These settings apply only when `--tag=package-2026-03-02` is specified on the command line.

``` yaml $(tag) == 'package-2026-03-02'
input-file:
  - stable/2025-04-01/ComputeRP.json
  - stable/2026-03-02/DiskRP.json
  - stable/2021-07-01/skus.json
  - stable/2025-03-03/GalleryRP.json
```

### Tag: package-2026-03-02-only

These settings apply only when `--tag=package-2026-03-02-only` is specified on the command line.

```yaml $(tag) == 'package-2026-03-02-only'
input-file:
  - common-types/v1/common.json
  - stable/2026-03-02/DiskRP.json
```

### Tag: package-2025-04-01

These settings apply only when `--tag=package-2025-04-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-04-01'
input-file:
  - stable/2025-04-01/ComputeRP.json
  - stable/2025-01-02/DiskRP.json
  - stable/2021-07-01/skus.json
  - stable/2024-03-03/GalleryRP.json
  - Cloudservice/stable/2024-11-04/cloudService.json
```

### Tag: package-2025-04-01-only

These settings apply only when `--tag=package-2025-04-01-only` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01-only'
input-file:
  - stable/2025-04-01/ComputeRP.json
```

### Tag: package-2025-03-03

These settings apply only when `--tag=package-2025-03-03` is specified on the command line.

``` yaml $(tag) == 'package-2025-03-03'
input-file:
  - stable/2025-03-03/GalleryRP.json
```

### Tag: package-2025-03-01

These settings apply only when `--tag=package-2025-03-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-03-01'
input-file:
  - stable/2024-11-01/ComputeRP.json
  - stable/2025-01-02/DiskRP.json
  - stable/2021-07-01/skus.json
  - stable/2024-03-03/GalleryRP.json
  - Cloudservice/stable/2024-11-04/cloudService.json
```

### Tag: package-2025-03-01-only

These settings apply only when `--tag=package-2025-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2025-01-02/DiskRP.json
```

### Tag: package-2025-02-01

These settings apply only when `--tag=package-2025-02-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-02-01'
input-file:
  - stable/2024-11-01/ComputeRP.json
  - stable/2024-03-02/DiskRP.json
  - stable/2021-07-01/skus.json
  - stable/2024-03-03/GalleryRP.json
  - Cloudservice/stable/2024-11-04/cloudService.json
```

### Tag: package-2025-02-01-only

These settings apply only when `--tag=package-2025-02-01-only` is specified on the command line.

```yaml $(tag) == 'package-2025-02-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2024-11-01/ComputeRP.json
```

### Tag: package-python-sdk

These settings apply only when `--tag=package-python-sdk` is specified on the command line.

```yaml $(tag) == 'package-python-sdk'
input-file:
  - common-types/v1/common.json
  - stable/2024-11-01/ComputeRP.json
  - Cloudservice/stable/2024-11-04/cloudService.json
  - stable/2023-10-02/diskRPCommon.json
  - stable/2023-10-02/disk.json
  - stable/2023-10-02/diskAccess.json
  - stable/2023-10-02/diskEncryptionSet.json
  - stable/2023-10-02/diskRestorePoint.json
  - stable/2023-10-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2023-07-03/galleryRPCommon.json
  - stable/2023-07-03/gallery.json
  - stable/2023-07-03/sharedGallery.json
  - stable/2023-07-03/communityGallery.json
```

### Tag: package-2024-11-04

These settings apply only when `--tag=package-2024-11-04` is specified on the command line.

```yaml $(tag) == 'package-2024-11-04'
input-file:
  - stable/2024-07-01/computeRPCommon.json
  - stable/2024-07-01/virtualMachineScaleSet.json
  - stable/2024-07-01/virtualMachine.json
  - stable/2024-07-01/virtualMachineImage.json
  - stable/2024-07-01/virtualMachineExtensionImage.json
  - stable/2024-07-01/availabilitySet.json
  - stable/2024-07-01/proximityPlacementGroup.json
  - stable/2024-07-01/dedicatedHost.json
  - stable/2024-07-01/sshPublicKey.json
  - stable/2024-07-01/image.json
  - stable/2024-07-01/restorePoint.json
  - stable/2024-07-01/capacityReservation.json
  - stable/2024-07-01/logAnalytic.json
  - stable/2024-07-01/runCommand.json 
  - stable/2024-03-02/DiskRP.json
  - stable/2021-07-01/skus.json
  - stable/2024-03-03/GalleryRP.json
  - Cloudservice/stable/2024-11-04/cloudService.json
```

### Tag: package-2024-11-04-only

These settings apply only when `--tag=package-2024-11-04-only` is specified on the command line.

```yaml $(tag) == 'package-2024-11-04-only'
input-file:
  - common-types/v1/common.json
  - Cloudservice/stable/2024-11-04/cloudService.json
```

### Tag: package-2024-11-01-only

These settings apply only when `--tag=package-2024-11-01-only` is specified on the command line.

```yaml $(tag) == 'package-2024-11-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2024-11-01/ComputeRP.json
```

### Tag: package-2024-10-01

These settings apply only when `--tag=package-2024-10-01` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01'
input-file:
  - common-types/v1/common.json
  - stable/2024-07-01/computeRPCommon.json
  - stable/2024-07-01/virtualMachineScaleSet.json
  - stable/2024-07-01/virtualMachine.json
  - stable/2024-07-01/virtualMachineImage.json
  - stable/2024-07-01/virtualMachineExtensionImage.json
  - stable/2024-07-01/availabilitySet.json
  - stable/2024-07-01/proximityPlacementGroup.json
  - stable/2024-07-01/dedicatedHost.json
  - stable/2024-07-01/sshPublicKey.json
  - stable/2024-07-01/image.json
  - stable/2024-07-01/restorePoint.json
  - stable/2024-07-01/capacityReservation.json
  - stable/2024-07-01/logAnalytic.json
  - stable/2024-07-01/runCommand.json 
  - stable/2024-03-02/DiskRP.json
  - stable/2021-07-01/skus.json
  - stable/2024-03-03/GalleryRP.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2024-03-03-only

These settings apply only when `--tag=package-2024-03-03-only` is specified on the command line.

```yaml $(tag) == 'package-2024-03-03-only'
input-file:
  - common-types/v1/common.json
  - stable/2024-03-03/GalleryRP.json
```

### Tag: package-2024-07-01

These settings apply only when `--tag=package-2024-07-01` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01'
input-file:
  - common-types/v1/common.json
  - stable/2024-07-01/computeRPCommon.json
  - stable/2024-07-01/virtualMachineScaleSet.json
  - stable/2024-07-01/virtualMachine.json
  - stable/2024-07-01/virtualMachineImage.json
  - stable/2024-07-01/virtualMachineExtensionImage.json
  - stable/2024-07-01/availabilitySet.json
  - stable/2024-07-01/proximityPlacementGroup.json
  - stable/2024-07-01/dedicatedHost.json
  - stable/2024-07-01/sshPublicKey.json
  - stable/2024-07-01/image.json
  - stable/2024-07-01/restorePoint.json
  - stable/2024-07-01/capacityReservation.json
  - stable/2024-07-01/logAnalytic.json
  - stable/2024-07-01/runCommand.json 
  - stable/2024-03-02/DiskRP.json
  - stable/2021-07-01/skus.json
  - stable/2023-07-03/galleryRPCommon.json
  - stable/2023-07-03/gallery.json
  - stable/2023-07-03/sharedGallery.json
  - stable/2023-07-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2024-07-01-only

These settings apply only when `--tag=package-2024-07-01-only` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2024-07-01/computeRPCommon.json
  - stable/2024-07-01/virtualMachineScaleSet.json
  - stable/2024-07-01/virtualMachine.json
  - stable/2024-07-01/virtualMachineImage.json
  - stable/2024-07-01/virtualMachineExtensionImage.json
  - stable/2024-07-01/availabilitySet.json
  - stable/2024-07-01/proximityPlacementGroup.json
  - stable/2024-07-01/dedicatedHost.json
  - stable/2024-07-01/sshPublicKey.json
  - stable/2024-07-01/image.json
  - stable/2024-07-01/restorePoint.json
  - stable/2024-07-01/capacityReservation.json
  - stable/2024-07-01/logAnalytic.json
  - stable/2024-07-01/runCommand.json 
```

### Tag: package-2024-03-02

These settings apply only when `--tag=package-2024-03-02` is specified on the command line.

```yaml $(tag) == 'package-2024-03-02'
input-file:
  - common-types/v1/common.json
  - stable/2024-03-01/computeRPCommon.json
  - stable/2024-03-01/virtualMachineScaleSet.json
  - stable/2024-03-01/virtualMachine.json
  - stable/2024-03-01/virtualMachineImage.json
  - stable/2024-03-01/virtualMachineExtensionImage.json
  - stable/2024-03-01/availabilitySet.json
  - stable/2024-03-01/proximityPlacementGroup.json
  - stable/2024-03-01/dedicatedHost.json
  - stable/2024-03-01/sshPublicKey.json
  - stable/2024-03-01/image.json
  - stable/2024-03-01/restorePoint.json
  - stable/2024-03-01/capacityReservation.json
  - stable/2024-03-01/logAnalytic.json
  - stable/2024-03-01/runCommand.json
  - stable/2024-03-02/DiskRP.json
  - stable/2021-07-01/skus.json
  - stable/2023-07-03/galleryRPCommon.json
  - stable/2023-07-03/gallery.json
  - stable/2023-07-03/sharedGallery.json
  - stable/2023-07-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2024-03-02-only

These settings apply only when `--tag=package-2024-03-02-only` is specified on the command line.

```yaml $(tag) == 'package-2024-03-02-only'
input-file:
  - common-types/v1/common.json
  - stable/2024-03-02/DiskRP.json
```

### Tag: package-2024-03-01

These settings apply only when `--tag=package-2024-03-01` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01'
input-file:
  - common-types/v1/common.json
  - stable/2024-03-01/computeRPCommon.json
  - stable/2024-03-01/virtualMachineScaleSet.json
  - stable/2024-03-01/virtualMachine.json
  - stable/2024-03-01/virtualMachineImage.json
  - stable/2024-03-01/virtualMachineExtensionImage.json
  - stable/2024-03-01/availabilitySet.json
  - stable/2024-03-01/proximityPlacementGroup.json
  - stable/2024-03-01/dedicatedHost.json
  - stable/2024-03-01/sshPublicKey.json
  - stable/2024-03-01/image.json
  - stable/2024-03-01/restorePoint.json
  - stable/2024-03-01/capacityReservation.json
  - stable/2024-03-01/logAnalytic.json
  - stable/2024-03-01/runCommand.json
  - stable/2023-10-02/diskRPCommon.json
  - stable/2023-10-02/disk.json
  - stable/2023-10-02/diskAccess.json
  - stable/2023-10-02/diskEncryptionSet.json
  - stable/2023-10-02/diskRestorePoint.json
  - stable/2023-10-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2023-07-03/galleryRPCommon.json
  - stable/2023-07-03/gallery.json
  - stable/2023-07-03/sharedGallery.json
  - stable/2023-07-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2024-03-01-only

These settings apply only when `--tag=package-2024-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2024-03-01/computeRPCommon.json
  - stable/2024-03-01/virtualMachineScaleSet.json
  - stable/2024-03-01/virtualMachine.json
  - stable/2024-03-01/virtualMachineImage.json
  - stable/2024-03-01/virtualMachineExtensionImage.json
  - stable/2024-03-01/availabilitySet.json
  - stable/2024-03-01/proximityPlacementGroup.json
  - stable/2024-03-01/dedicatedHost.json
  - stable/2024-03-01/sshPublicKey.json
  - stable/2024-03-01/image.json
  - stable/2024-03-01/restorePoint.json
  - stable/2024-03-01/capacityReservation.json
  - stable/2024-03-01/logAnalytic.json
  - stable/2024-03-01/runCommand.json
```

### Tag: package-2023-07-03

These settings apply only when `--tag=package-2023-07-03` is specified on the command line.

```yaml $(tag) == 'package-2023-07-03'
input-file:
  - common-types/v1/common.json
  - stable/2023-09-01/computeRPCommon.json
  - stable/2023-09-01/virtualMachineScaleSet.json
  - stable/2023-09-01/virtualMachine.json
  - stable/2023-09-01/virtualMachineImage.json
  - stable/2023-09-01/virtualMachineExtensionImage.json
  - stable/2023-09-01/availabilitySet.json
  - stable/2023-09-01/proximityPlacementGroup.json
  - stable/2023-09-01/dedicatedHost.json
  - stable/2023-09-01/sshPublicKey.json
  - stable/2023-09-01/image.json
  - stable/2023-09-01/restorePoint.json
  - stable/2023-09-01/capacityReservation.json
  - stable/2023-09-01/logAnalytic.json
  - stable/2023-09-01/runCommand.json
  - stable/2023-10-02/diskRPCommon.json
  - stable/2023-10-02/disk.json
  - stable/2023-10-02/diskAccess.json
  - stable/2023-10-02/diskEncryptionSet.json
  - stable/2023-10-02/diskRestorePoint.json
  - stable/2023-10-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2023-07-03/galleryRPCommon.json
  - stable/2023-07-03/gallery.json
  - stable/2023-07-03/sharedGallery.json
  - stable/2023-07-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-07-03-only

These settings apply only when `--tag=package-2023-07-03-only` is specified on the command line.

```yaml $(tag) == 'package-2023-07-03-only'
input-file:
  - common-types/v1/common.json
  - stable/2023-07-03/galleryRPCommon.json
  - stable/2023-07-03/gallery.json
  - stable/2023-07-03/sharedGallery.json
  - stable/2023-07-03/communityGallery.json
```

### Tag: package-2023-10-02

These settings apply only when `--tag=package-2023-10-02` is specified on the command line.

```yaml $(tag) == 'package-2023-10-02'
input-file:
  - common-types/v1/common.json
  - stable/2023-09-01/computeRPCommon.json
  - stable/2023-09-01/virtualMachineScaleSet.json
  - stable/2023-09-01/virtualMachine.json
  - stable/2023-09-01/virtualMachineImage.json
  - stable/2023-09-01/virtualMachineExtensionImage.json
  - stable/2023-09-01/availabilitySet.json
  - stable/2023-09-01/proximityPlacementGroup.json
  - stable/2023-09-01/dedicatedHost.json
  - stable/2023-09-01/sshPublicKey.json
  - stable/2023-09-01/image.json
  - stable/2023-09-01/restorePoint.json
  - stable/2023-09-01/capacityReservation.json
  - stable/2023-09-01/logAnalytic.json
  - stable/2023-09-01/runCommand.json
  - stable/2023-10-02/diskRPCommon.json
  - stable/2023-10-02/disk.json
  - stable/2023-10-02/diskAccess.json
  - stable/2023-10-02/diskEncryptionSet.json
  - stable/2023-10-02/diskRestorePoint.json
  - stable/2023-10-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-08-03/galleryRPCommon.json
  - stable/2022-08-03/gallery.json
  - stable/2022-08-03/sharedGallery.json
  - stable/2022-08-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-10-02-only

These settings apply only when `--tag=package-2023-10-02-only` is specified on the command line.

```yaml $(tag) == 'package-2023-10-02-only'
input-file:
  - common-types/v1/common.json
  - stable/2023-10-02/diskRPCommon.json
  - stable/2023-10-02/disk.json
  - stable/2023-10-02/diskAccess.json
  - stable/2023-10-02/diskEncryptionSet.json
  - stable/2023-10-02/diskRestorePoint.json
  - stable/2023-10-02/snapshot.json
```

### Tag: package-2023-09-01

These settings apply only when `--tag=package-2023-09-01` is specified on the command line.

```yaml $(tag) == 'package-2023-09-01'
input-file:
  - common-types/v1/common.json
  - stable/2023-09-01/computeRPCommon.json
  - stable/2023-09-01/virtualMachineScaleSet.json
  - stable/2023-09-01/virtualMachine.json
  - stable/2023-09-01/virtualMachineImage.json
  - stable/2023-09-01/virtualMachineExtensionImage.json
  - stable/2023-09-01/availabilitySet.json
  - stable/2023-09-01/proximityPlacementGroup.json
  - stable/2023-09-01/dedicatedHost.json
  - stable/2023-09-01/sshPublicKey.json
  - stable/2023-09-01/image.json
  - stable/2023-09-01/restorePoint.json
  - stable/2023-09-01/capacityReservation.json
  - stable/2023-09-01/logAnalytic.json
  - stable/2023-09-01/runCommand.json
  - stable/2023-04-02/diskRPCommon.json
  - stable/2023-04-02/disk.json
  - stable/2023-04-02/diskAccess.json
  - stable/2023-04-02/diskEncryptionSet.json
  - stable/2023-04-02/diskRestorePoint.json
  - stable/2023-04-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-08-03/galleryRPCommon.json
  - stable/2022-08-03/gallery.json
  - stable/2022-08-03/sharedGallery.json
  - stable/2022-08-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-09-01-only

These settings apply only when `--tag=package-2023-09-01-only` is specified on the command line.

```yaml $(tag) == 'package-2023-09-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2023-09-01/computeRPCommon.json
  - stable/2023-09-01/virtualMachineScaleSet.json
  - stable/2023-09-01/virtualMachine.json
  - stable/2023-09-01/virtualMachineImage.json
  - stable/2023-09-01/virtualMachineExtensionImage.json
  - stable/2023-09-01/availabilitySet.json
  - stable/2023-09-01/proximityPlacementGroup.json
  - stable/2023-09-01/dedicatedHost.json
  - stable/2023-09-01/sshPublicKey.json
  - stable/2023-09-01/image.json
  - stable/2023-09-01/restorePoint.json
  - stable/2023-09-01/capacityReservation.json
  - stable/2023-09-01/logAnalytic.json
  - stable/2023-09-01/runCommand.json
```

### Tag: package-2022-08-03

These settings apply only when `--tag=package-2022-08-03` is specified on the command line.

```yaml $(tag) == 'package-2022-08-03'
input-file:
  - common-types/v1/common.json
  - stable/2023-07-01/computeRPCommon.json
  - stable/2023-07-01/virtualMachineScaleSet.json
  - stable/2023-07-01/virtualMachine.json
  - stable/2023-07-01/virtualMachineImage.json
  - stable/2023-07-01/virtualMachineExtensionImage.json
  - stable/2023-07-01/availabilitySet.json
  - stable/2023-07-01/proximityPlacementGroup.json
  - stable/2023-07-01/dedicatedHost.json
  - stable/2023-07-01/sshPublicKey.json
  - stable/2023-07-01/image.json
  - stable/2023-07-01/restorePoint.json
  - stable/2023-07-01/capacityReservation.json
  - stable/2023-07-01/logAnalytic.json
  - stable/2023-07-01/runCommand.json
  - stable/2023-04-02/diskRPCommon.json
  - stable/2023-04-02/disk.json
  - stable/2023-04-02/diskAccess.json
  - stable/2023-04-02/diskEncryptionSet.json
  - stable/2023-04-02/diskRestorePoint.json
  - stable/2023-04-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-08-03/galleryRPCommon.json
  - stable/2022-08-03/gallery.json
  - stable/2022-08-03/sharedGallery.json
  - stable/2022-08-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2022-08-03-only

These settings apply only when `--tag=package-2022-08-03-only` is specified on the command line.

```yaml $(tag) == 'package-2022-08-03-only'
input-file:
  - common-types/v1/common.json
  - stable/2022-08-03/galleryRPCommon.json
  - stable/2022-08-03/gallery.json
  - stable/2022-08-03/sharedGallery.json
  - stable/2022-08-03/communityGallery.json
```

### Tag: package-2023-07-01

These settings apply only when `--tag=package-2023-07-01` is specified on the command line.

```yaml $(tag) == 'package-2023-07-01'
input-file:
  - common-types/v1/common.json
  - stable/2023-07-01/computeRPCommon.json
  - stable/2023-07-01/virtualMachineScaleSet.json
  - stable/2023-07-01/virtualMachine.json
  - stable/2023-07-01/virtualMachineImage.json
  - stable/2023-07-01/virtualMachineExtensionImage.json
  - stable/2023-07-01/availabilitySet.json
  - stable/2023-07-01/proximityPlacementGroup.json
  - stable/2023-07-01/dedicatedHost.json
  - stable/2023-07-01/sshPublicKey.json
  - stable/2023-07-01/image.json
  - stable/2023-07-01/restorePoint.json
  - stable/2023-07-01/capacityReservation.json
  - stable/2023-07-01/logAnalytic.json
  - stable/2023-07-01/runCommand.json
  - stable/2023-04-02/diskRPCommon.json
  - stable/2023-04-02/disk.json
  - stable/2023-04-02/diskAccess.json
  - stable/2023-04-02/diskEncryptionSet.json
  - stable/2023-04-02/diskRestorePoint.json
  - stable/2023-04-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-03-03/galleryRPCommon.json
  - stable/2022-03-03/gallery.json
  - stable/2022-03-03/sharedGallery.json
  - stable/2022-03-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-07-01-only

These settings apply only when `--tag=package-2023-07-01-only` is specified on the command line.

```yaml $(tag) == 'package-2023-07-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2023-07-01/computeRPCommon.json
  - stable/2023-07-01/virtualMachineScaleSet.json
  - stable/2023-07-01/virtualMachine.json
  - stable/2023-07-01/virtualMachineImage.json
  - stable/2023-07-01/virtualMachineExtensionImage.json
  - stable/2023-07-01/availabilitySet.json
  - stable/2023-07-01/proximityPlacementGroup.json
  - stable/2023-07-01/dedicatedHost.json
  - stable/2023-07-01/sshPublicKey.json
  - stable/2023-07-01/image.json
  - stable/2023-07-01/restorePoint.json
  - stable/2023-07-01/capacityReservation.json
  - stable/2023-07-01/logAnalytic.json
  - stable/2023-07-01/runCommand.json
```

### Tag: package-2023-04-02

These settings apply only when `--tag=package-2023-04-02` is specified on the command line.

```yaml $(tag) == 'package-2023-04-02'
input-file:
  - common-types/v1/common.json
  - stable/2023-03-01/computeRPCommon.json
  - stable/2023-03-01/virtualMachineScaleSet.json
  - stable/2023-03-01/virtualMachine.json
  - stable/2023-03-01/virtualMachineImage.json
  - stable/2023-03-01/virtualMachineExtensionImage.json
  - stable/2023-03-01/availabilitySet.json
  - stable/2023-03-01/proximityPlacementGroup.json
  - stable/2023-03-01/dedicatedHost.json
  - stable/2023-03-01/sshPublicKey.json
  - stable/2023-03-01/image.json
  - stable/2023-03-01/restorePoint.json
  - stable/2023-03-01/capacityReservation.json
  - stable/2023-03-01/logAnalytic.json
  - stable/2023-03-01/runCommand.json
  - stable/2023-04-02/diskRPCommon.json
  - stable/2023-04-02/disk.json
  - stable/2023-04-02/diskAccess.json
  - stable/2023-04-02/diskEncryptionSet.json
  - stable/2023-04-02/diskRestorePoint.json
  - stable/2023-04-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-03-03/galleryRPCommon.json
  - stable/2022-03-03/gallery.json
  - stable/2022-03-03/sharedGallery.json
  - stable/2022-03-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-04-02-only

These settings apply only when `--tag=package-2023-04-02-only` is specified on the command line.

```yaml $(tag) == 'package-2023-04-02-only'
input-file:
  - common-types/v1/common.json
  - stable/2023-04-02/diskRPCommon.json
  - stable/2023-04-02/disk.json
  - stable/2023-04-02/diskAccess.json
  - stable/2023-04-02/diskEncryptionSet.json
  - stable/2023-04-02/diskRestorePoint.json
  - stable/2023-04-02/snapshot.json
```

### Tag: package-2023-01-02

These settings apply only when `--tag=package-2023-01-02` is specified on the command line.

```yaml $(tag) == 'package-2023-01-02'
input-file:
  - common-types/v1/common.json
  - stable/2023-03-01/computeRPCommon.json
  - stable/2023-03-01/virtualMachineScaleSet.json
  - stable/2023-03-01/virtualMachine.json
  - stable/2023-03-01/virtualMachineImage.json
  - stable/2023-03-01/virtualMachineExtensionImage.json
  - stable/2023-03-01/availabilitySet.json
  - stable/2023-03-01/proximityPlacementGroup.json
  - stable/2023-03-01/dedicatedHost.json
  - stable/2023-03-01/sshPublicKey.json
  - stable/2023-03-01/image.json
  - stable/2023-03-01/restorePoint.json
  - stable/2023-03-01/capacityReservation.json
  - stable/2023-03-01/logAnalytic.json
  - stable/2023-03-01/runCommand.json
  - stable/2023-01-02/diskRPCommon.json
  - stable/2023-01-02/disk.json
  - stable/2023-01-02/diskAccess.json
  - stable/2023-01-02/diskEncryptionSet.json
  - stable/2023-01-02/diskRestorePoint.json
  - stable/2023-01-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-03-03/galleryRPCommon.json
  - stable/2022-03-03/gallery.json
  - stable/2022-03-03/sharedGallery.json
  - stable/2022-03-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-01-02-only

These settings apply only when `--tag=package-2023-01-02-only` is specified on the command line.

```yaml $(tag) == 'package-2023-01-02-only'
input-file:
  - common-types/v1/common.json
  - stable/2023-01-02/diskRPCommon.json
  - stable/2023-01-02/disk.json
  - stable/2023-01-02/diskAccess.json
  - stable/2023-01-02/diskEncryptionSet.json
  - stable/2023-01-02/diskRestorePoint.json
  - stable/2023-01-02/snapshot.json
```

### Tag: package-2023-03-01

These settings apply only when `--tag=package-2023-03-01` is specified on the command line.

```yaml $(tag) == 'package-2023-03-01'
input-file:
  - common-types/v1/common.json
  - stable/2023-03-01/computeRPCommon.json
  - stable/2023-03-01/virtualMachineScaleSet.json
  - stable/2023-03-01/virtualMachine.json
  - stable/2023-03-01/virtualMachineImage.json
  - stable/2023-03-01/virtualMachineExtensionImage.json
  - stable/2023-03-01/availabilitySet.json
  - stable/2023-03-01/proximityPlacementGroup.json
  - stable/2023-03-01/dedicatedHost.json
  - stable/2023-03-01/sshPublicKey.json
  - stable/2023-03-01/image.json
  - stable/2023-03-01/restorePoint.json
  - stable/2023-03-01/capacityReservation.json
  - stable/2023-03-01/logAnalytic.json
  - stable/2023-03-01/runCommand.json
  - stable/2022-07-02/diskRPCommon.json
  - stable/2022-07-02/disk.json
  - stable/2022-07-02/diskAccess.json
  - stable/2022-07-02/diskEncryptionSet.json
  - stable/2022-07-02/diskRestorePoint.json
  - stable/2022-07-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-03-03/galleryRPCommon.json
  - stable/2022-03-03/gallery.json
  - stable/2022-03-03/sharedGallery.json
  - stable/2022-03-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2023-03-01-only

These settings apply only when `--tag=package-2023-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2023-03-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2023-03-01/computeRPCommon.json
  - stable/2023-03-01/virtualMachineScaleSet.json
  - stable/2023-03-01/virtualMachine.json
  - stable/2023-03-01/virtualMachineImage.json
  - stable/2023-03-01/virtualMachineExtensionImage.json
  - stable/2023-03-01/availabilitySet.json
  - stable/2023-03-01/proximityPlacementGroup.json
  - stable/2023-03-01/dedicatedHost.json
  - stable/2023-03-01/sshPublicKey.json
  - stable/2023-03-01/image.json
  - stable/2023-03-01/restorePoint.json
  - stable/2023-03-01/capacityReservation.json
  - stable/2023-03-01/logAnalytic.json
  - stable/2023-03-01/runCommand.json
```

### Tag: package-2022-11-01

These settings apply only when `--tag=package-2022-11-01` is specified on the command line.

```yaml $(tag) == 'package-2022-11-01'
input-file:
  - common-types/v1/common.json
  - stable/2022-11-01/computeRPCommon.json
  - stable/2022-11-01/virtualMachineScaleSet.json
  - stable/2022-11-01/virtualMachine.json
  - stable/2022-11-01/virtualMachineImage.json
  - stable/2022-11-01/virtualMachineExtensionImage.json
  - stable/2022-11-01/availabilitySet.json
  - stable/2022-11-01/proximityPlacementGroup.json
  - stable/2022-11-01/dedicatedHost.json
  - stable/2022-11-01/sshPublicKey.json
  - stable/2022-11-01/image.json
  - stable/2022-11-01/restorePoint.json
  - stable/2022-11-01/capacityReservation.json
  - stable/2022-11-01/logAnalytic.json
  - stable/2022-11-01/runCommand.json
  - stable/2022-07-02/diskRPCommon.json
  - stable/2022-07-02/disk.json
  - stable/2022-07-02/diskAccess.json
  - stable/2022-07-02/diskEncryptionSet.json
  - stable/2022-07-02/diskRestorePoint.json
  - stable/2022-07-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-03-03/galleryRPCommon.json
  - stable/2022-03-03/gallery.json
  - stable/2022-03-03/sharedGallery.json
  - stable/2022-03-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2022-11-01-only

These settings apply only when `--tag=package-2022-11-01-only` is specified on the command line.

```yaml $(tag) == 'package-2022-11-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2022-11-01/computeRPCommon.json
  - stable/2022-11-01/virtualMachineScaleSet.json
  - stable/2022-11-01/virtualMachine.json
  - stable/2022-11-01/virtualMachineImage.json
  - stable/2022-11-01/virtualMachineExtensionImage.json
  - stable/2022-11-01/availabilitySet.json
  - stable/2022-11-01/proximityPlacementGroup.json
  - stable/2022-11-01/dedicatedHost.json
  - stable/2022-11-01/sshPublicKey.json
  - stable/2022-11-01/image.json
  - stable/2022-11-01/restorePoint.json
  - stable/2022-11-01/capacityReservation.json
  - stable/2022-11-01/logAnalytic.json
  - stable/2022-11-01/runCommand.json
```

### Tag: package-2022-09-04

These settings apply only when `--tag=package-2022-09-04` is specified on the command line.

```yaml $(tag) == 'package-2022-09-04'
input-file:
  - common-types/v1/common.json
  - stable/2022-08-01/computeRPCommon.json
  - stable/2022-08-01/virtualMachineScaleSet.json
  - stable/2022-08-01/virtualMachine.json
  - stable/2022-08-01/virtualMachineImage.json
  - stable/2022-08-01/virtualMachineExtensionImage.json
  - stable/2022-08-01/availabilitySet.json
  - stable/2022-08-01/proximityPlacementGroup.json
  - stable/2022-08-01/dedicatedHost.json
  - stable/2022-08-01/sshPublicKey.json
  - stable/2022-08-01/image.json
  - stable/2022-08-01/restorePoint.json
  - stable/2022-08-01/capacityReservation.json
  - stable/2022-08-01/logAnalytic.json
  - stable/2022-08-01/runCommand.json
  - stable/2022-07-02/diskRPCommon.json
  - stable/2022-07-02/disk.json
  - stable/2022-07-02/diskAccess.json
  - stable/2022-07-02/diskEncryptionSet.json
  - stable/2022-07-02/diskRestorePoint.json
  - stable/2022-07-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-03-03/galleryRPCommon.json
  - stable/2022-03-03/gallery.json
  - stable/2022-03-03/sharedGallery.json
  - stable/2022-03-03/communityGallery.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2022-09-04-only

These settings apply only when `--tag=package-2022-09-04-only` is specified on the command line.

```yaml $(tag) == 'package-2022-09-04-only'
input-file:
  - common-types/v1/common.json
  - Cloudservice/stable/2022-09-04/cloudService.json
```

### Tag: package-2022-03-03

These settings apply only when `--tag=package-2022-03-03` is specified on the command line.

```yaml $(tag) == 'package-2022-03-03'
input-file:
  - common-types/v1/common.json
  - stable/2022-08-01/computeRPCommon.json
  - stable/2022-08-01/virtualMachineScaleSet.json
  - stable/2022-08-01/virtualMachine.json
  - stable/2022-08-01/virtualMachineImage.json
  - stable/2022-08-01/virtualMachineExtensionImage.json
  - stable/2022-08-01/availabilitySet.json
  - stable/2022-08-01/proximityPlacementGroup.json
  - stable/2022-08-01/dedicatedHost.json
  - stable/2022-08-01/sshPublicKey.json
  - stable/2022-08-01/image.json
  - stable/2022-08-01/restorePoint.json
  - stable/2022-08-01/capacityReservation.json
  - stable/2022-08-01/logAnalytic.json
  - stable/2022-08-01/runCommand.json
  - stable/2022-07-02/diskRPCommon.json
  - stable/2022-07-02/disk.json
  - stable/2022-07-02/diskAccess.json
  - stable/2022-07-02/diskEncryptionSet.json
  - stable/2022-07-02/diskRestorePoint.json
  - stable/2022-07-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-03-03/galleryRPCommon.json
  - stable/2022-03-03/gallery.json
  - stable/2022-03-03/sharedGallery.json
  - stable/2022-03-03/communityGallery.json
  - Cloudservice/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-03-03-only

These settings apply only when `--tag=package-2022-03-03-only` is specified on the command line.

```yaml $(tag) == 'package-2022-03-03-only'
input-file:
  - common-types/v1/common.json
  - stable/2022-03-03/galleryRPCommon.json
  - stable/2022-03-03/gallery.json
  - stable/2022-03-03/sharedGallery.json
  - stable/2022-03-03/communityGallery.json
```

### Tag: package-2022-08-01

These settings apply only when `--tag=package-2022-08-01` is specified on the command line.

```yaml $(tag) == 'package-2022-08-01'
input-file:
  - common-types/v1/common.json
  - stable/2022-08-01/computeRPCommon.json
  - stable/2022-08-01/virtualMachineScaleSet.json
  - stable/2022-08-01/virtualMachine.json
  - stable/2022-08-01/virtualMachineImage.json
  - stable/2022-08-01/virtualMachineExtensionImage.json
  - stable/2022-08-01/availabilitySet.json
  - stable/2022-08-01/proximityPlacementGroup.json
  - stable/2022-08-01/dedicatedHost.json
  - stable/2022-08-01/sshPublicKey.json
  - stable/2022-08-01/image.json
  - stable/2022-08-01/restorePoint.json
  - stable/2022-08-01/capacityReservation.json
  - stable/2022-08-01/logAnalytic.json
  - stable/2022-08-01/runCommand.json
  - stable/2022-07-02/diskRPCommon.json
  - stable/2022-07-02/disk.json
  - stable/2022-07-02/diskAccess.json
  - stable/2022-07-02/diskEncryptionSet.json
  - stable/2022-07-02/diskRestorePoint.json
  - stable/2022-07-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-01-03/galleryRPCommon.json
  - stable/2022-01-03/gallery.json
  - stable/2022-01-03/sharedGallery.json
  - stable/2022-01-03/communityGallery.json
  - Cloudservice/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-08-01-only

These settings apply only when `--tag=package-2022-08-01-only` is specified on the command line.

```yaml $(tag) == 'package-2022-08-01-only'
input-file:
  - common-types/v1/common.json
  - stable/2022-08-01/computeRPCommon.json
  - stable/2022-08-01/virtualMachineScaleSet.json
  - stable/2022-08-01/virtualMachine.json
  - stable/2022-08-01/virtualMachineImage.json
  - stable/2022-08-01/virtualMachineExtensionImage.json
  - stable/2022-08-01/availabilitySet.json
  - stable/2022-08-01/proximityPlacementGroup.json
  - stable/2022-08-01/dedicatedHost.json
  - stable/2022-08-01/sshPublicKey.json
  - stable/2022-08-01/image.json
  - stable/2022-08-01/restorePoint.json
  - stable/2022-08-01/capacityReservation.json
  - stable/2022-08-01/logAnalytic.json
  - stable/2022-08-01/runCommand.json
```

### Tag: package-2022-07-02

These settings apply only when `--tag=package-2022-07-02` is specified on the command line.

```yaml $(tag) == 'package-2022-07-02'
input-file:
  - common-types/v1/common.json
  - stable/2022-03-01/computeRPCommon.json
  - stable/2022-03-01/virtualMachineScaleSet.json
  - stable/2022-03-01/virtualMachine.json
  - stable/2022-03-01/virtualMachineImage.json
  - stable/2022-03-01/virtualMachineExtensionImage.json
  - stable/2022-03-01/availabilitySet.json
  - stable/2022-03-01/proximityPlacementGroup.json
  - stable/2022-03-01/dedicatedHost.json
  - stable/2022-03-01/sshPublicKey.json
  - stable/2022-03-01/image.json
  - stable/2022-03-01/restorePoint.json
  - stable/2022-03-01/capacityReservation.json
  - stable/2022-03-01/logAnalytic.json
  - stable/2022-03-01/runCommand.json
  - stable/2022-07-02/diskRPCommon.json
  - stable/2022-07-02/disk.json
  - stable/2022-07-02/diskAccess.json
  - stable/2022-07-02/diskEncryptionSet.json
  - stable/2022-07-02/diskRestorePoint.json
  - stable/2022-07-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-01-03/galleryRPCommon.json
  - stable/2022-01-03/gallery.json
  - stable/2022-01-03/sharedGallery.json
  - stable/2022-01-03/communityGallery.json
  - Cloudservice/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-07-02-only

These settings apply only when `--tag=package-2022-07-02-only` is specified on the command line.

```yaml $(tag) == 'package-2022-07-02-only'
input-file:
  - common-types/v1/common.json
  - stable/2022-07-02/diskRPCommon.json
  - stable/2022-07-02/disk.json
  - stable/2022-07-02/diskAccess.json
  - stable/2022-07-02/diskEncryptionSet.json
  - stable/2022-07-02/diskRestorePoint.json
  - stable/2022-07-02/snapshot.json
```

### Tag: package-2022-04-04

These settings apply only when `--tag=package-2022-04-04` is specified on the command line.

```yaml $(tag) == 'package-2022-04-04'
input-file:
  - Cloudservice/stable/2022-04-04/common.json
  - stable/2022-03-01/computeRPCommon.json
  - stable/2022-03-01/virtualMachineScaleSet.json
  - stable/2022-03-01/virtualMachine.json
  - stable/2022-03-01/virtualMachineImage.json
  - stable/2022-03-01/virtualMachineExtensionImage.json
  - stable/2022-03-01/availabilitySet.json
  - stable/2022-03-01/proximityPlacementGroup.json
  - stable/2022-03-01/dedicatedHost.json
  - stable/2022-03-01/sshPublicKey.json
  - stable/2022-03-01/image.json
  - stable/2022-03-01/restorePoint.json
  - stable/2022-03-01/capacityReservation.json
  - stable/2022-03-01/logAnalytic.json
  - stable/2022-03-01/runCommand.json
  - stable/2022-03-02/diskRPCommon.json
  - stable/2022-03-02/disk.json
  - stable/2022-03-02/diskAccess.json
  - stable/2022-03-02/diskEncryptionSet.json
  - stable/2022-03-02/diskRestorePoint.json
  - stable/2022-03-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-01-03/galleryRPCommon.json
  - stable/2022-01-03/gallery.json
  - stable/2022-01-03/sharedGallery.json
  - stable/2022-01-03/communityGallery.json
  - Cloudservice/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-04-04-only

These settings apply only when `--tag=package-2022-04-04-only` is specified on the command line.

```yaml $(tag) == 'package-2022-04-04-only'
input-file:
  - Cloudservice/stable/2022-04-04/common.json
  - Cloudservice/stable/2022-04-04/cloudService.json
```

### Tag: package-2022-03-02

These settings apply only when `--tag=package-2022-03-02` is specified on the command line.

```yaml $(tag) == 'package-2022-03-02'
input-file:
  - stable/2022-03-02/common.json
  - stable/2022-03-01/computeRPCommon.json
  - stable/2022-03-01/virtualMachineScaleSet.json
  - stable/2022-03-01/virtualMachine.json
  - stable/2022-03-01/virtualMachineImage.json
  - stable/2022-03-01/virtualMachineExtensionImage.json
  - stable/2022-03-01/availabilitySet.json
  - stable/2022-03-01/proximityPlacementGroup.json
  - stable/2022-03-01/dedicatedHost.json
  - stable/2022-03-01/sshPublicKey.json
  - stable/2022-03-01/image.json
  - stable/2022-03-01/restorePoint.json
  - stable/2022-03-01/capacityReservation.json
  - stable/2022-03-01/logAnalytic.json
  - stable/2022-03-01/runCommand.json
  - stable/2022-03-02/diskRPCommon.json
  - stable/2022-03-02/disk.json
  - stable/2022-03-02/diskAccess.json
  - stable/2022-03-02/diskEncryptionSet.json
  - stable/2022-03-02/diskRestorePoint.json
  - stable/2022-03-02/snapshot.json
  - stable/2021-07-01/skus.json
  - stable/2022-01-03/galleryRPCommon.json
  - stable/2022-01-03/gallery.json
  - stable/2022-01-03/sharedGallery.json
  - stable/2022-01-03/communityGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2022-03-02-only

These settings apply only when `--tag=package-2022-03-02-only` is specified on the command line.

```yaml $(tag) == 'package-2022-03-02-only'
input-file:
  - stable/2022-03-02/common.json
  - stable/2022-03-02/diskRPCommon.json
  - stable/2022-03-02/disk.json
  - stable/2022-03-02/diskAccess.json
  - stable/2022-03-02/diskEncryptionSet.json
  - stable/2022-03-02/diskRestorePoint.json
  - stable/2022-03-02/snapshot.json
```

### Tag: package-2022-01-03

These settings apply only when `--tag=package-2022-01-03` is specified on the command line.

```yaml $(tag) == 'package-2022-01-03'
input-file:
  - stable/2022-03-01/computeRPCommon.json
  - stable/2022-03-01/virtualMachineScaleSet.json
  - stable/2022-03-01/virtualMachine.json
  - stable/2022-03-01/virtualMachineImage.json
  - stable/2022-03-01/virtualMachineExtensionImage.json
  - stable/2022-03-01/availabilitySet.json
  - stable/2022-03-01/proximityPlacementGroup.json
  - stable/2022-03-01/dedicatedHost.json
  - stable/2022-03-01/sshPublicKey.json
  - stable/2022-03-01/image.json
  - stable/2022-03-01/restorePoint.json
  - stable/2022-03-01/capacityReservation.json
  - stable/2022-03-01/logAnalytic.json
  - stable/2022-03-01/runCommand.json
  - stable/2021-07-01/skus.json
  - stable/2021-12-01/disk.json
  - stable/2022-01-03/common.json
  - stable/2022-01-03/galleryRPCommon.json
  - stable/2022-01-03/gallery.json
  - stable/2022-01-03/sharedGallery.json
  - stable/2022-01-03/communityGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2022-01-03-only

These settings apply only when `--tag=package-2022-01-03-only` is specified on the command line.

```yaml $(tag) == 'package-2022-01-03-only'
input-file:
  - stable/2022-01-03/common.json
  - stable/2022-01-03/galleryRPCommon.json
  - stable/2022-01-03/gallery.json
  - stable/2022-01-03/sharedGallery.json
  - stable/2022-01-03/communityGallery.json
```

### Tag: package-2022-03-01

These settings apply only when `--tag=package-2022-03-01` is specified on the command line.

```yaml $(tag) == 'package-2022-03-01'
input-file:
  - stable/2022-03-01/common.json
  - stable/2022-03-01/computeRPCommon.json
  - stable/2022-03-01/virtualMachineScaleSet.json
  - stable/2022-03-01/virtualMachine.json
  - stable/2022-03-01/virtualMachineImage.json
  - stable/2022-03-01/virtualMachineExtensionImage.json
  - stable/2022-03-01/availabilitySet.json
  - stable/2022-03-01/proximityPlacementGroup.json
  - stable/2022-03-01/dedicatedHost.json
  - stable/2022-03-01/sshPublicKey.json
  - stable/2022-03-01/image.json
  - stable/2022-03-01/restorePoint.json
  - stable/2022-03-01/capacityReservation.json
  - stable/2022-03-01/logAnalytic.json
  - stable/2022-03-01/runCommand.json
  - stable/2021-07-01/skus.json
  - stable/2021-12-01/disk.json
  - stable/2021-10-01/gallery.json
  - stable/2021-07-01/sharedGallery.json
  - stable/2021-07-01/communityGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2022-03-01-only

These settings apply only when `--tag=package-2022-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2022-03-01-only'
input-file:
  - stable/2022-03-01/common.json
  - stable/2022-03-01/computeRPCommon.json
  - stable/2022-03-01/virtualMachineScaleSet.json
  - stable/2022-03-01/virtualMachine.json
  - stable/2022-03-01/virtualMachineImage.json
  - stable/2022-03-01/virtualMachineExtensionImage.json
  - stable/2022-03-01/availabilitySet.json
  - stable/2022-03-01/proximityPlacementGroup.json
  - stable/2022-03-01/dedicatedHost.json
  - stable/2022-03-01/sshPublicKey.json
  - stable/2022-03-01/image.json
  - stable/2022-03-01/restorePoint.json
  - stable/2022-03-01/capacityReservation.json
  - stable/2022-03-01/logAnalytic.json
  - stable/2022-03-01/runCommand.json
```

### Tag: package-2021-12-01

These settings apply only when `--tag=package-2021-12-01` is specified on the command line.

```yaml $(tag) == 'package-2021-12-01'
input-file:
  - stable/2021-11-01/compute.json
  - stable/2021-11-01/runCommands.json
  - stable/2021-07-01/skus.json
  - stable/2021-12-01/disk.json
  - stable/2021-10-01/gallery.json
  - stable/2021-07-01/sharedGallery.json
  - stable/2021-07-01/communityGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-12-01-only

These settings apply only when `--tag=package-2021-12-01-oly` is specified on the command line.

```yaml $(tag) == 'package-2021-12-01-only'
input-file:
  - stable/2021-12-01/disk.json
```

### Tag: package-2021-11-01

These settings apply only when `--tag=package-2021-11-01` is specified on the command line.

```yaml $(tag) == 'package-2021-11-01'
input-file:
  - stable/2021-11-01/compute.json
  - stable/2021-11-01/runCommands.json
  - stable/2021-07-01/skus.json
  - stable/2021-08-01/disk.json
  - stable/2021-10-01/gallery.json
  - stable/2021-07-01/sharedGallery.json
  - stable/2021-07-01/communityGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-11-01-only

These settings apply only when `--tag=package-2021-11-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-11-01-only'
input-file:
  - stable/2021-11-01/compute.json
  - stable/2021-11-01/runCommands.json
```

### Tag: package-2021-08-01-only

These settings apply only when `--tag=package-2021-08-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-08-01-only'
input-file:
  - stable/2021-08-01/disk.json
```

### Tag: package-2021-08-01

These settings apply only when `--tag=package-2021-08-01` is specified on the command line.

```yaml $(tag) == 'package-2021-08-01'
input-file:
  - stable/2021-07-01/compute.json
  - stable/2021-07-01/runCommands.json
  - stable/2021-07-01/skus.json
  - stable/2021-08-01/disk.json
  - stable/2021-07-01/gallery.json
  - stable/2021-07-01/sharedGallery.json
  - stable/2021-07-01/communityGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-10-01

These settings apply only when `--tag=package-2021-10-01` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01'
input-file:
  - stable/2021-07-01/compute.json
  - stable/2021-07-01/runCommands.json
  - stable/2021-07-01/skus.json
  - stable/2021-04-01/disk.json
  - stable/2021-10-01/gallery.json
  - stable/2021-07-01/sharedGallery.json
  - stable/2021-07-01/communityGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-10-01-only

These settings apply only when `--tag=package-2021-10-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-only'
input-file:
  - stable/2021-10-01/gallery.json
```

### Tag: package-2021-07-01

These settings apply only when `--tag=package-2021-07-01` is specified on the command line.

```yaml $(tag) == 'package-2021-07-01'
input-file:
  - stable/2021-07-01/compute.json
  - stable/2021-07-01/runCommands.json
  - stable/2021-07-01/skus.json
  - stable/2021-04-01/disk.json
  - stable/2021-07-01/gallery.json
  - stable/2021-07-01/sharedGallery.json
  - stable/2021-07-01/communityGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-07-01-only

These settings apply only when `--tag=package-2021-07-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-07-01-only'
input-file:
  - stable/2021-07-01/compute.json
  - stable/2021-07-01/runCommands.json
  - stable/2021-07-01/skus.json
  - stable/2021-07-01/gallery.json
  - stable/2021-07-01/sharedGallery.json
  - stable/2021-07-01/communityGallery.json
```

### Tag: package-2021-06-01-preview

These settings apply only when `--tag=2021-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-06-01-preview'
input-file:
  - stable/2021-11-01/compute.json
  - stable/2021-11-01/runCommands.json
  - stable/2021-07-01/skus.json
  - stable/2021-12-01/disk.json
  - stable/2021-10-01/gallery.json
  - stable/2021-07-01/sharedGallery.json
  - stable/2021-07-01/communityGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-04-01

These settings apply only when `--tag=package-2021-04-01` is specified on the command line.

```yaml $(tag) == 'package-2021-04-01'
input-file:
  - stable/2021-04-01/compute.json
  - stable/2021-04-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2021-04-01/disk.json
  - stable/2020-09-30/gallery.json
  - stable/2020-09-30/sharedGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-04-01-only

These settings apply only when `--tag=package-2021-04-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-04-01-only'
input-file:
  - stable/2021-04-01/compute.json
  - stable/2021-04-01/runCommands.json
  - stable/2021-04-01/disk.json
```

### Tag: package-2021-03-01

These settings apply only when `--tag=package-2021-03-01` is specified on the command line.

```yaml $(tag) == 'package-2021-03-01'
input-file:
  - stable/2021-03-01/compute.json
  - stable/2021-03-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2020-12-01/disk.json
  - stable/2020-09-30/gallery.json
  - stable/2020-09-30/sharedGallery.json
  - Cloudservice/stable/2021-03-01/cloudService.json
```

### Tag: package-2021-03-01-only

These settings apply only when `--tag=package-2021-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2021-03-01-only'
input-file:
  - Cloudservice/stable/2021-03-01/cloudService.json
  - stable/2021-03-01/compute.json
  - stable/2021-03-01/runCommands.json
```

### Tag: package-2020-12-01

These settings apply only when `--tag=package-2020-12-01` is specified on the command line.

```yaml $(tag) == 'package-2020-12-01'
input-file:
  - stable/2020-12-01/compute.json
  - stable/2020-12-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2020-12-01/disk.json
  - stable/2019-12-01/gallery.json
```

### Tag: package-2020-12-01-only

These settings apply only when `--tag=package-2020-12-01-only` is specified on the command line.

```yaml $(tag) == 'package-2020-12-01-only'
input-file:
  - stable/2020-12-01/disk.json
  - stable/2020-12-01/compute.json
  - stable/2020-12-01/runCommands.json
```

### Tag: package-2020-10-01-preview

These settings apply only when `--tag=package-2020-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-10-01-preview'
input-file:
  - stable/2020-06-01/compute.json
  - stable/2020-06-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2020-09-30/disk.json
  - stable/2019-12-01/gallery.json
  - Cloudservice/preview/2020-10-01-preview/cloudService.json
```

### Tag: package-2020-10-01-preview-only

These settings apply only when `--tag=package-2020-10-01-preview-only` is specified on the command line.

```yaml $(tag) == 'package-2020-10-01-preview-only'
input-file:
  - Cloudservice/preview/2020-10-01-preview/cloudService.json
```

### Tag: package-2020-09-30

These settings apply only when `--tag=package-2020-09-30` is specified on the command line.

```yaml $(tag) == 'package-2020-09-30'
input-file:
  - stable/2020-06-01/compute.json
  - stable/2020-06-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2020-09-30/disk.json
  - preview/2020-09-30/gallery.json
  - preview/2020-09-30/sharedGallery.json
```

### Tag: package-2020-09-30-only

These settings apply only when `--tag=package-2020-09-30-only` is specified on the command line.

```yaml $(tag) == 'package-2020-09-30-only'
input-file:
  - stable/2020-09-30/disk.json
  - preview/2020-09-30/gallery.json
  - preview/2020-09-30/sharedGallery.json
```

### Tag: package-2020-06-30

These settings apply only when `--tag=package-2020-06-30` is specified on the command line.

```yaml $(tag) == 'package-2020-06-30'
input-file:
  - stable/2020-06-01/compute.json
  - stable/2020-06-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2020-06-30/disk.json
  - stable/2019-12-01/gallery.json
```

### Tag: package-2020-06-30-only

These settings apply only when `--tag=package-2020-06-30-only` is specified on the command line.

```yaml $(tag) == 'package-2020-06-30-only'
input-file:
  - stable/2020-06-30/disk.json
```

### Tag: package-2020-06-01

These settings apply only when `--tag=package-2020-06-01` is specified on the command line.

```yaml $(tag) == 'package-2020-06-01'
input-file:
  - stable/2020-06-01/compute.json
  - stable/2020-06-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2020-05-01/disk.json
  - stable/2019-12-01/gallery.json
```

### Tag: package-2020-06-01-only

These settings apply only when `--tag=package-2020-06-01-only` is specified on the command line.

```yaml $(tag) == 'package-2020-06-01-only'
input-file:
  - stable/2020-06-01/compute.json
  - stable/2020-06-01/runCommands.json
```

### Tag: package-2020-05-01

These settings apply only when `--tag=package-2020-05-01` is specified on the command line.

```yaml $(tag) == 'package-2020-05-01'
input-file:
  - stable/2019-12-01/compute.json
  - stable/2019-12-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2020-05-01/disk.json
  - stable/2019-12-01/gallery.json
```

### Tag: package-2020-05-01-only

These settings apply only when `--tag=package-2020-05-01-only` is specified on the command line.

```yaml $(tag) == 'package-2020-05-01-only'
input-file:
  - stable/2020-05-01/disk.json
```

### Tag: package-2019-12-01

These settings apply only when `--tag=package-2019-12-01` is specified on the command line.

```yaml $(tag) == 'package-2019-12-01'
input-file:
  - stable/2019-12-01/compute.json
  - stable/2019-12-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2019-11-01/disk.json
  - stable/2019-12-01/gallery.json
```

### Tag: package-2019-12-01-only

These settings apply only when `--tag=package-2019-12-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-12-01-only'
input-file:
  - stable/2019-12-01/compute.json
  - stable/2019-12-01/runCommands.json
  - stable/2019-12-01/gallery.json
```

### Tag: package-2019-11-01

These settings apply only when `--package-2019-11-01` is specified on the command line.

```yaml $(tag) == 'package-2019-11-01'
input-file:
  - stable/2019-07-01/compute.json
  - stable/2019-07-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2019-11-01/disk.json
  - stable/2019-07-01/gallery.json
```

### Tag: package-2019-11-01-only

These settings apply only when `--package-2019-11-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-11-01-only'
input-file:
  - stable/2019-11-01/disk.json
```

### Tag: package-2019-07

These settings apply only when `--tag=package-2019-07` is specified on the command line.

```yaml $(tag) == 'package-2019-07'
input-file:
  - stable/2019-07-01/compute.json
  - stable/2019-07-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2019-07-01/disk.json
  - stable/2019-07-01/gallery.json
```

### Tag: package-2019-07-01

These settings apply only when `--tag=package-2019-07-01` is specified on the command line.

```yaml $(tag) == 'package-2019-07-01'
input-file:
  - stable/2019-03-01/compute.json
  - stable/2019-03-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2019-07-01/disk.json
  - stable/2019-07-01/gallery.json
```

### Tag: package-2019-07-01-only

These settings apply only when `--tag=package-2019-07-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-07-01-only'
input-file:
  - stable/2019-07-01/compute.json
  - stable/2019-07-01/disk.json
  - stable/2019-07-01/gallery.json
  - stable/2019-07-01/runCommands.json
```

### Tag: package-2019-03-01

These settings apply only when `--tag=package-2019-03-01` is specified on the command line.

```yaml $(tag) == 'package-2019-03-01'
input-file:
  - stable/2019-03-01/compute.json
  - stable/2019-03-01/runCommands.json
  - stable/2019-04-01/skus.json
  - stable/2019-03-01/disk.json
  - stable/2019-03-01/gallery.json
```

### Tag: package-2019-04-01-only

These settings apply only when `--tag=package-2019-04-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-04-01-only'
input-file:
  - stable/2019-04-01/skus.json
```

### Tag: package-2019-03-01-only

These settings apply only when `--tag=package-2019-03-01-only` is specified on the command line.

```yaml $(tag) == 'package-2019-03-01-only'
input-file:
  - stable/2019-03-01/compute.json
  - stable/2019-03-01/runCommands.json
  - stable/2019-03-01/gallery.json
  - stable/2019-03-01/disk.json
```

### Tag: package-2018-10-01-Disks

These settings apply only when `--tag=package-2018-10-01-Disks` is specified on the command line.

```yaml $(tag) == 'package-2018-10-01-Disks'
input-file:
  - stable/2018-10-01/compute.json
  - stable/2018-10-01/runCommands.json
  - stable/2017-09-01/skus.json
  - stable/2018-09-30/disk.json
  - stable/2018-06-01/gallery.json
```

### Tag: package-2018-10-01

These settings apply only when `--tag=package-2018-10-01` is specified on the command line.

```yaml $(tag) == 'package-2018-10-01'
input-file:
  - stable/2018-10-01/compute.json
  - stable/2018-10-01/runCommands.json
  - stable/2017-09-01/skus.json
  - stable/2018-06-01/disk.json
  - stable/2018-06-01/gallery.json
```

### Tag: package-2018-10-01-only

These settings apply only when `--tag=package-2018-10-01-only` is specified on the command line.

```yaml $(tag) == 'package-2018-10-01-only'
input-file:
  - stable/2018-10-01/compute.json
  - stable/2018-10-01/runCommands.json
```

### Tag: package-2018-09-30-only

These settings apply only when `--tag=package-2018-09-30-only` is specified on the command line.

```yaml $(tag) == 'package-2018-09-30-only'
input-file:
  - stable/2018-09-30/disk.json
```

### Tag: package-2018-06-exclude-gallery

These settings apply only when `--tag=package-2018-06-exclude-gallery` is specified on the command line.

```yaml $(tag) == 'package-2018-06-exclude-gallery'
input-file:
  - stable/2018-06-01/compute.json
  - stable/2018-06-01/runCommands.json
  - stable/2017-09-01/skus.json
  - stable/2018-06-01/disk.json
```

### Tag: package-2018-06

These settings apply only when `--tag=package-2018-06` is specified on the command line.

```yaml $(tag) == 'package-2018-06'
input-file:
  - stable/2018-06-01/compute.json
  - stable/2018-06-01/runCommands.json
  - stable/2017-09-01/skus.json
  - stable/2018-06-01/disk.json
  - stable/2018-06-01/gallery.json
```

### Tag: package-2018-06-01

These settings apply only when `--tag=package-2018-06-01` is specified on the command line.

```yaml $(tag) == 'package-2018-06-01'
input-file:
  - stable/2018-04-01/compute.json
  - stable/2018-04-01/runCommands.json
  - stable/2017-09-01/skus.json
  - stable/2018-06-01/disk.json
  - stable/2018-06-01/gallery.json
```

### Tag: package-compute-only-2018-06

These settings apply only when `--tag=package-compute-only-2018-06` is specified on the command line.

```yaml $(tag) == 'package-compute-only-2018-06'
input-file:
  - stable/2018-06-01/compute.json
  - stable/2018-06-01/runCommands.json
  - stable/2018-06-01/gallery.json
  - stable/2018-06-01/disk.json
```

### Tag: package-2018-04-01

These settings apply only when `--tag=package-2018-04-01` is specified on the command line.

```yaml $(tag) == 'package-2018-04-01'
input-file:
  - stable/2018-04-01/compute.json
  - stable/2018-04-01/runCommands.json
  - stable/2017-09-01/skus.json
  - stable/2018-04-01/disk.json
```

### Tag: package-2018-04

These settings apply only when `--tag=package-2018-04` is specified on the command line.

```yaml $(tag) == 'package-2018-04'
input-file:
  - stable/2017-12-01/compute.json
  - stable/2017-12-01/runCommands.json
  - stable/2017-09-01/skus.json
  - stable/2018-04-01/disk.json
```

### Tag: package-compute-2018-04

These settings apply only when `--tag=package-compute-2018-04` is specified on the command line.

```yaml $(tag) == 'package-compute-2018-04'
input-file:
  - stable/2018-04-01/compute.json
  - stable/2018-04-01/runCommands.json
  - stable/2018-04-01/disk.json
```

### Tag: package-disks-2018-04

These settings apply only when `--tag=package-disks-2018-04` is specified on the command line.

```yaml $(tag) == 'package-disks-2018-04'
input-file:
  - stable/2018-04-01/disk.json
```

### Tag: package-2017-12

These settings apply only when `--tag=package-2017-12` is specified on the command line.

```yaml $(tag) == 'package-2017-12'
input-file:
  - stable/2017-12-01/compute.json
  - stable/2017-12-01/runCommands.json
  - stable/2017-09-01/skus.json
  - stable/2017-03-30/disk.json
```

### Tag: package-compute-2017-12

These settings apply only when `--tag=package-compute-2017-12` is specified on the command line.

```yaml $(tag) == 'package-compute-2017-12'
input-file:
  - stable/2017-12-01/compute.json
  - stable/2017-12-01/runCommands.json
  - stable/2017-09-01/skus.json
  - stable/2017-03-30/disk.json
```

### Tag: package-compute-only-2017-12

These settings apply only when `--tag=package-compute-only-2017-12` is specified on the command line.

```yaml $(tag) == 'package-compute-only-2017-12'
input-file:
  - stable/2017-12-01/compute.json
  - stable/2017-12-01/runCommands.json
```

### Tag: package-skus-2017-09

These settings apply only when `--tag=package-skus-2017-09` is specified on the command line.

```yaml $(tag) == 'package-skus-2017-09'
input-file:
  - stable/2017-09-01/skus.json
```

### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

```yaml $(tag) == 'package-2017-03'
input-file:
  - stable/2017-03-30/compute.json
  - stable/2017-03-30/disk.json
  - stable/2017-03-30/runCommands.json
```

### Tag: package-compute-2017-03

These settings apply only when `--tag=package-compute-2017-03` is specified on the command line.

```yaml $(tag) == 'package-compute-2017-03'
input-file:
  - stable/2017-03-30/compute.json
  - stable/2017-03-30/disk.json
  - stable/2017-03-30/runCommands.json
```

### Tag: package-2016-04-preview

These settings apply only when `--tag=package-2016-04-preview` is specified on the command line.

```yaml $(tag) == 'package-2016-04-preview'
input-file:
  - preview/2016-04-30-preview/compute.json
  - preview/2016-04-30-preview/disk.json
```

### Tag: package-compute-2016-04-preview

These settings apply only when `--tag=package-compute-2016-04-preview` is specified on the command line.

```yaml $(tag) == 'package-compute-2016-04-preview'
input-file:
  - preview/2016-04-30-preview/compute.json
  - preview/2016-04-30-preview/disk.json
```

### Tag: package-2016-03

These settings apply only when `--tag=package-2016-03` is specified on the command line.

```yaml $(tag) == 'package-2016-03'
input-file:
  - stable/2016-03-30/compute.json
```

### Tag: package-compute-2016-03

These settings apply only when `--tag=package-compute-2016-03` is specified on the command line.

```yaml $(tag) == 'package-compute-2016-03'
input-file:
  - stable/2016-03-30/compute.json
```

### Tag: package-compute-2015-06

These settings apply only when `--tag=package-compute-2015-06` is specified on the command line.

```yaml $(tag) == 'package-compute-2015-06'
input-file:
  - stable/2015-06-15/compute.json
```

### Tag: package-2015-06-preview

These settings apply only when `--tag=package-2015-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2015-06-preview'
input-file:
  - stable/2015-06-15/compute.json
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
  - stable/2020-06-01/compute.json
  - stable/2019-07-01/disk.json
```
