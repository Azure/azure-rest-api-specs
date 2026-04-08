import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Common;
using Compute;

// CommonTypes v3 defines Resource.id as string, but the .NET SDK base classes
// (ResourceData/TrackedResourceData) expect ResourceIdentifier. Override for csharp.
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@clientName(NetworkApiVersion.`2020-11-01`, "TwoThousandTwenty1101", "go");
@@clientName(NetworkApiVersion.`2022-11-01`, "TwoThousandTwentyTwo1101", "go");

@@alternateType(VirtualMachineScaleSetStorageProfile.diskControllerType,
  string,
  "go"
);
@@alternateType(VirtualMachineScaleSetUpdateStorageProfile.diskControllerType,
  string,
  "go"
);

@@clientName(VirtualMachineSizeTypes.Standard_B1ms, "StandardB1Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B2ms, "StandardB2Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B4ms, "StandardB4Ms", "go");
@@clientName(VirtualMachineSizeTypes.Standard_B8ms, "StandardB8Ms", "go");
@@clientName(VirtualMachineSizeTypes.`Standard_M128-32ms`,
  "StandardM12832Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.`Standard_M128-64ms`,
  "StandardM12864Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.Standard_M128ms, "StandardM128Ms", "go");
@@clientName(VirtualMachineSizeTypes.`Standard_M64-16ms`,
  "StandardM6416Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.`Standard_M64-32ms`,
  "StandardM6432Ms",
  "go"
);
@@clientName(VirtualMachineSizeTypes.Standard_M64ms, "StandardM64Ms", "go");

@@alternateType(AdditionalUnattendContent.passName, "OobeSystem", "go");
@@alternateType(AdditionalUnattendContent.componentName,
  "Microsoft-Windows-Shell-Setup",
  "go"
);

// Property case changes: diskIOPSReadWrite -> diskIopsReadWrite (retain old Java name)
@@clientName(VirtualMachineScaleSetDataDisk.diskIOPSReadWrite,
  "diskIopsReadWrite",
  "java"
);
@@clientName(DataDisk.diskIOPSReadWrite, "diskIopsReadWrite", "java");

// Property case changes: enableIPForwarding -> enableIpForwarding (retain old Java name)
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.enableIPForwarding,
  "enableIpForwarding",
  "java"
);
@@clientName(VirtualMachineScaleSetUpdateNetworkConfigurationProperties.enableIPForwarding,
  "enableIpForwarding",
  "java"
);
@@clientName(VirtualMachineNetworkInterfaceConfigurationProperties.enableIPForwarding,
  "enableIpForwarding",
  "java"
);

// Model name capitalization changes (retain previous Java model names)
@@clientName(PublicIPAddressSku, "PublicIpAddressSku", "java");

@@clientName(PublicIPAddressSkuName, "PublicIpAddressSkuName", "java");
@@clientName(PublicIPAddressSkuTier, "PublicIpAddressSkuTier", "java");
@@clientName(PublicIPAllocationMethod, "PublicIpAllocationMethod", "java");
@@clientName(IPVersion, "IpVersion", "java");
@@clientName(IPVersions, "IpVersions", "java");
@@clientName(VirtualMachineScaleSetPublicIPAddressConfiguration,
  "VirtualMachineScaleSetPublicIpAddressConfiguration",
  "java"
);
@@clientName(VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings,
  "VirtualMachineScaleSetPublicIpAddressConfigurationDnsSettings",
  "java"
);
@@clientName(VirtualMachineScaleSetIPConfiguration,
  "VirtualMachineScaleSetIpConfiguration",
  "java"
);
@@clientName(VirtualMachineScaleSetUpdateIPConfiguration,
  "VirtualMachineScaleSetUpdateIpConfiguration",
  "java"
);
@@clientName(VirtualMachineScaleSetUpdatePublicIPAddressConfiguration,
  "VirtualMachineScaleSetUpdatePublicIpAddressConfiguration",
  "java"
);
@@clientName(VirtualMachineNetworkInterfaceIPConfiguration,
  "VirtualMachineNetworkInterfaceIpConfiguration",
  "java"
);
@@clientName(VirtualMachinePublicIPAddressConfiguration,
  "VirtualMachinePublicIpAddressConfiguration",
  "java"
);
@@clientName(VirtualMachinePublicIPAddressDnsSettingsConfiguration,
  "VirtualMachinePublicIpAddressDnsSettingsConfiguration",
  "java"
);
@@clientName(RestorePointSourceVMOSDisk, "RestorePointSourceVmosDisk", "java");

