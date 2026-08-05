import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.ScVmm;

@@clientName(Microsoft.ScVmm, "ScVmmMgmtClient", "python");

// ---------------------------------------------------------------------------
// C# customizations for backward compatibility with the previously shipped
// AutoRest-generated Azure.ResourceManager.ScVmm 1.0.0 surface.
// These reproduce the rename-mapping, prepend-rp-prefix and acronym-mapping
// rules that used to live in src/autorest.md so the migrated TypeSpec SDK keeps
// the same public type names.
// ---------------------------------------------------------------------------

// Resources: prepend the "ScVmm" resource-provider prefix (and apply the
// historical VMMServer -> ScVmmServer / VmInstanceHybridIdentityMetadata ->
// ScVmmHybridIdentityMetadata renames) so the generated *Resource/*Data/
// *Collection types match the shipped names.
@@clientName(VmmServer, "ScVmmServer", "csharp");
@@clientName(Cloud, "ScVmmCloud", "csharp");
@@clientName(AvailabilitySet, "ScVmmAvailabilitySet", "csharp");
@@clientName(VirtualNetwork, "ScVmmVirtualNetwork", "csharp");
@@clientName(VirtualMachineTemplate, "ScVmmVirtualMachineTemplate", "csharp");
@@clientName(VirtualMachineInstance, "ScVmmVirtualMachineInstance", "csharp");
@@clientName(InventoryItem, "ScVmmInventoryItem", "csharp");
@@clientName(GuestAgent, "ScVmmGuestAgent", "csharp");
@@clientName(
  VmInstanceHybridIdentityMetadata,
  "ScVmmHybridIdentityMetadata",
  "csharp"
);

// Models and enums: prepend the "ScVmm" prefix / apply acronym casing so the
// generated names match the shipped 1.0.0 surface.
@@clientName(AvailabilitySetListItem, "ScVmmAvailabilitySetItem", "csharp");
@@clientName(Checkpoint, "ScVmmCheckpoint", "csharp");
@@clientName(CloudCapacity, "ScVmmCloudCapacity", "csharp");
@@clientName(GuestCredential, "ScVmmGuestCredential", "csharp");
@@clientName(HardwareProfile, "ScVmmHardwareProfile", "csharp");
@@clientName(HardwareProfileUpdate, "ScVmmHardwareProfileUpdate", "csharp");
@@clientName(HttpProxyConfiguration, "ScVmmHttpProxyConfiguration", "csharp");
@@clientName(InfrastructureProfile, "ScVmmInfrastructureProfile", "csharp");
@@clientName(
  InfrastructureProfileUpdate,
  "ScVmmInfrastructureProfileUpdate",
  "csharp"
);
@@clientName(InventoryItemDetails, "ScVmmInventoryItemDetails", "csharp");
@@clientName(InventoryItemProperties, "ScVmmInventoryItemProperties", "csharp");
@@clientName(InventoryType, "ScVmmInventoryType", "csharp");
@@clientName(NetworkInterface, "ScVmmNetworkInterface", "csharp");
@@clientName(NetworkInterfaceUpdate, "ScVmmNetworkInterfaceUpdate", "csharp");
@@clientName(NetworkProfile, "ScVmmNetworkProfile", "csharp");
@@clientName(NetworkProfileUpdate, "ScVmmNetworkProfileUpdate", "csharp");
@@clientName(OsType, "ScVmmOSType", "csharp");
@@clientName(ProvisioningAction, "ScVmmProvisioningAction", "csharp");
@@clientName(ProvisioningState, "ScVmmProvisioningState", "csharp");
@@clientName(StorageProfile, "ScVmmStorageProfile", "csharp");
@@clientName(StorageProfileUpdate, "ScVmmStorageProfileUpdate", "csharp");
@@clientName(StorageQosPolicy, "ScVmmStorageQosPolicy", "csharp");
@@clientName(StorageQosPolicyDetails, "ScVmmStorageQosPolicyDetails", "csharp");
@@clientName(VirtualDisk, "ScVmmVirtualDisk", "csharp");
@@clientName(VirtualDiskUpdate, "ScVmmVirtualDiskUpdate", "csharp");
@@clientName(ForceDelete, "ScVmmForceDeletion", "csharp");
@@clientName(OsProfileForVmInstance, "OSProfileForVmInstance", "csharp");
@@clientName(StopVirtualMachineOptions, "StopVirtualMachineContent", "csharp");
@@clientName(
  VirtualMachineCreateCheckpoint,
  "VirtualMachineCreateCheckpointContent",
  "csharp"
);
@@clientName(
  VirtualMachineDeleteCheckpoint,
  "VirtualMachineDeleteCheckpointContent",
  "csharp"
);
@@clientName(
  VirtualMachineRestoreCheckpoint,
  "VirtualMachineRestoreCheckpointContent",
  "csharp"
);
@@access(
  Azure.ResourceManager.Foundations.ResourceUpdateModel,
  Access.internal,
  "csharp"
);
// Properties: preserve the AutoRest acronym mapping (Os/Ip/Ipv4/Ipv6 ->
// OS/IP/IPv4/IPv6) for the shipped 1.0.0 C# public API.
@@clientName(VirtualMachineTemplateProperties.osType, "OSType", "csharp");
@@clientName(VirtualMachineTemplateProperties.osName, "OSName", "csharp");
@@clientName(VirtualMachineInstanceProperties.osProfile, "OSProfile", "csharp");
@@clientName(NetworkInterface.ipv4Addresses, "IPv4Addresses", "csharp");
@@clientName(NetworkInterface.ipv6Addresses, "IPv6Addresses", "csharp");
@@clientName(NetworkInterface.ipv4AddressType, "IPv4AddressType", "csharp");
@@clientName(NetworkInterface.ipv6AddressType, "IPv6AddressType", "csharp");
@@clientName(
  NetworkInterfaceUpdate.ipv4AddressType,
  "IPv4AddressType",
  "csharp"
);
@@clientName(
  NetworkInterfaceUpdate.ipv6AddressType,
  "IPv6AddressType",
  "csharp"
);
@@clientName(OsProfileForVmInstance.osType, "OSType", "csharp");
@@clientName(OsProfileForVmInstance.osSku, "OSSku", "csharp");
@@clientName(OsProfileForVmInstance.osVersion, "OSVersion", "csharp");
@@clientName(VirtualMachineTemplateInventoryItem.osType, "OSType", "csharp");
@@clientName(VirtualMachineTemplateInventoryItem.osName, "OSName", "csharp");
@@clientName(VirtualMachineInventoryItem.osType, "OSType", "csharp");
@@clientName(VirtualMachineInventoryItem.osName, "OSName", "csharp");
@@clientName(VirtualMachineInventoryItem.osVersion, "OSVersion", "csharp");
@@clientName(VirtualMachineInventoryItem.ipAddresses, "IPAddresses", "csharp");

