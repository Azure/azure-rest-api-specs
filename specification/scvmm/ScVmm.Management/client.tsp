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
@@clientName(Microsoft.ScVmm.VmmServer, "ScVmmServer", "csharp");
@@clientName(Microsoft.ScVmm.Cloud, "ScVmmCloud", "csharp");
@@clientName(Microsoft.ScVmm.AvailabilitySet, "ScVmmAvailabilitySet", "csharp");
@@clientName(Microsoft.ScVmm.VirtualNetwork, "ScVmmVirtualNetwork", "csharp");
@@clientName(
  Microsoft.ScVmm.VirtualMachineTemplate,
  "ScVmmVirtualMachineTemplate",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineInstance,
  "ScVmmVirtualMachineInstance",
  "csharp"
);
@@clientName(Microsoft.ScVmm.InventoryItem, "ScVmmInventoryItem", "csharp");
@@clientName(Microsoft.ScVmm.GuestAgent, "ScVmmGuestAgent", "csharp");
@@clientName(
  Microsoft.ScVmm.VmInstanceHybridIdentityMetadata,
  "ScVmmHybridIdentityMetadata",
  "csharp"
);

// Models and enums: prepend the "ScVmm" prefix / apply acronym casing so the
// generated names match the shipped 1.0.0 surface.
@@clientName(
  Microsoft.ScVmm.AvailabilitySetListItem,
  "ScVmmAvailabilitySetItem",
  "csharp"
);
@@clientName(Microsoft.ScVmm.Checkpoint, "ScVmmCheckpoint", "csharp");
@@clientName(Microsoft.ScVmm.CloudCapacity, "ScVmmCloudCapacity", "csharp");
@@clientName(Microsoft.ScVmm.GuestCredential, "ScVmmGuestCredential", "csharp");
@@clientName(Microsoft.ScVmm.HardwareProfile, "ScVmmHardwareProfile", "csharp");
@@clientName(
  Microsoft.ScVmm.HardwareProfileUpdate,
  "ScVmmHardwareProfileUpdate",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.HttpProxyConfiguration,
  "ScVmmHttpProxyConfiguration",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.InfrastructureProfile,
  "ScVmmInfrastructureProfile",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.InfrastructureProfileUpdate,
  "ScVmmInfrastructureProfileUpdate",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.InventoryItemDetails,
  "ScVmmInventoryItemDetails",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.InventoryItemProperties,
  "ScVmmInventoryItemProperties",
  "csharp"
);
@@clientName(Microsoft.ScVmm.InventoryType, "ScVmmInventoryType", "csharp");
@@clientName(
  Microsoft.ScVmm.NetworkInterface,
  "ScVmmNetworkInterface",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.NetworkInterfaceUpdate,
  "ScVmmNetworkInterfaceUpdate",
  "csharp"
);
@@clientName(Microsoft.ScVmm.NetworkProfile, "ScVmmNetworkProfile", "csharp");
@@clientName(
  Microsoft.ScVmm.NetworkProfileUpdate,
  "ScVmmNetworkProfileUpdate",
  "csharp"
);
@@clientName(Microsoft.ScVmm.OsType, "ScVmmOSType", "csharp");
@@clientName(
  Microsoft.ScVmm.ProvisioningAction,
  "ScVmmProvisioningAction",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.ProvisioningState,
  "ScVmmProvisioningState",
  "csharp"
);
@@clientName(Microsoft.ScVmm.StorageProfile, "ScVmmStorageProfile", "csharp");
@@clientName(
  Microsoft.ScVmm.StorageProfileUpdate,
  "ScVmmStorageProfileUpdate",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.StorageQosPolicy,
  "ScVmmStorageQosPolicy",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.StorageQosPolicyDetails,
  "ScVmmStorageQosPolicyDetails",
  "csharp"
);
@@clientName(Microsoft.ScVmm.VirtualDisk, "ScVmmVirtualDisk", "csharp");
@@clientName(
  Microsoft.ScVmm.VirtualDiskUpdate,
  "ScVmmVirtualDiskUpdate",
  "csharp"
);
@@clientName(Microsoft.ScVmm.ForceDelete, "ScVmmForceDeletion", "csharp");
@@clientName(
  Microsoft.ScVmm.OsProfileForVmInstance,
  "OSProfileForVmInstance",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.StopVirtualMachineOptions,
  "StopVirtualMachineContent",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineCreateCheckpoint,
  "VirtualMachineCreateCheckpointContent",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineDeleteCheckpoint,
  "VirtualMachineDeleteCheckpointContent",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineRestoreCheckpoint,
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
@@clientName(
  Microsoft.ScVmm.VirtualMachineTemplateProperties.osType,
  "OSType",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineTemplateProperties.osName,
  "OSName",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineInstanceProperties.osProfile,
  "OSProfile",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.NetworkInterface.ipv4Addresses,
  "IPv4Addresses",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.NetworkInterface.ipv6Addresses,
  "IPv6Addresses",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.NetworkInterface.ipv4AddressType,
  "IPv4AddressType",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.NetworkInterface.ipv6AddressType,
  "IPv6AddressType",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.NetworkInterfaceUpdate.ipv4AddressType,
  "IPv4AddressType",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.NetworkInterfaceUpdate.ipv6AddressType,
  "IPv6AddressType",
  "csharp"
);
@@clientName(Microsoft.ScVmm.OsProfileForVmInstance.osType, "OSType", "csharp");
@@clientName(Microsoft.ScVmm.OsProfileForVmInstance.osSku, "OSSku", "csharp");
@@clientName(
  Microsoft.ScVmm.OsProfileForVmInstance.osVersion,
  "OSVersion",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineTemplateInventoryItem.osType,
  "OSType",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineTemplateInventoryItem.osName,
  "OSName",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineInventoryItem.osType,
  "OSType",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineInventoryItem.osName,
  "OSName",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineInventoryItem.osVersion,
  "OSVersion",
  "csharp"
);
@@clientName(
  Microsoft.ScVmm.VirtualMachineInventoryItem.ipAddresses,
  "IPAddresses",
  "csharp"
);

// Model usage: these models were public input/output types in the AutoRest
// SDK even though the TypeSpec shapes are currently only reached through
// read-only operations/properties. Add the missing input usage so constructors,
// setters, and JsonModelWriteCore remain on the C# surface.
@@usage(Microsoft.ScVmm.Checkpoint, Usage.input, "csharp");
@@usage(
  Microsoft.ScVmm.VmInstanceHybridIdentityMetadataProperties,
  Usage.input,
  "csharp"
);

// ExtendedLocation: AutoRest mapped this resource envelope property to the
// shared ARM common C# type Azure.ResourceManager.Resources.Models.ExtendedLocation.
// The mgmt generator natively maps Azure.ResourceManager.CommonTypes.ExtendedLocation
// to that shared type without emitting a package-local model, so redirect each
// resource envelope's extendedLocation property to it for csharp.
@@alternateType(
  Microsoft.ScVmm.AvailabilitySet.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  Microsoft.ScVmm.Cloud.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  Microsoft.ScVmm.VmmServer.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  Microsoft.ScVmm.VirtualMachineInstance.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  Microsoft.ScVmm.VirtualMachineTemplate.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  Microsoft.ScVmm.VirtualNetwork.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);

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
