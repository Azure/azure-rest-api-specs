// ----------------------------------------------------------------------------
// VM building-block models extracted from Compute/Compute/models.tsp.
//
// This file is the single source of truth for the inner Virtual Machine
// profile / disk / network / OS / security building blocks consumed both
// by the Compute project (this folder) and by sibling subservice projects
// (e.g. Bulkactions) that need to express the same VM shape.
//
// Do not duplicate these declarations in sibling projects; import them.
// ----------------------------------------------------------------------------

import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using Versioning;
using Azure.ResourceManager;
using Common;

namespace Compute;

/**
 * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual machines associated to virtual machine scale set with OrchestrationMode as Flexible.<br /><br /> Possible values are:<br /><br /> **Manual** - You  control the application of patches to a virtual machine. You do this by applying patches manually inside the VM. In this mode, automatic updates are disabled; the property WindowsConfiguration.enableAutomaticUpdates must be false<br /><br /> **AutomaticByOS** - The virtual machine will automatically be updated by the OS. The property WindowsConfiguration.enableAutomaticUpdates must be true. <br /><br /> **AutomaticByPlatform** - the virtual machine will automatically updated by the platform. The properties provisionVMAgent and WindowsConfiguration.enableAutomaticUpdates must be true
 */
union WindowsVMGuestPatchMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manual: "Manual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutomaticByOS: "AutomaticByOS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutomaticByPlatform: "AutomaticByPlatform",
}
/**
 * Specifies the mode of VM Guest patch assessment for the IaaS virtual machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You control the timing of patch assessments on a virtual machine.<br /><br /> **AutomaticByPlatform** - The platform will trigger periodic patch assessments. The property provisionVMAgent must be true.
 */
union WindowsPatchAssessmentMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageDefault: "ImageDefault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutomaticByPlatform: "AutomaticByPlatform",
}
/**
 * Specifies the reboot setting for all AutomaticByPlatform patch installation operations.
 */
union WindowsVMGuestPatchAutomaticByPlatformRebootSetting {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IfRequired: "IfRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Never: "Never",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Always: "Always",
}
/**
 * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual machines associated to virtual machine scale set with OrchestrationMode as Flexible.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - The virtual machine's default patching configuration is used. <br /><br /> **AutomaticByPlatform** - The virtual machine will be automatically updated by the platform. The property provisionVMAgent must be true
 */
union LinuxVMGuestPatchMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageDefault: "ImageDefault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutomaticByPlatform: "AutomaticByPlatform",
}
/**
 * Specifies the mode of VM Guest Patch Assessment for the IaaS virtual machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You control the timing of patch assessments on a virtual machine. <br /><br /> **AutomaticByPlatform** - The platform will trigger periodic patch assessments. The property provisionVMAgent must be true.
 */
union LinuxPatchAssessmentMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageDefault: "ImageDefault",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutomaticByPlatform: "AutomaticByPlatform",
}
/**
 * Specifies the reboot setting for all AutomaticByPlatform patch installation operations.
 */
union LinuxVMGuestPatchAutomaticByPlatformRebootSetting {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IfRequired: "IfRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Never: "Never",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Always: "Always",
}
/**
 * Specifies how the virtual machine disk should be created. Possible values are **Attach:** This value is used when you are using a specialized disk to create the virtual machine. **FromImage:** This value is used when you are using an image to create the virtual machine. If you are using a platform image, you should also use the imageReference element described above. If you are using a marketplace image, you should also use the plan element previously described. **Empty:** This value is used when creating an empty data disk. **Copy:** This value is used to create a data disk from a snapshot or another disk. **Restore:** This value is used to create a data disk from a disk restore point.
 */
union DiskCreateOptionTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FromImage: "FromImage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Empty: "Empty",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Attach: "Attach",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Copy: "Copy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restore: "Restore",
}
/**
 * Specifies the ephemeral disk option for operating system disk.
 */
union DiffDiskOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Local: "Local",
}
/**
 * Specifies the ephemeral disk placement for operating system disk. This property can be used by user in the request to choose the location i.e, cache disk, resource disk or nvme disk space for Ephemeral OS disk provisioning. For more information on Ephemeral OS disk size requirements, please refer Ephemeral OS disk size requirements for Windows VM at https://docs.microsoft.com/azure/virtual-machines/windows/ephemeral-os-disks#size-requirements and Linux VM at https://docs.microsoft.com/azure/virtual-machines/linux/ephemeral-os-disks#size-requirements. Minimum api-version for NvmeDisk: 2024-03-01.
 */
union DiffDiskPlacement {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CacheDisk: "CacheDisk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceDisk: "ResourceDisk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NvmeDisk: "NvmeDisk",
}
/**
 * Specifies the storage account type for the managed disk. Managed OS disk storage account type can only be set when you create the scale set. NOTE: UltraSSD_LRS can only be used with data disks. It cannot be used with OS Disk. Standard_LRS uses Standard HDD. StandardSSD_LRS uses Standard SSD. Premium_LRS uses Premium SSD. UltraSSD_LRS uses Ultra disk. Premium_ZRS uses Premium SSD zone redundant storage. StandardSSD_ZRS uses Standard SSD zone redundant storage. For more information regarding disks supported for Windows Virtual Machines, refer to https://docs.microsoft.com/azure/virtual-machines/windows/disks-types and, for Linux Virtual Machines, refer to https://docs.microsoft.com/azure/virtual-machines/linux/disks-types
 */
union StorageAccountTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_LRS: "Standard_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium_LRS: "Premium_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StandardSSD_LRS: "StandardSSD_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UltraSSD_LRS: "UltraSSD_LRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium_ZRS: "Premium_ZRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StandardSSD_ZRS: "StandardSSD_ZRS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PremiumV2_LRS: "PremiumV2_LRS",
}
/**
 * Specifies the EncryptionType of the managed disk. It is set to DiskWithVMGuestState for encryption of the managed disk along with VMGuestState blob, VMGuestStateOnly for encryption of just the VMGuestState blob, and NonPersistedTPM for not persisting firmware state in the VMGuestState blob.. **Note:** It can be set for only Confidential VMs.
 */
union SecurityEncryptionTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VMGuestStateOnly: "VMGuestStateOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DiskWithVMGuestState: "DiskWithVMGuestState",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NonPersistedTPM: "NonPersistedTPM",
}
/**
 * Specifies the behavior of the managed disk when the VM gets deleted, for example whether the managed disk is deleted or detached. Supported values are: **Delete.** If this value is used, the managed disk is deleted when VM gets deleted. **Detach.** If this value is used, the managed disk is retained after VM gets deleted. Minimum api-version: 2021-03-01.
 */
union DiskDeleteOptionTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Detach: "Detach",
}
/**
 * The Domain name label scope.The concatenation of the hashed domain name label that generated according to the policy from domain name label scope and vm index will be the domain name labels of the PublicIPAddress resources that will be created
 */
union DomainNameLabelScopeTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TenantReuse: "TenantReuse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SubscriptionReuse: "SubscriptionReuse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceGroupReuse: "ResourceGroupReuse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoReuse: "NoReuse",
}
/**
 * Available from Api-Version 2017-03-30 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible values are: 'IPv4' and 'IPv6'.
 */
union IPVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPv4: "IPv4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPv6: "IPv6",
}
/**
 * Specify what happens to the network interface when the VM is deleted
 */
union DeleteOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Detach: "Detach",
}
/**
 * Specify public IP sku name
 */
union PublicIPAddressSkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
}
/**
 * Specify public IP sku tier
 */
union PublicIPAddressSkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Regional: "Regional",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Global: "Global",
}
/**
 * Specifies whether the Auxiliary mode is enabled for the Network Interface resource.
 */
union NetworkInterfaceAuxiliaryMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AcceleratedConnections: "AcceleratedConnections",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Floating: "Floating",
}
/**
 * Specifies whether the Auxiliary sku is enabled for the Network Interface resource.
 */
union NetworkInterfaceAuxiliarySku {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  A1: "A1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  A2: "A2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  A4: "A4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  A8: "A8",
}
/**
 * specifies the Microsoft.Network API version used when creating networking resources in the Network Interface Configurations
 */
union NetworkApiVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `2020-11-01`: "2020-11-01",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `2022-11-01`: "2022-11-01",
}
/**
 * Specifies the VM securityType; UefiSettings are enabled only when set to TrustedLaunch or ConfidentialVM, and returns a Standard value starting API version 2025-11-01.
 */
union SecurityTypes {
  string,

  /**
   * Indicates a VM without UEFI features such as SecureBoot or vTPM; returned as the default value when securityType is not specified.
   */
  @added(Versions.v2025_11_01)
  Standard: "Standard",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TrustedLaunch: "TrustedLaunch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ConfidentialVM: "ConfidentialVM",
}
/**
 * Specifies the mode that ProxyAgent will execute on if the feature is enabled. ProxyAgent will start to audit or monitor but not enforce access control over requests to host endpoints in Audit mode, while in Enforce mode it will enforce access control. The default value is Enforce mode.
 */
union Mode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Audit: "Audit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enforce: "Enforce",
}
/**
 * Specifies the execution mode. In Audit mode, the system acts as if it is enforcing the access control policy, including emitting access denial entries in the logs but it does not actually deny any requests to host endpoints. In Enforce mode, the system will enforce the access control and it is the recommended mode of operation.
 */
union Modes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Audit: "Audit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enforce: "Enforce",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}
/**
 * Specifies the detach behavior to be used while detaching a disk or which is already in the process of detachment from the virtual machine. Supported values are: **ForceDetach.** detachOption: **ForceDetach** is applicable only for managed data disks. If a previous detachment attempt of the data disk did not complete due to an unexpected failure from the virtual machine and the disk is still not released then use force-detach as a last resort option to detach the disk forcibly from the VM. All writes might not have been flushed when using this detach behavior. **This feature is still in preview**. To force-detach a data disk update toBeDetached to 'true' along with setting detachOption: 'ForceDetach'.
 */
union DiskDetachOptionTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ForceDetach: "ForceDetach",
}
/**
 * Specifies the disk controller type configured for the VM and VirtualMachineScaleSet. This property is only supported for virtual machines whose operating system disk and VM sku supports Generation 2 (https://docs.microsoft.com/en-us/azure/virtual-machines/generation-2), please check the HyperVGenerations capability returned as part of VM sku capabilities in the response of Microsoft.Compute SKUs api for the region contains V2 (https://docs.microsoft.com/rest/api/compute/resourceskus/list). For more information about Disk Controller Types supported please refer to https://aka.ms/azure-diskcontrollertypes.
 */
union DiskControllerTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SCSI: "SCSI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NVMe: "NVMe",
}
/**
 * Available from Api-Version 2017-03-30 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible values are: 'IPv4' and 'IPv6'.
 */
union IPVersions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPv4: "IPv4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IPv6: "IPv6",
}
/**
 * Specify the public IP allocation type
 */
union PublicIPAllocationMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Dynamic: "Dynamic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Static: "Static",
}
/**
 * Specifies the name of the setting to which the content applies. Possible values are: FirstLogonCommands and AutoLogon.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SettingNames {
  AutoLogon,
  FirstLogonCommands,
}
/**
 * Specifies the protocol of WinRM listener. Possible values are: **http,** **https.**
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ProtocolTypes {
  Http,
  Https,
}
/**
 * Specifies the caching requirements. Possible values are: **None,** **ReadOnly,** **ReadWrite.** The default values are: **None for Standard storage. ReadOnly for Premium storage**
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum CachingTypes {
  None,
  ReadOnly,
  ReadWrite,
}
/**
 * Specifies Redeploy, Reboot and ScheduledEventsAdditionalPublishingTargets Scheduled Event related configurations.
 */
model ScheduledEventsPolicy {
  /**
   * The configuration parameters used while creating userInitiatedRedeploy scheduled event setting creation.
   */
  userInitiatedRedeploy?: UserInitiatedRedeploy;

  /**
   * The configuration parameters used while creating userInitiatedReboot scheduled event setting creation.
   */
  userInitiatedReboot?: UserInitiatedReboot;

  /**
   * The configuration parameters used while publishing scheduledEventsAdditionalPublishingTargets.
   */
  scheduledEventsAdditionalPublishingTargets?: ScheduledEventsAdditionalPublishingTargets;

  /**
   * The configuration parameters used while creating AllInstancesDown scheduled event setting creation.
   */
  @added(Versions.v2025_04_01)
  allInstancesDown?: AllInstancesDown;
}
/**
 * Specifies Redeploy related Scheduled Event related configurations.
 */
model UserInitiatedRedeploy {
  /**
   * Specifies Redeploy Scheduled Event related configurations.
   */
  automaticallyApprove?: boolean;
}
/**
 * Specifies Reboot related Scheduled Event related configurations.
 */
model UserInitiatedReboot {
  /**
   * Specifies Reboot Scheduled Event related configurations.
   */
  automaticallyApprove?: boolean;
}
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ScheduledEventsAdditionalPublishingTargets {
  /**
   * The configuration parameters used while creating eventGridAndResourceGraph Scheduled Event setting.
   */
  eventGridAndResourceGraph?: EventGridAndResourceGraph;
}
/**
 * Specifies eventGridAndResourceGraph related Scheduled Event related configurations.
 */
model EventGridAndResourceGraph {
  /**
   * Specifies if event grid and resource graph is enabled for Scheduled event related configurations.
   */
  enable?: boolean;

  /**
   * Specifies the api-version to determine which Scheduled Events configuration schema version will be delivered.
   */
  @added(Versions.v2025_04_01)
  scheduledEventsApiVersion?: string;
}
/**
 * Specifies if Scheduled Events should be auto-approved when all instances are down.
 */
@added(Versions.v2025_04_01)
model AllInstancesDown {
  /**
   * Specifies if Scheduled Events should be auto-approved when all instances are down.
   * its default value is true
   */
  @added(Versions.v2025_04_01)
  automaticallyApprove?: boolean;
}
/**
 * Specifies Windows operating system settings on the virtual machine.
 */