// Model usage: these models were public input/output types in the AutoRest
// SDK even though the TypeSpec shapes are currently only reached through
// read-only operations/properties. Add the missing input usage so constructors,
// setters, and JsonModelWriteCore remain on the C# surface.
@@usage(Checkpoint, Usage.input, "csharp");
@@usage(VmInstanceHybridIdentityMetadata, Usage.input, "csharp");

// ExtendedLocation: AutoRest mapped this resource envelope property to the
// shared ARM common C# type Azure.ResourceManager.Resources.Models.ExtendedLocation.
// The mgmt generator natively maps Azure.ResourceManager.CommonTypes.ExtendedLocation
// to that shared type without emitting a package-local model, so redirect each
// resource envelope's extendedLocation property to it for csharp.
@@alternateType(
  AvailabilitySet.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  Cloud.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  VmmServer.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  VirtualMachineInstance.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  VirtualMachineTemplate.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  VirtualNetwork.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);

// csharp Update_Tags methods use the same class ScVmmResourcePatch as parameter for all resources.
/**
 * Object containing tags updates for patch operations.
 */
model ScVmmResourcePatch
  is Azure.ResourceManager.Foundations.TagsUpdateModel<AvailabilitySet>;
@@clientName(ScVmmResourcePatch, exact("ScVmmResourcePatch"), "csharp");

@@alternateType(
  AvailabilitySets.update::parameters.properties,
  ScVmmResourcePatch,
  "csharp"
);
@@alternateType(
  Clouds.update::parameters.properties,
  ScVmmResourcePatch,
  "csharp"
);
@@alternateType(
  VmmServers.update::parameters.properties,
  ScVmmResourcePatch,
  "csharp"
);
@@alternateType(
  VirtualMachineTemplates.update::parameters.properties,
  ScVmmResourcePatch,
  "csharp"
);
@@alternateType(
  VirtualNetworks.update::parameters.properties,
  ScVmmResourcePatch,
  "csharp"
);

/** C#-specific create-checkpoint operation with an optional convenience parameter. */
op virtualMachineInstancesCreateCheckpointForCsharp is Azure.ResourceManager.ArmResourceActionNoResponseContentAsync<
  VirtualMachineInstance,
  VirtualMachineCreateCheckpoint,
  OptionalRequestBody = true
>;
@@override(
  VirtualMachineInstances.createCheckpoint,
  virtualMachineInstancesCreateCheckpointForCsharp,
  "csharp"
);

/** C#-specific delete-checkpoint operation with an optional convenience parameter. */
op virtualMachineInstancesDeleteCheckpointForCsharp is Azure.ResourceManager.ArmResourceActionNoResponseContentAsync<
  VirtualMachineInstance,
  VirtualMachineDeleteCheckpoint,
  OptionalRequestBody = true
>;
@@override(
  VirtualMachineInstances.deleteCheckpoint,
  virtualMachineInstancesDeleteCheckpointForCsharp,
  "csharp"
);

/** C#-specific restore-checkpoint operation with an optional convenience parameter. */
op virtualMachineInstancesRestoreCheckpointForCsharp is Azure.ResourceManager.ArmResourceActionNoResponseContentAsync<
  VirtualMachineInstance,
  VirtualMachineRestoreCheckpoint,
  OptionalRequestBody = true
>;
@@override(
  VirtualMachineInstances.restoreCheckpoint,
  virtualMachineInstancesRestoreCheckpointForCsharp,
  "csharp"
);
