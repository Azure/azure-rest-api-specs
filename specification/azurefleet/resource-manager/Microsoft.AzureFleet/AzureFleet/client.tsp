import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureFleet;
using TypeSpec.Versioning;

@@clientName(Microsoft.AzureFleet, "ComputeFleetMgmtClient", "python");
@@clientName(Microsoft.AzureFleet, "ComputeFleetManagementClient", "java");

@@access(Operations.list, Access.internal, "csharp");

@@clientName(ApiError, "ComputeFleetApiError", "csharp");
@@clientName(ApplicationProfile, "ComputeFleetApplicationProfile", "csharp");
@@clientName(BootDiagnostics, "ComputeFleetBootDiagnostics", "csharp");
@@clientName(CachingTypes, "ComputeFleetCachingType", "csharp");
@@clientName(ComputeProfile, "ComputeFleetComputeProfile", "csharp");
@@clientName(DiagnosticsProfile, "ComputeFleetDiagnosticsProfile", "csharp");
@@clientName(DiffDiskOptions, "ComputeFleetDiffDiskOption", "csharp");
@@clientName(DiffDiskPlacement, "ComputeFleetDiffDiskPlacement", "csharp");
@@clientName(DiffDiskSettings, "ComputeFleetDiffDiskSettings", "csharp");
@@clientName(DiskControllerTypes, "ComputeFleetDiskControllerType", "csharp");
@@clientName(DiskCreateOptionTypes,
  "ComputeFleetDiskCreateOptionType",
  "csharp"
);
@@clientName(DiskDeleteOptionTypes,
  "ComputeFleetDiskDeleteOptionType",
  "csharp"
);
@@clientName(DomainNameLabelScopeTypes,
  "ComputeFleetDomainNameLabelScopeType",
  "csharp"
);
@@clientName(EncryptionIdentity, "ComputeFleetEncryptionIdentity", "csharp");
@@clientName(EvictionPolicy, "ComputeFleetEvictionPolicy", "csharp");
@@clientName(ImageReference, "ComputeFleetImageReference", "csharp");
@@clientName(InnerError, "ComputeFleetInnerError", "csharp");
@@clientName(IPVersion, "ComputeFleetIPVersion", "csharp");
@@clientName(KeyVaultSecretReference,
  "ComputeFleetKeyVaultSecretReference",
  "csharp"
);
@@clientName(LinuxConfiguration, "ComputeFleetLinuxConfiguration", "csharp");
@@clientName(LinuxPatchAssessmentMode,
  "ComputeFleetLinuxPatchAssessmentMode",
  "csharp"
);
@@clientName(LinuxPatchSettings, "ComputeFleetLinuxPatchSettings", "csharp");
@@clientName(LinuxVMGuestPatchAutomaticByPlatformRebootSetting,
  "ComputeFleetLinuxVmGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(LinuxVMGuestPatchAutomaticByPlatformSettings,
  "ComputeFleetLinuxVmGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(LinuxVMGuestPatchMode,
  "ComputeFleetLinuxVmGuestPatchMode",
  "csharp"
);
@@clientName(NetworkApiVersion, "ComputeFleetNetworkApiVersion", "csharp");
@@clientName(NetworkInterfaceAuxiliaryMode,
  "ComputeFleetNetworkInterfaceAuxiliaryMode",
  "csharp"
);
@@clientName(NetworkInterfaceAuxiliarySku,
  "ComputeFleetNetworkInterfaceAuxiliarySku",
  "csharp"
);
@@clientName(OperatingSystemTypes, "ComputeFleetOperatingSystemType", "csharp");
@@clientName(OSImageNotificationProfile,
  "ComputeFleetOSImageNotificationProfile",
  "csharp"
);
@@clientName(ProtocolTypes, "ComputeFleetProtocolType", "csharp");
@@clientName(ProvisioningState, "ComputeFleetProvisioningState", "csharp");
@@clientName(ProxyAgentSettings, "ComputeFleetProxyAgentSettings", "csharp");
@@clientName(PublicIPAddressSku, "ComputeFleetPublicIPAddressSku", "csharp");
@@clientName(PublicIPAddressSkuName,
  "ComputeFleetPublicIPAddressSkuName",
  "csharp"
);
@@clientName(PublicIPAddressSkuTier,
  "ComputeFleetPublicIPAddressSkuTier",
  "csharp"
);
@@clientName(ScheduledEventsProfile,
  "ComputeFleetScheduledEventsProfile",
  "csharp"
);
@@clientName(ScheduledEventsProfile.osImageNotificationProfile,
  "OSImageNotificationProfile",
  "csharp"
);
@@clientName(SecurityEncryptionTypes,
  "ComputeFleetSecurityEncryptionType",
  "csharp"
);
@@clientName(SecurityEncryptionTypes.DiskWithVMGuestState,
  "DiskWithVmGuestState",
  "csharp"
);
@@clientName(SecurityEncryptionTypes.VMGuestStateOnly,
  "VmGuestStateOnly",
  "csharp"
);
@@clientName(SecurityPostureReference,
  "ComputeFleetSecurityPostureReference",
  "csharp"
);
@@clientName(SecurityProfile, "ComputeFleetSecurityProfile", "csharp");
@@clientName(SecurityTypes, "ComputeFleetSecurityType", "csharp");
@@clientName(SecurityTypes.ConfidentialVM, "ConfidentialVm", "csharp");
@@clientName(SshConfiguration, "ComputeFleetSshConfiguration", "csharp");
@@clientName(SshPublicKey, "ComputeFleetSshPublicKey", "csharp");
@@clientName(StorageAccountTypes, "ComputeFleetStorageAccountType", "csharp");
@@clientName(TerminateNotificationProfile,
  "ComputeFleetTerminateNotificationProfile",
  "csharp"
);
@@clientName(UefiSettings, "ComputeFleetUefiSettings", "csharp");
@@clientName(VaultCertificate, "ComputeFleetVaultCertificate", "csharp");
@@clientName(VaultSecretGroup, "ComputeFleetVaultSecretGroup", "csharp");
@@clientName(VirtualHardDisk, "ComputeFleetVirtualHardDisk", "csharp");
@@clientName(VMDiskSecurityProfile,
  "ComputeFleetVmDiskSecurityProfile",
  "csharp"
);
@@clientName(VMGalleryApplication,
  "ComputeFleetVmGalleryApplication",
  "csharp"
);
@@clientName(VmSizeProfile, "ComputeFleetVmSizeProfile", "csharp");
@@clientName(VMSizeProperties, "ComputeFleetVmSizeProperties", "csharp");
@@clientName(WindowsConfiguration,
  "ComputeFleetWindowsConfiguration",
  "csharp"
);
@@clientName(WindowsPatchAssessmentMode,
  "ComputeFleetWindowsPatchAssessmentMode",
  "csharp"
);
@@clientName(WindowsVMGuestPatchAutomaticByPlatformRebootSetting,
  "ComputeFleetWindowsVmGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(WindowsVMGuestPatchAutomaticByPlatformSettings,
  "ComputeFleetWindowsVmGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(WindowsVMGuestPatchMode,
  "ComputeFleetWindowsVmGuestPatchMode",
  "csharp"
);
@@clientName(WinRMListener, "ComputeFleetWinRMListener", "csharp");