model WindowsConfiguration {
  /**
   * Indicates whether virtual machine agent should be provisioned on the virtual machine. When this property is not specified in the request body, it is set to true by default. This will ensure that VM Agent is installed on the VM so that extensions can be added to the VM later.
   */
  provisionVMAgent?: boolean;

  /**
   * Indicates whether Automatic Updates is enabled for the Windows virtual machine. Default value is true. For virtual machine scale sets, this property can be updated and updates will take effect on OS reprovisioning.
   */
  enableAutomaticUpdates?: boolean;

  /**
   * Specifies the time zone of the virtual machine. e.g. "Pacific Standard Time". Possible values can be [TimeZoneInfo.Id](https://docs.microsoft.com/dotnet/api/system.timezoneinfo.id?#System_TimeZoneInfo_Id) value from time zones returned by [TimeZoneInfo.GetSystemTimeZones](https://docs.microsoft.com/dotnet/api/system.timezoneinfo.getsystemtimezones).
   */
  timeZone?: string;

  /**
   * Specifies additional base-64 encoded XML formatted information that can be included in the Unattend.xml file, which is used by Windows Setup.
   */
  @identifiers(#[])
  additionalUnattendContent?: AdditionalUnattendContent[];

  /**
   * [Preview Feature] Specifies settings related to VM Guest Patching on Windows.
   */
  patchSettings?: PatchSettings;

  /**
   * Specifies the Windows Remote Management listeners. This enables remote Windows PowerShell.
   */
  winRM?: WinRMConfiguration;

  /**
   * Indicates whether VMAgent Platform Updates are enabled for the Windows Virtual Machine.
   */
  @visibility(Lifecycle.Read)
  enableVMAgentPlatformUpdates?: boolean;
}
/**
 * Specifies additional XML formatted information that can be included in the Unattend.xml file, which is used by Windows Setup. Contents are defined by setting name, component name, and the pass in which the content is applied.
 */
model AdditionalUnattendContent {
  /**
   * The pass name. Currently, the only allowable value is OobeSystem.
   */
  passName?: PassNames;

  /**
   * The component name. Currently, the only allowable value is Microsoft-Windows-Shell-Setup.
   */
  componentName?: ComponentNames;

  /**
   * Specifies the name of the setting to which the content applies. Possible values are: FirstLogonCommands and AutoLogon.
   */
  settingName?: SettingNames;

  /**
   * Specifies the XML formatted content that is added to the unattend.xml file for the specified path and component. The XML must be less than 4KB and must include the root element for the setting or feature that is being inserted.
   */
  content?: string;
}
/**
 * Specifies settings related to VM Guest Patching on Windows.
 */
model PatchSettings {
  /**
   * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual machines associated to virtual machine scale set with OrchestrationMode as Flexible.<br /><br /> Possible values are:<br /><br /> **Manual** - You  control the application of patches to a virtual machine. You do this by applying patches manually inside the VM. In this mode, automatic updates are disabled; the property WindowsConfiguration.enableAutomaticUpdates must be false<br /><br /> **AutomaticByOS** - The virtual machine will automatically be updated by the OS. The property WindowsConfiguration.enableAutomaticUpdates must be true. <br /><br /> **AutomaticByPlatform** - the virtual machine will automatically updated by the platform. The properties provisionVMAgent and WindowsConfiguration.enableAutomaticUpdates must be true
   */
  patchMode?: WindowsVMGuestPatchMode;

  /**
   * Enables customers to patch their Azure VMs without requiring a reboot. For enableHotpatching, the 'provisionVMAgent' must be set to true and 'patchMode' must be set to 'AutomaticByPlatform'.
   */
  enableHotpatching?: boolean;

  /**
   * Specifies the mode of VM Guest patch assessment for the IaaS virtual machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You control the timing of patch assessments on a virtual machine.<br /><br /> **AutomaticByPlatform** - The platform will trigger periodic patch assessments. The property provisionVMAgent must be true.
   */
  assessmentMode?: WindowsPatchAssessmentMode;

  /**
   * Specifies additional settings for patch mode AutomaticByPlatform in VM Guest Patching on Windows.
   */
  automaticByPlatformSettings?: WindowsVMGuestPatchAutomaticByPlatformSettings;
}
/**
 * Specifies additional settings to be applied when patch mode AutomaticByPlatform is selected in Windows patch settings.
 */
model WindowsVMGuestPatchAutomaticByPlatformSettings {
  /**
   * Specifies the reboot setting for all AutomaticByPlatform patch installation operations.
   */
  rebootSetting?: WindowsVMGuestPatchAutomaticByPlatformRebootSetting;

  /**
   * Enables customer to schedule patching without accidental upgrades
   */
  bypassPlatformSafetyChecksOnUserSchedule?: boolean;
}
/**
 * Describes Windows Remote Management configuration of the VM
 */
model WinRMConfiguration {
  /**
   * The list of Windows Remote Management listeners
   */
  @identifiers(#[])
  listeners?: WinRMListener[];
}
/**
 * Describes Protocol and thumbprint of Windows Remote Management listener
 */
model WinRMListener {
  /**
   * Specifies the protocol of WinRM listener. Possible values are: **http,** **https.**
   */
  protocol?: ProtocolTypes;

  /**
   * This is the URL of a certificate that has been uploaded to Key Vault as a secret. For adding a secret to the Key Vault, see [Add a key or secret to the key vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add). In this case, your certificate needs to be the Base64 encoding of the following JSON Object which is encoded in UTF-8: <br><br> {<br>  "data":"<Base64-encoded-certificate>",<br>  "dataType":"pfx",<br>  "password":"<pfx-file-password>"<br>} <br> To install certificates on a virtual machine it is recommended to use the [Azure Key Vault virtual machine extension for Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux) or the [Azure Key Vault virtual machine extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  certificateUrl?: string;
}
/**
 * Specifies the Linux operating system settings on the virtual machine. For a list of supported Linux distributions, see [Linux on Azure-Endorsed Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).
 */
model LinuxConfiguration {
  /**
   * Specifies whether password authentication should be disabled.
   */
  disablePasswordAuthentication?: boolean;

  /**
   * Specifies the ssh key configuration for a Linux OS.
   */
  ssh?: SshConfiguration;

  /**
   * Indicates whether virtual machine agent should be provisioned on the virtual machine. When this property is not specified in the request body, default behavior is to set it to true. This will ensure that VM Agent is installed on the VM so that extensions can be added to the VM later.
   */
  provisionVMAgent?: boolean;

  /**
   * [Preview Feature] Specifies settings related to VM Guest Patching on Linux.
   */
  patchSettings?: LinuxPatchSettings;

  /**
   * Indicates whether VMAgent Platform Updates is enabled for the Linux virtual machine. Default value is false.
   */
  enableVMAgentPlatformUpdates?: boolean;
}
/**
 * SSH configuration for Linux based VMs running on Azure
 */
model SshConfiguration {
  /**
   * The list of SSH public keys used to authenticate with linux based VMs.
   */
  @identifiers(#["path"])
  publicKeys?: SshPublicKey[];
}
/**
 * Contains information about SSH certificate public key and the path on the Linux VM where the public key is placed.
 */
model SshPublicKey {
  /**
   * Specifies the full path on the created VM where ssh public key is stored. If the file already exists, the specified key is appended to the file. Example: /home/user/.ssh/authorized_keys
   */
  path?: string;

  /**
   * SSH public key certificate used to authenticate with the VM through ssh. The key needs to be at least 2048-bit and in ssh-rsa format. For creating ssh keys, see [Create SSH keys on Linux and Mac for Linux VMs in Azure]https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).
   */
  keyData?: string;
}
/**
 * Specifies settings related to VM Guest Patching on Linux.
 */
model LinuxPatchSettings {
  /**
   * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual machines associated to virtual machine scale set with OrchestrationMode as Flexible.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - The virtual machine's default patching configuration is used. <br /><br /> **AutomaticByPlatform** - The virtual machine will be automatically updated by the platform. The property provisionVMAgent must be true
   */
  patchMode?: LinuxVMGuestPatchMode;

  /**
   * Specifies the mode of VM Guest Patch Assessment for the IaaS virtual machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You control the timing of patch assessments on a virtual machine. <br /><br /> **AutomaticByPlatform** - The platform will trigger periodic patch assessments. The property provisionVMAgent must be true.
   */
  assessmentMode?: LinuxPatchAssessmentMode;

  /**
   * Specifies additional settings for patch mode AutomaticByPlatform in VM Guest Patching on Linux.
   */
  automaticByPlatformSettings?: LinuxVMGuestPatchAutomaticByPlatformSettings;
}
/**
 * Specifies additional settings to be applied when patch mode AutomaticByPlatform is selected in Linux patch settings.
 */
model LinuxVMGuestPatchAutomaticByPlatformSettings {
  /**
   * Specifies the reboot setting for all AutomaticByPlatform patch installation operations.
   */
  rebootSetting?: LinuxVMGuestPatchAutomaticByPlatformRebootSetting;

  /**
   * Enables customer to schedule patching without accidental upgrades
   */
  bypassPlatformSafetyChecksOnUserSchedule?: boolean;
}
/**
 * Describes a set of certificates which are all in the same Key Vault.
 */
model VaultSecretGroup {
  /**
   * The relative URL of the Key Vault containing all of the certificates in VaultCertificates.
   */
  sourceVault?: SubResource;

  /**
   * The list of key vault references in SourceVault which contain certificates.
   */
  @identifiers(#["certificateUrl"])
  vaultCertificates?: VaultCertificate[];
}
/**
 * Describes a single certificate reference in a Key Vault, and where the certificate should reside on the VM.
 */
model VaultCertificate {
  /**
   * This is the URL of a certificate that has been uploaded to Key Vault as a secret. For adding a secret to the Key Vault, see [Add a key or secret to the key vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add). In this case, your certificate needs to be It is the Base64 encoding of the following JSON Object which is encoded in UTF-8: <br><br> {<br>  "data":"<Base64-encoded-certificate>",<br>  "dataType":"pfx",<br>  "password":"<pfx-file-password>"<br>} <br> To install certificates on a virtual machine it is recommended to use the [Azure Key Vault virtual machine extension for Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux) or the [Azure Key Vault virtual machine extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  certificateUrl?: string;

  /**
   * For Windows VMs, specifies the certificate store on the Virtual Machine to which the certificate should be added. The specified certificate store is implicitly in the LocalMachine account. For Linux VMs, the certificate file is placed under the /var/lib/waagent directory, with the file name &lt;UppercaseThumbprint&gt;.crt for the X509 certificate file and &lt;UppercaseThumbprint&gt;.prv for private key. Both of these files are .pem formatted.
   */
  certificateStore?: string;
}
/**
 * Specifies information about the image to use. You can specify information about platform images, marketplace images, or virtual machine images. This element is required when you want to use a platform image, marketplace image, or virtual machine image, but is not used in other creation operations. NOTE: Image reference publisher and offer can only be set when you create the scale set.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageReference extends SubResource {
  /**
   * The image publisher.
   */
  publisher?: string;

  /**
   * Specifies the offer of the platform image or marketplace image used to create the virtual machine.
   */
  offer?: string;

  /**
   * The image SKU.
   */
  sku?: string;

  /**
   * Specifies the version of the platform image or marketplace image used to create the virtual machine. The allowed formats are Major.Minor.Build or 'latest'. Major, Minor, and Build are decimal numbers. Specify 'latest' to use the latest version of an image available at deploy time. Even if you use 'latest', the VM image will not automatically update after deploy time even if a new version becomes available. Please do not use field 'version' for gallery image deployment, gallery image should always use 'id' field for deployment, to use 'latest' version of gallery image, just set '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/images/{imageName}' in the 'id' field without version input.
   */
  version?: string;

  /**
   * Specifies in decimal numbers, the version of platform image or marketplace image used to create the virtual machine. This readonly field differs from 'version', only if the value specified in 'version' field is 'latest'.
   */
  @visibility(Lifecycle.Read)
  exactVersion?: string;

  /**
   * Specified the shared gallery image unique id for vm deployment. This can be fetched from shared gallery image GET call.
   */
  sharedGalleryImageId?: string;

  /**
   * Specified the community gallery image unique id for vm deployment. This can be fetched from community gallery image GET call.
   */
  communityGalleryImageId?: string;
}
/**
 * Describes the parameters of ephemeral disk settings that can be specified for operating system disk. **Note:** The ephemeral disk settings can only be specified for managed disk.
 */
model DiffDiskSettings {
  /**
   * Specifies the ephemeral disk settings for operating system disk.
   */
  option?: DiffDiskOptions;

  /**
   * Specifies the ephemeral disk placement for operating system disk. Possible values are: **CacheDisk,** **ResourceDisk,** **NvmeDisk.** The defaulting behavior is: **CacheDisk** if one is configured for the VM size otherwise **ResourceDisk** or **NvmeDisk** is used. Refer to the VM size documentation for Windows VM at https://docs.microsoft.com/azure/virtual-machines/windows/sizes and Linux VM at https://docs.microsoft.com/azure/virtual-machines/linux/sizes to check which VM sizes exposes a cache disk. Minimum api-version for NvmeDisk: 2024-03-01.
   */
  placement?: DiffDiskPlacement;

  /**
   * Specifies whether or not to enable full caching for this VM which will cache the OS disk locally on the host and make this VM more resilient to storage outages
   */
  @added(Versions.v2025_11_01)
  enableFullCaching?: boolean;
}
/**
 * Describes the uri of a disk.
 */
model VirtualHardDisk {
  /**
   * Specifies the virtual hard disk's uri.
   */
  uri?: string;
}
/**
 * Describes the parameter of customer managed disk encryption set resource id that can be specified for disk. **Note:** The disk encryption set resource id can only be specified for managed disk. Please refer https://aka.ms/mdssewithcmkoverview for more details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
model DiskEncryptionSetParameters extends SubResource {}
/**
 * Specifies the security profile settings for the managed disk. **Note:** It can only be set for Confidential VMs.
 */
model VMDiskSecurityProfile {
  /**
   * Specifies the EncryptionType of the managed disk. It is set to DiskWithVMGuestState for encryption of the managed disk along with VMGuestState blob, VMGuestStateOnly for encryption of just the VMGuestState blob, and NonPersistedTPM for not persisting firmware state in the VMGuestState blob.. **Note:** It can be set for only Confidential VMs.
   */
  securityEncryptionType?: SecurityEncryptionTypes;

  /**
   * Specifies the customer managed disk encryption set resource id for the managed disk that is used for Customer Managed Key encrypted ConfidentialVM OS Disk and VMGuest blob.
   */
  diskEncryptionSet?: DiskEncryptionSetParameters;
}
/**
 * The API entity reference.
 */
model ApiEntityReference {
  /**
   * The ARM resource id in the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/...
   */
  id?: string;
}
/**
 * Describes the public IP Sku. It can only be set with OrchestrationMode as Flexible.
 */
model PublicIPAddressSku {
  /**
   * Specify public IP sku name
   */
  name?: PublicIPAddressSkuName;

  /**
   * Specify public IP sku tier
   */
  tier?: PublicIPAddressSkuTier;
}
/**
 * Specifies the Security profile settings for the virtual machine or virtual machine scale set.
 */
model SecurityProfile {
  /**
   * Specifies the security settings like secure boot and vTPM used while creating the virtual machine. Minimum api-version: 2020-12-01.
   */
  uefiSettings?: UefiSettings;

  /**
   * This property can be used by user in the request to enable or disable the Host Encryption for the virtual machine or virtual machine scale set. This will enable the encryption for all the disks including Resource/Temp disk at host itself. The default behavior is: The Encryption at host will be disabled unless this property is set to true for the resource.
   */
  encryptionAtHost?: boolean;

  /**
   * Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings. The default behavior is: UefiSettings will not be enabled unless this property is set and is not Standard. If not specified, Standard will be returned starting api version 2025-11-01.
   */
  securityType?: SecurityTypes;

  /**
   * Specifies the Managed Identity used by ADE to get access token for keyvault operations.
   */
  encryptionIdentity?: EncryptionIdentity;

  /**
   * Specifies ProxyAgent settings while creating the virtual machine. Minimum api-version: 2023-09-01.
   */
  proxyAgentSettings?: ProxyAgentSettings;
}
/**
 * Specifies the security settings like secure boot and vTPM used while creating the virtual machine. Minimum api-version: 2020-12-01.
 */
model UefiSettings {
  /**
   * Specifies whether secure boot should be enabled on the virtual machine. Minimum api-version: 2020-12-01.
   */
  secureBootEnabled?: boolean;

  /**
   * Specifies whether vTPM should be enabled on the virtual machine. Minimum api-version: 2020-12-01.
   */
  vTpmEnabled?: boolean;
}
/**
 * Specifies the Managed Identity used by ADE to get access token for keyvault operations.
 */
model EncryptionIdentity {
  /**
   * Specifies ARM Resource ID of one of the user identities associated with the VM.
   */
  userAssignedIdentityResourceId?: string;
}
/**
 * Specifies ProxyAgent settings for the virtual machine or virtual machine scale set. Minimum api-version: 2023-09-01.
 */
model ProxyAgentSettings {
  /**
   * Specifies whether ProxyAgent feature should be enabled on the virtual machine or virtual machine scale set.
   */
  enabled?: boolean;

  /**
   * Specifies the mode that ProxyAgent will execute on. Warning: this property has been deprecated, please specify 'mode' under particular hostendpoint setting.
   */
  mode?: Mode;

  /**
   * Increase the value of this property allows users to reset the key used for securing communication channel between guest and host.
   */
  keyIncarnationId?: int32;

  /**
   * Specifies the Wire Server endpoint settings while creating the virtual machine or virtual machine scale set. Minimum api-version: 2024-03-01.
   */
  wireServer?: HostEndpointSettings;

  /**
   * Specifies the IMDS endpoint settings while creating the virtual machine or virtual machine scale set. Minimum api-version: 2024-03-01.
   */
  imds?: HostEndpointSettings;

  /**
   * Specify whether to implicitly install the ProxyAgent Extension. This option is currently applicable only for Linux Os.
   */
  @added(Versions.v2025_04_01)
  addProxyAgentExtension?: boolean;
}
/**
 * Specifies particular host endpoint settings.
 */
model HostEndpointSettings {
  /**
   * Specifies the execution mode. In Audit mode, the system acts as if it is enforcing the access control policy, including emitting access denial entries in the logs but it does not actually deny any requests to host endpoints. In Enforce mode, the system will enforce the access control and it is the recommended mode of operation.
   */
  mode?: Modes;

  /**
   * Specifies the InVMAccessControlProfileVersion resource id in the format of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/inVMAccessControlProfiles/{profile}/versions/{version}
   */
  inVMAccessControlProfileReferenceId?: string;
}
/**
 * Specifies the boot diagnostic settings state. Minimum api-version: 2015-06-15.
 */
model DiagnosticsProfile {
  /**
   * Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. **NOTE**: If storageUri is being specified then ensure that the storage account is in the same region and subscription as the VM. You can easily view the output of your console log. Azure also enables you to see a screenshot of the VM from the hypervisor.
   */
  bootDiagnostics?: BootDiagnostics;
}
/**
 * Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. You can easily view the output of your console log. Azure also enables you to see a screenshot of the VM from the hypervisor.
 */
model BootDiagnostics {
  /**
   * Whether boot diagnostics should be enabled on the Virtual Machine.
   */
  enabled?: boolean;

  /**
   * Uri of the storage account to use for placing the console output and screenshot. If storageUri is not specified while enabling boot diagnostics, managed storage will be used.
   */
  storageUri?: string;
}
/**
 * Describes a reference to Key Vault Secret
 */
model KeyVaultSecretReference {
  /**
   * The URL referencing a secret in a Key Vault.
   */
  secretUrl: string;

  /**
   * The relative URL of the Key Vault containing the secret.
   */
  sourceVault: SubResource;
}
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ScheduledEventsProfile {
  /**
   * Specifies Terminate Scheduled Event related configurations.
   */
  terminateNotificationProfile?: TerminateNotificationProfile;

  /**
   * Specifies OS Image Scheduled Event related configurations.
   */
  osImageNotificationProfile?: OSImageNotificationProfile;
}
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TerminateNotificationProfile {
  /**
   * Configurable length of time a Virtual Machine being deleted will have to potentially approve the Terminate Scheduled Event before the event is auto approved (timed out). The configuration must be specified in ISO 8601 format, the default value is 5 minutes (PT5M)
   */
  notBeforeTimeout?: string;

  /**
   * Specifies whether the Terminate Scheduled event is enabled or disabled.
   */
  enable?: boolean;
}
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OSImageNotificationProfile {
  /**
   * Length of time a Virtual Machine being reimaged or having its OS upgraded will have to potentially approve the OS Image Scheduled Event before the event is auto approved (timed out). The configuration is specified in ISO 8601 format, and the value must be 15 minutes (PT15M)
   */
  notBeforeTimeout?: string;

  /**
   * Specifies whether the OS Image Scheduled event is enabled or disabled.
   */
  enable?: boolean;
}
/**
 * The parameters of a capacity reservation Profile.
 */
model CapacityReservationProfile {
  /**
   * Specifies the capacity reservation group resource id that should be used for allocating the virtual machine or scaleset vm instances provided enough capacity has been reserved. Please refer to https://aka.ms/CapacityReservation for more details.
   */
  capacityReservationGroup?: SubResource;
}
/**
 * Contains the list of gallery applications that should be made available to the VM/VMSS
 */
model ApplicationProfile {
  /**
   * Specifies the gallery applications that should be made available to the VM/VMSS
   */
  @identifiers(#["packageReferenceId"])
  galleryApplications?: VMGalleryApplication[];
}
/**
 * Specifies the required information to reference a compute gallery application version
 */
model VMGalleryApplication {
  /**
   * Optional, Specifies a passthrough value for more generic context.
   */
  tags?: string;

  /**
   * Optional, Specifies the order in which the packages have to be installed
   */
  order?: int32;

  /**
   * Specifies the GalleryApplicationVersion resource id on the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{application}/versions/{version}
   */
  packageReferenceId: string;

  /**
   * Optional, Specifies the uri to an azure blob that will replace the default configuration for the package if provided
   */
  configurationReference?: string;

  /**
   * Optional, If true, any failure for any operation in the VmApplication will fail the deployment
   */
  treatFailureAsDeploymentFailure?: boolean;

  /**
   * If set to true, when a new Gallery Application version is available in PIR/SIG, it will be automatically updated for the VM/VMSS
   */
  enableAutomaticUpgrade?: boolean;
}
/**
 * Specifies VM Size Property settings on the virtual machine.
 */
model VMSizeProperties {
  /**
   * Specifies the number of vCPUs available for the VM. When this property is not specified in the request body the default behavior is to set it to the value of vCPUs available for that VM size exposed in api response of [List all available virtual machine sizes in a region](https://docs.microsoft.com/en-us/rest/api/compute/resource-skus/list).
   */
  vCPUsAvailable?: int32;

  /**
   * Specifies the vCPU to physical core ratio. When this property is not specified in the request body the default behavior is set to the value of vCPUsPerCore for the VM Size exposed in api response of [List all available virtual machine sizes in a region](https://docs.microsoft.com/en-us/rest/api/compute/resource-skus/list). **Setting this property to 1 also means that hyper-threading is disabled.**
   */
  vCPUsPerCore?: int32;
}
/**
 * Enables or disables a capability on the virtual machine or virtual machine scale set.
 */
model AdditionalCapabilities {
  /**
   * The flag that enables or disables a capability to have one or more managed data disks with UltraSSD_LRS storage account type on the VM or VMSS. Managed disks with storage account type UltraSSD_LRS can be added to a virtual machine or virtual machine scale set only if this property is enabled.
   */
  ultraSSDEnabled?: boolean;

  /**
   * The flag that enables or disables hibernation capability on the VM.
   */
  hibernationEnabled?: boolean;

  /**
   * The flag enables the usage of FIPS 140-3 compliant cryptography on the protectedSettings of an extension. Learn more at: https://aka.ms/linuxagentfipssupport.
   */
  @added(Versions.v2025_04_01)
  enableFips1403Encryption?: boolean;
}
/**
 * Describes a Encryption Settings for a Disk
 */
model DiskEncryptionSettings {
  /**
   * Specifies the location of the disk encryption key, which is a Key Vault Secret.
   */
  diskEncryptionKey?: KeyVaultSecretReference;

  /**
   * Specifies the location of the key encryption key in Key Vault.
   */
  keyEncryptionKey?: KeyVaultKeyReference;

  /**
   * Specifies whether disk encryption should be enabled on the virtual machine.
   */
  enabled?: boolean;
}
/**
 * Describes a reference to Key Vault Key
 */
model KeyVaultKeyReference {
  /**
   * The URL referencing a key encryption key in Key Vault.
   */
  keyUrl: string;

  /**
   * The relative URL of the Key Vault containing the key.
   */
  sourceVault: SubResource;
}
/**
 * Specifies the hardware settings for the virtual machine.
 */
model HardwareProfile {
  /**
   * Specifies the size of the virtual machine. The enum data type is currently deprecated and will be removed by December 23rd 2023. The recommended way to get the list of available sizes is using these APIs: [List all available virtual machine sizes in an availability set](https://docs.microsoft.com/rest/api/compute/availabilitysets/listavailablesizes), [List all available virtual machine sizes in a region]( https://docs.microsoft.com/rest/api/compute/resourceskus/list), [List all available virtual machine sizes for resizing](https://docs.microsoft.com/rest/api/compute/virtualmachines/listavailablesizes). For more information about virtual machine sizes, see [Sizes for virtual machines](https://docs.microsoft.com/azure/virtual-machines/sizes). The available VM sizes depend on region and availability set.
   */
  vmSize?: VirtualMachineSizeTypes;

  /**
   * Specifies the properties for customizing the size of the virtual machine. Minimum api-version: 2021-07-01. This feature is still in preview mode and is not supported for VirtualMachineScaleSet. Please follow the instructions in [VM Customization](https://aka.ms/vmcustomization) for more details.
   */
  vmSizeProperties?: VMSizeProperties;
}
/**
 * Specifies the storage settings for the virtual machine disks.
 */
model StorageProfile {
  /**
   * Specifies information about the image to use. You can specify information about platform images, marketplace images, or virtual machine images. This element is required when you want to use a platform image, marketplace image, or virtual machine image, but is not used in other creation operations.
   */
  imageReference?: ImageReference;

  /**
   * Specifies information about the operating system disk used by the virtual machine. For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  osDisk?: OSDisk;

  /**
   * Specifies the parameters that are used to add a data disk to a virtual machine. For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  @identifiers(#["lun"])
  dataDisks?: DataDisk[];

  /**
   * Specifies the disk controller type configured for the VM. **Note:** This property will be set to the default disk controller type if not specified provided virtual machine is being created with 'hyperVGeneration' set to V2 based on the capabilities of the operating system disk and VM size from the the specified minimum api version. You need to deallocate the VM before updating its disk controller type unless you are updating the VM size in the VM configuration which implicitly deallocates and reallocates the VM. Minimum api-version: 2022-08-01.
   */
  diskControllerType?: DiskControllerTypes;

  /**
   * Specifies whether the regional disks should be aligned/moved to the VM zone. This is applicable only for VMs with placement property set. Please note that this change is irreversible. Minimum api-version: 2024-11-01.
   */
  alignRegionalDisksToVMZone?: boolean;
}
/**
 * Specifies information about the operating system disk used by the virtual machine. For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
 */
model OSDisk {
  /**
   * This property allows you to specify the type of the OS that is included in the disk if creating a VM from user-image or a specialized VHD. Possible values are: **Windows,** **Linux.**
   */
  osType?: OperatingSystemTypes;

  /**
   * Specifies the encryption settings for the OS Disk. Minimum api-version: 2015-06-15.
   */
  encryptionSettings?: DiskEncryptionSettings;

  /**
   * The disk name.
   */
  name?: string;

  /**
   * The virtual hard disk.
   */
  vhd?: VirtualHardDisk;

  /**
   * The source user image virtual hard disk. The virtual hard disk will be copied before being attached to the virtual machine. If SourceImage is provided, the destination virtual hard drive must not exist.
   */
  image?: VirtualHardDisk;

  /**
   * Specifies the caching requirements. Possible values are: **None,** **ReadOnly,** **ReadWrite.** The defaulting behavior is: **None for Standard storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * Specifies the ephemeral Disk Settings for the operating system disk used by the virtual machine.
   */
  diffDiskSettings?: DiffDiskSettings;

  /**
   * Specifies how the virtual machine disk should be created. Possible values are **Attach:** This value is used when you are using a specialized disk to create the virtual machine. **FromImage:** This value is used when you are using an image to create the virtual machine. If you are using a platform image, you should also use the imageReference element described above. If you are using a marketplace image, you should also use the plan element previously described.
   */
  createOption: DiskCreateOptionTypes;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used to overwrite the size of the disk in a virtual machine image. The property 'diskSizeGB' is the number of bytes x 1024^3 for the disk and the value cannot be larger than 1023.
   */
  diskSizeGB?: int32;

  /**
   * Specifies the storage fault domain alignment type for the disk.
   */
  @added(Versions.v2025_11_01)
  storageFaultDomainAlignment?: StorageFaultDomainAlignmentType;

  /**
   * The managed disk parameters.
   */
  managedDisk?: ManagedDiskParameters;

  /**
   * Specifies whether OS Disk should be deleted or detached upon VM deletion. Possible values are: **Delete.** If this value is used, the OS disk is deleted when VM is deleted. **Detach.** If this value is used, the os disk is retained after VM is deleted. The default value is set to **Detach**. For an ephemeral OS Disk, the default value is set to **Delete**. The user cannot change the delete option for an ephemeral OS Disk.
   */
  deleteOption?: DiskDeleteOptionTypes;
}
/**
 * The parameters of a managed disk.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ManagedDiskParameters extends SubResource {
  /**
   * Specifies the storage account type for the managed disk. NOTE: UltraSSD_LRS can only be used with data disks, it cannot be used with OS Disk.
   */
  storageAccountType?: StorageAccountTypes;

  /**
   * Specifies the customer managed disk encryption set resource id for the managed disk.
   */
  diskEncryptionSet?: DiskEncryptionSetParameters;

  /**
   * Specifies the security profile for the managed disk.
   */
  securityProfile?: VMDiskSecurityProfile;
}
/**
 * Describes a data disk.
 */
model DataDisk {
  /**
   * Specifies the logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM.
   */
  lun: int32;

  /**
   * The disk name.
   */
  name?: string;

  /**
   * The virtual hard disk.
   */
  vhd?: VirtualHardDisk;

  /**
   * The source user image virtual hard disk. The virtual hard disk will be copied before being attached to the virtual machine. If SourceImage is provided, the destination virtual hard drive must not exist.
   */
  image?: VirtualHardDisk;

  /**
   * Specifies the caching requirements. Possible values are: **None,** **ReadOnly,** **ReadWrite.** The defaulting behavior is: **None for Standard storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * Specifies how the virtual machine disk should be created. Possible values are **Attach:** This value is used when you are using a specialized disk to create the virtual machine. **FromImage:** This value is used when you are using an image to create the virtual machine data disk. If you are using a platform image, you should also use the imageReference element described above. If you are using a marketplace image, you should also use the plan element previously described. **Empty:** This value is used when creating an empty data disk. **Copy:** This value is used to create a data disk from a snapshot or another disk. **Restore:** This value is used to create a data disk from a disk restore point.
   */
  createOption: DiskCreateOptionTypes;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used to overwrite the size of the disk in a virtual machine image. The property 'diskSizeGB' is the number of bytes x 1024^3 for the disk and the value cannot be larger than 1023.
   */
  diskSizeGB?: int32;

  /**
   * Specifies the storage fault domain alignment type for the disk.
   */
  @added(Versions.v2025_11_01)
  storageFaultDomainAlignment?: StorageFaultDomainAlignmentType;

  /**
   * The managed disk parameters.
   */
  managedDisk?: ManagedDiskParameters;

  /**
   * The source resource identifier. It can be a snapshot, or disk restore point from which to create a disk.
   */
  sourceResource?: ApiEntityReference;

  /**
   * Specifies whether the data disk is in process of detachment from the VirtualMachine/VirtualMachineScaleset
   */
  toBeDetached?: boolean;

  /**
   * Specifies the Read-Write IOPS for the managed disk when StorageAccountType is UltraSSD_LRS. Returned only for VirtualMachine ScaleSet VM disks. Can be updated only via updates to the VirtualMachine Scale Set.
   */
  @renamedFrom(Versions.v2025_04_01, "diskIOPSReadWrite")
  @removed(Versions.v2025_04_01)
  @visibility(Lifecycle.Read)
  DiskIOPSReadWrite?: int64;

  /**
   * Specifies the Read-Write IOPS for the managed disk when StorageAccountType is UltraSSD_LRS.
   */
  @added(Versions.v2025_04_01)
  diskIOPSReadWrite?: int64;

  /**
   * Specifies the bandwidth in MB per second for the managed disk when StorageAccountType is UltraSSD_LRS. Returned only for VirtualMachine ScaleSet VM disks. Can be updated only via updates to the VirtualMachine Scale Set.
   */
  @renamedFrom(Versions.v2025_04_01, "diskMBpsReadWrite")
  @removed(Versions.v2025_04_01)
  @visibility(Lifecycle.Read)
  DiskMBpsReadWrite?: int64;

  /**
   * Specifies the bandwidth in MB per second for the managed disk when StorageAccountType is UltraSSD_LRS.
   */
  @added(Versions.v2025_04_01)
  diskMBpsReadWrite?: int64;

  /**
   * Specifies the detach behavior to be used while detaching a disk or which is already in the process of detachment from the virtual machine. Supported values: **ForceDetach.** detachOption: **ForceDetach** is applicable only for managed data disks. If a previous detachment attempt of the data disk did not complete due to an unexpected failure from the virtual machine and the disk is still not released then use force-detach as a last resort option to detach the disk forcibly from the VM. All writes might not have been flushed when using this detach behavior. **This feature is still in preview**. To force-detach a data disk update toBeDetached to 'true' along with setting detachOption: 'ForceDetach'.
   */
  detachOption?: DiskDetachOptionTypes;

  /**
   * Specifies whether data disk should be deleted or detached upon VM deletion. Possible values are: **Delete.** If this value is used, the data disk is deleted when VM is deleted. **Detach.** If this value is used, the data disk is retained after VM is deleted. The default value is set to **Detach**.
   */
  deleteOption?: DiskDeleteOptionTypes;
}
/**
 * Specifies the operating system settings for the virtual machine. Some of the settings cannot be changed once VM is provisioned.
 */
model OSProfile {
  /**
   * Specifies the host OS name of the virtual machine. This name cannot be updated after the VM is created. **Max-length (Windows):** 15 characters. **Max-length (Linux):** 64 characters. For naming conventions and restrictions see [Azure infrastructure services implementation guidelines](https://docs.microsoft.com/azure/azure-resource-manager/management/resource-name-rules).
   */
  computerName?: string;

  /**
   * Specifies the name of the administrator account. <br><br> This property cannot be updated after the VM is created. <br><br> **Windows-only restriction:** Cannot end in "." <br><br> **Disallowed values:** "administrator", "admin", "user", "user1", "test", "user2", "test1", "user3", "admin1", "1", "123", "a", "actuser", "adm", "admin2", "aspnet", "backup", "console", "david", "guest", "john", "owner", "root", "server", "sql", "support", "support_388945a0", "sys", "test2", "test3", "user4", "user5". <br><br> **Minimum-length (Linux):** 1  character <br><br> **Max-length (Linux):** 64 characters <br><br> **Max-length (Windows):** 20 characters.
   */
  adminUsername?: string;

  @doc("Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)")
  @secret
  adminPassword?: string;

  /**
   * Specifies a base-64 encoded string of custom data. The base-64 encoded string is decoded to a binary array that is saved as a file on the Virtual Machine. The maximum length of the binary array is 65535 bytes. **Note: Do not pass any secrets or passwords in customData property.** This property cannot be updated after the VM is created. The property 'customData' is passed to the VM to be saved as a file, for more information see [Custom Data on Azure VMs](https://azure.microsoft.com/blog/custom-data-and-cloud-init-on-windows-azure/). For using cloud-init for your Linux VM, see [Using cloud-init to customize a Linux VM during creation](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init).
   */
  customData?: string;

  /**
   * Specifies Windows operating system settings on the virtual machine.
   */
  windowsConfiguration?: WindowsConfiguration;

  /**
   * Specifies the Linux operating system settings on the virtual machine. For a list of supported Linux distributions, see [Linux on Azure-Endorsed Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).
   */
  linuxConfiguration?: LinuxConfiguration;

  /**
   * Specifies set of certificates that should be installed onto the virtual machine. To install certificates on a virtual machine it is recommended to use the [Azure Key Vault virtual machine extension for Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux) or the [Azure Key Vault virtual machine extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  @identifiers(#["sourceVault/id"])
  secrets?: VaultSecretGroup[];

  /**
   * Specifies whether extension operations should be allowed on the virtual machine. This may only be set to False when no extensions are present on the virtual machine.
   */
  allowExtensionOperations?: boolean;

  /**
   * Optional property which must either be set to True or omitted.
   */
  requireGuestProvisionSignal?: boolean;
}
/**
 * Specifies the network interfaces or the networking configuration of the virtual machine.
 */
model NetworkProfile {
  /**
   * Specifies the list of resource Ids for the network interfaces associated with the virtual machine.
   */
  networkInterfaces?: NetworkInterfaceReference[];

  /**
   * specifies the Microsoft.Network API version used when creating networking resources in the Network Interface Configurations
   */
  networkApiVersion?: NetworkApiVersion;

  /**
   * Specifies the networking configurations that will be used to create the virtual machine networking resources.
   */
  @identifiers(#["name"])
  networkInterfaceConfigurations?: VirtualMachineNetworkInterfaceConfiguration[];
}
/**
 * Describes a network interface reference.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkInterfaceReference extends SubResource {
  /**
   * Describes a network interface reference properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: NetworkInterfaceReferenceProperties;
}
/**
 * Describes a network interface reference properties.
 */
model NetworkInterfaceReferenceProperties {
  /**
   * Specifies the primary network interface in case the virtual machine has more than 1 network interface.
   */
  primary?: boolean;

  /**
   * Specify what happens to the network interface when the VM is deleted
   */
  deleteOption?: DeleteOptions;
}
/**
 * Describes a virtual machine network interface configurations.
 */
model VirtualMachineNetworkInterfaceConfiguration {
  /**
   * The network interface configuration name.
   */
  name: string;

  /**
   * Describes a virtual machine network profile's IP configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: VirtualMachineNetworkInterfaceConfigurationProperties;

  /**
   * Resource tags applied to the networkInterface address created by this NetworkInterfaceConfiguration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @added(Versions.v2025_04_01)
  tags?: Record<string>;
}
/**
 * Describes a virtual machine network profile's IP configuration.
 */
model VirtualMachineNetworkInterfaceConfigurationProperties {
  /**
   * Specifies the primary network interface in case the virtual machine has more than 1 network interface.
   */
  primary?: boolean;

  /**
   * Specify what happens to the network interface when the VM is deleted
   */
  deleteOption?: DeleteOptions;

  /**
   * Specifies whether the network interface is accelerated networking-enabled.
   */
  enableAcceleratedNetworking?: boolean;

  /**
   * Specifies whether the network interface is disabled for tcp state tracking.
   */
  disableTcpStateTracking?: boolean;

  /**
   * Specifies whether the network interface is FPGA networking-enabled.
   */
  enableFpga?: boolean;

  /**
   * Whether IP forwarding enabled on this NIC.
   */
  enableIPForwarding?: boolean;

  /**
   * The network security group.
   */
  networkSecurityGroup?: SubResource;

  /**
   * The dns settings to be applied on the network interfaces.
   */
  dnsSettings?: VirtualMachineNetworkInterfaceDnsSettingsConfiguration;

  /**
   * Specifies the IP configurations of the network interface.
   */
  @identifiers(#["name"])
  ipConfigurations: VirtualMachineNetworkInterfaceIPConfiguration[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  dscpConfiguration?: SubResource;

  /**
   * Specifies whether the Auxiliary mode is enabled for the Network Interface resource.
   */
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;

  /**
   * Specifies whether the Auxiliary sku is enabled for the Network Interface resource.
   */
  auxiliarySku?: NetworkInterfaceAuxiliarySku;
}
/**
 * Describes a virtual machines network configuration's DNS settings.
 */
model VirtualMachineNetworkInterfaceDnsSettingsConfiguration {
  /**
   * List of DNS servers IP addresses
   */
  dnsServers?: string[];
}
/**
 * Describes a virtual machine network profile's IP configuration.
 */
model VirtualMachineNetworkInterfaceIPConfiguration {
  /**
   * The IP configuration name.
   */
  name: string;

  /**
   * Describes a virtual machine network interface IP configuration properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: VirtualMachineNetworkInterfaceIPConfigurationProperties;
}
/**
 * Describes a virtual machine network interface IP configuration properties.
 */
model VirtualMachineNetworkInterfaceIPConfigurationProperties {
  /**
   * Specifies the identifier of the subnet.
   */
  subnet?: SubResource;

  /**
   * Specifies the primary network interface in case the virtual machine has more than 1 network interface.
   */
  primary?: boolean;

  /**
   * The publicIPAddressConfiguration.
   */
  publicIPAddressConfiguration?: VirtualMachinePublicIPAddressConfiguration;

  /**
   * Available from Api-Version 2017-03-30 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible values are: 'IPv4' and 'IPv6'.
   */
  privateIPAddressVersion?: IPVersions;

  /**
   * Specifies an array of references to application security group.
   */
  applicationSecurityGroups?: SubResource[];

  /**
   * Specifies an array of references to backend address pools of application gateways. A virtual machine can reference backend address pools of multiple application gateways. Multiple virtual machines cannot use the same application gateway.
   */
  applicationGatewayBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to backend address pools of load balancers. A virtual machine can reference backend address pools of one public and one internal load balancer. [Multiple virtual machines cannot use the same basic sku load balancer].
   */
  loadBalancerBackendAddressPools?: SubResource[];
}
/**
 * Describes a virtual machines IP Configuration's PublicIPAddress configuration
 */
model VirtualMachinePublicIPAddressConfiguration {
  /**
   * The publicIP address configuration name.
   */
  name: string;

  /**
   * Describes a virtual machines IP Configuration's PublicIPAddress configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: VirtualMachinePublicIPAddressConfigurationProperties;

  /**
   * Describes the public IP Sku. It can only be set with OrchestrationMode as Flexible.
   */
  sku?: PublicIPAddressSku;

  /**
   * Resource tags applied to the publicIP address created by this PublicIPAddressConfiguration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @added(Versions.v2025_04_01)
  tags?: Record<string>;
}
/**
 * Describes a virtual machines IP Configuration's PublicIPAddress configuration
 */
model VirtualMachinePublicIPAddressConfigurationProperties {
  /**
   * The idle timeout of the public IP address.
   */
  idleTimeoutInMinutes?: int32;

  /**
   * Specify what happens to the public IP address when the VM is deleted
   */
  deleteOption?: DeleteOptions;

  /**
   * The dns settings to be applied on the publicIP addresses .
   */
  dnsSettings?: VirtualMachinePublicIPAddressDnsSettingsConfiguration;

  /**
   * The list of IP tags associated with the public IP address.
   */
  @identifiers(#[])
  ipTags?: VirtualMachineIpTag[];

  /**
   * The PublicIPPrefix from which to allocate publicIP addresses.
   */
  publicIPPrefix?: SubResource;

  /**
   * Available from Api-Version 2019-07-01 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. Possible values are: 'IPv4' and 'IPv6'.
   */
  publicIPAddressVersion?: IPVersions;

  /**
   * Specify the public IP allocation type
   */
  publicIPAllocationMethod?: PublicIPAllocationMethod;
}
/**
 * Describes a virtual machines network configuration's DNS settings.
 */
model VirtualMachinePublicIPAddressDnsSettingsConfiguration {
  /**
   * The Domain name label prefix of the PublicIPAddress resources that will be created. The generated name label is the concatenation of the domain name label and vm network profile unique ID.
   */
  domainNameLabel: string;

  /**
   * The Domain name label scope of the PublicIPAddress resources that will be created. The generated name label is the concatenation of the hashed domain name label with policy according to the domain name label scope and vm network profile unique ID.
   */
  domainNameLabelScope?: DomainNameLabelScopeTypes;
}
/**
 * Contains the IP tag associated with the public IP address.
 */
model VirtualMachineIpTag {
  /**
   * IP tag type. Example: FirstPartyUsage.
   */
  ipTagType?: string;

  /**
   * IP tag associated with the public IP. Example: SQL, Storage etc.
   */
  tag?: string;
}