// Property case changes in VM size properties: vCPUs* -> vCpus*
@@clientName(VMSizeProperties.vCPUsAvailable, "vCpusAvailable", "java");
@@clientName(VMSizeProperties.vCPUsPerCore, "vCpusPerCore", "java");

// Property case change: ultraSSDEnabled -> ultraSsdEnabled
@@clientName(AdditionalCapabilities.ultraSSDEnabled, "ultraSsdEnabled", "java");
@@clientName(DedicatedHostGroupPropertiesAdditionalCapabilities.ultraSSDEnabled,
  "ultraSsdEnabled",
  "java"
);

// Scale set IP configuration properties
@@clientName(VirtualMachineScaleSetIPConfigurationProperties.publicIPAddressConfiguration,
  "publicIpAddressConfiguration",
  "java"
);
@@clientName(VirtualMachineScaleSetIPConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);

// Scale set public IP configuration properties
@@clientName(VirtualMachineScaleSetPublicIPAddressConfigurationProperties.publicIPAddressVersion,
  "publicIpAddressVersion",
  "java"
);
@@clientName(VirtualMachineScaleSetPublicIPAddressConfigurationProperties.publicIPPrefix,
  "publicIpPrefix",
  "java"
);

// Scale set UPDATE IP configuration properties
@@clientName(VirtualMachineScaleSetUpdateIPConfigurationProperties.publicIPAddressConfiguration,
  "publicIpAddressConfiguration",
  "java"
);
@@clientName(VirtualMachineScaleSetUpdateIPConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);

// Scale set UPDATE public IP configuration properties
@@clientName(VirtualMachineScaleSetUpdatePublicIPAddressConfigurationProperties.publicIPPrefix,
  "publicIpPrefix",
  "java"
);

// Network interface IP configuration properties
@@clientName(VirtualMachineNetworkInterfaceIPConfigurationProperties.publicIPAddressConfiguration,
  "publicIpAddressConfiguration",
  "java"
);
@@clientName(VirtualMachineNetworkInterfaceIPConfigurationProperties.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);

// VM-level public IP address configuration properties
@@clientName(VirtualMachinePublicIPAddressConfigurationProperties.publicIPAddressVersion,
  "publicIpAddressVersion",
  "java"
);
@@clientName(VirtualMachinePublicIPAddressConfigurationProperties.publicIPPrefix,
  "publicIpPrefix",
  "java"
);
@@clientName(VirtualMachinePublicIPAddressConfigurationProperties.publicIPAllocationMethod,
  "publicIpAllocationMethod",
  "java"
);

// C# operation location fixes — resolve collection result name collisions
// Both "list" and "listAll" on the same interface get mapped to "GetAll",
// causing duplicate CollectionResult type names. Move "listAll" to a separate
// interface so each gets a unique collection result type name.
@@clientLocation(VirtualMachineScaleSets.listAll,
  "VirtualMachineScaleSetsSubscription",
  "csharp"
);
@@clientLocation(VirtualMachines.listAll,
  "VirtualMachinesSubscription",
  "csharp"
);
@@clientLocation(RestorePointCollections.listAll,
  "RestorePointCollectionsSubscription",
  "csharp"
);

