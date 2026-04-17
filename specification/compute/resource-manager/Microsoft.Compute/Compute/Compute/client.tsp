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
@@clientName(Azure.ResourceManager.CommonTypes.Operation,
  "OperationValue",
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
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(VirtualMachineImagesOperationGroup.listByEdgeZone,
  "csharp"
);

// ── Type renames for backward compatibility (batch) ──
@@clientName(PublicIPAddressSku, "ComputePublicIPAddressSku", "csharp");
@@clientName(SecurityPostureReference, "ComputeSecurityPostureReference", "csharp");
@@clientName(StatusLevelTypes, "ComputeStatusLevelType", "csharp");
@@clientName(UpgradeMode, "VirtualMachineScaleSetUpgradeMode", "csharp");
@@clientName(SettingNames, "SettingName", "csharp");
@@clientName(ProtocolTypes, "WinRMListenerProtocolType", "csharp");
@@clientName(InstanceViewTypes, "InstanceViewType", "csharp");
@@clientName(MaintenanceOperationResultCodeTypes, "MaintenanceOperationResultCodeType", "csharp");
@@clientName(OSDisk, "VirtualMachineOSDisk", "csharp");
@@clientName(VMDiskSecurityProfile, "VirtualMachineDiskSecurityProfile", "csharp");
@@clientName(VMSizeProperties, "VirtualMachineSizeProperties", "csharp");
@@clientName(VirtualMachineScaleSetManagedDiskParameters, "VirtualMachineScaleSetManagedDisk", "csharp");
@@clientName(AlternativeOption, "ImageAlternativeOption", "csharp");
@@clientName(LogAnalyticsOperationResult, "LogAnalytics", "csharp");
@@clientName(RunCommandResult, "VirtualMachineRunCommandResult", "csharp");
@@clientName(ConvertToVirtualMachineScaleSetInput, "ConvertToVirtualMachineScaleSetContent", "csharp");
@@clientName(MigrateVMToVirtualMachineScaleSetInput, "MigrateVmToVirtualMachineScaleSetContent", "csharp");
@@clientName(OrchestrationServiceStateInput, "OrchestrationServiceStateContent", "csharp");
@@clientName(RequestRateByIntervalInput, "RequestRateByIntervalContent", "csharp");
@@clientName(ThrottledRequestsInput, "ThrottledRequestsContent", "csharp");
@@clientName(VirtualMachineCaptureParameters, "VirtualMachineCaptureContent", "csharp");
@@clientName(VirtualMachineInstallPatchesParameters, "VirtualMachineInstallPatchesContent", "csharp");
@@clientName(VirtualMachineReimageParameters, "VirtualMachineReimageContent", "csharp");
@@clientName(VirtualMachineScaleSetReimageParameters, "VirtualMachineScaleSetReimageContent", "csharp");
@@clientName(VMScaleSetConvertToSinglePlacementGroupInput, "VirtualMachineScaleSetConvertToSinglePlacementGroupContent", "csharp");
@@clientName(VMScaleSetScaleOutInput, "VirtualMachineScaleSetScaleOutContent", "csharp");
@@clientName(SshGenerateKeyPairInputParameters, "SshGenerateKeyPairInputContent", "csharp");
@@clientName(VirtualMachineScaleSetUpdateProperties, "VirtualMachineScaleSetPatchProperties", "csharp");
@@clientName(ExpandTypeForListVMs, "GetVirtualMachineExpandType", "csharp");
@@clientName(ExpandTypesForGetVMScaleSets, "VirtualMachineScaleSetGetExpand", "csharp");
@@clientName(Modes, "HostEndpointSettingsMode", "csharp");

// NOTE: AllInstancesDown and UserInitiatedRedeploy are safe-flattened by the generator.
// They need a generator option to disable safe-flatten per-type. See issue filed below.
// TODO: @@access(AllInstancesDown, Access.public, "csharp");
// TODO: @@access(UserInitiatedRedeploy, Access.public, "csharp");

// ── Plural→singular enum renames (C# backward compat) ──
@@clientName(CapacityReservationGroupInstanceViewTypes, "CapacityReservationGroupInstanceViewType", "csharp");
@@clientName(CapacityReservationInstanceViewTypes, "CapacityReservationInstanceViewType", "csharp");
@@clientName(DiffDiskOptions, "DiffDiskOption", "csharp");
@@clientName(DiskControllerTypes, "DiskControllerType", "csharp");
@@clientName(DomainNameLabelScopeTypes, "DomainNameLabelScopeType", "csharp");
@@clientName(ExpandTypesForListVMs, "ExpandTypesForListVm", "csharp");
@@clientName(ResourceIdOptionsForGetCapacityReservationGroups, "ResourceIdOptionsForGetCapacityReservationGroup", "csharp");
@@clientName(ScriptShellTypes, "ScriptShellType", "csharp");
@@clientName(SecurityEncryptionTypes, "SecurityEncryptionType", "csharp");
@@clientName(SecurityTypes, "SecurityType", "csharp");
@@clientName(SshEncryptionTypes, "SshEncryptionType", "csharp");
@@clientName(StorageAccountTypes, "StorageAccountType", "csharp");
@@clientName(VirtualMachineSizeTypes, "VirtualMachineSizeType", "csharp");

// ── RP-prefix renames (C# backward compat) ──
@@clientName(AllocationStrategy, "ComputeAllocationStrategy", "csharp");
@@clientName(DeleteOptions, "ComputeDeleteOption", "csharp");
@@clientName(NetworkInterfaceAuxiliaryMode, "ComputeNetworkInterfaceAuxiliaryMode", "csharp");
@@clientName(NetworkInterfaceAuxiliarySku, "ComputeNetworkInterfaceAuxiliarySku", "csharp");
@@clientName(PublicIPAddressSkuName, "ComputePublicIPAddressSkuName", "csharp");
@@clientName(PublicIPAddressSkuTier, "ComputePublicIPAddressSkuTier", "csharp");

// ── VM→Vm casing renames (C# backward compat) ──
@@clientName(LinuxVMGuestPatchAutomaticByPlatformSettings, "LinuxVmGuestPatchAutomaticByPlatformSettings", "csharp");
@@clientName(LinuxVMGuestPatchMode, "LinuxVmGuestPatchMode", "csharp");
@@clientName(VMGuestPatchRebootBehavior, "VmGuestPatchRebootBehavior", "csharp");
@@clientName(VMGuestPatchRebootSetting, "VmGuestPatchRebootSetting", "csharp");
@@clientName(VMGuestPatchRebootStatus, "VmGuestPatchRebootStatus", "csharp");
@@clientName(WindowsVMGuestPatchAutomaticByPlatformSettings, "WindowsVmGuestPatchAutomaticByPlatformSettings", "csharp");
@@clientName(WindowsVMGuestPatchMode, "WindowsVmGuestPatchMode", "csharp");

// ── IP→Ip casing renames (C# backward compat) ──
@@clientName(VirtualMachineIpTag, "VirtualMachineIPTag", "csharp");
@@clientName(VirtualMachineScaleSetIpTag, "VirtualMachineScaleSetIPTag", "csharp");

// ── Other renames (C# backward compat) ──
@@clientName(AlternativeType, "ImageAlternativeType", "csharp");
@@clientName(RestorePointExpandOptions, "RestorePointExpand", "csharp");
@@clientName(RestorePointCollectionExpandOptions, "RestorePointGroupExpand", "csharp");
@@clientName(RestorePointSourceVMDataDisk, "RestorePointSourceVmDataDisk", "csharp");
@@clientName(RestorePointSourceVMOSDisk, "RestorePointSourceVmOSDisk", "csharp");
@@clientName(RestorePointSourceVMStorageProfile, "RestorePointSourceVmStorageProfile", "csharp");
@@clientName(RebalanceBehavior, "VmssRebalanceBehavior", "csharp");
@@clientName(RebalanceStrategy, "VmssRebalanceStrategy", "csharp");
@@clientName(VmDiskTypes, "VirtualMachineDiskType", "csharp");

// ── Os→OS property casing renames (C# backward compat) ──
@@clientName(VirtualMachineSize.osDiskSizeInMB, "OSDiskSizeInMB", "csharp");
@@clientName(AutomaticOSUpgradePolicy.osRollingUpgradeDeferral, "OSRollingUpgradeDeferral", "csharp");
@@clientName(VirtualMachineScaleSetVMProfile.osProfile, "OSProfile", "csharp");
@@clientName(VirtualMachineScaleSetStorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(VirtualMachineScaleSetOSDisk.osType, "OSType", "csharp");
@@clientName(ScheduledEventsProfile.osImageNotificationProfile, "OSImageNotificationProfile", "csharp");
@@clientName(VirtualMachineScaleSetUpdateVMProfile.osProfile, "OSProfile", "csharp");
@@clientName(VirtualMachineScaleSetUpdateStorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(VirtualMachineReimageParameters.osProfile, "OSProfile", "csharp");
@@clientName(VirtualMachineScaleSetVMProperties.osProfile, "OSProfile", "csharp");
@@clientName(VirtualMachineScaleSetVMInstanceView.osName, "OSName", "csharp");
@@clientName(VirtualMachineScaleSetVMInstanceView.osVersion, "OSVersion", "csharp");
@@clientName(StorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(OSDisk.osType, "OSType", "csharp");
@@clientName(VirtualMachineProperties.osProfile, "OSProfile", "csharp");
@@clientName(VirtualMachineInstanceView.osName, "OSName", "csharp");
@@clientName(VirtualMachineInstanceView.osVersion, "OSVersion", "csharp");
@@clientName(VirtualMachineImageProperties.osDiskImage, "OSDiskImage", "csharp");
@@clientName(ImageStorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(ImageOSDisk.osType, "OSType", "csharp");
@@clientName(ImageOSDisk.osState, "OSState", "csharp");
@@clientName(RestorePointSourceMetadata.osProfile, "OSProfile", "csharp");
@@clientName(RestorePointSourceVMStorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(RestorePointSourceVMOSDisk.osType, "OSType", "csharp");
@@clientName(RunCommandDocumentBase.osType, "OSType", "csharp");

// ── Property casing renames: acronym case normalization (C# backward compat) ──
@@clientName(AdditionalCapabilities.ultraSSDEnabled, "UltraSsdEnabled", "csharp");
@@clientName(DedicatedHostGroupPropertiesAdditionalCapabilities.ultraSSDEnabled, "UltraSsdEnabled", "csharp");
@@clientName(DedicatedHostGroupProperties.hosts, "DedicatedHosts", "csharp");
@@clientName(HostEndpointSettings.inVMAccessControlProfileReferenceId, "InVmAccessControlProfileReferenceId", "csharp");
@@clientName(LinuxConfiguration.enableVMAgentPlatformUpdates, "EnableVmAgentPlatformUpdates", "csharp");
@@clientName(LinuxConfiguration.provisionVMAgent, "ProvisionVmAgent", "csharp");
@@clientName(WindowsConfiguration.provisionVMAgent, "ProvisionVmAgent", "csharp");
@@clientName(ScaleInPolicy.prioritizeUnhealthyVMs, "PrioritizeUnhealthyVms", "csharp");
@@clientName(DataDisk.diskIOPSReadWrite, "DiskIopsReadWrite", "csharp");
@@clientName(VirtualMachineInstanceView.isVMInStandbyPool, "IsVmInStandbyPool", "csharp");
@@clientName(VirtualMachineScaleSetDataDisk.diskIOPSReadWrite, "DiskIopsReadWrite", "csharp");
@@clientName(VirtualMachineScaleSetUpdateProperties.doNotRunExtensionsOnOverprovisionedVMs, "DoNotRunExtensionsOnOverprovisionedVms", "csharp");
@@clientName(VirtualMachineScaleSetProperties.doNotRunExtensionsOnOverprovisionedVMs, "DoNotRunExtensionsOnOverprovisionedVms", "csharp");
@@clientName(VirtualMachineScaleSetVMProperties.resilientVMDeletionStatus, "ResilientVmDeletionStatus", "csharp");
@@clientName(VMSizeProperties.vCPUsAvailable, "VCpusAvailable", "csharp");
@@clientName(VMSizeProperties.vCPUsPerCore, "VCpusPerCore", "csharp");
@@clientName(StorageProfile.alignRegionalDisksToVMZone, "AlignRegionalDisksToVmZone", "csharp");
@@clientName(MigrateVMToVirtualMachineScaleSetInput.targetVMSize, "TargetVmSize", "csharp");
@@clientName(VirtualMachineExtensionImageProperties.vmScaleSetEnabled, "VirtualMachineScaleSetEnabled", "csharp");

// ── IP→Ip property casing renames (C# backward compat) ──
@@clientName(VirtualMachineIpTag.ipTagType, "IPTagType", "csharp");
@@clientName(VirtualMachineScaleSetIpTag.ipTagType, "IPTagType", "csharp");
@@clientName(VirtualMachineNetworkInterfaceConfigurationProperties.ipConfigurations, "IPConfigurations", "csharp");
@@clientName(VirtualMachinePublicIPAddressConfigurationProperties.ipTags, "IPTags", "csharp");
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.ipConfigurations, "IPConfigurations", "csharp");
@@clientName(VirtualMachineScaleSetPublicIPAddressConfigurationProperties.ipTags, "IPTags", "csharp");
@@clientName(VirtualMachineScaleSetUpdateNetworkConfigurationProperties.ipConfigurations, "IPConfigurations", "csharp");

// ── Is* prefix / verb prefix property renames (C# backward compat) ──
@@clientName(EventGridAndResourceGraph.enable, "IsEnabled", "csharp");
@@clientName(RollingUpgradePolicy.maxSurge, "IsMaxSurgeEnabled", "csharp");
@@clientName(UefiSettings.secureBootEnabled, "IsSecureBootEnabled", "csharp");
@@clientName(UefiSettings.vTpmEnabled, "IsVirtualTpmEnabled", "csharp");
@@clientName(VirtualMachineScaleSetProperties.constrainedMaximumCapacity, "IsMaximumCapacityConstrained", "csharp");
@@clientName(WindowsConfiguration.enableVMAgentPlatformUpdates, "IsVmAgentPlatformUpdatesEnabled", "csharp");
@@clientName(VirtualMachineNetworkInterfaceConfigurationProperties.disableTcpStateTracking, "IsTcpStateTrackingDisabled", "csharp");
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.disableTcpStateTracking, "IsTcpStateTrackingDisabled", "csharp");
@@clientName(VirtualMachineScaleSetUpdateNetworkConfigurationProperties.disableTcpStateTracking, "IsTcpStateTrackingDisabled", "csharp");

// ── Qualified property name renames (C# backward compat) ──
@@clientName(AlternativeOption.type, "AlternativeType", "csharp");
@@clientName(RestorePointEncryption.type, "EncryptionType", "csharp");
@@clientName(RunCommandParameterDefinition.type, "RunCommandParameterDefinitionType", "csharp");
@@clientName(UpgradeOperationHistoricalStatusInfo.type, "UpgradeOperationHistoricalStatusInfoType", "csharp");
@@clientName(VirtualMachineExtensionHandlerInstanceView.type, "VirtualMachineExtensionHandlerInstanceViewType", "csharp");
@@clientName(VirtualMachineExtensionInstanceView.type, "VirtualMachineExtensionInstanceViewType", "csharp");

// ── Other property renames (C# backward compat) ──
@@clientName(ImageReference.sharedGalleryImageId, "SharedGalleryImageUniqueId", "csharp");
@@clientName(OrchestrationServiceSummary.lastStatusChangeTime, "LastStatusChangedOn", "csharp");
@@clientName(RestorePointCollectionProperties.restorePointCollectionId, "RestorePointGroupId", "csharp");
@@clientName(VMScaleSetScaleOutInputProperties.zone, "VmScaleSetScaleOutInputZone", "csharp");

// ── alternateType: string → ResourceIdentifier for C# (migration from AutoRest) ──

// Wrapper model id properties → ResourceIdentifier
@@alternateType(ApiEntityReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ServiceArtifactReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SecurityPostureReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SshPublicKeyGenerateKeyPairResult.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RestorePointCollectionSourceProperties.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Direct string properties → ResourceIdentifier
@@alternateType(VirtualMachineScaleSetVMInstanceView.assignedHost,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ── alternateType: string → Uri for C# (migration from AutoRest) ──
@@alternateType(BootDiagnostics.storageUri, url, "csharp");
@@alternateType(BootDiagnosticsInstanceView.consoleScreenshotBlobUri, url, "csharp");
@@alternateType(BootDiagnosticsInstanceView.serialConsoleLogBlobUri, url, "csharp");
@@alternateType(ImageDisk.blobUri, url, "csharp");
@@alternateType(KeyVaultKeyReference.keyUrl, url, "csharp");
@@alternateType(KeyVaultSecretReference.secretUrl, url, "csharp");
@@alternateType(LogAnalyticsInputBase.blobContainerSasUri, url, "csharp");
@@alternateType(RetrieveBootDiagnosticsDataResult.consoleScreenshotBlobUri, url, "csharp");
@@alternateType(RetrieveBootDiagnosticsDataResult.serialConsoleLogBlobUri, url, "csharp");
@@alternateType(VaultCertificate.certificateUrl, url, "csharp");
@@alternateType(VirtualHardDisk.uri, url, "csharp");
@@alternateType(VirtualMachineRunCommandProperties.outputBlobUri, url, "csharp");
@@alternateType(VirtualMachineRunCommandProperties.errorBlobUri, url, "csharp");
@@alternateType(VirtualMachineRunCommandScriptSource.scriptUri, url, "csharp");
@@alternateType(WinRMListener.certificateUrl, url, "csharp");

// ── alternateType: Identity types → ManagedServiceIdentity for C# ──
@@alternateType(VirtualMachineScaleSet.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(VirtualMachineScaleSetUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(VirtualMachineScaleSetVM.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(VirtualMachine.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(VirtualMachineUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);

// ── alternateType: SubResource[] for C# backward compat ──
@@alternateType(AvailabilitySetProperties.virtualMachines,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineScaleSetNetworkConfigurationProperties.networkSecurityGroup,
  Azure.ResourceManager.Models.SubResource,
  "csharp"
);
@@alternateType(VirtualMachineScaleSetIPConfigurationProperties.applicationGatewayBackendAddressPools,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineScaleSetIPConfigurationProperties.applicationSecurityGroups,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineScaleSetIPConfigurationProperties.loadBalancerBackendAddressPools,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineScaleSetIPConfigurationProperties.loadBalancerInboundNatPools,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineScaleSetUpdateNetworkConfigurationProperties.networkSecurityGroup,
  Azure.ResourceManager.Models.SubResource,
  "csharp"
);
@@alternateType(VirtualMachineScaleSetUpdateIPConfigurationProperties.applicationGatewayBackendAddressPools,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineScaleSetUpdateIPConfigurationProperties.applicationSecurityGroups,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineScaleSetUpdateIPConfigurationProperties.loadBalancerBackendAddressPools,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineScaleSetUpdateIPConfigurationProperties.loadBalancerInboundNatPools,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineNetworkInterfaceConfigurationProperties.networkSecurityGroup,
  Azure.ResourceManager.Models.SubResource,
  "csharp"
);
@@alternateType(VirtualMachineNetworkInterfaceIPConfigurationProperties.applicationSecurityGroups,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineNetworkInterfaceIPConfigurationProperties.applicationGatewayBackendAddressPools,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(VirtualMachineNetworkInterfaceIPConfigurationProperties.loadBalancerBackendAddressPools,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(DedicatedHostGroupProperties.hosts,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(DedicatedHostProperties.virtualMachines,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(CapacityReservationGroupProperties.capacityReservations,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(CapacityReservationGroupProperties.virtualMachinesAssociated,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(CapacityReservationProperties.virtualMachinesAssociated,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(CapacityReservationUtilization.virtualMachinesAllocated,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(ResourceSharingProfile.subscriptionIds,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(CapacityReservationGroupInstanceView.sharedSubscriptionIds,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(RestorePointProperties.excludeDisks,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);

// ── Extensible enum wrappers for closed unions/enums (C# backward compat) ──
// The old SDK had these as extensible enums (readonly struct). The TypeSpec spec defines them
// as closed unions/enums, which generate as fixed enums in C#. We define extensible wrappers
// and use @@alternateType on the type to replace all usages automatically.

/**
 * The component name. Currently, the only allowable value is Microsoft-Windows-Shell-Setup.
 */
union ComponentName {
  ComponentNames,
  string,
}

/**
 * The pass name. Currently, the only allowable value is OobeSystem.
 */
union PassName {
  PassNames,
  string,
}

@@alternateType(ComponentNames, ComponentName, "csharp");
@@alternateType(PassNames, PassName, "csharp");
// TODO: OperatingSystemTypes → extensible enum blocked by name collision with Compute.OperatingSystemType

// ── VirtualMachineSizeType member casing fixes (65 members) ──
// The generator lowercases size suffixes (s, m, r) differently from old SDK.
@@clientName(VirtualMachineSizeTypes.`Standard_A2m_v2`, "StandardA2MV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_A4m_v2`, "StandardA4MV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_A8m_v2`, "StandardA8MV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_B1ms`, "StandardB1Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_B1s`, "StandardB1S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_B2ms`, "StandardB2Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_B2s`, "StandardB2S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_B4ms`, "StandardB4Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_B8ms`, "StandardB8Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_D16s_v3`, "StandardD16SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_D2s_v3`, "StandardD2SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_D32s_v3`, "StandardD32SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_D4s_v3`, "StandardD4SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_D64s_v3`, "StandardD64SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_D8s_v3`, "StandardD8SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_E16s_v3`, "StandardE16SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_E2s_v3`, "StandardE2SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_E32-8s_v3`, "StandardE328SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_E32s_v3`, "StandardE32SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_E4s_v3`, "StandardE4SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_E64-16s_v3`, "StandardE6416SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_E64-32s_v3`, "StandardE6432SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_E64s_v3`, "StandardE64SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_E8s_v3`, "StandardE8SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F16s`, "StandardF16S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F16s_v2`, "StandardF16SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F1s`, "StandardF1S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F2s`, "StandardF2S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F2s_v2`, "StandardF2SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F32s_v2`, "StandardF32SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F4s`, "StandardF4S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F4s_v2`, "StandardF4SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F64s_v2`, "StandardF64SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F72s_v2`, "StandardF72SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F8s`, "StandardF8S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_F8s_v2`, "StandardF8SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_H16m`, "StandardH16M", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_H16mr`, "StandardH16Mr", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_H16r`, "StandardH16R", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_H8m`, "StandardH8M", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_L16s`, "StandardL16S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_L32s`, "StandardL32S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_L4s`, "StandardL4S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_L8s`, "StandardL8S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_M128-32ms`, "StandardM12832Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_M128-64ms`, "StandardM12864Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_M128ms`, "StandardM128Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_M128s`, "StandardM128S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_M64-16ms`, "StandardM6416Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_M64-32ms`, "StandardM6432Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_M64ms`, "StandardM64Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_M64s`, "StandardM64S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_NC12s_v2`, "StandardNC12SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_NC12s_v3`, "StandardNC12SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_NC24r`, "StandardNC24R", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_NC24rs_v2`, "StandardNC24RsV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_NC24rs_v3`, "StandardNC24RsV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_NC24s_v2`, "StandardNC24SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_NC24s_v3`, "StandardNC24SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_NC6s_v2`, "StandardNC6SV2", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_NC6s_v3`, "StandardNC6SV3", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_ND12s`, "StandardND12S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_ND24rs`, "StandardND24Rs", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_ND24s`, "StandardND24S", "csharp");
@@clientName(VirtualMachineSizeTypes.`Standard_ND6s`, "StandardND6S", "csharp");