@@clientName(Fleet, "ComputeFleet", "csharp");

@@clientName(FleetProperties, "ComputeFleetProperties", "csharp");
@@clientName(FleetProperties.timeCreated, "CreatedOn", "csharp");

@@clientName(AdditionalUnattendContent,
  "WindowsSetupAdditionalInformation",
  "csharp"
);

@@clientName(ApiErrorBase, "ComputeFleetApiErrorInfo", "csharp");

@@clientName(BaseVirtualMachineProfile, "ComputeFleetVmProfile", "csharp");
@@clientName(BaseVirtualMachineProfile.timeCreated, "CreatedOn", "csharp");
@@clientName(BaseVirtualMachineProfile.osProfile, "OSProfile", "csharp");

@@clientName(BootDiagnostics.enabled, "IsEnabled", "csharp");

@@clientName(DeleteOptions, "ComputeFleetVmDeleteOption", "csharp");

@@clientName(DiskControllerTypes.NVMe, "Nvme", "csharp");
@@clientName(DiskControllerTypes.SCSI, "Scsi", "csharp");

@@clientName(LinuxConfiguration.disablePasswordAuthentication,
  "IsPasswordAuthenticationDisabled",
  "csharp"
);

@@clientName(LinuxConfiguration.provisionVMAgent,
  "IsVmAgentProvisioned",
  "csharp"
);
@@clientName(LinuxConfiguration.enableVMAgentPlatformUpdates,
  "IsVmAgentPlatformUpdatesEnabled",
  "csharp"
);
@@clientName(LinuxVMGuestPatchAutomaticByPlatformSettings.bypassPlatformSafetyChecksOnUserSchedule,
  "IsBypassPlatformSafetyChecksOnUserScheduleEnabled",
  "csharp"
);
@@clientName(Mode, "ProxyAgentExecuteMode", "csharp");
@@clientName(OSImageNotificationProfile.enable, "IsEnabled", "csharp");
@@clientName(PatchSettings, "ComputeFleetVmGuestPatchSettings", "csharp");
@@clientName(PatchSettings.enableHotpatching, "IsHotPatchingEnabled", "csharp");
@@clientName(ProxyAgentSettings.enabled, "IsEnabled", "csharp");
@@clientName(SecurityEncryptionTypes.NonPersistedTPM,
  "NonPersistedTpm",
  "csharp"
);
@@clientName(SecurityProfile.encryptionAtHost,
  "IsEncryptionAtHostEnabled",
  "csharp"
);
@@clientName(SettingNames, "AdditionalInformationSettingName", "csharp");
@@clientName(SpotPriorityProfile.maintain, "IsMaintainEnabled", "csharp");
@@clientName(SpotPriorityProfile.maxPricePerVM, "MaxPricePerVm", "csharp");
@@clientName(StorageAccountTypes.Standard_LRS, "StandardLrs", "csharp");
@@clientName(StorageAccountTypes.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(StorageAccountTypes.StandardSSD_LRS, "StandardSsdLrd", "csharp");
@@clientName(StorageAccountTypes.UltraSSD_LRS, "UltraSsdLrs", "csharp");
@@clientName(StorageAccountTypes.Premium_ZRS, "PremiumZrs", "csharp");
@@clientName(StorageAccountTypes.StandardSSD_ZRS, "StandardSsdZrs", "csharp");
@@clientName(TerminateNotificationProfile.enable, "IsEnabled", "csharp");
@@clientName(UefiSettings.secureBootEnabled, "IsSecureBootEnabled", "csharp");
@@clientName(UefiSettings.vTpmEnabled, "IsVTpmEnabled", "csharp");
@@clientName(VirtualMachineScaleSet, "ComputeFleetVmss", "csharp");
@@clientName(VirtualMachineScaleSetDataDisk,
  "ComputeFleetVmssDataDisk",
  "csharp"
);
@@clientName(VirtualMachineScaleSetDataDisk.diskIOPSReadWrite,
  "DiskIopsReadWrite",
  "csharp"
);
@@clientName(VirtualMachineScaleSetDataDisk.diskMBpsReadWrite,
  "DiskMbpsReadWrite",
  "csharp"
);
@@clientName(VirtualMachineScaleSetDataDisk.writeAcceleratorEnabled,
  "IsWriteAcceleratorEnabled",
  "csharp"
);
@@clientName(VirtualMachineScaleSetExtension,
  "ComputeFleetVmssExtension",
  "csharp"
);
@@clientName(VirtualMachineScaleSetExtension.type, "ExtensionType", "csharp");
@@clientName(VirtualMachineScaleSetExtensionProfile,
  "ComputeFleetVmssExtensionProfile",
  "csharp"
);
@@clientName(VirtualMachineScaleSetExtensionProperties,
  "ComputeFleetVmssExtensionProperties",
  "csharp"
);
@@clientName(VirtualMachineScaleSetExtensionProperties.type,
  "ExtensionType",
  "csharp"
);
@@clientName(VirtualMachineScaleSetExtensionProperties.autoUpgradeMinorVersion,
  "ShouldAutoUpgradeMinorVersion",
  "csharp"
);
@@clientName(VirtualMachineScaleSetExtensionProperties.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);
@@clientName(VirtualMachineScaleSetExtensionProperties.suppressFailures,
  "IsSuppressFailuresEnabled",
  "csharp"
);
@@clientName(VirtualMachineScaleSetHardwareProfile,
  "ComputeFleetVmssHardwareProfile",
  "csharp"
);
@@clientName(VirtualMachineScaleSetIPConfiguration,
  "ComputeFleetVmssIPConfiguration",
  "csharp"
);
@@clientName(VirtualMachineScaleSetIPConfigurationProperties,
  "ComputeFleetVmssIPConfigurationProperties",
  "csharp"
);
@@clientName(VirtualMachineScaleSetIPConfigurationProperties.primary,
  "IsPrimary",
  "csharp"
);
@@clientName(VirtualMachineScaleSetIpTag, "ComputeFleetVmssIPTag", "csharp");
@@clientName(VirtualMachineScaleSetIpTag.ipTagType, "IPTagType", "csharp");
@@clientName(VirtualMachineScaleSetManagedDiskParameters,
  "ComputeFleetVmssManagedDisk",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkConfiguration,
  "ComputeFleetVmssNetworkConfiguration",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkConfigurationDnsSettings,
  "ComputeFleetVmssNetworkDnsSettings",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties,
  "ComputeFleetVmssNetworkConfigurationProperties",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.ipConfigurations,
  "IPConfigurations",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.primary,
  "IsPrimary",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.enableAcceleratedNetworking,
  "IsAcceleratedNetworkingEnabled",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.disableTcpStateTracking,
  "IsTcpStateTrackingDisabled",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.enableFpga,
  "IsFpgaEnabled",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkConfigurationProperties.enableIPForwarding,
  "IsIPForwardingEnabled",
  "csharp"
);
@@clientName(VirtualMachineScaleSetNetworkProfile,
  "ComputeFleetVmssNetworkProfile",
  "csharp"
);
@@clientName(VirtualMachineScaleSetOSDisk, "ComputeFleetVmssOSDisk", "csharp");
@@clientName(VirtualMachineScaleSetOSDisk.osType, "OSType", "csharp");
@@clientName(VirtualMachineScaleSetOSDisk.writeAcceleratorEnabled,
  "IsWriteAcceleratorEnabled",
  "csharp"
);
@@clientName(VirtualMachineScaleSetOSProfile,
  "ComputeFleetVmssOSProfile",
  "csharp"
);
@@clientName(VirtualMachineScaleSetOSProfile.allowExtensionOperations,
  "AreExtensionOperationsAllowed",
  "csharp"
);
@@clientName(VirtualMachineScaleSetOSProfile.requireGuestProvisionSignal,
  "IsGuestProvisionSignalRequired",
  "csharp"
);
@@clientName(VirtualMachineScaleSetPublicIPAddressConfiguration,
  "ComputeFleetVmssPublicIPAddressConfiguration",
  "csharp"
);
@@clientName(VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings,
  "ComputeFleetVmssPublicIPAddressDnsSettings",
  "csharp"
);
@@clientName(VirtualMachineScaleSetPublicIPAddressConfigurationProperties,
  "ComputeFleetVmssPublicIPAddressConfigurationProperties",
  "csharp"
);
@@clientName(VirtualMachineScaleSetPublicIPAddressConfigurationProperties.ipTags,
  "IPTags",
  "csharp"
);
@@clientName(VirtualMachineScaleSetStorageProfile,
  "ComputeFleetVmssStorageProfile",
  "csharp"
);
@@clientName(VirtualMachineScaleSetStorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(VMGalleryApplication.treatFailureAsDeploymentFailure,
  "IsTreatFailureAsDeploymentFailureEnabled",
  "csharp"
);
@@clientName(VMGalleryApplication.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);
@@clientName(WindowsConfiguration.provisionVMAgent,
  "IsVmAgentProvisioned",
  "csharp"
);
@@clientName(WindowsConfiguration.enableAutomaticUpdates,
  "IsAutomaticUpdatesEnabled",
  "csharp"
);
@@clientName(WindowsConfiguration.enableVMAgentPlatformUpdates,
  "IsVmAgentPlatformUpdatesEnabled",
  "csharp"
);
@@clientName(WindowsVMGuestPatchAutomaticByPlatformSettings.bypassPlatformSafetyChecksOnUserSchedule,
  "IsBypassPlatformSafetyChecksOnUserScheduleEnabled",
  "csharp"
);
@@clientName(AdditionalCapabilities.hibernationEnabled,
  "isHibernationEnabled",
  "csharp"
);
@@clientName(AdditionalCapabilities.ultraSSDEnabled,
  "isUltraSSDEnabled",
  "csharp"
);
@@clientName(VMAttributes, "ComputeFleetVmAttributes", "csharp");
@@clientName(VMAttributes.excludedVMSizes, "ExcludedVmSizes", "csharp");
@@clientName(VMAttributeSupport, "ComputeFleetVmAttributeSupport", "csharp");
@@clientName(VMAttributeMinMaxDouble,
  "ComputeFleetVmAttributeMinMaxDouble",
  "csharp"
);
@@clientName(VMAttributeMinMaxInteger,
  "ComputeFleetVmAttributeMinMaxInteger",
  "csharp"
);
@@clientName(VMCategory, "ComputeFleetVmCategory", "csharp");
@@clientName(CapacityType, "ComputeFleetCapacityType", "csharp");
@@clientName(CapacityType.VM, "Vm", "csharp");
@@clientName(FleetMode, "ComputeFleetMode", "csharp");
@@clientName(VirtualMachine, "ComputeFleetVirtualMachine", "csharp");
@@clientName(VMOperationStatus, "ComputeFleetVmOperationStatus", "csharp");
@@clientName(ZoneAllocationPolicy,
  "ComputeFleetZoneAllocationPolicy",
  "csharp"
);
@@clientName(ZoneDistributionStrategy,
  "ComputeFleetZoneDistributionStrategy",
  "csharp"
);
@@alternateType(FleetUpdate.plan,
  Azure.ResourceManager.CommonTypes.Plan,
  "csharp"
);
@@clientName(ListVirtualMachinesParameters.$skiptoken, "skipToken", "csharp");
@@alternateType(VirtualMachineScaleSet, ComputeFleetVmss, "csharp");

// The following code is added to solve the problem that the `compute fleet vmss` class does not inherit the `resource data` class
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@doc("An AzureFleet's virtualMachineScaleSet")
model ComputeFleetVmss extends Azure.ResourceManager.CommonTypes.Resource {
  @removed(Versions.v2024_05_01_preview)
  @doc("This represents the Provisioning State of the VMSS in response to the last operation that was performed on it by Azure Fleet resource.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @added(Versions.v2024_05_01_preview)
  @doc("This represents the operationStatus of the VMSS in response to the last operation that was performed on it by Azure Fleet resource.")
  @visibility(Lifecycle.Read)
  operationStatus: ProvisioningState;

  @added(Versions.v2024_05_01_preview)
  @doc("Error Information when `operationStatus` is `Failed`")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}