// C# operation renames — OperationGroup operations with colliding names on the
// same mockable resource scope need unique C# method names.
// VirtualMachineImagesEdgeZoneOperationGroup ops renamed to old API names.
@@clientName(VirtualMachineImagesEdgeZoneOperationGroup.listPublishers,
  "GetPublishersVirtualMachineImagesEdgeZones",
  "csharp"
);
@@clientName(VirtualMachineImagesEdgeZoneOperationGroup.listOffers,
  "GetOffersVirtualMachineImagesEdgeZones",
  "csharp"
);
@@clientName(VirtualMachineImagesEdgeZoneOperationGroup.listSkus,
  "GetVirtualMachineImageEdgeZoneSkus",
  "csharp"
);
@@clientName(VirtualMachineImagesEdgeZoneOperationGroup.list,
  "GetVirtualMachineImagesEdgeZones",
  "csharp"
);
@@clientName(VirtualMachineImagesEdgeZoneOperationGroup.get,
  "GetVirtualMachineImagesEdgeZone",
  "csharp"
);
// VirtualMachineImagesOperationGroup ops renamed to old API names.
@@clientName(VirtualMachineImagesOperationGroup.listPublishers,
  "GetVirtualMachineImagePublishers",
  "csharp"
);
@@clientName(VirtualMachineImagesOperationGroup.listOffers,
  "GetVirtualMachineImageOffers",
  "csharp"
);
@@clientName(VirtualMachineImagesOperationGroup.listSkus,
  "GetVirtualMachineImageSkus",
  "csharp"
);
@@clientName(VirtualMachineImagesOperationGroup.list,
  "GetVirtualMachineImages",
  "csharp"
);
@@clientName(VirtualMachineImagesOperationGroup.get,
  "GetVirtualMachineImage",
  "csharp"
);
@@clientName(VirtualMachineImagesOperationGroup.listByEdgeZone,
  "GetVirtualMachineImagesByEdgeZone",
  "csharp"
);
@@clientName(VirtualMachineImagesOperationGroup.listWithProperties,
  "GetVirtualMachineImagesWithProperties",
  "csharp"
);
// Other OperationGroup ops renamed to old API names.
@@clientName(UsageOperationGroup.list, "GetUsages", "csharp");
@@clientName(VirtualMachineSizesOperationGroup.list,
  "GetVirtualMachineSizes",
  "csharp"
);
@@clientName(VirtualMachineRunCommandsOperationGroup.list,
  "GetVirtualMachineRunCommands",
  "csharp"
);
@@clientName(VirtualMachineRunCommandsOperationGroup.get,
  "GetVirtualMachineRunCommand",
  "csharp"
);
@@clientName(LogAnalyticsOperationGroup.exportThrottledRequests,
  "ExportLogAnalyticsThrottledRequests",
  "csharp"
);
@@clientName(LogAnalyticsOperationGroup.exportRequestRateByInterval,
  "ExportLogAnalyticsRequestRateByInterval",
  "csharp"
);

// C# model renames — preserve backward compatibility during TypeSpec migration

// VM sub-model renames: prefix with "VirtualMachine" to match old C# names
@@clientName(DataDisk, "VirtualMachineDataDisk", "csharp");
@@clientName(HardwareProfile, "VirtualMachineHardwareProfile", "csharp");
@@clientName(NetworkProfile, "VirtualMachineNetworkProfile", "csharp");
@@clientName(OSProfile, "VirtualMachineOSProfile", "csharp");
@@clientName(StorageProfile, "VirtualMachineStorageProfile", "csharp");
@@clientName(ManagedDiskParameters, "VirtualMachineManagedDisk", "csharp");

// VMSS sub-model renames
@@clientName(UpgradePolicy, "VirtualMachineScaleSetUpgradePolicy", "csharp");
@@clientName(PriorityMixPolicy,
  "VirtualMachineScaleSetPriorityMixPolicy",
  "csharp"
);

// Enum singular←plural renames
@@clientName(CachingTypes, "CachingType", "csharp");
@@clientName(DiskCreateOptionTypes, "DiskCreateOptionType", "csharp");
@@clientName(DiskDeleteOptionTypes, "DiskDeleteOptionType", "csharp");
@@clientName(DiskDetachOptionTypes, "DiskDetachOptionType", "csharp");

// RP-prefix renames
@@clientName(Plan, "ComputePlan", "csharp");
@@clientName(SkuProfile, "ComputeSkuProfile", "csharp");
@@clientName(UpdateResource, "ComputeResourcePatch", "csharp");

