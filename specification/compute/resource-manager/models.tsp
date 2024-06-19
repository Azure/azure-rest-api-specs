import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ComputeManagementClient;

/**
 * Type of repair action (replace, restart, reimage) that will be used for
 * repairing unhealthy virtual machines in the scale set. Default value is
 * replace.
 */
union RepairAction {
  string,
  Replace: "Replace",
  Restart: "Restart",
  Reimage: "Reimage",
}

/**
 * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual
 * machines associated to virtual machine scale set with OrchestrationMode as
 * Flexible.<br /><br /> Possible values are:<br /><br /> **Manual** - You
 * control the application of patches to a virtual machine. You do this by
 * applying patches manually inside the VM. In this mode, automatic updates are
 * disabled; the property WindowsConfiguration.enableAutomaticUpdates must be
 * false<br /><br /> **AutomaticByOS** - The virtual machine will automatically be
 * updated by the OS. The property WindowsConfiguration.enableAutomaticUpdates
 * must be true. <br /><br /> **AutomaticByPlatform** - the virtual machine will
 * automatically updated by the platform. The properties provisionVMAgent and
 * WindowsConfiguration.enableAutomaticUpdates must be true
 */
union WindowsVMGuestPatchMode {
  string,
  Manual: "Manual",
  AutomaticByOS: "AutomaticByOS",
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the mode of VM Guest patch assessment for the IaaS virtual
 * machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You
 * control the timing of patch assessments on a virtual machine.<br /><br />
 * **AutomaticByPlatform** - The platform will trigger periodic patch assessments.
 * The property provisionVMAgent must be true.
 */
union WindowsPatchAssessmentMode {
  string,
  ImageDefault: "ImageDefault",
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the reboot setting for all AutomaticByPlatform patch installation
 * operations.
 */
union WindowsVMGuestPatchAutomaticByPlatformRebootSetting {
  string,
  Unknown: "Unknown",
  IfRequired: "IfRequired",
  Never: "Never",
  Always: "Always",
}

/**
 * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual
 * machines associated to virtual machine scale set with OrchestrationMode as
 * Flexible.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - The
 * virtual machine's default patching configuration is used. <br /><br />
 * **AutomaticByPlatform** - The virtual machine will be automatically updated by
 * the platform. The property provisionVMAgent must be true
 */
union LinuxVMGuestPatchMode {
  string,
  ImageDefault: "ImageDefault",
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the mode of VM Guest Patch Assessment for the IaaS virtual
 * machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You
 * control the timing of patch assessments on a virtual machine. <br /><br />
 * **AutomaticByPlatform** - The platform will trigger periodic patch assessments.
 * The property provisionVMAgent must be true.
 */
union LinuxPatchAssessmentMode {
  string,
  ImageDefault: "ImageDefault",
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the reboot setting for all AutomaticByPlatform patch installation
 * operations.
 */
union LinuxVMGuestPatchAutomaticByPlatformRebootSetting {
  string,
  Unknown: "Unknown",
  IfRequired: "IfRequired",
  Never: "Never",
  Always: "Always",
}

/**
 * Specifies how the virtual machine should be created. Possible values are:
 * **Attach.** This value is used when you are using a specialized disk to create
 * the virtual machine. **FromImage.** This value is used when you are using an
 * image to create the virtual machine. If you are using a platform image, you
 * also use the imageReference element described above. If you are using a
 * marketplace image, you also use the plan element previously described.
 */
union DiskCreateOptionTypes {
  string,
  FromImage: "FromImage",
  Empty: "Empty",
  Attach: "Attach",
}

/**
 * Specifies the ephemeral disk option for operating system disk.
 */
union DiffDiskOptions {
  string,
  Local: "Local",
}

/**
 * Specifies the ephemeral disk placement for operating system disk. This property
 * can be used by user in the request to choose the location i.e, cache disk or
 * resource disk space for Ephemeral OS disk provisioning. For more information on
 * Ephemeral OS disk size requirements, please refer Ephemeral OS disk size
 * requirements for Windows VM at
 * https://docs.microsoft.com/azure/virtual-machines/windows/ephemeral-os-disks#size-requirements
 * and Linux VM at
 * https://docs.microsoft.com/azure/virtual-machines/linux/ephemeral-os-disks#size-requirements
 */
union DiffDiskPlacement {
  string,
  CacheDisk: "CacheDisk",
  ResourceDisk: "ResourceDisk",
}

/**
 * Specifies the storage account type for the managed disk. Managed OS disk
 * storage account type can only be set when you create the scale set. NOTE:
 * UltraSSD_LRS can only be used with data disks. It cannot be used with OS Disk.
 * Standard_LRS uses Standard HDD. StandardSSD_LRS uses Standard SSD. Premium_LRS
 * uses Premium SSD. UltraSSD_LRS uses Ultra disk. Premium_ZRS uses Premium SSD
 * zone redundant storage. StandardSSD_ZRS uses Standard SSD zone redundant
 * storage. For more information regarding disks supported for Windows Virtual
 * Machines, refer to
 * https://docs.microsoft.com/azure/virtual-machines/windows/disks-types and, for
 * Linux Virtual Machines, refer to
 * https://docs.microsoft.com/azure/virtual-machines/linux/disks-types
 */
union StorageAccountTypes {
  string,
  Standard_LRS: "Standard_LRS",
  Premium_LRS: "Premium_LRS",
  StandardSSD_LRS: "StandardSSD_LRS",
  UltraSSD_LRS: "UltraSSD_LRS",
  Premium_ZRS: "Premium_ZRS",
  StandardSSD_ZRS: "StandardSSD_ZRS",
  PremiumV2_LRS: "PremiumV2_LRS",
}

/**
 * Specifies the EncryptionType of the managed disk. It is set to
 * DiskWithVMGuestState for encryption of the managed disk along with VMGuestState
 * blob, VMGuestStateOnly for encryption of just the VMGuestState blob, and
 * NonPersistedTPM for not persisting firmware state in the VMGuestState blob..
 * **Note:** It can be set for only Confidential VMs.
 */
union SecurityEncryptionTypes {
  string,
  VMGuestStateOnly: "VMGuestStateOnly",
  DiskWithVMGuestState: "DiskWithVMGuestState",
  NonPersistedTPM: "NonPersistedTPM",
}

/**
 * Specifies the behavior of the managed disk when the VM gets deleted, for
 * example whether the managed disk is deleted or detached. Supported values are:
 * **Delete.** If this value is used, the managed disk is deleted when VM gets
 * deleted. **Detach.** If this value is used, the managed disk is retained after
 * VM gets deleted. Minimum api-version: 2021-03-01.
 */
union DiskDeleteOptionTypes {
  string,
  Delete: "Delete",
  Detach: "Detach",
}

/**
 * The Domain name label scope.The concatenation of the hashed domain name label
 * that generated according to the policy from domain name label scope and vm
 * index will be the domain name labels of the PublicIPAddress resources that will
 * be created
 */
union DomainNameLabelScopeTypes {
  string,
  TenantReuse: "TenantReuse",
  SubscriptionReuse: "SubscriptionReuse",
  ResourceGroupReuse: "ResourceGroupReuse",
  NoReuse: "NoReuse",
}

/**
 * Available from Api-Version 2017-03-30 onwards, it represents whether the
 * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible
 * values are: 'IPv4' and 'IPv6'.
 */
union IPVersion {
  string,
  IPv4: "IPv4",
  IPv6: "IPv6",
}

/**
 * Specify what happens to the network interface when the VM is deleted
 */
union DeleteOptions {
  string,
  Delete: "Delete",
  Detach: "Detach",
}

/**
 * Specify public IP sku name
 */
union PublicIPAddressSkuName {
  string,
  Basic: "Basic",
  Standard: "Standard",
}

/**
 * Specify public IP sku tier
 */
union PublicIPAddressSkuTier {
  string,
  Regional: "Regional",
  Global: "Global",
}

/**
 * Specifies whether the Auxiliary mode is enabled for the Network Interface
 * resource.
 */
union NetworkInterfaceAuxiliaryMode {
  string,
  None: "None",
  AcceleratedConnections: "AcceleratedConnections",
  Floating: "Floating",
}

/**
 * Specifies whether the Auxiliary sku is enabled for the Network Interface
 * resource.
 */
union NetworkInterfaceAuxiliarySku {
  string,
  None: "None",
  A1: "A1",
  A2: "A2",
  A4: "A4",
  A8: "A8",
}

/**
 * specifies the Microsoft.Network API version used when creating networking
 * resources in the Network Interface Configurations for Virtual Machine Scale Set
 * with orchestration mode 'Flexible'
 */
union NetworkApiVersion {
  string,
  `2020-11-01`: "2020-11-01",
}

/**
 * Specifies the SecurityType of the virtual machine. It has to be set to any
 * specified value to enable UefiSettings. The default behavior is: UefiSettings
 * will not be enabled unless this property is set.
 */
union SecurityTypes {
  string,
  TrustedLaunch: "TrustedLaunch",
  ConfidentialVM: "ConfidentialVM",
}

/**
 * Specifies the mode that ProxyAgent will execute on if the feature is enabled.
 * ProxyAgent will start to audit or monitor but not enforce access control over
 * requests to host endpoints in Audit mode, while in Enforce mode it will enforce
 * access control. The default value is Enforce mode.
 */
union Mode {
  string,
  Audit: "Audit",
  Enforce: "Enforce",
}

/**
 * Specifies the priority for a standalone virtual machine or the virtual machines
 * in the scale set. 'Low' enum will be deprecated in the future, please use
 * 'Spot' as the enum to deploy Azure Spot VM/VMSS.
 */
union VirtualMachinePriorityTypes {
  string,
  Regular: "Regular",
  Low: "Low",
  Spot: "Spot",
}

/**
 * Specifies the eviction policy for the Azure Spot VM/VMSS
 */
union VirtualMachineEvictionPolicyTypes {
  string,
  Deallocate: "Deallocate",
  Delete: "Delete",
}

union VirtualMachineScaleSetScaleInRules {
  string,
  Default: "Default",
  OldestVM: "OldestVM",
  NewestVM: "NewestVM",
}

/**
 * Specifies the orchestration mode for the virtual machine scale set.
 */
union OrchestrationMode {
  string,
  Uniform: "Uniform",
  Flexible: "Flexible",
}

/**
 * The type of extendedLocation.
 */
union ExtendedLocationTypes {
  string,
  EdgeZone: "EdgeZone",
}

union ExpandTypesForGetVMScaleSets {
  string,
  userData: "userData",
}

/**
 * The name of the service.
 */
union OrchestrationServiceNames {
  string,
  AutomaticRepairs: "AutomaticRepairs",
}

/**
 * The current state of the service.
 */
union OrchestrationServiceState {
  string,
  NotRunning: "NotRunning",
  Running: "Running",
  Suspended: "Suspended",
}

/**
 * The action to be performed.
 */
union OrchestrationServiceStateAction {
  string,
  Resume: "Resume",
  Suspend: "Suspend",
}

/**
 * The hypervisor generation of the Virtual Machine [V1, V2]
 */
union HyperVGeneration {
  string,
  V1: "V1",
  V2: "V2",
}

/**
 * Specifies the size of the virtual machine. The enum data type is currently
 * deprecated and will be removed by December 23rd 2023. The recommended way to
 * get the list of available sizes is using these APIs: [List all available
 * virtual machine sizes in an availability
 * set](https://docs.microsoft.com/rest/api/compute/availabilitysets/listavailablesizes),
 * [List all available virtual machine sizes in a region](
 * https://docs.microsoft.com/rest/api/compute/resourceskus/list), [List all
 * available virtual machine sizes for
 * resizing](https://docs.microsoft.com/rest/api/compute/virtualmachines/listavailablesizes).
 * For more information about virtual machine sizes, see [Sizes for virtual
 * machines](https://docs.microsoft.com/azure/virtual-machines/sizes). The
 * available VM sizes depend on region and availability set.
 */
union VirtualMachineSizeTypes {
  string,
  Basic_A0: "Basic_A0",
  Basic_A1: "Basic_A1",
  Basic_A2: "Basic_A2",
  Basic_A3: "Basic_A3",
  Basic_A4: "Basic_A4",
  Standard_A0: "Standard_A0",
  Standard_A1: "Standard_A1",
  Standard_A2: "Standard_A2",
  Standard_A3: "Standard_A3",
  Standard_A4: "Standard_A4",
  Standard_A5: "Standard_A5",
  Standard_A6: "Standard_A6",
  Standard_A7: "Standard_A7",
  Standard_A8: "Standard_A8",
  Standard_A9: "Standard_A9",
  Standard_A10: "Standard_A10",
  Standard_A11: "Standard_A11",
  Standard_A1_v2: "Standard_A1_v2",
  Standard_A2_v2: "Standard_A2_v2",
  Standard_A4_v2: "Standard_A4_v2",
  Standard_A8_v2: "Standard_A8_v2",
  Standard_A2m_v2: "Standard_A2m_v2",
  Standard_A4m_v2: "Standard_A4m_v2",
  Standard_A8m_v2: "Standard_A8m_v2",
  Standard_B1s: "Standard_B1s",
  Standard_B1ms: "Standard_B1ms",
  Standard_B2s: "Standard_B2s",
  Standard_B2ms: "Standard_B2ms",
  Standard_B4ms: "Standard_B4ms",
  Standard_B8ms: "Standard_B8ms",
  Standard_D1: "Standard_D1",
  Standard_D2: "Standard_D2",
  Standard_D3: "Standard_D3",
  Standard_D4: "Standard_D4",
  Standard_D11: "Standard_D11",
  Standard_D12: "Standard_D12",
  Standard_D13: "Standard_D13",
  Standard_D14: "Standard_D14",
  Standard_D1_v2: "Standard_D1_v2",
  Standard_D2_v2: "Standard_D2_v2",
  Standard_D3_v2: "Standard_D3_v2",
  Standard_D4_v2: "Standard_D4_v2",
  Standard_D5_v2: "Standard_D5_v2",
  Standard_D2_v3: "Standard_D2_v3",
  Standard_D4_v3: "Standard_D4_v3",
  Standard_D8_v3: "Standard_D8_v3",
  Standard_D16_v3: "Standard_D16_v3",
  Standard_D32_v3: "Standard_D32_v3",
  Standard_D64_v3: "Standard_D64_v3",
  Standard_D2s_v3: "Standard_D2s_v3",
  Standard_D4s_v3: "Standard_D4s_v3",
  Standard_D8s_v3: "Standard_D8s_v3",
  Standard_D16s_v3: "Standard_D16s_v3",
  Standard_D32s_v3: "Standard_D32s_v3",
  Standard_D64s_v3: "Standard_D64s_v3",
  Standard_D11_v2: "Standard_D11_v2",
  Standard_D12_v2: "Standard_D12_v2",
  Standard_D13_v2: "Standard_D13_v2",
  Standard_D14_v2: "Standard_D14_v2",
  Standard_D15_v2: "Standard_D15_v2",
  Standard_DS1: "Standard_DS1",
  Standard_DS2: "Standard_DS2",
  Standard_DS3: "Standard_DS3",
  Standard_DS4: "Standard_DS4",
  Standard_DS11: "Standard_DS11",
  Standard_DS12: "Standard_DS12",
  Standard_DS13: "Standard_DS13",
  Standard_DS14: "Standard_DS14",
  Standard_DS1_v2: "Standard_DS1_v2",
  Standard_DS2_v2: "Standard_DS2_v2",
  Standard_DS3_v2: "Standard_DS3_v2",
  Standard_DS4_v2: "Standard_DS4_v2",
  Standard_DS5_v2: "Standard_DS5_v2",
  Standard_DS11_v2: "Standard_DS11_v2",
  Standard_DS12_v2: "Standard_DS12_v2",
  Standard_DS13_v2: "Standard_DS13_v2",
  Standard_DS14_v2: "Standard_DS14_v2",
  Standard_DS15_v2: "Standard_DS15_v2",
  `Standard_DS13-4_v2`: "Standard_DS13-4_v2",
  `Standard_DS13-2_v2`: "Standard_DS13-2_v2",
  `Standard_DS14-8_v2`: "Standard_DS14-8_v2",
  `Standard_DS14-4_v2`: "Standard_DS14-4_v2",
  Standard_E2_v3: "Standard_E2_v3",
  Standard_E4_v3: "Standard_E4_v3",
  Standard_E8_v3: "Standard_E8_v3",
  Standard_E16_v3: "Standard_E16_v3",
  Standard_E32_v3: "Standard_E32_v3",
  Standard_E64_v3: "Standard_E64_v3",
  Standard_E2s_v3: "Standard_E2s_v3",
  Standard_E4s_v3: "Standard_E4s_v3",
  Standard_E8s_v3: "Standard_E8s_v3",
  Standard_E16s_v3: "Standard_E16s_v3",
  Standard_E32s_v3: "Standard_E32s_v3",
  Standard_E64s_v3: "Standard_E64s_v3",
  `Standard_E32-16_v3`: "Standard_E32-16_v3",
  `Standard_E32-8s_v3`: "Standard_E32-8s_v3",
  `Standard_E64-32s_v3`: "Standard_E64-32s_v3",
  `Standard_E64-16s_v3`: "Standard_E64-16s_v3",
  Standard_F1: "Standard_F1",
  Standard_F2: "Standard_F2",
  Standard_F4: "Standard_F4",
  Standard_F8: "Standard_F8",
  Standard_F16: "Standard_F16",
  Standard_F1s: "Standard_F1s",
  Standard_F2s: "Standard_F2s",
  Standard_F4s: "Standard_F4s",
  Standard_F8s: "Standard_F8s",
  Standard_F16s: "Standard_F16s",
  Standard_F2s_v2: "Standard_F2s_v2",
  Standard_F4s_v2: "Standard_F4s_v2",
  Standard_F8s_v2: "Standard_F8s_v2",
  Standard_F16s_v2: "Standard_F16s_v2",
  Standard_F32s_v2: "Standard_F32s_v2",
  Standard_F64s_v2: "Standard_F64s_v2",
  Standard_F72s_v2: "Standard_F72s_v2",
  Standard_G1: "Standard_G1",
  Standard_G2: "Standard_G2",
  Standard_G3: "Standard_G3",
  Standard_G4: "Standard_G4",
  Standard_G5: "Standard_G5",
  Standard_GS1: "Standard_GS1",
  Standard_GS2: "Standard_GS2",
  Standard_GS3: "Standard_GS3",
  Standard_GS4: "Standard_GS4",
  Standard_GS5: "Standard_GS5",
  `Standard_GS4-8`: "Standard_GS4-8",
  `Standard_GS4-4`: "Standard_GS4-4",
  `Standard_GS5-16`: "Standard_GS5-16",
  `Standard_GS5-8`: "Standard_GS5-8",
  Standard_H8: "Standard_H8",
  Standard_H16: "Standard_H16",
  Standard_H8m: "Standard_H8m",
  Standard_H16m: "Standard_H16m",
  Standard_H16r: "Standard_H16r",
  Standard_H16mr: "Standard_H16mr",
  Standard_L4s: "Standard_L4s",
  Standard_L8s: "Standard_L8s",
  Standard_L16s: "Standard_L16s",
  Standard_L32s: "Standard_L32s",
  Standard_M64s: "Standard_M64s",
  Standard_M64ms: "Standard_M64ms",
  Standard_M128s: "Standard_M128s",
  Standard_M128ms: "Standard_M128ms",
  `Standard_M64-32ms`: "Standard_M64-32ms",
  `Standard_M64-16ms`: "Standard_M64-16ms",
  `Standard_M128-64ms`: "Standard_M128-64ms",
  `Standard_M128-32ms`: "Standard_M128-32ms",
  Standard_NC6: "Standard_NC6",
  Standard_NC12: "Standard_NC12",
  Standard_NC24: "Standard_NC24",
  Standard_NC24r: "Standard_NC24r",
  Standard_NC6s_v2: "Standard_NC6s_v2",
  Standard_NC12s_v2: "Standard_NC12s_v2",
  Standard_NC24s_v2: "Standard_NC24s_v2",
  Standard_NC24rs_v2: "Standard_NC24rs_v2",
  Standard_NC6s_v3: "Standard_NC6s_v3",
  Standard_NC12s_v3: "Standard_NC12s_v3",
  Standard_NC24s_v3: "Standard_NC24s_v3",
  Standard_NC24rs_v3: "Standard_NC24rs_v3",
  Standard_ND6s: "Standard_ND6s",
  Standard_ND12s: "Standard_ND12s",
  Standard_ND24s: "Standard_ND24s",
  Standard_ND24rs: "Standard_ND24rs",
  Standard_NV6: "Standard_NV6",
  Standard_NV12: "Standard_NV12",
  Standard_NV24: "Standard_NV24",
}

/**
 * Specifies the detach behavior to be used while detaching a disk or which is
 * already in the process of detachment from the virtual machine. Supported values
 * are: **ForceDetach.** detachOption: **ForceDetach** is applicable only for
 * managed data disks. If a previous detachment attempt of the data disk did not
 * complete due to an unexpected failure from the virtual machine and the disk is
 * still not released then use force-detach as a last resort option to detach the
 * disk forcibly from the VM. All writes might not have been flushed when using
 * this detach behavior. **This feature is still in preview** mode and is not
 * supported for VirtualMachineScaleSet. To force-detach a data disk update
 * toBeDetached to 'true' along with setting detachOption: 'ForceDetach'.
 */
union DiskDetachOptionTypes {
  string,
  ForceDetach: "ForceDetach",
}

/**
 * Specifies the disk controller type configured for the VM and
 * VirtualMachineScaleSet. This property is only supported for virtual machines
 * whose operating system disk and VM sku supports Generation 2
 * (https://docs.microsoft.com/en-us/azure/virtual-machines/generation-2), please
 * check the HyperVGenerations capability returned as part of VM sku capabilities
 * in the response of Microsoft.Compute SKUs api for the region contains V2
 * (https://docs.microsoft.com/rest/api/compute/resourceskus/list). For more
 * information about Disk Controller Types supported please refer to
 * https://aka.ms/azure-diskcontrollertypes.
 */
union DiskControllerTypes {
  string,
  SCSI: "SCSI",
  NVMe: "NVMe",
}

/**
 * Available from Api-Version 2019-07-01 onwards, it represents whether the
 * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. Possible
 * values are: 'IPv4' and 'IPv6'.
 */
union IPVersions {
  string,
  IPv4: "IPv4",
  IPv6: "IPv6",
}

/**
 * Specify the public IP allocation type
 */
union PublicIPAllocationMethod {
  string,
  Dynamic: "Dynamic",
  Static: "Static",
}

/**
 * Specifies the mode of an upgrade to virtual machines in the scale set.<br /><br
 * /> Possible values are:<br /><br /> **Manual** - You  control the application
 * of updates to virtual machines in the scale set. You do this by using the
 * manualUpgrade action.<br /><br /> **Automatic** - All virtual machines in the
 * scale set are  automatically updated at the same time.
 */
enum UpgradeMode {
  Automatic,
  Manual,
  Rolling,
}

/**
 * Specifies the name of the setting to which the content applies. Possible values
 * are: FirstLogonCommands and AutoLogon.
 */
enum SettingNames {
  AutoLogon,
  FirstLogonCommands,
}

/**
 * Specifies the protocol of WinRM listener. Possible values are: **http,**
 * **https.**
 */
enum ProtocolTypes {
  Http,
  Https,
}

/**
 * Specifies the caching requirements. Possible values are: **None,**
 * **ReadOnly,** **ReadWrite.** The default values are: **None for Standard
 * storage. ReadOnly for Premium storage**
 */
enum CachingTypes {
  None,
  ReadOnly,
  ReadWrite,
}

/**
 * This property allows you to specify the type of the OS that is included in the
 * disk if creating a VM from user-image or a specialized VHD. Possible values
 * are: **Windows,** **Linux.**
 */
enum OperatingSystemTypes {
  Windows,
  Linux,
}

/**
 * The level code.
 */
enum StatusLevelTypes {
  Info,
  Warning,
  Error,
}

/**
 * The type of identity used for the virtual machine scale set. The type
 * 'SystemAssigned, UserAssigned' includes both an implicitly created identity and
 * a set of user assigned identities. The type 'None' will remove any identities
 * from the virtual machine scale set.
 */
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The scale type applicable to the sku.
 */
enum VirtualMachineScaleSetSkuScaleType {
  Automatic,
  None,
}

/**
 * Code indicating the current status of the upgrade.
 */
enum UpgradeState {
  RollingForward,
  Cancelled,
  Completed,
  Faulted,
}

/**
 * Invoker of the Upgrade Operation
 */
enum UpgradeOperationInvoker {
  Unknown,
  User,
  Platform,
}

/**
 * Code indicating the current status of the upgrade.
 */
enum RollingUpgradeStatusCode {
  RollingForward,
  Cancelled,
  Completed,
  Faulted,
}

/**
 * The last action performed on the rolling upgrade.
 */
enum RollingUpgradeActionType {
  Start,
  Cancel,
}

/**
 * The Last Maintenance Operation Result Code.
 */
enum MaintenanceOperationResultCodeTypes {
  None,
  RetryLater,
  MaintenanceAborted,
  MaintenanceCompleted,
}

enum InstanceViewTypes {
  instanceView,
  userData,
}

/**
 * The List Virtual Machine operation response.
 */
model VirtualMachineScaleSetListResult
  is Azure.Core.Page<VirtualMachineScaleSet>;

/**
 * Describes a Virtual Machine Scale Set.
 */
model VirtualMachineScaleSet extends Resource {
  /**
   * The virtual machine scale set sku.
   */
  sku?: Sku;

  /**
   * Specifies information about the marketplace image used to create the virtual
   * machine. This element is only used for marketplace images. Before you can use a
   * marketplace image from an API, you must enable the image for programmatic use.
   * In the Azure portal, find the marketplace image that you want to use and then
   * click **Want to deploy programmatically, Get Started ->**. Enter any required
   * information and then click **Save**.
   */
  plan?: Plan;

  /**
   * Describes the properties of a Virtual Machine Scale Set.
   */
  properties?: VirtualMachineScaleSetProperties;

  /**
   * The identity of the virtual machine scale set, if configured.
   */
  identity?: VirtualMachineScaleSetIdentity;

  /**
   * The virtual machine scale set zones. NOTE: Availability zones can only be set
   * when you create the scale set
   */
  zones?: string[];

  /**
   * The extended location of the Virtual Machine Scale Set.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Etag is property returned in Create/Update/Get response of the VMSS, so that
   * customer can supply it in the header to ensure optimistic updates
   */
  @visibility("read")
  etag?: string;
}

/**
 * Describes a virtual machine scale set sku. NOTE: If the new VM SKU is not
 * supported on the hardware the scale set is currently on, you need to deallocate
 * the VMs in the scale set before you modify the SKU name.
 */
model Sku {
  /**
   * The sku name.
   */
  name?: string;

  /**
   * Specifies the tier of virtual machines in a scale set.<br /><br /> Possible
   * Values:<br /><br /> **Standard**<br /><br /> **Basic**
   */
  tier?: string;

  /**
   * Specifies the number of virtual machines in the scale set.
   */
  capacity?: int64;
}

/**
 * Specifies information about the marketplace image used to create the virtual
 * machine. This element is only used for marketplace images. Before you can use a
 * marketplace image from an API, you must enable the image for programmatic use.
 * In the Azure portal, find the marketplace image that you want to use and then
 * click **Want to deploy programmatically, Get Started ->**. Enter any required
 * information and then click **Save**.
 */
model Plan {
  /**
   * The plan ID.
   */
  name?: string;

  /**
   * The publisher ID.
   */
  publisher?: string;

  /**
   * Specifies the product of the image from the marketplace. This is the same value
   * as Offer under the imageReference element.
   */
  product?: string;

  /**
   * The promotion code.
   */
  promotionCode?: string;
}

/**
 * Describes the properties of a Virtual Machine Scale Set.
 */
model VirtualMachineScaleSetProperties {
  /**
   * The upgrade policy.
   */
  upgradePolicy?: UpgradePolicy;

  /**
   * Policy for automatic repairs.
   */
  automaticRepairsPolicy?: AutomaticRepairsPolicy;

  /**
   * The virtual machine profile.
   */
  virtualMachineProfile?: VirtualMachineScaleSetVMProfile;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Specifies whether the Virtual Machine Scale Set should be overprovisioned.
   */
  overprovision?: boolean;

  /**
   * When Overprovision is enabled, extensions are launched only on the requested
   * number of VMs which are finally kept. This property will hence ensure that the
   * extensions do not run on the extra overprovisioned VMs.
   */
  doNotRunExtensionsOnOverprovisionedVMs?: boolean;

  /**
   * Specifies the ID which uniquely identifies a Virtual Machine Scale Set.
   */
  @visibility("read")
  uniqueId?: string;

  /**
   * When true this limits the scale set to a single placement group, of max size
   * 100 virtual machines. NOTE: If singlePlacementGroup is true, it may be modified
   * to false. However, if singlePlacementGroup is false, it may not be modified to
   * true.
   */
  singlePlacementGroup?: boolean;

  /**
   * Whether to force strictly even Virtual Machine distribution cross x-zones in
   * case there is zone outage. zoneBalance property can only be set if the zones
   * property of the scale set contains more than one zone. If there are no zones or
   * only one zone specified, then zoneBalance property should not be set.
   */
  zoneBalance?: boolean;

  /**
   * Fault Domain count for each placement group.
   */
  platformFaultDomainCount?: int32;

  /**
   * Specifies information about the proximity placement group that the virtual
   * machine scale set should be assigned to. Minimum api-version: 2018-04-01.
   */
  proximityPlacementGroup?: SubResource;

  /**
   * Specifies information about the dedicated host group that the virtual machine
   * scale set resides in. Minimum api-version: 2020-06-01.
   */
  hostGroup?: SubResource;

  /**
   * Specifies additional capabilities enabled or disabled on the Virtual Machines
   * in the Virtual Machine Scale Set. For instance: whether the Virtual Machines
   * have the capability to support attaching managed data disks with UltraSSD_LRS
   * storage account type.
   */
  additionalCapabilities?: AdditionalCapabilities;

  /**
   * Specifies the policies applied when scaling in Virtual Machines in the Virtual
   * Machine Scale Set.
   */
  scaleInPolicy?: ScaleInPolicy;

  /**
   * Specifies the orchestration mode for the virtual machine scale set.
   */
  orchestrationMode?: OrchestrationMode;

  /**
   * Specifies the Spot Restore properties for the virtual machine scale set.
   */
  spotRestorePolicy?: SpotRestorePolicy;

  /**
   * Specifies the desired targets for mixing Spot and Regular priority VMs within
   * the same VMSS Flex instance.
   */
  priorityMixPolicy?: PriorityMixPolicy;

  /**
   * Specifies the time at which the Virtual Machine Scale Set resource was created.
   * Minimum api-version: 2021-11-01.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCreated?: utcDateTime;

  /**
   * Optional property which must either be set to True or omitted.
   */
  constrainedMaximumCapacity?: boolean;

  /**
   * Policy for Resiliency
   */
  resiliencyPolicy?: ResiliencyPolicy;
}

/**
 * Describes an upgrade policy - automatic, manual, or rolling.
 */
model UpgradePolicy {
  /**
   * Specifies the mode of an upgrade to virtual machines in the scale set.<br /><br
   * /> Possible values are:<br /><br /> **Manual** - You  control the application
   * of updates to virtual machines in the scale set. You do this by using the
   * manualUpgrade action.<br /><br /> **Automatic** - All virtual machines in the
   * scale set are  automatically updated at the same time.
   */
  mode?: UpgradeMode;

  /**
   * The configuration parameters used while performing a rolling upgrade.
   */
  rollingUpgradePolicy?: RollingUpgradePolicy;

  /**
   * Configuration parameters used for performing automatic OS Upgrade.
   */
  automaticOSUpgradePolicy?: AutomaticOSUpgradePolicy;
}

/**
 * The configuration parameters used while performing a rolling upgrade.
 */
model RollingUpgradePolicy {
  /**
   * The maximum percent of total virtual machine instances that will be upgraded
   * simultaneously by the rolling upgrade in one batch. As this is a maximum,
   * unhealthy instances in previous or future batches can cause the percentage of
   * instances in a batch to decrease to ensure higher reliability. The default
   * value for this parameter is 20%.
   */
  @maxValue(100)
  @minValue(5)
  maxBatchInstancePercent?: int32;

  /**
   * The maximum percentage of the total virtual machine instances in the scale set
   * that can be simultaneously unhealthy, either as a result of being upgraded, or
   * by being found in an unhealthy state by the virtual machine health checks
   * before the rolling upgrade aborts. This constraint will be checked prior to
   * starting any batch. The default value for this parameter is 20%.
   */
  @maxValue(100)
  @minValue(5)
  maxUnhealthyInstancePercent?: int32;

  /**
   * The maximum percentage of upgraded virtual machine instances that can be found
   * to be in an unhealthy state. This check will happen after each batch is
   * upgraded. If this percentage is ever exceeded, the rolling update aborts. The
   * default value for this parameter is 20%.
   */
  @maxValue(100)
  maxUnhealthyUpgradedInstancePercent?: int32;

  /**
   * The wait time between completing the update for all virtual machines in one
   * batch and starting the next batch. The time duration should be specified in ISO
   * 8601 format. The default value is 0 seconds (PT0S).
   */
  pauseTimeBetweenBatches?: string;

  /**
   * Allow VMSS to ignore AZ boundaries when constructing upgrade batches. Take into
   * consideration the Update Domain and maxBatchInstancePercent to determine the
   * batch size.
   */
  enableCrossZoneUpgrade?: boolean;

  /**
   * Upgrade all unhealthy instances in a scale set before any healthy instances.
   */
  prioritizeUnhealthyInstances?: boolean;

  /**
   * Rollback failed instances to previous model if the Rolling Upgrade policy is
   * violated.
   */
  rollbackFailedInstancesOnPolicyBreach?: boolean;

  /**
   * Create new virtual machines to upgrade the scale set, rather than updating the
   * existing virtual machines. Existing virtual machines will be deleted once the
   * new virtual machines are created for each batch.
   */
  maxSurge?: boolean;
}

/**
 * The configuration parameters used for performing automatic OS upgrade.
 */
model AutomaticOSUpgradePolicy {
  /**
   * Indicates whether OS upgrades should automatically be applied to scale set
   * instances in a rolling fashion when a newer version of the OS image becomes
   * available. Default value is false. If this is set to true for Windows based
   * scale sets,
   * [enableAutomaticUpdates](https://docs.microsoft.com/dotnet/api/microsoft.azure.management.compute.models.windowsconfiguration.enableautomaticupdates?view=azure-dotnet)
   * is automatically set to false and cannot be set to true.
   */
  enableAutomaticOSUpgrade?: boolean;

  /**
   * Whether OS image rollback feature should be disabled. Default value is false.
   */
  disableAutomaticRollback?: boolean;

  /**
   * Indicates whether rolling upgrade policy should be used during Auto OS Upgrade.
   * Default value is false. Auto OS Upgrade will fallback to the default policy if
   * no policy is defined on the VMSS.
   */
  useRollingUpgradePolicy?: boolean;

  /**
   * Indicates whether Auto OS Upgrade should undergo deferral. Deferred OS upgrades
   * will send advanced notifications on a per-VM basis that an OS upgrade from
   * rolling upgrades is incoming, via the IMDS tag 'Platform.PendingOSUpgrade'. The
   * upgrade then defers until the upgrade is approved via an ApproveRollingUpgrade
   * call.
   */
  osRollingUpgradeDeferral?: boolean;
}

/**
 * Specifies the configuration parameters for automatic repairs on the virtual
 * machine scale set.
 */
model AutomaticRepairsPolicy {
  /**
   * Specifies whether automatic repairs should be enabled on the virtual machine
   * scale set. The default value is false.
   */
  enabled?: boolean;

  /**
   * The amount of time for which automatic repairs are suspended due to a state
   * change on VM. The grace time starts after the state change has completed. This
   * helps avoid premature or accidental repairs. The time duration should be
   * specified in ISO 8601 format. The minimum allowed grace period is 10 minutes
   * (PT10M), which is also the default value. The maximum allowed grace period is
   * 90 minutes (PT90M).
   */
  gracePeriod?: string;

  /**
   * Type of repair action (replace, restart, reimage) that will be used for
   * repairing unhealthy virtual machines in the scale set. Default value is
   * replace.
   */
  repairAction?: RepairAction;
}

/**
 * Describes a virtual machine scale set virtual machine profile.
 */
model VirtualMachineScaleSetVMProfile {
  /**
   * Specifies the operating system settings for the virtual machines in the scale
   * set.
   */
  osProfile?: VirtualMachineScaleSetOSProfile;

  /**
   * Specifies the storage settings for the virtual machine disks.
   */
  storageProfile?: VirtualMachineScaleSetStorageProfile;

  /**
   * Specifies properties of the network interfaces of the virtual machines in the
   * scale set.
   */
  networkProfile?: VirtualMachineScaleSetNetworkProfile;

  /**
   * Specifies the Security related profile settings for the virtual machines in the
   * scale set.
   */
  securityProfile?: SecurityProfile;

  /**
   * Specifies the boot diagnostic settings state. Minimum api-version: 2015-06-15.
   */
  diagnosticsProfile?: DiagnosticsProfile;

  /**
   * Specifies a collection of settings for extensions installed on virtual machines
   * in the scale set.
   */
  extensionProfile?: VirtualMachineScaleSetExtensionProfile;

  /**
   * Specifies that the image or disk that is being used was licensed on-premises.
   * <br><br> Possible values for Windows Server operating system are: <br><br>
   * Windows_Client <br><br> Windows_Server <br><br> Possible values for Linux
   * Server operating system are: <br><br> RHEL_BYOS (for RHEL) <br><br> SLES_BYOS
   * (for SUSE) <br><br> For more information, see [Azure Hybrid Use Benefit for
   * Windows
   * Server](https://docs.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing)
   * <br><br> [Azure Hybrid Use Benefit for Linux
   * Server](https://docs.microsoft.com/azure/virtual-machines/linux/azure-hybrid-benefit-linux)
   * <br><br> Minimum api-version: 2015-06-15
   */
  licenseType?: string;

  /**
   * Specifies the priority for the virtual machines in the scale set. Minimum
   * api-version: 2017-10-30-preview.
   */
  priority?: VirtualMachinePriorityTypes;

  /**
   * Specifies the eviction policy for the Azure Spot virtual machine and Azure Spot
   * scale set. For Azure Spot virtual machines, both 'Deallocate' and 'Delete' are
   * supported and the minimum api-version is 2019-03-01. For Azure Spot scale sets,
   * both 'Deallocate' and 'Delete' are supported and the minimum api-version is
   * 2017-10-30-preview.
   */
  evictionPolicy?: VirtualMachineEvictionPolicyTypes;

  /**
   * Specifies the billing related details of a Azure Spot VMSS. Minimum
   * api-version: 2019-03-01.
   */
  billingProfile?: BillingProfile;

  /**
   * Specifies Scheduled Event related configurations.
   */
  scheduledEventsProfile?: ScheduledEventsProfile;

  /**
   * UserData for the virtual machines in the scale set, which must be base-64
   * encoded. Customer should not pass any secrets in here. Minimum api-version:
   * 2021-03-01.
   */
  userData?: string;

  /**
   * Specifies the capacity reservation related details of a scale set. Minimum
   * api-version: 2021-04-01.
   */
  capacityReservation?: CapacityReservationProfile;

  /**
   * Specifies the gallery applications that should be made available to the VM/VMSS
   */
  applicationProfile?: ApplicationProfile;

  /**
   * Specifies the hardware profile related details of a scale set. Minimum
   * api-version: 2021-11-01.
   */
  hardwareProfile?: VirtualMachineScaleSetHardwareProfile;

  /**
   * Specifies the service artifact reference id used to set same image version for
   * all virtual machines in the scale set when using 'latest' image version.
   * Minimum api-version: 2022-11-01
   */
  serviceArtifactReference?: ServiceArtifactReference;

  /**
   * Specifies the security posture to be used for all virtual machines in the scale
   * set. Minimum api-version: 2023-03-01
   */
  securityPostureReference?: SecurityPostureReference;

  /**
   * Specifies the time in which this VM profile for the Virtual Machine Scale Set
   * was created. Minimum API version for this property is 2023-09-01. This value
   * will be added to VMSS Flex VM tags when creating/updating the VMSS VM Profile
   * with minimum api-version 2023-09-01.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCreated?: utcDateTime;
}

/**
 * Describes a virtual machine scale set OS profile.
 */
model VirtualMachineScaleSetOSProfile {
  /**
   * Specifies the computer name prefix for all of the virtual machines in the scale
   * set. Computer name prefixes must be 1 to 15 characters long.
   */
  computerNamePrefix?: string;

  /**
   * Specifies the name of the administrator account. <br><br> **Windows-only
   * restriction:** Cannot end in "." <br><br> **Disallowed values:**
   * "administrator", "admin", "user", "user1", "test", "user2", "test1", "user3",
   * "admin1", "1", "123", "a", "actuser", "adm", "admin2", "aspnet", "backup",
   * "console", "david", "guest", "john", "owner", "root", "server", "sql",
   * "support", "support_388945a0", "sys", "test2", "test3", "user4", "user5".
   * <br><br> **Minimum-length (Linux):** 1  character <br><br> **Max-length
   * (Linux):** 64 characters <br><br> **Max-length (Windows):** 20 characters
   */
  adminUsername?: string;

  @doc("""
Specifies the password of the administrator account. <br><br> **Minimum-length
(Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters
<br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length
(Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4
conditions below need to be fulfilled <br> Has lower characters <br>Has upper
characters <br> Has a digit <br> Has a special character (Regex match [\\W_])
<br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\",
\"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\",
\"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to
reset the Remote Desktop service or its login password in a Windows
VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp)
<br><br> For resetting root password, see [Manage users, SSH, and check or
repair disks on Azure Linux VMs using the VMAccess
Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)
""")
  adminPassword?: string;

  /**
   * Specifies a base-64 encoded string of custom data. The base-64 encoded string
   * is decoded to a binary array that is saved as a file on the Virtual Machine.
   * The maximum length of the binary array is 65535 bytes. For using cloud-init for
   * your VM, see [Using cloud-init to customize a Linux VM during
   * creation](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init)
   */
  customData?: string;

  /**
   * Specifies Windows operating system settings on the virtual machine.
   */
  windowsConfiguration?: WindowsConfiguration;

  /**
   * Specifies the Linux operating system settings on the virtual machine. For a
   * list of supported Linux distributions, see [Linux on Azure-Endorsed
   * Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).
   */
  linuxConfiguration?: LinuxConfiguration;

  /**
   * Specifies set of certificates that should be installed onto the virtual
   * machines in the scale set. To install certificates on a virtual machine it is
   * recommended to use the [Azure Key Vault virtual machine extension for
   * Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux)
   * or the [Azure Key Vault virtual machine extension for
   * Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  @OpenAPI.extension("x-ms-identifiers", ["sourceVault/id"])
  secrets?: VaultSecretGroup[];

  /**
   * Specifies whether extension operations should be allowed on the virtual machine
   * scale set. This may only be set to False when no extensions are present on the
   * virtual machine scale set.
   */
  allowExtensionOperations?: boolean;

  /**
   * Optional property which must either be set to True or omitted.
   */
  requireGuestProvisionSignal?: boolean;
}

/**
 * Specifies Windows operating system settings on the virtual machine.
 */
model WindowsConfiguration {
  /**
   * Indicates whether virtual machine agent should be provisioned on the virtual
   * machine. When this property is not specified in the request body, it is set to
   * true by default. This will ensure that VM Agent is installed on the VM so that
   * extensions can be added to the VM later.
   */
  provisionVMAgent?: boolean;

  /**
   * Indicates whether Automatic Updates is enabled for the Windows virtual machine.
   * Default value is true. For virtual machine scale sets, this property can be
   * updated and updates will take effect on OS reprovisioning.
   */
  enableAutomaticUpdates?: boolean;

  /**
   * Specifies the time zone of the virtual machine. e.g. "Pacific Standard Time".
   * Possible values can be
   * [TimeZoneInfo.Id](https://docs.microsoft.com/dotnet/api/system.timezoneinfo.id?#System_TimeZoneInfo_Id)
   * value from time zones returned by
   * [TimeZoneInfo.GetSystemTimeZones](https://docs.microsoft.com/dotnet/api/system.timezoneinfo.getsystemtimezones).
   */
  timeZone?: string;

  /**
   * Specifies additional base-64 encoded XML formatted information that can be
   * included in the Unattend.xml file, which is used by Windows Setup.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  additionalUnattendContent?: AdditionalUnattendContent[];

  /**
   * [Preview Feature] Specifies settings related to VM Guest Patching on Windows.
   */
  patchSettings?: PatchSettings;

  /**
   * Specifies the Windows Remote Management listeners. This enables remote Windows
   * PowerShell.
   */
  winRM?: WinRMConfiguration;

  /**
   * Indicates whether VMAgent Platform Updates is enabled for the Windows virtual
   * machine. Default value is false.
   */
  enableVMAgentPlatformUpdates?: boolean;
}

/**
 * Specifies additional XML formatted information that can be included in the
 * Unattend.xml file, which is used by Windows Setup. Contents are defined by
 * setting name, component name, and the pass in which the content is applied.
 */
model AdditionalUnattendContent {
  /**
   * The pass name. Currently, the only allowable value is OobeSystem.
   */
  passName?: "OobeSystem";

  /**
   * The component name. Currently, the only allowable value is
   * Microsoft-Windows-Shell-Setup.
   */
  componentName?: "Microsoft-Windows-Shell-Setup";

  /**
   * Specifies the name of the setting to which the content applies. Possible values
   * are: FirstLogonCommands and AutoLogon.
   */
  settingName?: SettingNames;

  /**
   * Specifies the XML formatted content that is added to the unattend.xml file for
   * the specified path and component. The XML must be less than 4KB and must
   * include the root element for the setting or feature that is being inserted.
   */
  content?: string;
}

/**
 * Specifies settings related to VM Guest Patching on Windows.
 */
model PatchSettings {
  /**
   * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual
   * machines associated to virtual machine scale set with OrchestrationMode as
   * Flexible.<br /><br /> Possible values are:<br /><br /> **Manual** - You
   * control the application of patches to a virtual machine. You do this by
   * applying patches manually inside the VM. In this mode, automatic updates are
   * disabled; the property WindowsConfiguration.enableAutomaticUpdates must be
   * false<br /><br /> **AutomaticByOS** - The virtual machine will automatically be
   * updated by the OS. The property WindowsConfiguration.enableAutomaticUpdates
   * must be true. <br /><br /> **AutomaticByPlatform** - the virtual machine will
   * automatically updated by the platform. The properties provisionVMAgent and
   * WindowsConfiguration.enableAutomaticUpdates must be true
   */
  patchMode?: WindowsVMGuestPatchMode;

  /**
   * Enables customers to patch their Azure VMs without requiring a reboot. For
   * enableHotpatching, the 'provisionVMAgent' must be set to true and 'patchMode'
   * must be set to 'AutomaticByPlatform'.
   */
  enableHotpatching?: boolean;

  /**
   * Specifies the mode of VM Guest patch assessment for the IaaS virtual
   * machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You
   * control the timing of patch assessments on a virtual machine.<br /><br />
   * **AutomaticByPlatform** - The platform will trigger periodic patch assessments.
   * The property provisionVMAgent must be true.
   */
  assessmentMode?: WindowsPatchAssessmentMode;

  /**
   * Specifies additional settings for patch mode AutomaticByPlatform in VM Guest
   * Patching on Windows.
   */
  automaticByPlatformSettings?: WindowsVMGuestPatchAutomaticByPlatformSettings;
}

/**
 * Specifies additional settings to be applied when patch mode AutomaticByPlatform
 * is selected in Windows patch settings.
 */
model WindowsVMGuestPatchAutomaticByPlatformSettings {
  /**
   * Specifies the reboot setting for all AutomaticByPlatform patch installation
   * operations.
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
  @OpenAPI.extension("x-ms-identifiers", [])
  listeners?: WinRMListener[];
}

/**
 * Describes Protocol and thumbprint of Windows Remote Management listener
 */
model WinRMListener {
  /**
   * Specifies the protocol of WinRM listener. Possible values are: **http,**
   * **https.**
   */
  protocol?: ProtocolTypes;

  /**
   * This is the URL of a certificate that has been uploaded to Key Vault as a
   * secret. For adding a secret to the Key Vault, see [Add a key or secret to the
   * key
   * vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add).
   * In this case, your certificate needs to be the Base64 encoding of the following
   * JSON Object which is encoded in UTF-8: <br><br> {<br>
   * "data":"<Base64-encoded-certificate>",<br>  "dataType":"pfx",<br>
   * "password":"<pfx-file-password>"<br>} <br> To install certificates on a virtual
   * machine it is recommended to use the [Azure Key Vault virtual machine extension
   * for
   * Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux)
   * or the [Azure Key Vault virtual machine extension for
   * Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  certificateUrl?: string;
}

/**
 * Specifies the Linux operating system settings on the virtual machine. For a
 * list of supported Linux distributions, see [Linux on Azure-Endorsed
 * Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).
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
   * Indicates whether virtual machine agent should be provisioned on the virtual
   * machine. When this property is not specified in the request body, default
   * behavior is to set it to true. This will ensure that VM Agent is installed on
   * the VM so that extensions can be added to the VM later.
   */
  provisionVMAgent?: boolean;

  /**
   * [Preview Feature] Specifies settings related to VM Guest Patching on Linux.
   */
  patchSettings?: LinuxPatchSettings;

  /**
   * Indicates whether VMAgent Platform Updates is enabled for the Linux virtual
   * machine. Default value is false.
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
  @OpenAPI.extension("x-ms-identifiers", ["path"])
  publicKeys?: SshPublicKey[];
}

/**
 * Contains information about SSH certificate public key and the path on the Linux
 * VM where the public key is placed.
 */
model SshPublicKey {
  /**
   * Specifies the full path on the created VM where ssh public key is stored. If
   * the file already exists, the specified key is appended to the file. Example:
   * /home/user/.ssh/authorized_keys
   */
  path?: string;

  /**
   * SSH public key certificate used to authenticate with the VM through ssh. The
   * key needs to be at least 2048-bit and in ssh-rsa format. For creating ssh keys,
   * see [Create SSH keys on Linux and Mac for Linux VMs in
   * Azure]https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).
   */
  keyData?: string;
}

/**
 * Specifies settings related to VM Guest Patching on Linux.
 */
model LinuxPatchSettings {
  /**
   * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual
   * machines associated to virtual machine scale set with OrchestrationMode as
   * Flexible.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - The
   * virtual machine's default patching configuration is used. <br /><br />
   * **AutomaticByPlatform** - The virtual machine will be automatically updated by
   * the platform. The property provisionVMAgent must be true
   */
  patchMode?: LinuxVMGuestPatchMode;

  /**
   * Specifies the mode of VM Guest Patch Assessment for the IaaS virtual
   * machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You
   * control the timing of patch assessments on a virtual machine. <br /><br />
   * **AutomaticByPlatform** - The platform will trigger periodic patch assessments.
   * The property provisionVMAgent must be true.
   */
  assessmentMode?: LinuxPatchAssessmentMode;

  /**
   * Specifies additional settings for patch mode AutomaticByPlatform in VM Guest
   * Patching on Linux.
   */
  automaticByPlatformSettings?: LinuxVMGuestPatchAutomaticByPlatformSettings;
}

/**
 * Specifies additional settings to be applied when patch mode AutomaticByPlatform
 * is selected in Linux patch settings.
 */
model LinuxVMGuestPatchAutomaticByPlatformSettings {
  /**
   * Specifies the reboot setting for all AutomaticByPlatform patch installation
   * operations.
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
   * The relative URL of the Key Vault containing all of the certificates in
   * VaultCertificates.
   */
  sourceVault?: SubResource;

  /**
   * The list of key vault references in SourceVault which contain certificates.
   */
  @OpenAPI.extension("x-ms-identifiers", ["certificateUrl"])
  vaultCertificates?: VaultCertificate[];
}

model SubResource {
  /**
   * Resource Id
   */
  id?: string;
}

/**
 * Describes a single certificate reference in a Key Vault, and where the
 * certificate should reside on the VM.
 */
model VaultCertificate {
  /**
   * This is the URL of a certificate that has been uploaded to Key Vault as a
   * secret. For adding a secret to the Key Vault, see [Add a key or secret to the
   * key
   * vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add).
   * In this case, your certificate needs to be It is the Base64 encoding of the
   * following JSON Object which is encoded in UTF-8: <br><br> {<br>
   * "data":"<Base64-encoded-certificate>",<br>  "dataType":"pfx",<br>
   * "password":"<pfx-file-password>"<br>} <br> To install certificates on a virtual
   * machine it is recommended to use the [Azure Key Vault virtual machine extension
   * for
   * Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux)
   * or the [Azure Key Vault virtual machine extension for
   * Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  certificateUrl?: string;

  /**
   * For Windows VMs, specifies the certificate store on the Virtual Machine to
   * which the certificate should be added. The specified certificate store is
   * implicitly in the LocalMachine account. For Linux VMs, the certificate file is
   * placed under the /var/lib/waagent directory, with the file name
   * &lt;UppercaseThumbprint&gt;.crt for the X509 certificate file and
   * &lt;UppercaseThumbprint&gt;.prv for private key. Both of these files are .pem
   * formatted.
   */
  certificateStore?: string;
}

/**
 * Describes a virtual machine scale set storage profile.
 */
model VirtualMachineScaleSetStorageProfile {
  /**
   * Specifies information about the image to use. You can specify information about
   * platform images, marketplace images, or virtual machine images. This element is
   * required when you want to use a platform image, marketplace image, or virtual
   * machine image, but is not used in other creation operations.
   */
  imageReference?: ImageReference;

  /**
   * Specifies information about the operating system disk used by the virtual
   * machines in the scale set. For more information about disks, see [About disks
   * and VHDs for Azure virtual
   * machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  osDisk?: VirtualMachineScaleSetOSDisk;

  /**
   * Specifies the parameters that are used to add data disks to the virtual
   * machines in the scale set. For more information about disks, see [About disks
   * and VHDs for Azure virtual
   * machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  @OpenAPI.extension("x-ms-identifiers", ["name", "lun"])
  dataDisks?: VirtualMachineScaleSetDataDisk[];

  diskControllerType?: string;
}

/**
 * Specifies information about the image to use. You can specify information about
 * platform images, marketplace images, or virtual machine images. This element is
 * required when you want to use a platform image, marketplace image, or virtual
 * machine image, but is not used in other creation operations. NOTE: Image
 * reference publisher and offer can only be set when you create the scale set.
 */
model ImageReference extends SubResource {
  /**
   * The image publisher.
   */
  publisher?: string;

  /**
   * Specifies the offer of the platform image or marketplace image used to create
   * the virtual machine.
   */
  offer?: string;

  /**
   * The image SKU.
   */
  sku?: string;

  /**
   * Specifies the version of the platform image or marketplace image used to create
   * the virtual machine. The allowed formats are Major.Minor.Build or 'latest'.
   * Major, Minor, and Build are decimal numbers. Specify 'latest' to use the latest
   * version of an image available at deploy time. Even if you use 'latest', the VM
   * image will not automatically update after deploy time even if a new version
   * becomes available. Please do not use field 'version' for gallery image
   * deployment, gallery image should always use 'id' field for deployment, to use
   * 'latest' version of gallery image, just set
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/images/{imageName}'
   * in the 'id' field without version input.
   */
  version?: string;

  /**
   * Specifies in decimal numbers, the version of platform image or marketplace
   * image used to create the virtual machine. This readonly field differs from
   * 'version', only if the value specified in 'version' field is 'latest'.
   */
  @visibility("read")
  exactVersion?: string;

  /**
   * Specified the shared gallery image unique id for vm deployment. This can be
   * fetched from shared gallery image GET call.
   */
  sharedGalleryImageId?: string;

  /**
   * Specified the community gallery image unique id for vm deployment. This can be
   * fetched from community gallery image GET call.
   */
  communityGalleryImageId?: string;
}

/**
 * Describes a virtual machine scale set operating system disk.
 */
model VirtualMachineScaleSetOSDisk {
  /**
   * The disk name.
   */
  name?: string;

  /**
   * Specifies the caching requirements. Possible values are: **None,**
   * **ReadOnly,** **ReadWrite.** The default values are: **None for Standard
   * storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * Specifies how the virtual machines in the scale set should be created. The only
   * allowed value is: **FromImage.** This value is used when you are using an image
   * to create the virtual machine. If you are using a platform image, you also use
   * the imageReference element described above. If you are using a marketplace
   * image, you  also use the plan element previously described.
   */
  createOption: DiskCreateOptionTypes;

  /**
   * Specifies the ephemeral disk Settings for the operating system disk used by the
   * virtual machine scale set.
   */
  diffDiskSettings?: DiffDiskSettings;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used
   * to overwrite the size of the disk in a virtual machine image. The property
   * 'diskSizeGB' is the number of bytes x 1024^3 for the disk and the value cannot
   * be larger than 1023.
   */
  diskSizeGB?: int32;

  /**
   * This property allows you to specify the type of the OS that is included in the
   * disk if creating a VM from user-image or a specialized VHD. Possible values
   * are: **Windows,** **Linux.**
   */
  osType?: OperatingSystemTypes;

  /**
   * Specifies information about the unmanaged user image to base the scale set on.
   */
  image?: VirtualHardDisk;

  /**
   * Specifies the container urls that are used to store operating system disks for
   * the scale set.
   */
  vhdContainers?: string[];

  /**
   * The managed disk parameters.
   */
  managedDisk?: VirtualMachineScaleSetManagedDiskParameters;

  /**
   * Specifies whether OS Disk should be deleted or detached upon VMSS Flex deletion
   * (This feature is available for VMSS with Flexible OrchestrationMode only).
   * <br><br> Possible values: <br><br> **Delete** If this value is used, the OS
   * disk is deleted when VMSS Flex VM is deleted.<br><br> **Detach** If this value
   * is used, the OS disk is retained after VMSS Flex VM is deleted. <br><br> The
   * default value is set to **Delete**. For an Ephemeral OS Disk, the default value
   * is set to **Delete**. User cannot change the delete option for Ephemeral OS
   * Disk.
   */
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * Describes the parameters of ephemeral disk settings that can be specified for
 * operating system disk. **Note:** The ephemeral disk settings can only be
 * specified for managed disk.
 */
model DiffDiskSettings {
  /**
   * Specifies the ephemeral disk settings for operating system disk.
   */
  option?: DiffDiskOptions;

  /**
   * Specifies the ephemeral disk placement for operating system disk. Possible
   * values are: **CacheDisk,** **ResourceDisk.** The defaulting behavior is:
   * **CacheDisk** if one is configured for the VM size otherwise **ResourceDisk**
   * is used. Refer to the VM size documentation for Windows VM at
   * https://docs.microsoft.com/azure/virtual-machines/windows/sizes and Linux VM at
   * https://docs.microsoft.com/azure/virtual-machines/linux/sizes to check which VM
   * sizes exposes a cache disk.
   */
  placement?: DiffDiskPlacement;
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
 * Describes the parameters of a ScaleSet managed disk.
 */
model VirtualMachineScaleSetManagedDiskParameters {
  /**
   * Specifies the storage account type for the managed disk. NOTE: UltraSSD_LRS can
   * only be used with data disks, it cannot be used with OS Disk.
   */
  storageAccountType?: StorageAccountTypes;

  /**
   * Specifies the customer managed disk encryption set resource id for the managed
   * disk.
   */
  diskEncryptionSet?: DiskEncryptionSetParameters;

  /**
   * Specifies the security profile for the managed disk.
   */
  securityProfile?: VMDiskSecurityProfile;
}

/**
 * Describes the parameter of customer managed disk encryption set resource id
 * that can be specified for disk. **Note:** The disk encryption set resource id
 * can only be specified for managed disk. Please refer
 * https://aka.ms/mdssewithcmkoverview for more details.
 */
model DiskEncryptionSetParameters extends SubResource {}

/**
 * Specifies the security profile settings for the managed disk. **Note:** It can
 * only be set for Confidential VMs.
 */
model VMDiskSecurityProfile {
  /**
   * Specifies the EncryptionType of the managed disk. It is set to
   * DiskWithVMGuestState for encryption of the managed disk along with VMGuestState
   * blob, VMGuestStateOnly for encryption of just the VMGuestState blob, and
   * NonPersistedTPM for not persisting firmware state in the VMGuestState blob..
   * **Note:** It can be set for only Confidential VMs.
   */
  securityEncryptionType?: SecurityEncryptionTypes;

  /**
   * Specifies the customer managed disk encryption set resource id for the managed
   * disk that is used for Customer Managed Key encrypted ConfidentialVM OS Disk and
   * VMGuest blob.
   */
  diskEncryptionSet?: DiskEncryptionSetParameters;
}

/**
 * Describes a virtual machine scale set data disk.
 */
model VirtualMachineScaleSetDataDisk {
  /**
   * The disk name.
   */
  name?: string;

  /**
   * Specifies the logical unit number of the data disk. This value is used to
   * identify data disks within the VM and therefore must be unique for each data
   * disk attached to a VM.
   */
  lun: int32;

  /**
   * Specifies the caching requirements. Possible values are: **None,**
   * **ReadOnly,** **ReadWrite.** The default values are: **None for Standard
   * storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * The create option.
   */
  createOption: DiskCreateOptionTypes;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used
   * to overwrite the size of the disk in a virtual machine image. The property
   * diskSizeGB is the number of bytes x 1024^3 for the disk and the value cannot be
   * larger than 1023.
   */
  diskSizeGB?: int32;

  /**
   * The managed disk parameters.
   */
  managedDisk?: VirtualMachineScaleSetManagedDiskParameters;

  /**
   * Specifies the Read-Write IOPS for the managed disk. Should be used only when
   * StorageAccountType is UltraSSD_LRS. If not specified, a default value would be
   * assigned based on diskSizeGB.
   */
  @encodedName("application/json", "diskIOPSReadWrite")
  diskIopsReadWrite?: int64;

  /**
   * Specifies the bandwidth in MB per second for the managed disk. Should be used
   * only when StorageAccountType is UltraSSD_LRS. If not specified, a default value
   * would be assigned based on diskSizeGB.
   */
  diskMBpsReadWrite?: int64;

  /**
   * Specifies whether data disk should be deleted or detached upon VMSS Flex
   * deletion (This feature is available for VMSS with Flexible OrchestrationMode
   * only).<br><br> Possible values: <br><br> **Delete** If this value is used, the
   * data disk is deleted when the VMSS Flex VM is deleted.<br><br> **Detach** If
   * this value is used, the data disk is retained after VMSS Flex VM is
   * deleted.<br><br> The default value is set to **Delete**.
   */
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * Describes a virtual machine scale set network profile.
 */
model VirtualMachineScaleSetNetworkProfile {
  /**
   * A reference to a load balancer probe used to determine the health of an
   * instance in the virtual machine scale set. The reference will be in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}'.
   */
  healthProbe?: ApiEntityReference;

  /**
   * The list of network configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  networkInterfaceConfigurations?: VirtualMachineScaleSetNetworkConfiguration[];

  /**
   * specifies the Microsoft.Network API version used when creating networking
   * resources in the Network Interface Configurations for Virtual Machine Scale Set
   * with orchestration mode 'Flexible'
   */
  networkApiVersion?: NetworkApiVersion;
}

/**
 * The API entity reference.
 */
model ApiEntityReference {
  /**
   * The ARM resource id in the form of
   * /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/...
   */
  id?: string;
}

/**
 * Describes a virtual machine scale set network profile's network configurations.
 */
model VirtualMachineScaleSetNetworkConfiguration {
  /**
   * The network configuration name.
   */
  name: string;

  /**
   * Describes a virtual machine scale set network profile's IP configuration.
   */
  properties?: VirtualMachineScaleSetNetworkConfigurationProperties;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration.
 */
model VirtualMachineScaleSetNetworkConfigurationProperties {
  /**
   * Specifies the primary network interface in case the virtual machine has more
   * than 1 network interface.
   */
  primary?: boolean;

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
   * The network security group.
   */
  networkSecurityGroup?: SubResource;

  /**
   * The dns settings to be applied on the network interfaces.
   */
  dnsSettings?: VirtualMachineScaleSetNetworkConfigurationDnsSettings;

  /**
   * Specifies the IP configurations of the network interface.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  ipConfigurations: VirtualMachineScaleSetIPConfiguration[];

  /**
   * Whether IP forwarding enabled on this NIC.
   */
  enableIPForwarding?: boolean;

  /**
   * Specify what happens to the network interface when the VM is deleted
   */
  deleteOption?: DeleteOptions;

  /**
   * Specifies whether the Auxiliary mode is enabled for the Network Interface
   * resource.
   */
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;

  /**
   * Specifies whether the Auxiliary sku is enabled for the Network Interface
   * resource.
   */
  auxiliarySku?: NetworkInterfaceAuxiliarySku;
}

/**
 * Describes a virtual machines scale sets network configuration's DNS settings.
 */
model VirtualMachineScaleSetNetworkConfigurationDnsSettings {
  /**
   * List of DNS servers IP addresses
   */
  dnsServers?: string[];
}

/**
 * Describes a virtual machine scale set network profile's IP configuration.
 */
model VirtualMachineScaleSetIPConfiguration {
  /**
   * The IP configuration name.
   */
  name: string;

  /**
   * Describes a virtual machine scale set network profile's IP configuration
   * properties.
   */
  properties?: VirtualMachineScaleSetIPConfigurationProperties;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration
 * properties.
 */
model VirtualMachineScaleSetIPConfigurationProperties {
  /**
   * Specifies the identifier of the subnet.
   */
  subnet?: ApiEntityReference;

  /**
   * Specifies the primary network interface in case the virtual machine has more
   * than 1 network interface.
   */
  primary?: boolean;

  /**
   * The publicIPAddressConfiguration.
   */
  publicIPAddressConfiguration?: VirtualMachineScaleSetPublicIPAddressConfiguration;

  /**
   * Available from Api-Version 2017-03-30 onwards, it represents whether the
   * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible
   * values are: 'IPv4' and 'IPv6'.
   */
  privateIPAddressVersion?: IPVersion;

  /**
   * Specifies an array of references to backend address pools of application
   * gateways. A scale set can reference backend address pools of multiple
   * application gateways. Multiple scale sets cannot use the same application
   * gateway.
   */
  applicationGatewayBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to application security group.
   */
  applicationSecurityGroups?: SubResource[];

  /**
   * Specifies an array of references to backend address pools of load balancers. A
   * scale set can reference backend address pools of one public and one internal
   * load balancer. Multiple scale sets cannot use the same basic sku load balancer.
   */
  loadBalancerBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to inbound Nat pools of the load balancers. A
   * scale set can reference inbound nat pools of one public and one internal load
   * balancer. Multiple scale sets cannot use the same basic sku load balancer.
   */
  loadBalancerInboundNatPools?: SubResource[];
}

/**
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress
 * configuration
 */
model VirtualMachineScaleSetPublicIPAddressConfiguration {
  /**
   * The publicIP address configuration name.
   */
  name: string;

  /**
   * Describes a virtual machines scale set IP Configuration's PublicIPAddress
   * configuration
   */
  properties?: VirtualMachineScaleSetPublicIPAddressConfigurationProperties;

  /**
   * Describes the public IP Sku. It can only be set with OrchestrationMode as
   * Flexible.
   */
  sku?: PublicIPAddressSku;
}

/**
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress
 * configuration
 */
model VirtualMachineScaleSetPublicIPAddressConfigurationProperties {
  /**
   * The idle timeout of the public IP address.
   */
  idleTimeoutInMinutes?: int32;

  /**
   * The dns settings to be applied on the publicIP addresses .
   */
  dnsSettings?: VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings;

  /**
   * The list of IP tags associated with the public IP address.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipTags?: VirtualMachineScaleSetIpTag[];

  /**
   * The PublicIPPrefix from which to allocate publicIP addresses.
   */
  publicIPPrefix?: SubResource;

  /**
   * Available from Api-Version 2019-07-01 onwards, it represents whether the
   * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. Possible
   * values are: 'IPv4' and 'IPv6'.
   */
  publicIPAddressVersion?: IPVersion;

  /**
   * Specify what happens to the public IP when the VM is deleted
   */
  deleteOption?: DeleteOptions;
}

/**
 * Describes a virtual machines scale sets network configuration's DNS settings.
 */
model VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings {
  /**
   * The Domain name label.The concatenation of the domain name label and vm index
   * will be the domain name labels of the PublicIPAddress resources that will be
   * created
   */
  domainNameLabel: string;

  /**
   * The Domain name label scope.The concatenation of the hashed domain name label
   * that generated according to the policy from domain name label scope and vm
   * index will be the domain name labels of the PublicIPAddress resources that will
   * be created
   */
  domainNameLabelScope?: DomainNameLabelScopeTypes;
}

/**
 * Contains the IP tag associated with the public IP address.
 */
model VirtualMachineScaleSetIpTag {
  /**
   * IP tag type. Example: FirstPartyUsage.
   */
  ipTagType?: string;

  /**
   * IP tag associated with the public IP. Example: SQL, Storage etc.
   */
  tag?: string;
}

/**
 * Describes the public IP Sku. It can only be set with OrchestrationMode as
 * Flexible.
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
 * Specifies the Security profile settings for the virtual machine or virtual
 * machine scale set.
 */
model SecurityProfile {
  /**
   * Specifies the security settings like secure boot and vTPM used while creating
   * the virtual machine. Minimum api-version: 2020-12-01.
   */
  uefiSettings?: UefiSettings;

  /**
   * This property can be used by user in the request to enable or disable the Host
   * Encryption for the virtual machine or virtual machine scale set. This will
   * enable the encryption for all the disks including Resource/Temp disk at host
   * itself. The default behavior is: The Encryption at host will be disabled unless
   * this property is set to true for the resource.
   */
  encryptionAtHost?: boolean;

  /**
   * Specifies the SecurityType of the virtual machine. It has to be set to any
   * specified value to enable UefiSettings. The default behavior is: UefiSettings
   * will not be enabled unless this property is set.
   */
  securityType?: SecurityTypes;

  /**
   * Specifies the Managed Identity used by ADE to get access token for keyvault
   * operations.
   */
  encryptionIdentity?: EncryptionIdentity;

  /**
   * Specifies ProxyAgent settings while creating the virtual machine. Minimum
   * api-version: 2023-09-01.
   */
  proxyAgentSettings?: ProxyAgentSettings;
}

/**
 * Specifies the security settings like secure boot and vTPM used while creating
 * the virtual machine. Minimum api-version: 2020-12-01.
 */
model UefiSettings {
  /**
   * Specifies whether secure boot should be enabled on the virtual machine. Minimum
   * api-version: 2020-12-01.
   */
  secureBootEnabled?: boolean;

  /**
   * Specifies whether vTPM should be enabled on the virtual machine. Minimum
   * api-version: 2020-12-01.
   */
  vTpmEnabled?: boolean;
}

/**
 * Specifies the Managed Identity used by ADE to get access token for keyvault
 * operations.
 */
model EncryptionIdentity {
  /**
   * Specifies ARM Resource ID of one of the user identities associated with the VM.
   */
  userAssignedIdentityResourceId?: string;
}

/**
 * Specifies ProxyAgent settings while creating the virtual machine. Minimum
 * api-version: 2023-09-01.
 */
model ProxyAgentSettings {
  /**
   * Specifies whether ProxyAgent feature should be enabled on the virtual machine
   * or virtual machine scale set.
   */
  enabled?: boolean;

  /**
   * Specifies the mode that ProxyAgent will execute on if the feature is enabled.
   * ProxyAgent will start to audit or monitor but not enforce access control over
   * requests to host endpoints in Audit mode, while in Enforce mode it will enforce
   * access control. The default value is Enforce mode.
   */
  mode?: Mode;

  /**
   * Increase the value of this property allows user to reset the key used for
   * securing communication channel between guest and host.
   */
  keyIncarnationId?: int32;
}

/**
 * Specifies the boot diagnostic settings state. Minimum api-version: 2015-06-15.
 */
model DiagnosticsProfile {
  /**
   * Boot Diagnostics is a debugging feature which allows you to view Console Output
   * and Screenshot to diagnose VM status. **NOTE**: If storageUri is being
   * specified then ensure that the storage account is in the same region and
   * subscription as the VM. You can easily view the output of your console log.
   * Azure also enables you to see a screenshot of the VM from the hypervisor.
   */
  bootDiagnostics?: BootDiagnostics;
}

/**
 * Boot Diagnostics is a debugging feature which allows you to view Console Output
 * and Screenshot to diagnose VM status. You can easily view the output of your
 * console log. Azure also enables you to see a screenshot of the VM from the
 * hypervisor.
 */
model BootDiagnostics {
  /**
   * Whether boot diagnostics should be enabled on the Virtual Machine.
   */
  enabled?: boolean;

  /**
   * Uri of the storage account to use for placing the console output and
   * screenshot. If storageUri is not specified while enabling boot diagnostics,
   * managed storage will be used.
   */
  storageUri?: string;
}

/**
 * Describes a virtual machine scale set extension profile.
 */
model VirtualMachineScaleSetExtensionProfile {
  /**
   * The virtual machine scale set child extension resources.
   */
  extensions?: VirtualMachineScaleSetExtension[];

  /**
   * Specifies the time alloted for all extensions to start. The time duration
   * should be between 15 minutes and 120 minutes (inclusive) and should be
   * specified in ISO 8601 format. The default value is 90 minutes (PT1H30M).
   * Minimum api-version: 2020-06-01.
   */
  extensionsTimeBudget?: string;
}

/**
 * Describes a Virtual Machine Scale Set Extension.
 */
model VirtualMachineScaleSetExtension extends SubResourceReadOnly {
  /**
   * The name of the extension.
   */
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Describes the properties of a Virtual Machine Scale Set Extension.
   */
  properties?: VirtualMachineScaleSetExtensionProperties;
}

/**
 * Describes the properties of a Virtual Machine Scale Set Extension.
 */
model VirtualMachineScaleSetExtensionProperties {
  /**
   * If a value is provided and is different from the previous value, the extension
   * handler will be forced to update even if the extension configuration has not
   * changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is
   * available at deployment time. Once deployed, however, the extension will not
   * upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Indicates whether the extension should be automatically upgraded by the
   * platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  settings?: Record<unknown>;

  /**
   * The extension can contain either protectedSettings or
   * protectedSettingsFromKeyVault or no protected settings at all.
   */
  protectedSettings?: Record<unknown>;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Collection of extension names after which this extension needs to be
   * provisioned.
   */
  provisionAfterExtensions?: string[];

  /**
   * Indicates whether failures stemming from the extension will be suppressed
   * (Operational failures such as not connecting to the VM will not be suppressed
   * regardless of this value). The default is false.
   */
  suppressFailures?: boolean;

  /**
   * The extensions protected settings that are passed by reference, and consumed
   * from key vault
   */
  protectedSettingsFromKeyVault?: KeyVaultSecretReference;
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

model SubResourceReadOnly {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;
}

/**
 * Specifies the billing related details of a Azure Spot VM or VMSS. Minimum
 * api-version: 2019-03-01.
 */
model BillingProfile {
  /**
   * Specifies the maximum price you are willing to pay for a Azure Spot VM/VMSS.
   * This price is in US Dollars. <br><br> This price will be compared with the
   * current Azure Spot price for the VM size. Also, the prices are compared at the
   * time of create/update of Azure Spot VM/VMSS and the operation will only succeed
   * if  the maxPrice is greater than the current Azure Spot price. <br><br> The
   * maxPrice will also be used for evicting a Azure Spot VM/VMSS if the current
   * Azure Spot price goes beyond the maxPrice after creation of VM/VMSS. <br><br>
   * Possible values are: <br><br> - Any decimal value greater than zero. Example:
   * 0.01538 <br><br> -1 – indicates default price to be up-to on-demand. <br><br>
   * You can set the maxPrice to -1 to indicate that the Azure Spot VM/VMSS should
   * not be evicted for price reasons. Also, the default max price is -1 if it is
   * not provided by you. <br><br>Minimum api-version: 2019-03-01.
   */
  maxPrice?: float64;
}

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

model TerminateNotificationProfile {
  /**
   * Configurable length of time a Virtual Machine being deleted will have to
   * potentially approve the Terminate Scheduled Event before the event is auto
   * approved (timed out). The configuration must be specified in ISO 8601 format,
   * the default value is 5 minutes (PT5M)
   */
  notBeforeTimeout?: string;

  /**
   * Specifies whether the Terminate Scheduled event is enabled or disabled.
   */
  enable?: boolean;
}

model OSImageNotificationProfile {
  /**
   * Length of time a Virtual Machine being reimaged or having its OS upgraded will
   * have to potentially approve the OS Image Scheduled Event before the event is
   * auto approved (timed out). The configuration is specified in ISO 8601 format,
   * and the value must be 15 minutes (PT15M)
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
   * Specifies the capacity reservation group resource id that should be used for
   * allocating the virtual machine or scaleset vm instances provided enough
   * capacity has been reserved. Please refer to https://aka.ms/CapacityReservation
   * for more details.
   */
  capacityReservationGroup?: SubResource;
}

/**
 * Contains the list of gallery applications that should be made available to the
 * VM/VMSS
 */
model ApplicationProfile {
  /**
   * Specifies the gallery applications that should be made available to the VM/VMSS
   */
  @OpenAPI.extension("x-ms-identifiers", ["packageReferenceId"])
  galleryApplications?: VMGalleryApplication[];
}

/**
 * Specifies the required information to reference a compute gallery application
 * version
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
   * Specifies the GalleryApplicationVersion resource id on the form of
   * /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{application}/versions/{version}
   */
  packageReferenceId: string;

  /**
   * Optional, Specifies the uri to an azure blob that will replace the default
   * configuration for the package if provided
   */
  configurationReference?: string;

  /**
   * Optional, If true, any failure for any operation in the VmApplication will fail
   * the deployment
   */
  treatFailureAsDeploymentFailure?: boolean;

  /**
   * If set to true, when a new Gallery Application version is available in PIR/SIG,
   * it will be automatically updated for the VM/VMSS
   */
  enableAutomaticUpgrade?: boolean;
}

/**
 * Specifies the hardware settings for the virtual machine scale set.
 */
model VirtualMachineScaleSetHardwareProfile {
  /**
   * Specifies the properties for customizing the size of the virtual machine.
   * Minimum api-version: 2021-11-01. Please follow the instructions in [VM
   * Customization](https://aka.ms/vmcustomization) for more details.
   */
  vmSizeProperties?: VMSizeProperties;
}

/**
 * Specifies VM Size Property settings on the virtual machine.
 */
model VMSizeProperties {
  /**
   * Specifies the number of vCPUs available for the VM. When this property is not
   * specified in the request body the default behavior is to set it to the value of
   * vCPUs available for that VM size exposed in api response of [List all available
   * virtual machine sizes in a
   * region](https://docs.microsoft.com/en-us/rest/api/compute/resource-skus/list).
   */
  vCPUsAvailable?: int32;

  /**
   * Specifies the vCPU to physical core ratio. When this property is not specified
   * in the request body the default behavior is set to the value of vCPUsPerCore
   * for the VM Size exposed in api response of [List all available virtual machine
   * sizes in a
   * region](https://docs.microsoft.com/en-us/rest/api/compute/resource-skus/list).
   * **Setting this property to 1 also means that hyper-threading is disabled.**
   */
  vCPUsPerCore?: int32;
}

/**
 * Specifies the service artifact reference id used to set same image version for
 * all virtual machines in the scale set when using 'latest' image version.
 * Minimum api-version: 2022-11-01
 */
model ServiceArtifactReference {
  /**
   * The service artifact reference id in the form of
   * /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/serviceArtifacts/{serviceArtifactName}/vmArtifactsProfiles/{vmArtifactsProfilesName}
   */
  id?: string;
}

/**
 * Specifies the security posture to be used for all virtual machines in the scale
 * set. Minimum api-version: 2023-03-01
 */
model SecurityPostureReference {
  /**
   * The security posture reference id in the form of
   * /CommunityGalleries/{communityGalleryName}/securityPostures/{securityPostureName}/versions/{major.minor.patch}|{major.*}|latest
   */
  id?: string;

  /**
   * List of virtual machine extensions to exclude when applying the Security
   * Posture.
   */
  excludeExtensions?: VirtualMachineExtension[];
}

/**
 * Describes a Virtual Machine Extension.
 */
model VirtualMachineExtension extends ResourceWithOptionalLocation {
  /**
   * Describes the properties of a Virtual Machine Extension.
   */
  properties?: VirtualMachineExtensionProperties;
}

/**
 * Describes the properties of a Virtual Machine Extension.
 */
model VirtualMachineExtensionProperties {
  /**
   * How the extension handler should be forced to update even if the extension
   * configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is
   * available at deployment time. Once deployed, however, the extension will not
   * upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Indicates whether the extension should be automatically upgraded by the
   * platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  settings?: Record<unknown>;

  /**
   * The extension can contain either protectedSettings or
   * protectedSettingsFromKeyVault or no protected settings at all.
   */
  protectedSettings?: Record<unknown>;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The virtual machine extension instance view.
   */
  instanceView?: VirtualMachineExtensionInstanceView;

  /**
   * Indicates whether failures stemming from the extension will be suppressed
   * (Operational failures such as not connecting to the VM will not be suppressed
   * regardless of this value). The default is false.
   */
  suppressFailures?: boolean;

  /**
   * The extensions protected settings that are passed by reference, and consumed
   * from key vault
   */
  protectedSettingsFromKeyVault?: KeyVaultSecretReference;

  /**
   * Collection of extension names after which this extension needs to be
   * provisioned.
   */
  provisionAfterExtensions?: string[];
}

/**
 * The instance view of a virtual machine extension.
 */
model VirtualMachineExtensionInstanceView {
  /**
   * The virtual machine extension name.
   */
  name?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * The resource status information.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  substatuses?: InstanceViewStatus[];

  /**
   * The resource status information.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  statuses?: InstanceViewStatus[];
}

/**
 * Instance view status.
 */
model InstanceViewStatus {
  /**
   * The status code.
   */
  code?: string;

  /**
   * The level code.
   */
  level?: StatusLevelTypes;

  /**
   * The short localizable label for the status.
   */
  displayStatus?: string;

  /**
   * The detailed status message, including for alerts and error messages.
   */
  message?: string;

  /**
   * The time of the status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * The Resource model definition with location property as optional.
 */
model ResourceWithOptionalLocation {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Enables or disables a capability on the virtual machine or virtual machine
 * scale set.
 */
model AdditionalCapabilities {
  /**
   * The flag that enables or disables a capability to have one or more managed data
   * disks with UltraSSD_LRS storage account type on the VM or VMSS. Managed disks
   * with storage account type UltraSSD_LRS can be added to a virtual machine or
   * virtual machine scale set only if this property is enabled.
   */
  ultraSSDEnabled?: boolean;

  /**
   * The flag that enables or disables hibernation capability on the VM.
   */
  hibernationEnabled?: boolean;
}

/**
 * Describes a scale-in policy for a virtual machine scale set.
 */
model ScaleInPolicy {
  /**
   * The rules to be followed when scaling-in a virtual machine scale set. <br><br>
   * Possible values are: <br><br> **Default** When a virtual machine scale set is
   * scaled in, the scale set will first be balanced across zones if it is a zonal
   * scale set. Then, it will be balanced across Fault Domains as far as possible.
   * Within each Fault Domain, the virtual machines chosen for removal will be the
   * newest ones that are not protected from scale-in. <br><br> **OldestVM** When a
   * virtual machine scale set is being scaled-in, the oldest virtual machines that
   * are not protected from scale-in will be chosen for removal. For zonal virtual
   * machine scale sets, the scale set will first be balanced across zones. Within
   * each zone, the oldest virtual machines that are not protected will be chosen
   * for removal. <br><br> **NewestVM** When a virtual machine scale set is being
   * scaled-in, the newest virtual machines that are not protected from scale-in
   * will be chosen for removal. For zonal virtual machine scale sets, the scale set
   * will first be balanced across zones. Within each zone, the newest virtual
   * machines that are not protected will be chosen for removal. <br><br>
   */
  rules?: VirtualMachineScaleSetScaleInRules[];

  /**
   * This property allows you to specify if virtual machines chosen for removal have
   * to be force deleted when a virtual machine scale set is being
   * scaled-in.(Feature in Preview)
   */
  forceDeletion?: boolean;
}

/**
 * Specifies the Spot-Try-Restore properties for the virtual machine scale set.
 * With this property customer can enable or disable automatic restore of the
 * evicted Spot VMSS VM instances opportunistically based on capacity availability
 * and pricing constraint.
 */
model SpotRestorePolicy {
  /**
   * Enables the Spot-Try-Restore feature where evicted VMSS SPOT instances will be
   * tried to be restored opportunistically based on capacity availability and
   * pricing constraints
   */
  enabled?: boolean;

  /**
   * Timeout value expressed as an ISO 8601 time duration after which the platform
   * will not try to restore the VMSS SPOT instances
   */
  restoreTimeout?: string;
}

/**
 * Specifies the target splits for Spot and Regular priority VMs within a scale
 * set with flexible orchestration mode. With this property the customer is able
 * to specify the base number of regular priority VMs created as the VMSS flex
 * instance scales out and the split between Spot and Regular priority VMs after
 * this base target has been reached.
 */
model PriorityMixPolicy {
  /**
   * The base number of regular priority VMs that will be created in this scale set
   * as it scales out.
   */
  baseRegularPriorityCount?: int32;

  /**
   * The percentage of VM instances, after the base regular priority count has been
   * reached, that are expected to use regular priority.
   */
  @maxValue(100)
  regularPriorityPercentageAboveBase?: int32;
}

/**
 * Describes an resiliency policy - resilientVMCreationPolicy and/or
 * resilientVMDeletionPolicy.
 */
model ResiliencyPolicy {
  /**
   * The configuration parameters used while performing resilient VM creation.
   */
  resilientVMCreationPolicy?: ResilientVMCreationPolicy;

  /**
   * The configuration parameters used while performing resilient VM deletion.
   */
  resilientVMDeletionPolicy?: ResilientVMDeletionPolicy;
}

/**
 * The configuration parameters used while performing resilient VM creation.
 */
model ResilientVMCreationPolicy {
  /**
   * Specifies whether resilient VM creation should be enabled on the virtual
   * machine scale set. The default value is false.
   */
  enabled?: boolean;
}

/**
 * The configuration parameters used while performing resilient VM deletion.
 */
model ResilientVMDeletionPolicy {
  /**
   * Specifies whether resilient VM deletion should be enabled on the virtual
   * machine scale set. The default value is false.
   */
  enabled?: boolean;
}

/**
 * Identity for the virtual machine scale set.
 */
model VirtualMachineScaleSetIdentity {
  /**
   * The principal id of virtual machine scale set identity. This property will only
   * be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id associated with the virtual machine scale set. This property will
   * only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of identity used for the virtual machine scale set. The type
   * 'SystemAssigned, UserAssigned' includes both an implicitly created identity and
   * a set of user assigned identities. The type 'None' will remove any identities
   * from the virtual machine scale set.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the virtual machine scale set. The
   * user identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * The complex type of the extended location.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name?: string;

  /**
   * The type of the extended location.
   */
  type?: ExtendedLocationTypes;
}

/**
 * The Resource model definition.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  location: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * An error response from the Compute service.
 */
@error
model CloudError {
  /**
   * Api error.
   */
  error?: ApiError;
}

/**
 * Api error.
 */
model ApiError {
  /**
   * The Api error details
   */
  @OpenAPI.extension("x-ms-identifiers", ["message", "target"])
  details?: ApiErrorBase[];

  /**
   * The Api inner error
   */
  innererror?: InnerError;

  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Api error base.
 */
model ApiErrorBase {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Inner error details.
 */
model InnerError {
  /**
   * The exception type.
   */
  exceptiontype?: string;

  /**
   * The internal error message or exception dump.
   */
  errordetail?: string;
}

/**
 * Describes a Virtual Machine Scale Set.
 */
model VirtualMachineScaleSetUpdate extends UpdateResource {
  /**
   * The virtual machine scale set sku.
   */
  sku?: Sku;

  /**
   * The purchase plan when deploying a virtual machine scale set from VM
   * Marketplace images.
   */
  plan?: Plan;

  /**
   * Describes the properties of a Virtual Machine Scale Set.
   */
  properties?: VirtualMachineScaleSetUpdateProperties;

  /**
   * The identity of the virtual machine scale set, if configured.
   */
  identity?: VirtualMachineScaleSetIdentity;
}

/**
 * Describes the properties of a Virtual Machine Scale Set.
 */
model VirtualMachineScaleSetUpdateProperties {
  /**
   * The upgrade policy.
   */
  upgradePolicy?: UpgradePolicy;

  /**
   * Policy for automatic repairs.
   */
  automaticRepairsPolicy?: AutomaticRepairsPolicy;

  /**
   * The virtual machine profile.
   */
  virtualMachineProfile?: VirtualMachineScaleSetUpdateVMProfile;

  /**
   * Specifies whether the Virtual Machine Scale Set should be overprovisioned.
   */
  overprovision?: boolean;

  /**
   * When Overprovision is enabled, extensions are launched only on the requested
   * number of VMs which are finally kept. This property will hence ensure that the
   * extensions do not run on the extra overprovisioned VMs.
   */
  doNotRunExtensionsOnOverprovisionedVMs?: boolean;

  /**
   * When true this limits the scale set to a single placement group, of max size
   * 100 virtual machines. NOTE: If singlePlacementGroup is true, it may be modified
   * to false. However, if singlePlacementGroup is false, it may not be modified to
   * true.
   */
  singlePlacementGroup?: boolean;

  /**
   * Specifies additional capabilities enabled or disabled on the Virtual Machines
   * in the Virtual Machine Scale Set. For instance: whether the Virtual Machines
   * have the capability to support attaching managed data disks with UltraSSD_LRS
   * storage account type.
   */
  additionalCapabilities?: AdditionalCapabilities;

  /**
   * Specifies the policies applied when scaling in Virtual Machines in the Virtual
   * Machine Scale Set.
   */
  scaleInPolicy?: ScaleInPolicy;

  /**
   * Specifies information about the proximity placement group that the virtual
   * machine scale set should be assigned to. <br><br>Minimum api-version:
   * 2018-04-01.
   */
  proximityPlacementGroup?: SubResource;

  /**
   * Specifies the desired targets for mixing Spot and Regular priority VMs within
   * the same VMSS Flex instance.
   */
  priorityMixPolicy?: PriorityMixPolicy;

  /**
   * Specifies the Spot Restore properties for the virtual machine scale set.
   */
  spotRestorePolicy?: SpotRestorePolicy;

  /**
   * Policy for Resiliency
   */
  resiliencyPolicy?: ResiliencyPolicy;
}

/**
 * Describes a virtual machine scale set virtual machine profile.
 */
model VirtualMachineScaleSetUpdateVMProfile {
  /**
   * The virtual machine scale set OS profile.
   */
  osProfile?: VirtualMachineScaleSetUpdateOSProfile;

  /**
   * The virtual machine scale set storage profile.
   */
  storageProfile?: VirtualMachineScaleSetUpdateStorageProfile;

  /**
   * The virtual machine scale set network profile.
   */
  networkProfile?: VirtualMachineScaleSetUpdateNetworkProfile;

  /**
   * The virtual machine scale set Security profile
   */
  securityProfile?: SecurityProfile;

  /**
   * The virtual machine scale set diagnostics profile.
   */
  diagnosticsProfile?: DiagnosticsProfile;

  /**
   * The virtual machine scale set extension profile.
   */
  extensionProfile?: VirtualMachineScaleSetExtensionProfile;

  /**
   * The license type, which is for bring your own license scenario.
   */
  licenseType?: string;

  /**
   * Specifies the billing related details of a Azure Spot VMSS. Minimum
   * api-version: 2019-03-01.
   */
  billingProfile?: BillingProfile;

  /**
   * Specifies Scheduled Event related configurations.
   */
  scheduledEventsProfile?: ScheduledEventsProfile;

  /**
   * UserData for the VM, which must be base-64 encoded. Customer should not pass
   * any secrets in here. <br><br>Minimum api-version: 2021-03-01
   */
  userData?: string;

  /**
   * Specifies the hardware profile related details of a scale set. Minimum
   * api-version: 2021-11-01.
   */
  hardwareProfile?: VirtualMachineScaleSetHardwareProfile;
}

/**
 * Describes a virtual machine scale set OS profile.
 */
model VirtualMachineScaleSetUpdateOSProfile {
  /**
   * A base-64 encoded string of custom data.
   */
  customData?: string;

  /**
   * The Windows Configuration of the OS profile.
   */
  windowsConfiguration?: WindowsConfiguration;

  /**
   * The Linux Configuration of the OS profile.
   */
  linuxConfiguration?: LinuxConfiguration;

  /**
   * The List of certificates for addition to the VM.
   */
  @OpenAPI.extension("x-ms-identifiers", ["sourceVault/id"])
  secrets?: VaultSecretGroup[];
}

/**
 * Describes a virtual machine scale set storage profile.
 */
model VirtualMachineScaleSetUpdateStorageProfile {
  /**
   * The image reference.
   */
  imageReference?: ImageReference;

  /**
   * The OS disk.
   */
  osDisk?: VirtualMachineScaleSetUpdateOSDisk;

  /**
   * The data disks.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name", "lun"])
  dataDisks?: VirtualMachineScaleSetDataDisk[];

  diskControllerType?: string;
}

/**
 * Describes virtual machine scale set operating system disk Update Object. This
 * should be used for Updating VMSS OS Disk.
 */
model VirtualMachineScaleSetUpdateOSDisk {
  /**
   * The caching type.
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used
   * to overwrite the size of the disk in a virtual machine image. <br><br>
   * diskSizeGB is the number of bytes x 1024^3 for the disk and the value cannot be
   * larger than 1023
   */
  diskSizeGB?: int32;

  /**
   * The Source User Image VirtualHardDisk. This VirtualHardDisk will be copied
   * before using it to attach to the Virtual Machine. If SourceImage is provided,
   * the destination VirtualHardDisk should not exist.
   */
  image?: VirtualHardDisk;

  /**
   * The list of virtual hard disk container uris.
   */
  vhdContainers?: string[];

  /**
   * The managed disk parameters.
   */
  managedDisk?: VirtualMachineScaleSetManagedDiskParameters;

  /**
   * Specifies whether OS Disk should be deleted or detached upon VMSS Flex deletion
   * (This feature is available for VMSS with Flexible OrchestrationMode only).
   * <br><br> Possible values: <br><br> **Delete** If this value is used, the OS
   * disk is deleted when VMSS Flex VM is deleted.<br><br> **Detach** If this value
   * is used, the OS disk is retained after VMSS Flex VM is deleted. <br><br> The
   * default value is set to **Delete**. For an Ephemeral OS Disk, the default value
   * is set to **Delete**. User cannot change the delete option for Ephemeral OS
   * Disk.
   */
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * Describes a virtual machine scale set network profile.
 */
model VirtualMachineScaleSetUpdateNetworkProfile {
  /**
   * A reference to a load balancer probe used to determine the health of an
   * instance in the virtual machine scale set. The reference will be in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}'.
   */
  healthProbe?: ApiEntityReference;

  /**
   * The list of network configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  networkInterfaceConfigurations?: VirtualMachineScaleSetUpdateNetworkConfiguration[];

  /**
   * specifies the Microsoft.Network API version used when creating networking
   * resources in the Network Interface Configurations for Virtual Machine Scale Set
   * with orchestration mode 'Flexible'
   */
  networkApiVersion?: NetworkApiVersion;
}

/**
 * Describes a virtual machine scale set network profile's network configurations.
 */
model VirtualMachineScaleSetUpdateNetworkConfiguration {
  /**
   * The network configuration name.
   */
  name?: string;

  /**
   * Describes a virtual machine scale set updatable network profile's IP
   * configuration.Use this object for updating network profile's IP Configuration.
   */
  properties?: VirtualMachineScaleSetUpdateNetworkConfigurationProperties;
}

/**
 * Describes a virtual machine scale set updatable network profile's IP
 * configuration.Use this object for updating network profile's IP Configuration.
 */
model VirtualMachineScaleSetUpdateNetworkConfigurationProperties {
  /**
   * Whether this is a primary NIC on a virtual machine.
   */
  primary?: boolean;

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
   * The network security group.
   */
  networkSecurityGroup?: SubResource;

  /**
   * The dns settings to be applied on the network interfaces.
   */
  dnsSettings?: VirtualMachineScaleSetNetworkConfigurationDnsSettings;

  /**
   * The virtual machine scale set IP Configuration.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  ipConfigurations?: VirtualMachineScaleSetUpdateIPConfiguration[];

  /**
   * Whether IP forwarding enabled on this NIC.
   */
  enableIPForwarding?: boolean;

  /**
   * Specify what happens to the network interface when the VM is deleted
   */
  deleteOption?: DeleteOptions;

  /**
   * Specifies whether the Auxiliary mode is enabled for the Network Interface
   * resource.
   */
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;

  /**
   * Specifies whether the Auxiliary sku is enabled for the Network Interface
   * resource.
   */
  auxiliarySku?: NetworkInterfaceAuxiliarySku;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration. NOTE:
 * The subnet of a scale set may be modified as long as the original subnet and
 * the new subnet are in the same virtual network
 */
model VirtualMachineScaleSetUpdateIPConfiguration {
  /**
   * The IP configuration name.
   */
  name?: string;

  /**
   * Describes a virtual machine scale set network profile's IP configuration
   * properties.
   */
  properties?: VirtualMachineScaleSetUpdateIPConfigurationProperties;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration
 * properties.
 */
model VirtualMachineScaleSetUpdateIPConfigurationProperties {
  /**
   * The subnet.
   */
  subnet?: ApiEntityReference;

  /**
   * Specifies the primary IP Configuration in case the network interface has more
   * than one IP Configuration.
   */
  primary?: boolean;

  /**
   * The publicIPAddressConfiguration.
   */
  publicIPAddressConfiguration?: VirtualMachineScaleSetUpdatePublicIPAddressConfiguration;

  /**
   * Available from Api-Version 2017-03-30 onwards, it represents whether the
   * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible
   * values are: 'IPv4' and 'IPv6'.
   */
  privateIPAddressVersion?: IPVersion;

  /**
   * The application gateway backend address pools.
   */
  applicationGatewayBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to application security group.
   */
  applicationSecurityGroups?: SubResource[];

  /**
   * The load balancer backend address pools.
   */
  loadBalancerBackendAddressPools?: SubResource[];

  /**
   * The load balancer inbound nat pools.
   */
  loadBalancerInboundNatPools?: SubResource[];
}

/**
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress
 * configuration
 */
model VirtualMachineScaleSetUpdatePublicIPAddressConfiguration {
  /**
   * The publicIP address configuration name.
   */
  name?: string;

  /**
   * Describes a virtual machines scale set IP Configuration's PublicIPAddress
   * configuration
   */
  properties?: VirtualMachineScaleSetUpdatePublicIPAddressConfigurationProperties;
}

/**
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress
 * configuration
 */
model VirtualMachineScaleSetUpdatePublicIPAddressConfigurationProperties {
  /**
   * The idle timeout of the public IP address.
   */
  idleTimeoutInMinutes?: int32;

  /**
   * The dns settings to be applied on the publicIP addresses .
   */
  dnsSettings?: VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings;

  /**
   * The PublicIPPrefix from which to allocate publicIP addresses.
   */
  publicIPPrefix?: SubResource;

  /**
   * Specify what happens to the public IP when the VM is deleted
   */
  deleteOption?: DeleteOptions;
}

/**
 * The Update Resource model definition.
 */
model UpdateResource {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Specifies a list of virtual machine instance IDs from the VM scale set.
 */
model VirtualMachineScaleSetVMInstanceIDs {
  /**
   * The virtual machine scale set instance ids. Omitting the virtual machine scale
   * set instance ids will result in the operation being performed on all virtual
   * machines in the virtual machine scale set.
   */
  instanceIds?: string[];
}

/**
 * Specifies a list of virtual machine instance IDs from the VM scale set.
 */
model VirtualMachineScaleSetVMInstanceRequiredIDs {
  /**
   * The virtual machine scale set instance ids.
   */
  instanceIds: string[];
}

/**
 * The instance view of a virtual machine scale set.
 */
model VirtualMachineScaleSetInstanceView {
  /**
   * The instance view status summary for the virtual machine scale set.
   */
  @visibility("read")
  virtualMachine?: VirtualMachineScaleSetInstanceViewStatusesSummary;

  /**
   * The extensions information.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  extensions?: VirtualMachineScaleSetVMExtensionsSummary[];

  /**
   * The resource status information.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  statuses?: InstanceViewStatus[];

  /**
   * The orchestration services information.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["serviceName"])
  orchestrationServices?: OrchestrationServiceSummary[];
}

/**
 * Instance view statuses summary for virtual machines of a virtual machine scale
 * set.
 */
model VirtualMachineScaleSetInstanceViewStatusesSummary {
  /**
   * The extensions information.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  statusesSummary?: VirtualMachineStatusCodeCount[];
}

/**
 * The status code and count of the virtual machine scale set instance view status
 * summary.
 */
model VirtualMachineStatusCodeCount {
  /**
   * The instance view status code.
   */
  @visibility("read")
  code?: string;

  /**
   * The number of instances having a particular status code.
   */
  @visibility("read")
  count?: int32;
}

/**
 * Extensions summary for virtual machines of a virtual machine scale set.
 */
model VirtualMachineScaleSetVMExtensionsSummary {
  /**
   * The extension name.
   */
  @visibility("read")
  name?: string;

  /**
   * The extensions information.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  statusesSummary?: VirtualMachineStatusCodeCount[];
}

/**
 * Summary for an orchestration service of a virtual machine scale set.
 */
model OrchestrationServiceSummary {
  /**
   * The name of the service.
   */
  @visibility("read")
  serviceName?: OrchestrationServiceNames;

  /**
   * The current state of the service.
   */
  @visibility("read")
  serviceState?: OrchestrationServiceState;
}

/**
 * Describes a Virtual Machine Scale Set Extension.
 */
model VirtualMachineScaleSetExtensionUpdate extends SubResourceReadOnly {
  /**
   * The name of the extension.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Describes the properties of a Virtual Machine Scale Set Extension.
   */
  properties?: VirtualMachineScaleSetExtensionProperties;
}

/**
 * The List VM scale set extension operation response.
 */
model VirtualMachineScaleSetExtensionListResult
  is Azure.Core.Page<VirtualMachineScaleSetExtension>;

/**
 * The List Virtual Machine operation response.
 */
model VirtualMachineScaleSetListWithLinkResult
  is Azure.Core.Page<VirtualMachineScaleSet>;

/**
 * The Virtual Machine Scale Set List Skus operation response.
 */
model VirtualMachineScaleSetListSkusResult
  is Azure.Core.Page<VirtualMachineScaleSetSku>;

/**
 * Describes an available virtual machine scale set sku.
 */
model VirtualMachineScaleSetSku {
  /**
   * The type of resource the sku applies to.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The Sku.
   */
  @visibility("read")
  sku?: Sku;

  /**
   * Specifies the number of virtual machines in the scale set.
   */
  @visibility("read")
  capacity?: VirtualMachineScaleSetSkuCapacity;
}

/**
 * Describes scaling information of a sku.
 */
model VirtualMachineScaleSetSkuCapacity {
  /**
   * The minimum capacity.
   */
  @visibility("read")
  minimum?: int64;

  /**
   * The maximum capacity that can be set.
   */
  @visibility("read")
  maximum?: int64;

  /**
   * The default capacity.
   */
  @visibility("read")
  defaultCapacity?: int64;

  /**
   * The scale type applicable to the sku.
   */
  @visibility("read")
  scaleType?: VirtualMachineScaleSetSkuScaleType;
}

/**
 * List of Virtual Machine Scale Set OS Upgrade History operation response.
 */
model VirtualMachineScaleSetListOSUpgradeHistory
  is Azure.Core.Page<UpgradeOperationHistoricalStatusInfo>;

/**
 * Virtual Machine Scale Set OS Upgrade History operation response.
 */
model UpgradeOperationHistoricalStatusInfo {
  /**
   * Information about the properties of the upgrade operation.
   */
  @visibility("read")
  properties?: UpgradeOperationHistoricalStatusInfoProperties;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read")
  location?: string;
}

/**
 * Describes each OS upgrade on the Virtual Machine Scale Set.
 */
model UpgradeOperationHistoricalStatusInfoProperties {
  /**
   * Information about the overall status of the upgrade operation.
   */
  @visibility("read")
  runningStatus?: UpgradeOperationHistoryStatus;

  /**
   * Counts of the VMs in each state.
   */
  @visibility("read")
  progress?: RollingUpgradeProgressInfo;

  /**
   * Error Details for this upgrade if there are any.
   */
  @visibility("read")
  error?: ApiError;

  /**
   * Invoker of the Upgrade Operation
   */
  @visibility("read")
  startedBy?: UpgradeOperationInvoker;

  /**
   * Image Reference details
   */
  @visibility("read")
  targetImageReference?: ImageReference;

  /**
   * Information about OS rollback if performed
   */
  @visibility("read")
  rollbackInfo?: RollbackStatusInfo;
}

/**
 * Information about the current running state of the overall upgrade.
 */
model UpgradeOperationHistoryStatus {
  /**
   * Code indicating the current status of the upgrade.
   */
  @visibility("read")
  code?: UpgradeState;

  /**
   * Start time of the upgrade.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the upgrade.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

/**
 * Information about the number of virtual machine instances in each upgrade state.
 */
model RollingUpgradeProgressInfo {
  /**
   * The number of instances that have been successfully upgraded.
   */
  @visibility("read")
  successfulInstanceCount?: int32;

  /**
   * The number of instances that have failed to be upgraded successfully.
   */
  @visibility("read")
  failedInstanceCount?: int32;

  /**
   * The number of instances that are currently being upgraded.
   */
  @visibility("read")
  inProgressInstanceCount?: int32;

  /**
   * The number of instances that have not yet begun to be upgraded.
   */
  @visibility("read")
  pendingInstanceCount?: int32;
}

/**
 * Information about rollback on failed VM instances after a OS Upgrade operation.
 */
model RollbackStatusInfo {
  /**
   * The number of instances which have been successfully rolled back.
   */
  @visibility("read")
  successfullyRolledbackInstanceCount?: int32;

  /**
   * The number of instances which failed to rollback.
   */
  @visibility("read")
  failedRolledbackInstanceCount?: int32;

  /**
   * Error details if OS rollback failed.
   */
  @visibility("read")
  rollbackError?: ApiError;
}

/**
 * Describes a Virtual Machine Scale Set VM Reimage Parameters.
 */
model VirtualMachineScaleSetReimageParameters
  extends VirtualMachineScaleSetVMReimageParameters {
  /**
   * The virtual machine scale set instance ids. Omitting the virtual machine scale
   * set instance ids will result in the operation being performed on all virtual
   * machines in the virtual machine scale set.
   */
  instanceIds?: string[];
}

/**
 * Describes a Virtual Machine Scale Set VM Reimage Parameters.
 */
model VirtualMachineScaleSetVMReimageParameters
  extends VirtualMachineReimageParameters {}

/**
 * Parameters for Reimaging Virtual Machine. NOTE: Virtual Machine OS disk will
 * always be reimaged
 */
model VirtualMachineReimageParameters {
  /**
   * Specifies whether to reimage temp disk. Default value: false. Note: This temp
   * disk reimage parameter is only supported for VM/VMSS with Ephemeral OS disk.
   */
  tempDisk?: boolean;

  /**
   * Specifies in decimal number, the version the OS disk should be reimaged to. If
   * exact version is not provided, the OS disk is reimaged to the existing version
   * of OS Disk.
   */
  exactVersion?: string;

  /**
   * Specifies information required for reimaging the non-ephemeral OS disk.
   */
  osProfile?: OSProfileProvisioningData;
}

/**
 * Additional parameters for Reimaging Non-Ephemeral Virtual Machine.
 */
model OSProfileProvisioningData {
  @doc("""
Specifies the password of the administrator account. <br><br> **Minimum-length
(Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters
<br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length
(Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4
conditions below need to be fulfilled <br> Has lower characters <br>Has upper
characters <br> Has a digit <br> Has a special character (Regex match [\\W_])
<br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\",
\"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\",
\"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to
reset the Remote Desktop service or its login password in a Windows
VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp)
<br><br> For resetting root password, see [Manage users, SSH, and check or
repair disks on Azure Linux VMs using the VMAccess
Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)
""")
  adminPassword?: string;

  /**
   * Specifies a base-64 encoded string of custom data. The base-64 encoded string
   * is decoded to a binary array that is saved as a file on the Virtual Machine.
   * The maximum length of the binary array is 65535 bytes. **Note: Do not pass any
   * secrets or passwords in customData property.** This property cannot be updated
   * after the VM is created. The property customData is passed to the VM to be
   * saved as a file, for more information see [Custom Data on Azure
   * VMs](https://azure.microsoft.com/blog/custom-data-and-cloud-init-on-windows-azure/).
   * If using cloud-init for your Linux VM, see [Using cloud-init to customize a
   * Linux VM during
   * creation](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init).
   */
  customData?: string;
}

/**
 * The status of the latest virtual machine scale set rolling upgrade.
 */
model RollingUpgradeStatusInfo extends Resource {
  /**
   * The status of the latest virtual machine scale set rolling upgrade.
   */
  properties?: RollingUpgradeStatusInfoProperties;
}

/**
 * The status of the latest virtual machine scale set rolling upgrade.
 */
model RollingUpgradeStatusInfoProperties {
  /**
   * The rolling upgrade policies applied for this upgrade.
   */
  @visibility("read")
  policy?: RollingUpgradePolicy;

  /**
   * Information about the current running state of the overall upgrade.
   */
  @visibility("read")
  runningStatus?: RollingUpgradeRunningStatus;

  /**
   * Information about the number of virtual machine instances in each upgrade state.
   */
  @visibility("read")
  progress?: RollingUpgradeProgressInfo;

  /**
   * Error details for this upgrade, if there are any.
   */
  @visibility("read")
  error?: ApiError;
}

/**
 * Information about the current running state of the overall upgrade.
 */
model RollingUpgradeRunningStatus {
  /**
   * Code indicating the current status of the upgrade.
   */
  @visibility("read")
  code?: RollingUpgradeStatusCode;

  /**
   * Start time of the upgrade.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The last action performed on the rolling upgrade.
   */
  @visibility("read")
  lastAction?: RollingUpgradeActionType;

  /**
   * Last action time of the upgrade.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionTime?: utcDateTime;
}

/**
 * Response after calling a manual recovery walk
 */
model RecoveryWalkResponse {
  /**
   * Whether the recovery walk was performed
   */
  @visibility("read")
  walkPerformed?: boolean;

  /**
   * The next update domain that needs to be walked. Null means walk spanning all
   * update domains has been completed
   */
  @visibility("read")
  nextPlatformUpdateDomain?: int32;
}

model VMScaleSetConvertToSinglePlacementGroupInput {
  /**
   * Id of the placement group in which you want future virtual machine instances to
   * be placed. To query placement group Id, please use Virtual Machine Scale Set
   * VMs - Get API. If not provided, the platform will choose one with maximum
   * number of virtual machine instances.
   */
  activePlacementGroupId?: string;
}

/**
 * The input for OrchestrationServiceState
 */
model OrchestrationServiceStateInput {
  /**
   * The name of the service.
   */
  serviceName: OrchestrationServiceNames;

  /**
   * The action to be performed.
   */
  action: OrchestrationServiceStateAction;
}

/**
 * Describes a VMSS VM Extension.
 */
model VirtualMachineScaleSetVMExtension extends SubResourceReadOnly {
  /**
   * The name of the extension.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * The location of the extension.
   */
  @visibility("read", "create")
  location?: string;

  /**
   * Describes the properties of a Virtual Machine Extension.
   */
  properties?: VirtualMachineExtensionProperties;
}

/**
 * Describes a VMSS VM Extension.
 */
model VirtualMachineScaleSetVMExtensionUpdate extends SubResourceReadOnly {
  /**
   * The name of the extension.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Describes the properties of a Virtual Machine Extension.
   */
  properties?: VirtualMachineExtensionUpdateProperties;
}

/**
 * Describes the properties of a Virtual Machine Extension.
 */
model VirtualMachineExtensionUpdateProperties {
  /**
   * How the extension handler should be forced to update even if the extension
   * configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is
   * available at deployment time. Once deployed, however, the extension will not
   * upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Indicates whether the extension should be automatically upgraded by the
   * platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  settings?: Record<unknown>;

  /**
   * The extension can contain either protectedSettings or
   * protectedSettingsFromKeyVault or no protected settings at all.
   */
  protectedSettings?: Record<unknown>;

  /**
   * Indicates whether failures stemming from the extension will be suppressed
   * (Operational failures such as not connecting to the VM will not be suppressed
   * regardless of this value). The default is false.
   */
  suppressFailures?: boolean;

  /**
   * The extensions protected settings that are passed by reference, and consumed
   * from key vault
   */
  protectedSettingsFromKeyVault?: KeyVaultSecretReference;
}

/**
 * The List VMSS VM Extension operation response
 */
model VirtualMachineScaleSetVMExtensionsListResult {
  /**
   * The list of VMSS VM extensions
   */
  value?: VirtualMachineScaleSetVMExtension[];
}

/**
 * Describes a virtual machine scale set virtual machine.
 */
model VirtualMachineScaleSetVM extends Resource {
  /**
   * The virtual machine instance ID.
   */
  @visibility("read")
  instanceId?: string;

  /**
   * The virtual machine SKU.
   */
  @visibility("read")
  sku?: Sku;

  /**
   * Describes the properties of a virtual machine scale set virtual machine.
   */
  properties?: VirtualMachineScaleSetVMProperties;

  /**
   * Specifies information about the marketplace image used to create the virtual
   * machine. This element is only used for marketplace images. Before you can use a
   * marketplace image from an API, you must enable the image for programmatic use.
   * In the Azure portal, find the marketplace image that you want to use and then
   * click **Want to deploy programmatically, Get Started ->**. Enter any required
   * information and then click **Save**.
   */
  plan?: Plan;

  /**
   * The virtual machine child extension resources.
   */
  @visibility("read")
  resources?: VirtualMachineExtension[];

  /**
   * The virtual machine zones.
   */
  @visibility("read")
  zones?: string[];

  /**
   * The identity of the virtual machine, if configured.
   */
  identity?: VirtualMachineIdentity;

  /**
   * Etag is property returned in Update/Get response of the VMSS VM, so that
   * customer can supply it in the header to ensure optimistic updates.
   */
  @visibility("read")
  etag?: string;
}

/**
 * Describes the properties of a virtual machine scale set virtual machine.
 */
model VirtualMachineScaleSetVMProperties {
  /**
   * Specifies whether the latest model has been applied to the virtual machine.
   */
  @visibility("read")
  latestModelApplied?: boolean;

  /**
   * Azure VM unique ID.
   */
  @visibility("read")
  vmId?: string;

  /**
   * The virtual machine instance view.
   */
  @visibility("read")
  instanceView?: VirtualMachineScaleSetVMInstanceView;

  /**
   * Specifies the hardware settings for the virtual machine.
   */
  hardwareProfile?: HardwareProfile;

  /**
   * Specifies the storage settings for the virtual machine disks.
   */
  storageProfile?: StorageProfile;

  /**
   * Specifies additional capabilities enabled or disabled on the virtual machine in
   * the scale set. For instance: whether the virtual machine has the capability to
   * support attaching managed data disks with UltraSSD_LRS storage account type.
   */
  additionalCapabilities?: AdditionalCapabilities;

  /**
   * Specifies the operating system settings for the virtual machine.
   */
  osProfile?: OSProfile;

  /**
   * Specifies the Security related profile settings for the virtual machine.
   */
  securityProfile?: SecurityProfile;

  /**
   * Specifies the network interfaces of the virtual machine.
   */
  networkProfile?: NetworkProfile;

  /**
   * Specifies the network profile configuration of the virtual machine.
   */
  networkProfileConfiguration?: VirtualMachineScaleSetVMNetworkProfileConfiguration;

  /**
   * Specifies the boot diagnostic settings state. Minimum api-version: 2015-06-15.
   */
  diagnosticsProfile?: DiagnosticsProfile;

  /**
   * Specifies information about the availability set that the virtual machine
   * should be assigned to. Virtual machines specified in the same availability set
   * are allocated to different nodes to maximize availability. For more information
   * about availability sets, see [Availability sets
   * overview](https://docs.microsoft.com/azure/virtual-machines/availability-set-overview).
   * For more information on Azure planned maintenance, see [Maintenance and updates
   * for Virtual Machines in
   * Azure](https://docs.microsoft.com/azure/virtual-machines/maintenance-and-updates).
   * Currently, a VM can only be added to availability set at creation time. An
   * existing VM cannot be added to an availability set.
   */
  availabilitySet?: SubResource;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Specifies that the image or disk that is being used was licensed on-premises.
   * <br><br> Possible values for Windows Server operating system are: <br><br>
   * Windows_Client <br><br> Windows_Server <br><br> Possible values for Linux
   * Server operating system are: <br><br> RHEL_BYOS (for RHEL) <br><br> SLES_BYOS
   * (for SUSE) <br><br> For more information, see [Azure Hybrid Use Benefit for
   * Windows
   * Server](https://docs.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing)
   * <br><br> [Azure Hybrid Use Benefit for Linux
   * Server](https://docs.microsoft.com/azure/virtual-machines/linux/azure-hybrid-benefit-linux)
   * <br><br> Minimum api-version: 2015-06-15
   */
  licenseType?: string;

  /**
   * Specifies whether the model applied to the virtual machine is the model of the
   * virtual machine scale set or the customized model for the virtual machine.
   */
  @visibility("read")
  modelDefinitionApplied?: string;

  /**
   * Specifies the protection policy of the virtual machine.
   */
  protectionPolicy?: VirtualMachineScaleSetVMProtectionPolicy;

  /**
   * UserData for the VM, which must be base-64 encoded. Customer should not pass
   * any secrets in here. <br><br>Minimum api-version: 2021-03-01
   */
  userData?: string;

  /**
   * Specifies the time at which the Virtual Machine resource was
   * created.<br><br>Minimum api-version: 2021-11-01.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCreated?: utcDateTime;
}

/**
 * The instance view of a virtual machine scale set VM.
 */
model VirtualMachineScaleSetVMInstanceView {
  /**
   * The Update Domain count.
   */
  platformUpdateDomain?: int32;

  /**
   * The Fault Domain count.
   */
  platformFaultDomain?: int32;

  /**
   * The Remote desktop certificate thumbprint.
   */
  rdpThumbPrint?: string;

  /**
   * The VM Agent running on the virtual machine.
   */
  vmAgent?: VirtualMachineAgentInstanceView;

  /**
   * The Maintenance Operation status on the virtual machine.
   */
  maintenanceRedeployStatus?: MaintenanceRedeployStatus;

  /**
   * The disks information.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  disks?: DiskInstanceView[];

  /**
   * The extensions information.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name", "type"])
  extensions?: VirtualMachineExtensionInstanceView[];

  /**
   * The health status for the VM.
   */
  @visibility("read")
  vmHealth?: VirtualMachineHealthStatus;

  /**
   * Boot Diagnostics is a debugging feature which allows you to view Console Output
   * and Screenshot to diagnose VM status. You can easily view the output of your
   * console log. Azure also enables you to see a screenshot of the VM from the
   * hypervisor.
   */
  bootDiagnostics?: BootDiagnosticsInstanceView;

  /**
   * The resource status information.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  statuses?: InstanceViewStatus[];

  /**
   * Resource id of the dedicated host, on which the virtual machine is allocated
   * through automatic placement, when the virtual machine is associated with a
   * dedicated host group that has automatic placement enabled. Minimum api-version:
   * 2020-06-01.
   */
  @visibility("read")
  assignedHost?: string;

  /**
   * The placement group in which the VM is running. If the VM is deallocated it
   * will not have a placementGroupId.
   */
  placementGroupId?: string;

  /**
   * Specifies the host OS name of the virtual machine. <br><br> This name cannot be
   * updated after the VM is created. <br><br> **Max-length (Windows):** 15
   * characters <br><br> **Max-length (Linux):** 64 characters. <br><br> For naming
   * conventions and restrictions see [Azure infrastructure services implementation
   * guidelines](https://docs.microsoft.com/azure/virtual-machines/virtual-machines-linux-infrastructure-subscription-accounts-guidelines?toc=%2fazure%2fvirtual-machines%2flinux%2ftoc.json#1-naming-conventions).
   */
  computerName?: string;

  /**
   * The Operating System running on the hybrid machine.
   */
  osName?: string;

  /**
   * The version of Operating System running on the hybrid machine.
   */
  osVersion?: string;

  /**
   * The hypervisor generation of the Virtual Machine [V1, V2]
   */
  hyperVGeneration?: HyperVGeneration;
}

/**
 * The instance view of the VM Agent running on the virtual machine.
 */
model VirtualMachineAgentInstanceView {
  /**
   * The VM Agent full version.
   */
  vmAgentVersion?: string;

  /**
   * The virtual machine extension handler instance view.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  extensionHandlers?: VirtualMachineExtensionHandlerInstanceView[];

  /**
   * The resource status information.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  statuses?: InstanceViewStatus[];
}

/**
 * The instance view of a virtual machine extension handler.
 */
model VirtualMachineExtensionHandlerInstanceView {
  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * The extension handler status.
   */
  status?: InstanceViewStatus;
}

/**
 * Maintenance Operation Status.
 */
model MaintenanceRedeployStatus {
  /**
   * True, if customer is allowed to perform Maintenance.
   */
  isCustomerInitiatedMaintenanceAllowed?: boolean;

  /**
   * Start Time for the Pre Maintenance Window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  preMaintenanceWindowStartTime?: utcDateTime;

  /**
   * End Time for the Pre Maintenance Window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  preMaintenanceWindowEndTime?: utcDateTime;

  /**
   * Start Time for the Maintenance Window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maintenanceWindowStartTime?: utcDateTime;

  /**
   * End Time for the Maintenance Window.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maintenanceWindowEndTime?: utcDateTime;

  /**
   * The Last Maintenance Operation Result Code.
   */
  lastOperationResultCode?: MaintenanceOperationResultCodeTypes;

  /**
   * Message returned for the last Maintenance Operation.
   */
  lastOperationMessage?: string;
}

/**
 * The instance view of the disk.
 */
model DiskInstanceView {
  /**
   * The disk name.
   */
  name?: string;

  /**
   * Specifies the encryption settings for the OS Disk. <br><br> Minimum
   * api-version: 2015-06-15
   */
  @OpenAPI.extension("x-ms-identifiers", ["diskEncryptionKey/sourceVault/id"])
  encryptionSettings?: DiskEncryptionSettings[];

  /**
   * The resource status information.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  statuses?: InstanceViewStatus[];
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
 * The health status of the VM.
 */
model VirtualMachineHealthStatus {
  /**
   * The health status information for the VM.
   */
  @visibility("read")
  status?: InstanceViewStatus;
}

/**
 * The instance view of a virtual machine boot diagnostics.
 */
model BootDiagnosticsInstanceView {
  /**
   * The console screenshot blob URI. **Note:** This will **not** be set if boot
   * diagnostics is currently enabled with managed storage.
   */
  @visibility("read")
  consoleScreenshotBlobUri?: string;

  /**
   * The serial console log blob Uri. **Note:** This will **not** be set if boot
   * diagnostics is currently enabled with managed storage.
   */
  @visibility("read")
  serialConsoleLogBlobUri?: string;

  /**
   * The boot diagnostics status information for the VM. **Note:** It will be set
   * only if there are errors encountered in enabling boot diagnostics.
   */
  @visibility("read")
  status?: InstanceViewStatus;
}

/**
 * Specifies the hardware settings for the virtual machine.
 */
model HardwareProfile {
  /**
   * Specifies the size of the virtual machine. The enum data type is currently
   * deprecated and will be removed by December 23rd 2023. The recommended way to
   * get the list of available sizes is using these APIs: [List all available
   * virtual machine sizes in an availability
   * set](https://docs.microsoft.com/rest/api/compute/availabilitysets/listavailablesizes),
   * [List all available virtual machine sizes in a region](
   * https://docs.microsoft.com/rest/api/compute/resourceskus/list), [List all
   * available virtual machine sizes for
   * resizing](https://docs.microsoft.com/rest/api/compute/virtualmachines/listavailablesizes).
   * For more information about virtual machine sizes, see [Sizes for virtual
   * machines](https://docs.microsoft.com/azure/virtual-machines/sizes). The
   * available VM sizes depend on region and availability set.
   */
  vmSize?: VirtualMachineSizeTypes;

  /**
   * Specifies the properties for customizing the size of the virtual machine.
   * Minimum api-version: 2021-07-01. This feature is still in preview mode and is
   * not supported for VirtualMachineScaleSet. Please follow the instructions in [VM
   * Customization](https://aka.ms/vmcustomization) for more details.
   */
  vmSizeProperties?: VMSizeProperties;
}

/**
 * Specifies the storage settings for the virtual machine disks.
 */
model StorageProfile {
  /**
   * Specifies information about the image to use. You can specify information about
   * platform images, marketplace images, or virtual machine images. This element is
   * required when you want to use a platform image, marketplace image, or virtual
   * machine image, but is not used in other creation operations.
   */
  imageReference?: ImageReference;

  /**
   * Specifies information about the operating system disk used by the virtual
   * machine. For more information about disks, see [About disks and VHDs for Azure
   * virtual
   * machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  osDisk?: OSDisk;

  /**
   * Specifies the parameters that are used to add a data disk to a virtual machine.
   * For more information about disks, see [About disks and VHDs for Azure virtual
   * machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  @OpenAPI.extension("x-ms-identifiers", ["lun"])
  dataDisks?: DataDisk[];

  /**
   * Specifies the disk controller type configured for the VM. **Note:** This
   * property will be set to the default disk controller type if not specified
   * provided virtual machine is being created with 'hyperVGeneration' set to V2
   * based on the capabilities of the operating system disk and VM size from the the
   * specified minimum api version. You need to deallocate the VM before updating
   * its disk controller type unless you are updating the VM size in the VM
   * configuration which implicitly deallocates and reallocates the VM. Minimum
   * api-version: 2022-08-01.
   */
  diskControllerType?: DiskControllerTypes;
}

/**
 * Specifies information about the operating system disk used by the virtual
 * machine. For more information about disks, see [About disks and VHDs for Azure
 * virtual
 * machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
 */
model OSDisk {
  /**
   * This property allows you to specify the type of the OS that is included in the
   * disk if creating a VM from user-image or a specialized VHD. Possible values
   * are: **Windows,** **Linux.**
   */
  osType?: OperatingSystemTypes;

  /**
   * Specifies the encryption settings for the OS Disk. Minimum api-version:
   * 2015-06-15.
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
   * The source user image virtual hard disk. The virtual hard disk will be copied
   * before being attached to the virtual machine. If SourceImage is provided, the
   * destination virtual hard drive must not exist.
   */
  image?: VirtualHardDisk;

  /**
   * Specifies the caching requirements. Possible values are: **None,**
   * **ReadOnly,** **ReadWrite.** The defaulting behavior is: **None for Standard
   * storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * Specifies the ephemeral Disk Settings for the operating system disk used by the
   * virtual machine.
   */
  diffDiskSettings?: DiffDiskSettings;

  /**
   * Specifies how the virtual machine should be created. Possible values are:
   * **Attach.** This value is used when you are using a specialized disk to create
   * the virtual machine. **FromImage.** This value is used when you are using an
   * image to create the virtual machine. If you are using a platform image, you
   * should also use the imageReference element described above. If you are using a
   * marketplace image, you should also use the plan element previously described.
   */
  createOption: DiskCreateOptionTypes;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used
   * to overwrite the size of the disk in a virtual machine image. The property
   * 'diskSizeGB' is the number of bytes x 1024^3 for the disk and the value cannot
   * be larger than 1023.
   */
  diskSizeGB?: int32;

  /**
   * The managed disk parameters.
   */
  managedDisk?: ManagedDiskParameters;

  /**
   * Specifies whether OS Disk should be deleted or detached upon VM deletion.
   * Possible values are: **Delete.** If this value is used, the OS disk is deleted
   * when VM is deleted. **Detach.** If this value is used, the os disk is retained
   * after VM is deleted. The default value is set to **Detach**. For an ephemeral
   * OS Disk, the default value is set to **Delete**. The user cannot change the
   * delete option for an ephemeral OS Disk.
   */
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * The parameters of a managed disk.
 */
model ManagedDiskParameters extends SubResource {
  /**
   * Specifies the storage account type for the managed disk. NOTE: UltraSSD_LRS can
   * only be used with data disks, it cannot be used with OS Disk.
   */
  storageAccountType?: StorageAccountTypes;

  /**
   * Specifies the customer managed disk encryption set resource id for the managed
   * disk.
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
   * Specifies the logical unit number of the data disk. This value is used to
   * identify data disks within the VM and therefore must be unique for each data
   * disk attached to a VM.
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
   * The source user image virtual hard disk. The virtual hard disk will be copied
   * before being attached to the virtual machine. If SourceImage is provided, the
   * destination virtual hard drive must not exist.
   */
  image?: VirtualHardDisk;

  /**
   * Specifies the caching requirements. Possible values are: **None,**
   * **ReadOnly,** **ReadWrite.** The defaulting behavior is: **None for Standard
   * storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * Specifies how the virtual machine should be created. Possible values are:
   * **Attach.** This value is used when you are using a specialized disk to create
   * the virtual machine. **FromImage.** This value is used when you are using an
   * image to create the virtual machine. If you are using a platform image, you
   * should also use the imageReference element described above. If you are using a
   * marketplace image, you should also use the plan element previously described.
   */
  createOption: DiskCreateOptionTypes;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used
   * to overwrite the size of the disk in a virtual machine image. The property
   * 'diskSizeGB' is the number of bytes x 1024^3 for the disk and the value cannot
   * be larger than 1023.
   */
  diskSizeGB?: int32;

  /**
   * The managed disk parameters.
   */
  managedDisk?: ManagedDiskParameters;

  /**
   * Specifies whether the data disk is in process of detachment from the
   * VirtualMachine/VirtualMachineScaleset
   */
  toBeDetached?: boolean;

  /**
   * Specifies the Read-Write IOPS for the managed disk when StorageAccountType is
   * UltraSSD_LRS. Returned only for VirtualMachine ScaleSet VM disks. Can be
   * updated only via updates to the VirtualMachine Scale Set.
   */
  @visibility("read")
  @encodedName("application/json", "diskIOPSReadWrite")
  diskIopsReadWrite?: int64;

  /**
   * Specifies the bandwidth in MB per second for the managed disk when
   * StorageAccountType is UltraSSD_LRS. Returned only for VirtualMachine ScaleSet
   * VM disks. Can be updated only via updates to the VirtualMachine Scale Set.
   */
  @visibility("read")
  diskMBpsReadWrite?: int64;

  /**
   * Specifies the detach behavior to be used while detaching a disk or which is
   * already in the process of detachment from the virtual machine. Supported
   * values: **ForceDetach.** detachOption: **ForceDetach** is applicable only for
   * managed data disks. If a previous detachment attempt of the data disk did not
   * complete due to an unexpected failure from the virtual machine and the disk is
   * still not released then use force-detach as a last resort option to detach the
   * disk forcibly from the VM. All writes might not have been flushed when using
   * this detach behavior. **This feature is still in preview** mode and is not
   * supported for VirtualMachineScaleSet. To force-detach a data disk update
   * toBeDetached to 'true' along with setting detachOption: 'ForceDetach'.
   */
  detachOption?: DiskDetachOptionTypes;

  /**
   * Specifies whether data disk should be deleted or detached upon VM deletion.
   * Possible values are: **Delete.** If this value is used, the data disk is
   * deleted when VM is deleted. **Detach.** If this value is used, the data disk is
   * retained after VM is deleted. The default value is set to **Detach**.
   */
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * Specifies the operating system settings for the virtual machine. Some of the
 * settings cannot be changed once VM is provisioned.
 */
model OSProfile {
  /**
   * Specifies the host OS name of the virtual machine. This name cannot be updated
   * after the VM is created. **Max-length (Windows):** 15 characters. **Max-length
   * (Linux):** 64 characters. For naming conventions and restrictions see [Azure
   * infrastructure services implementation
   * guidelines](https://docs.microsoft.com/azure/azure-resource-manager/management/resource-name-rules).
   */
  computerName?: string;

  /**
   * Specifies the name of the administrator account. <br><br> This property cannot
   * be updated after the VM is created. <br><br> **Windows-only restriction:**
   * Cannot end in "." <br><br> **Disallowed values:** "administrator", "admin",
   * "user", "user1", "test", "user2", "test1", "user3", "admin1", "1", "123", "a",
   * "actuser", "adm", "admin2", "aspnet", "backup", "console", "david", "guest",
   * "john", "owner", "root", "server", "sql", "support", "support_388945a0", "sys",
   * "test2", "test3", "user4", "user5". <br><br> **Minimum-length (Linux):** 1
   * character <br><br> **Max-length (Linux):** 64 characters <br><br> **Max-length
   * (Windows):** 20 characters.
   */
  adminUsername?: string;

  @doc("""
Specifies the password of the administrator account. <br><br> **Minimum-length
(Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters
<br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length
(Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4
conditions below need to be fulfilled <br> Has lower characters <br>Has upper
characters <br> Has a digit <br> Has a special character (Regex match [\\W_])
<br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\",
\"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\",
\"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to
reset the Remote Desktop service or its login password in a Windows
VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp)
<br><br> For resetting root password, see [Manage users, SSH, and check or
repair disks on Azure Linux VMs using the VMAccess
Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)
""")
  adminPassword?: string;

  /**
   * Specifies a base-64 encoded string of custom data. The base-64 encoded string
   * is decoded to a binary array that is saved as a file on the Virtual Machine.
   * The maximum length of the binary array is 65535 bytes. **Note: Do not pass any
   * secrets or passwords in customData property.** This property cannot be updated
   * after the VM is created. The property 'customData' is passed to the VM to be
   * saved as a file, for more information see [Custom Data on Azure
   * VMs](https://azure.microsoft.com/blog/custom-data-and-cloud-init-on-windows-azure/).
   * For using cloud-init for your Linux VM, see [Using cloud-init to customize a
   * Linux VM during
   * creation](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init).
   */
  customData?: string;

  /**
   * Specifies Windows operating system settings on the virtual machine.
   */
  windowsConfiguration?: WindowsConfiguration;

  /**
   * Specifies the Linux operating system settings on the virtual machine. For a
   * list of supported Linux distributions, see [Linux on Azure-Endorsed
   * Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).
   */
  linuxConfiguration?: LinuxConfiguration;

  /**
   * Specifies set of certificates that should be installed onto the virtual
   * machine. To install certificates on a virtual machine it is recommended to use
   * the [Azure Key Vault virtual machine extension for
   * Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux)
   * or the [Azure Key Vault virtual machine extension for
   * Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  @OpenAPI.extension("x-ms-identifiers", ["sourceVault/id"])
  secrets?: VaultSecretGroup[];

  /**
   * Specifies whether extension operations should be allowed on the virtual
   * machine. This may only be set to False when no extensions are present on the
   * virtual machine.
   */
  allowExtensionOperations?: boolean;

  /**
   * Optional property which must either be set to True or omitted.
   */
  requireGuestProvisionSignal?: boolean;
}

/**
 * Specifies the network interfaces or the networking configuration of the virtual
 * machine.
 */
model NetworkProfile {
  /**
   * Specifies the list of resource Ids for the network interfaces associated with
   * the virtual machine.
   */
  networkInterfaces?: NetworkInterfaceReference[];

  /**
   * specifies the Microsoft.Network API version used when creating networking
   * resources in the Network Interface Configurations
   */
  networkApiVersion?: NetworkApiVersion;

  /**
   * Specifies the networking configurations that will be used to create the virtual
   * machine networking resources.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  networkInterfaceConfigurations?: VirtualMachineNetworkInterfaceConfiguration[];
}

/**
 * Describes a network interface reference.
 */
model NetworkInterfaceReference extends SubResource {
  /**
   * Describes a network interface reference properties.
   */
  properties?: NetworkInterfaceReferenceProperties;
}

/**
 * Describes a network interface reference properties.
 */
model NetworkInterfaceReferenceProperties {
  /**
   * Specifies the primary network interface in case the virtual machine has more
   * than 1 network interface.
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
  properties?: VirtualMachineNetworkInterfaceConfigurationProperties;
}

/**
 * Describes a virtual machine network profile's IP configuration.
 */
model VirtualMachineNetworkInterfaceConfigurationProperties {
  /**
   * Specifies the primary network interface in case the virtual machine has more
   * than 1 network interface.
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
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  ipConfigurations: VirtualMachineNetworkInterfaceIPConfiguration[];

  dscpConfiguration?: SubResource;

  /**
   * Specifies whether the Auxiliary mode is enabled for the Network Interface
   * resource.
   */
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;

  /**
   * Specifies whether the Auxiliary sku is enabled for the Network Interface
   * resource.
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
   * Specifies the primary network interface in case the virtual machine has more
   * than 1 network interface.
   */
  primary?: boolean;

  /**
   * The publicIPAddressConfiguration.
   */
  publicIPAddressConfiguration?: VirtualMachinePublicIPAddressConfiguration;

  /**
   * Available from Api-Version 2017-03-30 onwards, it represents whether the
   * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible
   * values are: 'IPv4' and 'IPv6'.
   */
  privateIPAddressVersion?: IPVersions;

  /**
   * Specifies an array of references to application security group.
   */
  applicationSecurityGroups?: SubResource[];

  /**
   * Specifies an array of references to backend address pools of application
   * gateways. A virtual machine can reference backend address pools of multiple
   * application gateways. Multiple virtual machines cannot use the same application
   * gateway.
   */
  applicationGatewayBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to backend address pools of load balancers. A
   * virtual machine can reference backend address pools of one public and one
   * internal load balancer. [Multiple virtual machines cannot use the same basic
   * sku load balancer].
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
  properties?: VirtualMachinePublicIPAddressConfigurationProperties;

  /**
   * Describes the public IP Sku. It can only be set with OrchestrationMode as
   * Flexible.
   */
  sku?: PublicIPAddressSku;
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
  @OpenAPI.extension("x-ms-identifiers", [])
  ipTags?: VirtualMachineIpTag[];

  /**
   * The PublicIPPrefix from which to allocate publicIP addresses.
   */
  publicIPPrefix?: SubResource;

  /**
   * Available from Api-Version 2019-07-01 onwards, it represents whether the
   * specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. Possible
   * values are: 'IPv4' and 'IPv6'.
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
   * The Domain name label prefix of the PublicIPAddress resources that will be
   * created. The generated name label is the concatenation of the domain name label
   * and vm network profile unique ID.
   */
  domainNameLabel: string;

  /**
   * The Domain name label scope of the PublicIPAddress resources that will be
   * created. The generated name label is the concatenation of the hashed domain
   * name label with policy according to the domain name label scope and vm network
   * profile unique ID.
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

/**
 * Describes a virtual machine scale set VM network profile.
 */
model VirtualMachineScaleSetVMNetworkProfileConfiguration {
  /**
   * The list of network configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  networkInterfaceConfigurations?: VirtualMachineScaleSetNetworkConfiguration[];
}

/**
 * The protection policy of a virtual machine scale set VM.
 */
model VirtualMachineScaleSetVMProtectionPolicy {
  /**
   * Indicates that the virtual machine scale set VM shouldn't be considered for
   * deletion during a scale-in operation.
   */
  protectFromScaleIn?: boolean;

  /**
   * Indicates that model updates or actions (including scale-in) initiated on the
   * virtual machine scale set should not be applied to the virtual machine scale
   * set VM.
   */
  protectFromScaleSetActions?: boolean;
}

/**
 * Identity for the virtual machine.
 */
model VirtualMachineIdentity {
  /**
   * The principal id of virtual machine identity. This property will only be
   * provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id associated with the virtual machine. This property will only be
   * provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of identity used for the virtual machine. The type 'SystemAssigned,
   * UserAssigned' includes both an implicitly created identity and a set of user
   * assigned identities. The type 'None' will remove any identities from the
   * virtual machine.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the Virtual Machine. The user
   * identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

/**
 * The List Virtual Machine Scale Set VMs operation response.
 */
model VirtualMachineScaleSetVMListResult
  is Azure.Core.Page<VirtualMachineScaleSetVM>;

/**
 * The SAS URIs of the console screenshot and serial log blobs.
 */
model RetrieveBootDiagnosticsDataResult {
  /**
   * The console screenshot blob URI
   */
  @visibility("read")
  consoleScreenshotBlobUri?: string;

  /**
   * The serial console log blob URI.
   */
  @visibility("read")
  serialConsoleLogBlobUri?: string;
}

/**
 * Specifies the input for attaching and detaching a list of managed data disks.
 */
model AttachDetachDataDisksRequest {
  /**
   * The list of managed data disks to be attached.
   */
  @OpenAPI.extension("x-ms-identifiers", ["diskId"])
  dataDisksToAttach?: DataDisksToAttach[];

  /**
   * The list of managed data disks to be detached.
   */
  @OpenAPI.extension("x-ms-identifiers", ["diskId"])
  dataDisksToDetach?: DataDisksToDetach[];
}

/**
 * Describes the data disk to be attached.
 */
model DataDisksToAttach {
  /**
   * ID of the managed data disk.
   */
  diskId: string;

  /**
   * The logical unit number of the data disk. This value is used to identify data
   * disks within the VM and therefore must be unique for each data disk attached to
   * a VM. If not specified, lun would be auto assigned.
   */
  lun?: int32;
}

/**
 * Describes the data disk to be detached.
 */
model DataDisksToDetach {
  /**
   * ID of the managed data disk.
   */
  diskId: string;

  /**
   * Supported options available for Detach of a disk from a VM. Refer to
   * DetachOption object reference for more details.
   */
  detachOption?: DiskDetachOptionTypes;
}

/**
 * The system meta data relating to this resource.
 */
model SystemData {
  /**
   * Specifies the time in UTC at which the Cloud Service (extended support)
   * resource was created. <br />Minimum api-version: 2022-04-04.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Specifies the time in UTC at which the Cloud Service (extended support)
   * resource was last modified. <br />Minimum api-version: 2022-04-04.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}
