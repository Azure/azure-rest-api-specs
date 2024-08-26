import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureFleet;

@@clientName(Microsoft.AzureFleet, "ComputeFleetMgmt", "python");

@@access(Operations.list, Access.internal, "csharp");

@@clientName(ApiError, "ComputeFleetApiError", "csharp");
@@clientName(ApplicationProfile, "ComputeFleetApplicationProfile", "csharp");
@@clientName(BootDiagnostics, "ComputeFleetBootDiagnostics", "csharp");
@@clientName(CachingTypes, "ComputeFleetCachingTypes", "csharp");
@@clientName(ComputeProfile, "ComputeFleetComputeProfile", "csharp");
@@clientName(DiagnosticsProfile, "ComputeFleetDiagnosticsProfile", "csharp");
@@clientName(DiffDiskOptions, "ComputeFleetDiffDiskOptions", "csharp");
@@clientName(DiffDiskPlacement, "ComputeFleetDiffDiskPlacement", "csharp");
@@clientName(DiffDiskSettings, "ComputeFleetDiffDiskSettings", "csharp");
@@clientName(DiskControllerTypes, "ComputeFleetDiskControllerTypes", "csharp");
@@clientName(DiskCreateOptionTypes,
  "ComputeFleetDiskCreateOptionTypes",
  "csharp"
);
@@clientName(DiskDeleteOptionTypes,
  "ComputeFleetDiskDeleteOptionTypes",
  "csharp"
);
@@clientName(DomainNameLabelScopeTypes,
  "ComputeFleetDomainNameLabelScopeTypes",
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
  "ComputeFleetLinuxVMGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(LinuxVMGuestPatchAutomaticByPlatformSettings,
  "ComputeFleetLinuxVMGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(LinuxVMGuestPatchMode,
  "ComputeFleetLinuxVMGuestPatchMode",
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
@@clientName(OperatingSystemTypes,
  "ComputeFleetOperatingSystemTypes",
  "csharp"
);
@@clientName(OSImageNotificationProfile,
  "ComputeFleetOSImageNotificationProfile",
  "csharp"
);
@@clientName(ProtocolTypes, "ComputeFleetProtocolTypes", "csharp");
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
@@clientName(SecurityEncryptionTypes,
  "ComputeFleetSecurityEncryptionTypes",
  "csharp"
);
@@clientName(SecurityPostureReference,
  "ComputeFleetSecurityPostureReference",
  "csharp"
);
@@clientName(SecurityProfile, "ComputeFleetSecurityProfile", "csharp");
@@clientName(SecurityTypes, "ComputeFleetSecurityTypes", "csharp");
@@clientName(SshConfiguration, "ComputeFleetSshConfiguration", "csharp");
@@clientName(SshPublicKey, "ComputeFleetSshPublicKey", "csharp");
@@clientName(StorageAccountTypes, "ComputeFleetStorageAccountTypes", "csharp");
@@clientName(TerminateNotificationProfile,
  "ComputeFleetTerminateNotificationProfile",
  "csharp"
);
@@clientName(UefiSettings, "ComputeFleetUefiSettings", "csharp");
@@clientName(VaultCertificate, "ComputeFleetVaultCertificate", "csharp");
@@clientName(VaultSecretGroup, "ComputeFleetVaultSecretGroup", "csharp");
@@clientName(VirtualHardDisk, "ComputeFleetVirtualHardDisk", "csharp");
@@clientName(VMDiskSecurityProfile,
  "ComputeFleetVMDiskSecurityProfile",
  "csharp"
);
@@clientName(VMGalleryApplication,
  "ComputeFleetVMGalleryApplication",
  "csharp"
);
@@clientName(VmSizeProfile, "ComputeFleetVmSizeProfile", "csharp");
@@clientName(VMSizeProperties, "ComputeFleetVMSizeProperties", "csharp");
@@clientName(WindowsConfiguration,
  "ComputeFleetWindowsConfiguration",
  "csharp"
);
@@clientName(WindowsPatchAssessmentMode,
  "ComputeFleetWindowsPatchAssessmentMode",
  "csharp"
);
@@clientName(WindowsVMGuestPatchAutomaticByPlatformRebootSetting,
  "ComputeFleetWindowsVMGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(WindowsVMGuestPatchAutomaticByPlatformSettings,
  "ComputeFleetWindowsVMGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(WindowsVMGuestPatchMode,
  "ComputeFleetWindowsVMGuestPatchMode",
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

@@clientName(BootDiagnostics.enabled, "IsEnabled", "csharp");

@@clientName(DeleteOptions, "ComputeFleetVmDeleteOptions", "csharp");

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
@@clientName(SettingNames, "AdditionalInformationSettingNames", "csharp");
@@clientName(SpotPriorityProfile.maintain, "IsMaintainEnabled", "csharp");
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
@@clientName(VirtualMachineScaleSetStorageProfile,
  "ComputeFleetVmssStorageProfile",
  "csharp"
);
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