// Base type rename
@@clientName(VirtualMachineImageResource, "VirtualMachineImageBase", "csharp");

// Long enum/type renames
@@clientName(ExpandTypesForGetCapacityReservationGroups,
  "CapacityReservationGroupGetExpand",
  "csharp"
);

// VM→Vm casing renames (old C# convention used lowercase "Vm")
@@clientName(VirtualMachineScaleSetVMInstanceIDs,
  "VirtualMachineScaleSetVmInstanceIds",
  "csharp"
);
@@clientName(ResilientVMDeletionStatus, "ResilientVmDeletionStatus", "csharp");
@@clientName(LinuxVMGuestPatchAutomaticByPlatformRebootSetting,
  "LinuxVmGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(WindowsVMGuestPatchAutomaticByPlatformRebootSetting,
  "WindowsVmGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMInstanceView,
  "VirtualMachineScaleSetVmInstanceView",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMProperties,
  "VirtualMachineScaleSetVmProperties",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMProtectionPolicy,
  "VirtualMachineScaleSetVmProtectionPolicy",
  "csharp"
);

// ── Type renames for backward compatibility (migration from AutoRest) ──

// Enum/union plural→singular renames
@@clientName(ArchitectureTypes, "ArchitectureType", "csharp");
@@clientName(ConsistencyModeTypes, "ConsistencyModeType", "csharp");
@@clientName(DedicatedHostLicenseTypes, "DedicatedHostLicenseType", "csharp");
@@clientName(OperatingSystemStateTypes, "OperatingSystemStateType", "csharp");
@@clientName(OrchestrationServiceNames, "OrchestrationServiceName", "csharp");
@@clientName(VirtualMachineEvictionPolicyTypes,
  "VirtualMachineEvictionPolicyType",
  "csharp"
);
@@clientName(VirtualMachinePriorityTypes,
  "VirtualMachinePriorityType",
  "csharp"
);
@@clientName(VirtualMachineScaleSetScaleInRules,
  "VirtualMachineScaleSetScaleInRule",
  "csharp"
);
@@clientName(VMGuestPatchClassificationLinux,
  "VmGuestPatchClassificationForLinux",
  "csharp"
);
@@clientName(VMGuestPatchClassificationWindows,
  "VmGuestPatchClassificationForWindows",
  "csharp"
);

// Model casing renames
@@clientName(DedicatedHostAllocatableVM,
  "DedicatedHostAllocatableVm",
  "csharp"
);

// Resource type VM→Vm casing renames (backward compat with AutoRest output)
@@clientName(VirtualMachineScaleSetVM, "VirtualMachineScaleSetVm", "csharp");
@@clientName(VirtualMachineScaleSetVMExtension,
  "VirtualMachineScaleSetVmExtension",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMNetworkProfileConfiguration,
  "VirtualMachineScaleSetVmNetworkProfileConfiguration",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMInstanceRequiredIDs,
  "VirtualMachineScaleSetVmInstanceRequiredIds",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMExtensionsSummary,
  "VirtualMachineScaleSetVmExtensionsSummary",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMReimageParameters,
  "VirtualMachineScaleSetVmReimageContent",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMExtensionUpdate,
  "VirtualMachineScaleSetVmExtensionPatch",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMExtensionsListResult,
  "VirtualMachineScaleSetVmExtensionsListResult",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMListResult,
  "VirtualMachineScaleSetVmListResult",
  "csharp"
);

// RP-prefix renames (old AutoRest prepend-rp-prefix convention)
@@clientName(ApiError, "ComputeApiError", "csharp");
@@clientName(Placement, "VirtualMachinePlacement", "csharp");
@@clientName(ScheduledEventsProfile, "ComputeScheduledEventsProfile", "csharp");
@@clientName(SubResourceWithColocationStatus,
  "ComputeSubResourceDataWithColocationStatus",
  "csharp"
);
@@clientName(UsageName, "ComputeUsageName", "csharp");
@@clientName(OperatingSystemType, "SupportedOperatingSystemType", "csharp");
@@clientName(ReservationType, "CapacityReservationType", "csharp");
@@clientName(ApiErrorBase, "ComputeApiErrorBase", "csharp");
@@clientName(VMGalleryApplication,
  "VirtualMachineGalleryApplication",
  "csharp"
);
@@clientName(NetworkInterfaceReference,
  "VirtualMachineNetworkInterfaceReference",
  "csharp"
);
@@clientName(SkuProfileVMSize, "ComputeSkuProfileVmSize", "csharp");
@@clientName(VirtualMachineScaleSetVMProfile,
  "VirtualMachineScaleSetVmProfile",
  "csharp"
);
@@clientName(VirtualMachineScaleSetUpdateVMProfile,
  "VirtualMachineScaleSetUpdateVmProfile",
  "csharp"
);

// Accessibility overrides (types generated as internal that should be public)
@@access(VirtualMachineScaleSetVMProfile, Access.public, "csharp");
@@access(VirtualMachineScaleSetProperties, Access.public, "csharp");
@@access(VirtualMachineScaleSetUpdateVMProfile, Access.public, "csharp");
@@access(VirtualMachineScaleSetVMProperties, Access.public, "csharp");

// Rename listByLocation operations to avoid name collision (both map to GetByLocation)
@@clientName(VirtualMachinesOperationGroup.listByLocation,
  "GetVirtualMachinesByLocation",
  "csharp"
);
@@clientName(VirtualMachineScaleSetsOperationGroup.listByLocation,
  "GetVirtualMachineScaleSetsByLocation",
  "csharp"
);

// Rename extension property "type" to avoid conflict with base class "Type" property
@@clientName(VirtualMachineScaleSetExtensionProperties.type,
  "ExtensionType",
  "csharp"
);
@@clientName(VirtualMachineExtensionProperties.type, "ExtensionType", "csharp");
@@clientName(VirtualMachineExtensionUpdateProperties.type,
  "ExtensionType",
  "csharp"
);

// Rename duplicate automaticallyApprove in sub-models to avoid flattening collision
@@clientName(UserInitiatedRedeploy.automaticallyApprove,
  "AutomaticallyApproveRedeploy",
  "csharp"
);
@@clientName(AllInstancesDown.automaticallyApprove,
  "AutomaticallyApproveAllDown",
  "csharp"
);

// Resource type rename for backward compatibility - RollingUpgradeStatusInfo → VirtualMachineScaleSetRollingUpgrade
@@clientName(RollingUpgradeStatusInfo,
  "VirtualMachineScaleSetRollingUpgrade",
  "csharp"
);
@@clientName(RollingUpgradeStatusInfoProperties,
  "VirtualMachineScaleSetRollingUpgradeProperties",
  "csharp"
);

// ── ARM resource renames for backward compatibility ──

// Image → DiskImage (old: DiskImageResource, DiskImageData, DiskImageCollection)
@@clientName(Image, "DiskImage", "csharp");

// RestorePointCollection → RestorePointGroup (old: RestorePointGroupResource, RestorePointGroupData)
@@clientName(RestorePointCollection, "RestorePointGroup", "csharp");
@@clientName(RestorePointCollectionSourceProperties,
  "RestorePointGroupSource",
  "csharp"
);

// Rename non-resource model SshPublicKey → SshPublicKeyConfiguration to free the name,
// then rename the resource model SshPublicKeyResource → SshPublicKey
@@clientName(Compute.SshPublicKey, "SshPublicKeyConfiguration", "csharp");
@@clientName(SshPublicKeyResource, "SshPublicKey", "csharp");

// VirtualMachineScaleSetVMRunCommands interface → Vm casing (old: VirtualMachineScaleSetVmRunCommandResource)
@@clientName(VirtualMachineScaleSetVMRunCommands,
  "VirtualMachineScaleSetVmRunCommands",
  "csharp"
);

// Mark non-pageable list operations as pageable for backward compatibility
// These return a single-page list result but the SDK expects them to be enumerable
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(VirtualMachineExtensions.list,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(VirtualMachineScaleSetVMExtensions.list,
  "csharp"
);
