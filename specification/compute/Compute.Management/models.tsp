import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Compute;

/**
 * Describes a virtual machine scale set sku. NOTE: If the new VM SKU is not supported on the hardware the scale set is currently on, you need to deallocate the VMs in the scale set before you modify the SKU name.
 */
model Sku {
  /**
   * The sku name.
   */
  name?: string;

  /**
   * Specifies the tier of virtual machines in a scale set.<br /><br /> Possible Values:<br /><br /> **Standard**<br /><br /> **Basic**
   */
  tier?: string;

  /**
   * Specifies the number of virtual machines in the scale set.
   */
  capacity?: int64;
}

/**
 * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use.  In the Azure portal, find the marketplace image that you want to use and then click **Want to deploy programmatically, Get Started ->**. Enter any required information and then click **Save**.
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
   * Specifies the product of the image from the marketplace. This is the same value as Offer under the imageReference element.
   */
  product?: string;

  /**
   * The promotion code.
   */
  promotionCode?: string;
}

/**
 * Type of repair action (replace, restart, reimage) that will be used for repairing unhealthy virtual machines in the scale set. Default value is replace.
 */
union RepairAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Replace: "Replace",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restart: "Restart",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Reimage: "Reimage",
}

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
 * Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings. The default behavior is: UefiSettings will not be enabled unless this property is set.
 */
union SecurityTypes {
  string,
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
 * Specifies the priority for a standalone virtual machine or the virtual machines in the scale set. 'Low' enum will be deprecated in the future, please use 'Spot' as the enum to deploy Azure Spot VM/VMSS.
 */
union VirtualMachinePriorityTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Regular: "Regular",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Low: "Low",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Spot: "Spot",
}

/**
 * Specifies the eviction policy for the Azure Spot VM/VMSS
 */
union VirtualMachineEvictionPolicyTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deallocate: "Deallocate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Delete: "Delete",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union VirtualMachineScaleSetScaleInRules {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OldestVM: "OldestVM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NewestVM: "NewestVM",
}

/**
 * Specifies the orchestration mode for the virtual machine scale set.
 */
union OrchestrationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Uniform: "Uniform",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Flexible: "Flexible",
}

/**
 * Type of rebalance strategy that will be used for rebalancing virtual machines in the scale set across availability zones. Default and only supported value for now is Recreate.
 */
union RebalanceStrategy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Recreate: "Recreate",
}

/**
 * Type of rebalance behavior that will be used for recreating virtual machines in the scale set across availability zones. Default and only supported value for now is CreateBeforeDelete.
 */
union RebalanceBehavior {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CreateBeforeDelete: "CreateBeforeDelete",
}

/**
 * Specifies the align mode between Virtual Machine Scale Set compute and storage Fault Domain count.
 */
union ZonalPlatformFaultDomainAlignMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Aligned: "Aligned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unaligned: "Unaligned",
}

/**
 * Specifies the allocation strategy for the virtual machine scale set based on which the VMs will be allocated.
 */
union AllocationStrategy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LowestPrice: "LowestPrice",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CapacityOptimized: "CapacityOptimized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Prioritized: "Prioritized",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ExpandTypesForGetVMScaleSets {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  userData: "userData",
}

/**
 * The name of the service.
 */
union OrchestrationServiceNames {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutomaticRepairs: "AutomaticRepairs",

  /**
   * AutomaticZoneRebalancing orchestration service.
   */
  @added(Versions.v2025_04_01)
  AutomaticZoneRebalancing: "AutomaticZoneRebalancing",
}

/**
 * The current state of the service.
 */
union OrchestrationServiceState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotRunning: "NotRunning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspended: "Suspended",
}

/**
 * The action to be performed.
 */
union OrchestrationServiceStateAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Resume: "Resume",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspend: "Suspend",
}

/**
 * The latest operation status of the service.
 */
@added(Versions.v2025_04_01)
union OrchestrationServiceOperationStatus {
  string,

  /**
   * InProgress orchestration service operation status.
   */
  InProgress: "InProgress",

  /**
   * Completed orchestration service operation status.
   */
  Completed: "Completed",
}

/**
 * The hypervisor generation of the Virtual Machine [V1, V2]
 */
union HyperVGeneration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V2: "V2",
}

/**
 * Specifies the size of the virtual machine. The enum data type is currently deprecated and will be removed by December 23rd 2023. The recommended way to get the list of available sizes is using these APIs: [List all available virtual machine sizes in an availability set](https://docs.microsoft.com/rest/api/compute/availabilitysets/listavailablesizes), [List all available virtual machine sizes in a region]( https://docs.microsoft.com/rest/api/compute/resourceskus/list), [List all available virtual machine sizes for resizing](https://docs.microsoft.com/rest/api/compute/virtualmachines/listavailablesizes). For more information about virtual machine sizes, see [Sizes for virtual machines](https://docs.microsoft.com/azure/virtual-machines/sizes). The available VM sizes depend on region and availability set.
 */
union VirtualMachineSizeTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic_A0: "Basic_A0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic_A1: "Basic_A1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic_A2: "Basic_A2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic_A3: "Basic_A3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic_A4: "Basic_A4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A0: "Standard_A0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A1: "Standard_A1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A2: "Standard_A2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A3: "Standard_A3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A4: "Standard_A4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A5: "Standard_A5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A6: "Standard_A6",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A7: "Standard_A7",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A8: "Standard_A8",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A9: "Standard_A9",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A10: "Standard_A10",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A11: "Standard_A11",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A1_v2: "Standard_A1_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A2_v2: "Standard_A2_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A4_v2: "Standard_A4_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A8_v2: "Standard_A8_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A2m_v2: "Standard_A2m_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A4m_v2: "Standard_A4m_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_A8m_v2: "Standard_A8m_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_B1s: "Standard_B1s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_B1ms: "Standard_B1ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_B2s: "Standard_B2s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_B2ms: "Standard_B2ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_B4ms: "Standard_B4ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_B8ms: "Standard_B8ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D1: "Standard_D1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D2: "Standard_D2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D3: "Standard_D3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D4: "Standard_D4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D11: "Standard_D11",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D12: "Standard_D12",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D13: "Standard_D13",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D14: "Standard_D14",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D1_v2: "Standard_D1_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D2_v2: "Standard_D2_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D3_v2: "Standard_D3_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D4_v2: "Standard_D4_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D5_v2: "Standard_D5_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D2_v3: "Standard_D2_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D4_v3: "Standard_D4_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D8_v3: "Standard_D8_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D16_v3: "Standard_D16_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D32_v3: "Standard_D32_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D64_v3: "Standard_D64_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D2s_v3: "Standard_D2s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D4s_v3: "Standard_D4s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D8s_v3: "Standard_D8s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D16s_v3: "Standard_D16s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D32s_v3: "Standard_D32s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D64s_v3: "Standard_D64s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D11_v2: "Standard_D11_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D12_v2: "Standard_D12_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D13_v2: "Standard_D13_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D14_v2: "Standard_D14_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_D15_v2: "Standard_D15_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS1: "Standard_DS1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS2: "Standard_DS2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS3: "Standard_DS3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS4: "Standard_DS4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS11: "Standard_DS11",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS12: "Standard_DS12",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS13: "Standard_DS13",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS14: "Standard_DS14",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS1_v2: "Standard_DS1_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS2_v2: "Standard_DS2_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS3_v2: "Standard_DS3_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS4_v2: "Standard_DS4_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS5_v2: "Standard_DS5_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS11_v2: "Standard_DS11_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS12_v2: "Standard_DS12_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS13_v2: "Standard_DS13_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS14_v2: "Standard_DS14_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_DS15_v2: "Standard_DS15_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_DS13-4_v2`: "Standard_DS13-4_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_DS13-2_v2`: "Standard_DS13-2_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_DS14-8_v2`: "Standard_DS14-8_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_DS14-4_v2`: "Standard_DS14-4_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E2_v3: "Standard_E2_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E4_v3: "Standard_E4_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E8_v3: "Standard_E8_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E16_v3: "Standard_E16_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E32_v3: "Standard_E32_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E64_v3: "Standard_E64_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E2s_v3: "Standard_E2s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E4s_v3: "Standard_E4s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E8s_v3: "Standard_E8s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E16s_v3: "Standard_E16s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E32s_v3: "Standard_E32s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_E64s_v3: "Standard_E64s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E32-16_v3`: "Standard_E32-16_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E32-8s_v3`: "Standard_E32-8s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E64-32s_v3`: "Standard_E64-32s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_E64-16s_v3`: "Standard_E64-16s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F1: "Standard_F1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F2: "Standard_F2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F4: "Standard_F4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F8: "Standard_F8",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F16: "Standard_F16",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F1s: "Standard_F1s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F2s: "Standard_F2s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F4s: "Standard_F4s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F8s: "Standard_F8s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F16s: "Standard_F16s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F2s_v2: "Standard_F2s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F4s_v2: "Standard_F4s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F8s_v2: "Standard_F8s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F16s_v2: "Standard_F16s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F32s_v2: "Standard_F32s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F64s_v2: "Standard_F64s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_F72s_v2: "Standard_F72s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_G1: "Standard_G1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_G2: "Standard_G2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_G3: "Standard_G3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_G4: "Standard_G4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_G5: "Standard_G5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_GS1: "Standard_GS1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_GS2: "Standard_GS2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_GS3: "Standard_GS3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_GS4: "Standard_GS4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_GS5: "Standard_GS5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_GS4-8`: "Standard_GS4-8",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_GS4-4`: "Standard_GS4-4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_GS5-16`: "Standard_GS5-16",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_GS5-8`: "Standard_GS5-8",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_H8: "Standard_H8",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_H16: "Standard_H16",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_H8m: "Standard_H8m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_H16m: "Standard_H16m",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_H16r: "Standard_H16r",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_H16mr: "Standard_H16mr",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L4s: "Standard_L4s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L8s: "Standard_L8s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L16s: "Standard_L16s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_L32s: "Standard_L32s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_M64s: "Standard_M64s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_M64ms: "Standard_M64ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_M128s: "Standard_M128s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_M128ms: "Standard_M128ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_M64-32ms`: "Standard_M64-32ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_M64-16ms`: "Standard_M64-16ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_M128-64ms`: "Standard_M128-64ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Standard_M128-32ms`: "Standard_M128-32ms",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC6: "Standard_NC6",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC12: "Standard_NC12",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC24: "Standard_NC24",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC24r: "Standard_NC24r",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC6s_v2: "Standard_NC6s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC12s_v2: "Standard_NC12s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC24s_v2: "Standard_NC24s_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC24rs_v2: "Standard_NC24rs_v2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC6s_v3: "Standard_NC6s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC12s_v3: "Standard_NC12s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC24s_v3: "Standard_NC24s_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NC24rs_v3: "Standard_NC24rs_v3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_ND6s: "Standard_ND6s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_ND12s: "Standard_ND12s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_ND24s: "Standard_ND24s",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_ND24rs: "Standard_ND24rs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NV6: "Standard_NV6",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NV12: "Standard_NV12",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard_NV24: "Standard_NV24",
}

/**
 * Specifies the resilient VM deletion status for the virtual machine.
 */
union ResilientVMDeletionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
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
 * Specifies the HyperVGeneration Type associated with a resource
 */
union HyperVGenerationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V2: "V2",
}

/**
 * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Unknown", "Failed", "Succeeded", or "CompletedWithWarnings."
 */
union PatchOperationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CompletedWithWarnings: "CompletedWithWarnings",
}

/**
 * Specifies the policy for resource's placement in availability zone. Possible values are: **Any** (used for Virtual Machines), **Auto** (used for Virtual Machine Scale Sets) - An availability zone will be automatically picked by system as part of resource creation.
 */
union ZonePlacementPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Any: "Any",

  /**
   * Automatic zone placement in a Virtual Machine Scale Set.
   */
  @added(Versions.v2025_04_01)
  Auto: "Auto",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ExpandTypesForListVMs {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  instanceView: "instanceView",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ExpandTypeForListVMs {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  instanceView: "instanceView",
}

/**
 * Describes the reboot requirements of the patch.
 */
union VMGuestPatchRebootBehavior {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NeverReboots: "NeverReboots",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlwaysRequiresReboot: "AlwaysRequiresReboot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CanRequestReboot: "CanRequestReboot",
}

/**
 * Describes the availability of a given patch.
 */
union PatchAssessmentState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Available: "Available",
}

/**
 * Defines when it is acceptable to reboot a VM during a software update operation.
 */
union VMGuestPatchRebootSetting {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IfRequired: "IfRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Never: "Never",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Always: "Always",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union VMGuestPatchClassificationWindows {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Critical: "Critical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Security: "Security",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpdateRollUp: "UpdateRollUp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FeaturePack: "FeaturePack",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServicePack: "ServicePack",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Definition: "Definition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Tools: "Tools",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updates: "Updates",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union VMGuestPatchClassificationLinux {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Critical: "Critical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Security: "Security",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Other: "Other",
}

/**
 * The reboot state of the VM following completion of the operation.
 */
union VMGuestPatchRebootStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotNeeded: "NotNeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Required: "Required",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Started: "Started",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
}

/**
 * The state of the patch after the installation operation completed.
 */
union PatchInstallationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Installed: "Installed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Excluded: "Excluded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSelected: "NotSelected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
}

/**
 * Specifies the HyperVGeneration Type
 */
union HyperVGenerationTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V2: "V2",
}

/**
 * Specifies the high speed interconnect placement for the virtual machine scale set.
 */
@added(Versions.v2025_04_01)
union HighSpeedInterconnectPlacement {
  string,

  /** No high speed interconnect placement */
  None: "None",

  /** Trunk high speed interconnect placement */
  Trunk: "Trunk",
}

/**
 * VM disk types which are disallowed.
 */
union VmDiskTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unmanaged: "Unmanaged",
}

/**
 * Specifies the Architecture Type
 */
union ArchitectureTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  x64: "x64",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Arm64: "Arm64",
}

/**
 * Describes the state of the image.
 */
union ImageState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ScheduledForDeprecation: "ScheduledForDeprecation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deprecated: "Deprecated",
}

/**
 * Describes the type of the alternative option.
 */
union AlternativeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Offer: "Offer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Plan: "Plan",
}

/**
 * Specifies the type of the proximity placement group. Possible values are: **Standard** : Co-locate resources within an Azure region or Availability Zone. **Ultra** : For future use.
 */
union ProximityPlacementGroupType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ultra: "Ultra",
}

/**
 * The encryption type of the SSH keys to be generated. See SshEncryptionTypes for possible set of values. If not provided, will default to RSA
 */
union SshEncryptionTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RSA: "RSA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ed25519: "Ed25519",
}

/**
 * Gets the Operating System type.
 */
union OperatingSystemType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Linux: "Linux",
}

/**
 * The type of key used to encrypt the data of the disk restore point.
 */
union RestorePointEncryptionType {
  string,

  /**
   * Disk Restore Point is encrypted at rest with Platform managed key.
   */
  EncryptionAtRestWithPlatformKey: "EncryptionAtRestWithPlatformKey",

  /**
   * Disk Restore Point is encrypted at rest with Customer managed key that can be changed and revoked by a customer.
   */
  EncryptionAtRestWithCustomerKey: "EncryptionAtRestWithCustomerKey",

  /**
   * Disk Restore Point is encrypted at rest with 2 layers of encryption. One of the keys is Customer managed and the other key is Platform managed.
   */
  EncryptionAtRestWithPlatformAndCustomerKeys: "EncryptionAtRestWithPlatformAndCustomerKeys",
}

/**
 * ConsistencyMode of the RestorePoint. Can be specified in the input while creating a restore point. For now, only CrashConsistent is accepted as a valid input. Please refer to https://aka.ms/RestorePoints for more details.
 */
union ConsistencyModeTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CrashConsistent: "CrashConsistent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FileSystemConsistent: "FileSystemConsistent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ApplicationConsistent: "ApplicationConsistent",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union RestorePointCollectionExpandOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  restorePoints: "restorePoints",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union RestorePointExpandOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  instanceView: "instanceView",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ExpandTypesForGetCapacityReservationGroups {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `virtualMachineScaleSetVMs/$ref`: "virtualMachineScaleSetVMs/$ref",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `virtualMachines/$ref`: "virtualMachines/$ref",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ResourceIdOptionsForGetCapacityReservationGroups {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CreatedInSubscription: "CreatedInSubscription",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SharedWithSubscription: "SharedWithSubscription",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  All: "All",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union CapacityReservationGroupInstanceViewTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  instanceView: "instanceView",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union CapacityReservationInstanceViewTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  instanceView: "instanceView",
}

/**
 * Script execution status.
 */
union ExecutionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TimedOut: "TimedOut",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Script shell types.
 */
@added(Versions.v2025_04_01)
union ScriptShellTypes {
  string,

  /**
   * Default script shell type.
   */
  Default: "Default",

  /**
   * Powershell7 script shell type.
   */
  Powershell7: "Powershell7",
}

/**
 * Specifies the sku of an Availability Set. Use 'Aligned' for virtual machines with managed disks and 'Classic' for virtual machines with unmanaged disks. Default value is 'Classic'.
 */
union AvailabilitySetSkuTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Classic: "Classic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Aligned: "Aligned",
}

/**
 * Specifies the mode of an upgrade to virtual machines in the scale set.<br /><br /> Possible values are:<br /><br /> **Manual** - You  control the application of updates to virtual machines in the scale set. You do this by using the manualUpgrade action.<br /><br /> **Automatic** - All virtual machines in the scale set are  automatically updated at the same time.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum UpgradeMode {
  Automatic,
  Manual,
  Rolling,
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
 * This property allows you to specify the type of the OS that is included in the disk if creating a VM from user-image or a specialized VHD. Possible values are: **Windows,** **Linux.**
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperatingSystemTypes {
  Windows,
  Linux,
}

/**
 * The type of identity used for the virtual machine scale set. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine scale set.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The level code.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum StatusLevelTypes {
  Info,
  Warning,
  Error,
}

/**
 * Code indicating the current status of the upgrade.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum UpgradeState {
  RollingForward,
  Cancelled,
  Completed,
  Faulted,
}

/**
 * Invoker of the Upgrade Operation
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum UpgradeOperationInvoker {
  Unknown,
  User,
  Platform,
}

/**
 * Code indicating the current status of the upgrade.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RollingUpgradeStatusCode {
  RollingForward,
  Cancelled,
  Completed,
  Faulted,
}

/**
 * The last action performed on the rolling upgrade.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RollingUpgradeActionType {
  Start,
  Cancel,
}

/**
 * The scale type applicable to the sku.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum VirtualMachineScaleSetSkuScaleType {
  Automatic,
  None,
}

/**
 * The Last Maintenance Operation Result Code.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum MaintenanceOperationResultCodeTypes {
  None,
  RetryLater,
  MaintenanceAborted,
  MaintenanceCompleted,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum InstanceViewTypes {
  instanceView,
  userData,
  resiliencyView,
}
/**
 * Specifies the software license type that will be applied to the VMs deployed on the dedicated host. Possible values are: **None,** **Windows_Server_Hybrid,** **Windows_Server_Perpetual.** The default value is: **None.**
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DedicatedHostLicenseTypes {
  None,
  Windows_Server_Hybrid,
  Windows_Server_Perpetual,
}

/**
 * The OS State. For managed images, use Generalized.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperatingSystemStateTypes {
  /**
   * Generalized image. Needs to be provisioned during deployment time.
   */
  Generalized,

  /**
   * Specialized image. Contains already provisioned OS Disk.
   */
  Specialized,
}

/**
 * Interval value in minutes used to create LogAnalytics call rate logs.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum IntervalInMins {
  ThreeMins,
  FiveMins,
  ThirtyMins,
  SixtyMins,
}

/**
 * The List Usages operation response.
 */
model ListUsagesResult is Azure.Core.Page<Usage>;

@@identifiers(ListUsagesResult.value, #[]);
@@doc(ListUsagesResult.value, "The list of compute resource usages.");
@@doc(ListUsagesResult.nextLink,
  "The URI to fetch the next page of compute resource usage information. Call ListNext() with this to fetch the next page of compute resource usage information."
);

/**
 * Describes Compute Resource Usage.
 */
model Usage {
  /**
   * An enum describing the unit of usage measurement.
   */
  unit: "Count";

  /**
   * The current usage of the resource.
   */
  currentValue: int32;

  /**
   * The maximum permitted usage of the resource.
   */
  limit: int64;

  /**
   * The name of the type of usage.
   */
  name: UsageName;
}

/**
 * The Usage Names.
 */
model UsageName {
  /**
   * The name of the resource.
   */
  value?: string;

  /**
   * The localized name of the resource.
   */
  localizedValue?: string;
}

/**
 * The List Virtual Machine operation response.
 */
model VirtualMachineSizeListResult {
  /**
   * The list of virtual machine sizes.
   */
  @pageItems
  @identifiers(#["name"])
  value?: VirtualMachineSize[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Describes the properties of a VM size.
 */
model VirtualMachineSize {
  /**
   * The name of the virtual machine size.
   */
  name?: string;

  /**
   * The number of cores supported by the virtual machine size. For Constrained vCPU capable VM sizes, this number represents the total vCPUs of quota that the VM uses. For accurate vCPU count, please refer to https://docs.microsoft.com/azure/virtual-machines/constrained-vcpu or https://docs.microsoft.com/rest/api/compute/resourceskus/list
   */
  numberOfCores?: int32;

  /**
   * The OS disk size, in MB, allowed by the virtual machine size.
   */
  osDiskSizeInMB?: int32;

  /**
   * The resource disk size, in MB, allowed by the virtual machine size.
   */
  resourceDiskSizeInMB?: int32;

  /**
   * The amount of memory, in MB, supported by the virtual machine size.
   */
  memoryInMB?: int32;

  /**
   * The maximum number of data disks that can be attached to the virtual machine size.
   */
  maxDataDiskCount?: int32;
}

/**
 * The List Virtual Machine operation response.
 */
model VirtualMachineScaleSetListResult
  is Azure.Core.Page<VirtualMachineScaleSet>;

@@doc(VirtualMachineScaleSetListResult.value,
  "The list of virtual machine scale sets."
);
@@doc(VirtualMachineScaleSetListResult.nextLink,
  "The uri to fetch the next page of Virtual Machine Scale Sets. Call ListNext() with this to fetch the next page of VMSS."
);

/**
 * Describes the properties of a Virtual Machine Scale Set.
 */
model VirtualMachineScaleSetProperties {
  /**
   * The upgrade policy.
   */
  upgradePolicy?: UpgradePolicy;

  /**
   * The ScheduledEventsPolicy.
   */
  scheduledEventsPolicy?: ScheduledEventsPolicy;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Specifies whether the Virtual Machine Scale Set should be overprovisioned.
   */
  overprovision?: boolean;

  /**
   * When Overprovision is enabled, extensions are launched only on the requested number of VMs which are finally kept. This property will hence ensure that the extensions do not run on the extra overprovisioned VMs.
   */
  doNotRunExtensionsOnOverprovisionedVMs?: boolean;

  /**
   * Specifies the ID which uniquely identifies a Virtual Machine Scale Set.
   */
  @visibility(Lifecycle.Read)
  uniqueId?: string;

  /**
   * When true this limits the scale set to a single placement group, of max size 100 virtual machines. NOTE: If singlePlacementGroup is true, it may be modified to false. However, if singlePlacementGroup is false, it may not be modified to true.
   */
  singlePlacementGroup?: boolean;

  /**
   * Whether to force strictly even Virtual Machine distribution cross x-zones in case there is zone outage. zoneBalance property can only be set if the zones property of the scale set contains more than one zone. If there are no zones or only one zone specified, then zoneBalance property should not be set.
   */
  zoneBalance?: boolean;

  /**
   * Fault Domain count for each placement group.
   */
  platformFaultDomainCount?: int32;

  /**
   * Specifies information about the proximity placement group that the virtual machine scale set should be assigned to. Minimum api-version: 2018-04-01.
   */
  proximityPlacementGroup?: SubResource;

  /**
   * Specifies information about the dedicated host group that the virtual machine scale set resides in. Minimum api-version: 2020-06-01.
   */
  hostGroup?: SubResource;

  /**
   * Specifies additional capabilities enabled or disabled on the Virtual Machines in the Virtual Machine Scale Set. For instance: whether the Virtual Machines have the capability to support attaching managed data disks with UltraSSD_LRS storage account type.
   */
  additionalCapabilities?: AdditionalCapabilities;

  /**
   * Specifies the policies applied when scaling in Virtual Machines in the Virtual Machine Scale Set.
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
   * Specifies the desired targets for mixing Spot and Regular priority VMs within the same VMSS Flex instance.
   */
  priorityMixPolicy?: PriorityMixPolicy;

  /**
   * Specifies the time at which the Virtual Machine Scale Set resource was created. Minimum api-version: 2021-11-01.
   */
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;

  /**
   * Optional property which must either be set to True or omitted.
   */
  constrainedMaximumCapacity?: boolean;

  /**
   * Policy for Resiliency
   */
  resiliencyPolicy?: ResiliencyPolicy;

  /**
   * Specifies the align mode between Virtual Machine Scale Set compute and storage Fault Domain count.
   */
  zonalPlatformFaultDomainAlignMode?: ZonalPlatformFaultDomainAlignMode;

  /**
   * Specifies the sku profile for the virtual machine scale set.
   */
  skuProfile?: SkuProfile;

  /**
   * Specifies the high speed interconnect placement for the virtual machine scale set.
   */
  @added(Versions.v2025_04_01)
  highSpeedInterconnectPlacement?: HighSpeedInterconnectPlacement;
}

/**
 * Describes an upgrade policy - automatic, manual, or rolling.
 */
model UpgradePolicy {
  /**
   * Specifies the mode of an upgrade to virtual machines in the scale set.<br /><br /> Possible values are:<br /><br /> **Manual** - You  control the application of updates to virtual machines in the scale set. You do this by using the manualUpgrade action.<br /><br /> **Automatic** - All virtual machines in the scale set are  automatically updated at the same time.
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
   * The maximum percent of total virtual machine instances that will be upgraded simultaneously by the rolling upgrade in one batch. As this is a maximum, unhealthy instances in previous or future batches can cause the percentage of instances in a batch to decrease to ensure higher reliability. The default value for this parameter is 20%.
   */
  @maxValue(100)
  @minValue(5)
  maxBatchInstancePercent?: int32;

  /**
   * The maximum percentage of the total virtual machine instances in the scale set that can be simultaneously unhealthy, either as a result of being upgraded, or by being found in an unhealthy state by the virtual machine health checks before the rolling upgrade aborts. This constraint will be checked prior to starting any batch. The default value for this parameter is 20%.
   */
  @maxValue(100)
  @minValue(5)
  maxUnhealthyInstancePercent?: int32;

  /**
   * The maximum percentage of upgraded virtual machine instances that can be found to be in an unhealthy state. This check will happen after each batch is upgraded. If this percentage is ever exceeded, the rolling update aborts. The default value for this parameter is 20%.
   */
  @maxValue(100)
  maxUnhealthyUpgradedInstancePercent?: int32;

  /**
   * The wait time between completing the update for all virtual machines in one batch and starting the next batch. The time duration should be specified in ISO 8601 format. The default value is 0 seconds (PT0S).
   */
  pauseTimeBetweenBatches?: string;

  /**
   * Allow VMSS to ignore AZ boundaries when constructing upgrade batches. Take into consideration the Update Domain and maxBatchInstancePercent to determine the batch size.
   */
  enableCrossZoneUpgrade?: boolean;

  /**
   * Upgrade all unhealthy instances in a scale set before any healthy instances.
   */
  prioritizeUnhealthyInstances?: boolean;

  /**
   * Rollback failed instances to previous model if the Rolling Upgrade policy is violated.
   */
  rollbackFailedInstancesOnPolicyBreach?: boolean;

  /**
   * Create new virtual machines to upgrade the scale set, rather than updating the existing virtual machines. Existing virtual machines will be deleted once the new virtual machines are created for each batch.
   */
  maxSurge?: boolean;
}

/**
 * The configuration parameters used for performing automatic OS upgrade.
 */
model AutomaticOSUpgradePolicy {
  /**
   * Indicates whether OS upgrades should automatically be applied to scale set instances in a rolling fashion when a newer version of the OS image becomes available. Default value is false. If this is set to true for Windows based scale sets, [enableAutomaticUpdates](https://docs.microsoft.com/dotnet/api/microsoft.azure.management.compute.models.windowsconfiguration.enableautomaticupdates?view=azure-dotnet) is automatically set to false and cannot be set to true.
   */
  enableAutomaticOSUpgrade?: boolean;

  /**
   * Whether OS image rollback feature should be disabled. Default value is false.
   */
  disableAutomaticRollback?: boolean;

  /**
   * Indicates whether rolling upgrade policy should be used during Auto OS Upgrade. Default value is false. Auto OS Upgrade will fallback to the default policy if no policy is defined on the VMSS.
   */
  useRollingUpgradePolicy?: boolean;

  /**
   * Indicates whether Auto OS Upgrade should undergo deferral. Deferred OS upgrades will send advanced notifications on a per-VM basis that an OS upgrade from rolling upgrades is incoming, via the IMDS tag 'Platform.PendingOSUpgrade'. The upgrade then defers until the upgrade is approved via an ApproveRollingUpgrade call.
   */
  osRollingUpgradeDeferral?: boolean;
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
 * Specifies the configuration parameters for automatic repairs on the virtual machine scale set.
 */
model AutomaticRepairsPolicy {
  /**
   * Specifies whether automatic repairs should be enabled on the virtual machine scale set. The default value is false.
   */
  enabled?: boolean;

  /**
   * The amount of time for which automatic repairs are suspended due to a state change on VM. The grace time starts after the state change has completed. This helps avoid premature or accidental repairs. The time duration should be specified in ISO 8601 format. The minimum allowed grace period is 10 minutes (PT10M), which is also the default value. The maximum allowed grace period is 90 minutes (PT90M).
   */
  gracePeriod?: string;

  /**
   * Type of repair action (replace, restart, reimage) that will be used for repairing unhealthy virtual machines in the scale set. Default value is replace.
   */
  repairAction?: RepairAction;
}

/**
 * Describes a virtual machine scale set virtual machine profile.
 */
model VirtualMachineScaleSetVMProfile {
  /**
   * Specifies the operating system settings for the virtual machines in the scale set.
   */
  osProfile?: VirtualMachineScaleSetOSProfile;

  /**
   * Specifies the storage settings for the virtual machine disks.
   */
  storageProfile?: VirtualMachineScaleSetStorageProfile;

  /**
   * Specifies properties of the network interfaces of the virtual machines in the scale set.
   */
  networkProfile?: VirtualMachineScaleSetNetworkProfile;

  /**
   * Specifies the Security related profile settings for the virtual machines in the scale set.
   */
  securityProfile?: SecurityProfile;

  /**
   * Specifies the boot diagnostic settings state. Minimum api-version: 2015-06-15.
   */
  diagnosticsProfile?: DiagnosticsProfile;

  /**
   * Specifies a collection of settings for extensions installed on virtual machines in the scale set.
   */
  extensionProfile?: VirtualMachineScaleSetExtensionProfile;

  /**
   * Specifies that the image or disk that is being used was licensed on-premises. <br><br> Possible values for Windows Server operating system are: <br><br> Windows_Client <br><br> Windows_Server <br><br> Possible values for Linux Server operating system are: <br><br> RHEL_BYOS (for RHEL) <br><br> SLES_BYOS (for SUSE) <br><br> For more information, see [Azure Hybrid Use Benefit for Windows Server](https://docs.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing) <br><br> [Azure Hybrid Use Benefit for Linux Server](https://docs.microsoft.com/azure/virtual-machines/linux/azure-hybrid-benefit-linux) <br><br> Minimum api-version: 2015-06-15
   */
  licenseType?: string;

  /**
   * Specifies the priority for the virtual machines in the scale set. Minimum api-version: 2017-10-30-preview.
   */
  priority?: VirtualMachinePriorityTypes;

  /**
   * Specifies the eviction policy for the Azure Spot virtual machine and Azure Spot scale set. For Azure Spot virtual machines, both 'Deallocate' and 'Delete' are supported and the minimum api-version is 2019-03-01. For Azure Spot scale sets, both 'Deallocate' and 'Delete' are supported and the minimum api-version is 2017-10-30-preview.
   */
  evictionPolicy?: VirtualMachineEvictionPolicyTypes;

  /**
   * Specifies the billing related details of a Azure Spot VMSS. Minimum api-version: 2019-03-01.
   */
  billingProfile?: BillingProfile;

  /**
   * Specifies Scheduled Event related configurations.
   */
  scheduledEventsProfile?: ScheduledEventsProfile;

  /**
   * UserData for the virtual machines in the scale set, which must be base-64 encoded. Customer should not pass any secrets in here. Minimum api-version: 2021-03-01.
   */
  userData?: string;

  /**
   * Specifies the capacity reservation related details of a scale set. Minimum api-version: 2021-04-01.
   */
  capacityReservation?: CapacityReservationProfile;

  /**
   * Specifies the gallery applications that should be made available to the VM/VMSS
   */
  applicationProfile?: ApplicationProfile;

  /**
   * Specifies the hardware profile related details of a scale set. Minimum api-version: 2021-11-01.
   */
  hardwareProfile?: VirtualMachineScaleSetHardwareProfile;

  /**
   * Specifies the service artifact reference id used to set same image version for all virtual machines in the scale set when using 'latest' image version. Minimum api-version: 2022-11-01
   */
  serviceArtifactReference?: ServiceArtifactReference;

  /**
   * Specifies the security posture to be used in the scale set. Minimum api-version: 2023-03-01
   */
  securityPostureReference?: SecurityPostureReference;

  /**
   * Specifies the time in which this VM profile for the Virtual Machine Scale Set was created. This value will be added to VMSS Flex VM tags when creating/updating the VMSS VM Profile. Minimum API version for this property is 2023-09-01.
   */
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;
}

/**
 * Describes a virtual machine scale set OS profile.
 */
model VirtualMachineScaleSetOSProfile {
  /**
   * Specifies the computer name prefix for all of the virtual machines in the scale set. Computer name prefixes must be 1 to 15 characters long.
   */
  computerNamePrefix?: string;

  /**
   * Specifies the name of the administrator account. <br><br> **Windows-only restriction:** Cannot end in "." <br><br> **Disallowed values:** "administrator", "admin", "user", "user1", "test", "user2", "test1", "user3", "admin1", "1", "123", "a", "actuser", "adm", "admin2", "aspnet", "backup", "console", "david", "guest", "john", "owner", "root", "server", "sql", "support", "support_388945a0", "sys", "test2", "test3", "user4", "user5". <br><br> **Minimum-length (Linux):** 1  character <br><br> **Max-length (Linux):** 64 characters <br><br> **Max-length (Windows):** 20 characters
   */
  adminUsername?: string;

  @doc("Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)")
  @secret
  adminPassword?: string;

  /**
   * Specifies a base-64 encoded string of custom data. The base-64 encoded string is decoded to a binary array that is saved as a file on the Virtual Machine. The maximum length of the binary array is 65535 bytes. For using cloud-init for your VM, see [Using cloud-init to customize a Linux VM during creation](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init)
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
   * Specifies set of certificates that should be installed onto the virtual machines in the scale set. To install certificates on a virtual machine it is recommended to use the [Azure Key Vault virtual machine extension for Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux) or the [Azure Key Vault virtual machine extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).
   */
  @identifiers(#["sourceVault/id"])
  secrets?: VaultSecretGroup[];

  /**
   * Specifies whether extension operations should be allowed on the virtual machine scale set. This may only be set to False when no extensions are present on the virtual machine scale set.
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
 * The component name. Currently, the only allowable value is Microsoft-Windows-Shell-Setup.
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union"
union ComponentNames {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  "Microsoft-Windows-Shell-Setup",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union"
union PassNames {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  "OobeSystem",
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
 * Describes a virtual machine scale set storage profile.
 */
model VirtualMachineScaleSetStorageProfile {
  /**
   * Specifies information about the image to use. You can specify information about platform images, marketplace images, or virtual machine images. This element is required when you want to use a platform image, marketplace image, or virtual machine image, but is not used in other creation operations.
   */
  imageReference?: ImageReference;

  /**
   * Specifies information about the operating system disk used by the virtual machines in the scale set. For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  osDisk?: VirtualMachineScaleSetOSDisk;

  /**
   * Specifies the parameters that are used to add data disks to the virtual machines in the scale set. For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  @identifiers(#["name", "lun"])
  dataDisks?: VirtualMachineScaleSetDataDisk[];

  /**
   * Specifies the disk controller type configured for the virtual machines in the scale set. Minimum api-version: 2022-08-01
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  diskControllerType?: DiskControllerTypes;
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
 * Describes a virtual machine scale set operating system disk.
 */
model VirtualMachineScaleSetOSDisk {
  /**
   * The disk name.
   */
  name?: string;

  /**
   * Specifies the caching requirements. Possible values are: **None,** **ReadOnly,** **ReadWrite.** The default values are: **None for Standard storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;

  /**
   * Specifies how the virtual machines in the scale set should be created. The only allowed value is: **FromImage.** This value is used when you are using an image to create the virtual machine. If you are using a platform image, you also use the imageReference element described above. If you are using a marketplace image, you  also use the plan element previously described.
   */
  createOption: DiskCreateOptionTypes;

  /**
   * Specifies the ephemeral disk Settings for the operating system disk used by the virtual machine scale set.
   */
  diffDiskSettings?: DiffDiskSettings;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used to overwrite the size of the disk in a virtual machine image. The property 'diskSizeGB' is the number of bytes x 1024^3 for the disk and the value cannot be larger than 1023.
   */
  diskSizeGB?: int32;

  /**
   * This property allows you to specify the type of the OS that is included in the disk if creating a VM from user-image or a specialized VHD. Possible values are: **Windows,** **Linux.**
   */
  osType?: OperatingSystemTypes;

  /**
   * Specifies information about the unmanaged user image to base the scale set on.
   */
  image?: VirtualHardDisk;

  /**
   * Specifies the container urls that are used to store operating system disks for the scale set.
   */
  vhdContainers?: string[];

  /**
   * The managed disk parameters.
   */
  managedDisk?: VirtualMachineScaleSetManagedDiskParameters;

  /**
   * Specifies whether OS Disk should be deleted or detached upon VMSS Flex deletion (This feature is available for VMSS with Flexible OrchestrationMode only). <br><br> Possible values: <br><br> **Delete** If this value is used, the OS disk is deleted when VMSS Flex VM is deleted.<br><br> **Detach** If this value is used, the OS disk is retained after VMSS Flex VM is deleted. <br><br> The default value is set to **Delete**. For an Ephemeral OS Disk, the default value is set to **Delete**. User cannot change the delete option for Ephemeral OS Disk.
   */
  deleteOption?: DiskDeleteOptionTypes;
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
 * Describes a virtual machine scale set data disk.
 */
model VirtualMachineScaleSetDataDisk {
  /**
   * The disk name.
   */
  name?: string;

  /**
   * Specifies the logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM.
   */
  lun: int32;

  /**
   * Specifies the caching requirements. Possible values are: **None,** **ReadOnly,** **ReadWrite.** The default values are: **None for Standard storage. ReadOnly for Premium storage.**
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
   * Specifies the size of an empty data disk in gigabytes. This element can be used to overwrite the size of the disk in a virtual machine image. The property diskSizeGB is the number of bytes x 1024^3 for the disk and the value cannot be larger than 1023.
   */
  diskSizeGB?: int32;

  /**
   * The managed disk parameters.
   */
  managedDisk?: VirtualMachineScaleSetManagedDiskParameters;

  /**
   * Specifies the Read-Write IOPS for the managed disk. Should be used only when StorageAccountType is UltraSSD_LRS. If not specified, a default value would be assigned based on diskSizeGB.
   */
  diskIOPSReadWrite?: int64;

  /**
   * Specifies the bandwidth in MB per second for the managed disk. Should be used only when StorageAccountType is UltraSSD_LRS. If not specified, a default value would be assigned based on diskSizeGB.
   */
  diskMBpsReadWrite?: int64;

  /**
   * Specifies whether data disk should be deleted or detached upon VMSS Flex deletion (This feature is available for VMSS with Flexible OrchestrationMode only).<br><br> Possible values: <br><br> **Delete** If this value is used, the data disk is deleted when the VMSS Flex VM is deleted.<br><br> **Detach** If this value is used, the data disk is retained after VMSS Flex VM is deleted.<br><br> The default value is set to **Delete**.
   */
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * Describes a virtual machine scale set network profile.
 */
model VirtualMachineScaleSetNetworkProfile {
  /**
   * A reference to a load balancer probe used to determine the health of an instance in the virtual machine scale set. The reference will be in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}'.
   */
  healthProbe?: ApiEntityReference;

  /**
   * The list of network configurations.
   */
  @identifiers(#[])
  networkInterfaceConfigurations?: VirtualMachineScaleSetNetworkConfiguration[];

  /**
   * specifies the Microsoft.Network API version used when creating networking resources in the Network Interface Configurations for Virtual Machine Scale Set with orchestration mode 'Flexible'
   */
  networkApiVersion?: NetworkApiVersion;
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineScaleSetNetworkConfigurationProperties;

  /**
   * Resource tags applied to the networkInterface address created by this NetworkInterfaceConfiguration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @added(Versions.v2025_04_01)
  tags?: Record<string>;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration.
 */
model VirtualMachineScaleSetNetworkConfigurationProperties {
  /**
   * Specifies the primary network interface in case the virtual machine has more than 1 network interface.
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
  @identifiers(#["name"])
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
   * Specifies whether the Auxiliary mode is enabled for the Network Interface resource.
   */
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;

  /**
   * Specifies whether the Auxiliary sku is enabled for the Network Interface resource.
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
   * Describes a virtual machine scale set network profile's IP configuration properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineScaleSetIPConfigurationProperties;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration properties.
 */
model VirtualMachineScaleSetIPConfigurationProperties {
  /**
   * Specifies the identifier of the subnet.
   */
  subnet?: ApiEntityReference;

  /**
   * Specifies the primary network interface in case the virtual machine has more than 1 network interface.
   */
  primary?: boolean;

  /**
   * The publicIPAddressConfiguration.
   */
  publicIPAddressConfiguration?: VirtualMachineScaleSetPublicIPAddressConfiguration;

  /**
   * Available from Api-Version 2017-03-30 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible values are: 'IPv4' and 'IPv6'.
   */
  privateIPAddressVersion?: IPVersion;

  /**
   * Specifies an array of references to backend address pools of application gateways. A scale set can reference backend address pools of multiple application gateways. Multiple scale sets cannot use the same application gateway.
   */
  applicationGatewayBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to application security group.
   */
  applicationSecurityGroups?: SubResource[];

  /**
   * Specifies an array of references to backend address pools of load balancers. A scale set can reference backend address pools of one public and one internal load balancer. Multiple scale sets cannot use the same basic sku load balancer.
   */
  loadBalancerBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to inbound Nat pools of the load balancers. A scale set can reference inbound nat pools of one public and one internal load balancer. Multiple scale sets cannot use the same basic sku load balancer.
   */
  loadBalancerInboundNatPools?: SubResource[];
}

/**
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress configuration
 */
model VirtualMachineScaleSetPublicIPAddressConfiguration {
  /**
   * The publicIP address configuration name.
   */
  name: string;

  /**
   * Describes a virtual machines scale set IP Configuration's PublicIPAddress configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineScaleSetPublicIPAddressConfigurationProperties;

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
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress configuration
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
  @identifiers(#[])
  ipTags?: VirtualMachineScaleSetIpTag[];

  /**
   * The PublicIPPrefix from which to allocate publicIP addresses.
   */
  publicIPPrefix?: SubResource;

  /**
   * Available from Api-Version 2019-07-01 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. Possible values are: 'IPv4' and 'IPv6'.
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
   * The Domain name label.The concatenation of the domain name label and vm index will be the domain name labels of the PublicIPAddress resources that will be created
   */
  domainNameLabel: string;

  /**
   * The Domain name label scope.The concatenation of the hashed domain name label that generated according to the policy from domain name label scope and vm index will be the domain name labels of the PublicIPAddress resources that will be created
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
   * Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings. The default behavior is: UefiSettings will not be enabled unless this property is set.
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
 * Describes a virtual machine scale set extension profile.
 */
model VirtualMachineScaleSetExtensionProfile {
  /**
   * The virtual machine scale set child extension resources.
   */
  @identifiers(#["name", "id"])
  extensions?: VirtualMachineScaleSetExtension[];

  /**
   * Specifies the time alloted for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. The default value is 90 minutes (PT1H30M). Minimum api-version: 2020-06-01.
   */
  extensionsTimeBudget?: string;
}

/**
 * Describes the properties of a Virtual Machine Scale Set Extension.
 */
model VirtualMachineScaleSetExtensionProperties {
  /**
   * If a value is provided and is different from the previous value, the extension handler will be forced to update even if the extension configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "backcompat"
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  settings?: unknown;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  protectedSettings?: unknown;

  /**
   * The provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Collection of extension names after which this extension needs to be provisioned.
   */
  provisionAfterExtensions?: string[];

  /**
   * Indicates whether failures stemming from the extension will be suppressed (Operational failures such as not connecting to the VM will not be suppressed regardless of this value). The default is false.
   */
  suppressFailures?: boolean;

  /**
   * The extensions protected settings that are passed by reference, and consumed from key vault
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

/**
 * Specifies the billing related details of a Azure Spot VM or VMSS. Minimum api-version: 2019-03-01.
 */
model BillingProfile {
  /**
   * Specifies the maximum price you are willing to pay for a Azure Spot VM/VMSS. This price is in US Dollars. <br><br> This price will be compared with the current Azure Spot price for the VM size. Also, the prices are compared at the time of create/update of Azure Spot VM/VMSS and the operation will only succeed if  the maxPrice is greater than the current Azure Spot price. <br><br> The maxPrice will also be used for evicting a Azure Spot VM/VMSS if the current Azure Spot price goes beyond the maxPrice after creation of VM/VMSS. <br><br> Possible values are: <br><br> - Any decimal value greater than zero. Example: 0.01538 <br><br> -1 – indicates default price to be up-to on-demand. <br><br> You can set the maxPrice to -1 to indicate that the Azure Spot VM/VMSS should not be evicted for price reasons. Also, the default max price is -1 if it is not provided by you. <br><br>Minimum api-version: 2019-03-01.
   */
  maxPrice?: float64;
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
 * Specifies the hardware settings for the virtual machine scale set.
 */
model VirtualMachineScaleSetHardwareProfile {
  /**
   * Specifies the properties for customizing the size of the virtual machine. Minimum api-version: 2021-11-01. Please follow the instructions in [VM Customization](https://aka.ms/vmcustomization) for more details.
   */
  vmSizeProperties?: VMSizeProperties;
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
 * Specifies the service artifact reference id used to set same image version for all virtual machines in the scale set when using 'latest' image version. Minimum api-version: 2022-11-01
 */
model ServiceArtifactReference {
  /**
   * The service artifact reference id in the form of /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/serviceArtifacts/{serviceArtifactName}/vmArtifactsProfiles/{vmArtifactsProfilesName}
   */
  id?: string;
}

/**
 * Specifies the security posture to be used in the scale set. Minimum api-version: 2023-03-01
 */
model SecurityPostureReference {
  /**
   * The security posture reference id in the form of /CommunityGalleries/{communityGalleryName}/securityPostures/{securityPostureName}/versions/{major.minor.patch}|latest
   */
  id: string;

  /**
   * The list of virtual machine extension names to exclude when applying the security posture.
   */
  excludeExtensions?: string[];

  /**
   * Whether the security posture can be overridden by the user.
   */
  isOverridable?: boolean;
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
}

/**
 * Describes a scale-in policy for a virtual machine scale set.
 */
model ScaleInPolicy {
  /**
   * The rules to be followed when scaling-in a virtual machine scale set. <br><br> Possible values are: <br><br> **Default** When a virtual machine scale set is scaled in, the scale set will first be balanced across zones if it is a zonal scale set. Then, it will be balanced across Fault Domains as far as possible. Within each Fault Domain, the virtual machines chosen for removal will be the newest ones that are not protected from scale-in. <br><br> **OldestVM** When a virtual machine scale set is being scaled-in, the oldest virtual machines that are not protected from scale-in will be chosen for removal. For zonal virtual machine scale sets, the scale set will first be balanced across zones. Within each zone, the oldest virtual machines that are not protected will be chosen for removal. <br><br> **NewestVM** When a virtual machine scale set is being scaled-in, the newest virtual machines that are not protected from scale-in will be chosen for removal. For zonal virtual machine scale sets, the scale set will first be balanced across zones. Within each zone, the newest virtual machines that are not protected will be chosen for removal. <br><br>
   */
  rules?: VirtualMachineScaleSetScaleInRules[];

  /**
   * This property allows you to specify if virtual machines chosen for removal have to be force deleted when a virtual machine scale set is being scaled-in.(Feature in Preview)
   */
  forceDeletion?: boolean;

  /**
   * This property allows you to prioritize the deletion of unhealthy and inactive VMs when a virtual machine scale set is being scaled-in.(Feature in Preview)
   */
  prioritizeUnhealthyVMs?: boolean;
}

/**
 * Specifies the Spot-Try-Restore properties for the virtual machine scale set. With this property customer can enable or disable automatic restore of the evicted Spot VMSS VM instances opportunistically based on capacity availability and pricing constraint.
 */
model SpotRestorePolicy {
  /**
   * Enables the Spot-Try-Restore feature where evicted VMSS SPOT instances will be tried to be restored opportunistically based on capacity availability and pricing constraints
   */
  enabled?: boolean;

  /**
   * Timeout value expressed as an ISO 8601 time duration after which the platform will not try to restore the VMSS SPOT instances
   */
  restoreTimeout?: string;
}

/**
 * Specifies the target splits for Spot and Regular priority VMs within a scale set with flexible orchestration mode. With this property the customer is able to specify the base number of regular priority VMs created as the VMSS flex instance scales out and the split between Spot and Regular priority VMs after this base target has been reached.
 */
model PriorityMixPolicy {
  /**
   * The base number of regular priority VMs that will be created in this scale set as it scales out.
   */
  baseRegularPriorityCount?: int32;

  /**
   * The percentage of VM instances, after the base regular priority count has been reached, that are expected to use regular priority.
   */
  @maxValue(100)
  regularPriorityPercentageAboveBase?: int32;
}

/**
 * Describes an resiliency policy - AutomaticZoneRebalancingPolicy, ResilientVMCreationPolicy and/or ResilientVMDeletionPolicy.
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

  /**
   * The configuration parameters used while performing automatic AZ balancing.
   */
  automaticZoneRebalancingPolicy?: AutomaticZoneRebalancingPolicy;

  /**
   * The configuration parameters used while performing zone allocation.
   */
  @added(Versions.v2025_04_01)
  zoneAllocationPolicy?: ZoneAllocationPolicy;
}

/**
 * The configuration parameters used while performing resilient VM creation.
 */
model ResilientVMCreationPolicy {
  /**
   * Specifies whether resilient VM creation should be enabled on the virtual machine scale set. The default value is false.
   */
  enabled?: boolean;
}

/**
 * The configuration parameters used while performing resilient VM deletion.
 */
model ResilientVMDeletionPolicy {
  /**
   * Specifies whether resilient VM deletion should be enabled on the virtual machine scale set. The default value is false.
   */
  enabled?: boolean;
}

/**
 * The configuration parameters for zone allocation of a virtual machine scale set.
 */
@added(Versions.v2025_04_01)
model ZoneAllocationPolicy {
  /**
   * The maximum number of availability zones to use if the ZonePlacementPolicy is 'Auto'. If not specified, all availability zones will be used.
   */
  maxZoneCount?: int32;

  /**
   * The configuration parameters used to limit the number of virtual machines per availability zone in the virtual machine scale set.
   */
  maxInstancePercentPerZonePolicy?: MaxInstancePercentPerZonePolicy;
}

/**
 * The configuration parameters used while performing automatic AZ balancing.
 */
model AutomaticZoneRebalancingPolicy {
  /**
   * Specifies whether Automatic AZ Balancing should be enabled on the virtual machine scale set. The default value is false.
   */
  enabled?: boolean;

  /**
   * Type of rebalance strategy that will be used for rebalancing virtual machines in the scale set across availability zones. Default and only supported value for now is Recreate.
   */
  rebalanceStrategy?: RebalanceStrategy;

  /**
   * Type of rebalance behavior that will be used for recreating virtual machines in the scale set across availability zones. Default and only supported value for now is CreateBeforeDelete.
   */
  rebalanceBehavior?: RebalanceBehavior;
}

/**
 * The configuration parameters used to limit the number of virtual machines per availability zone in the virtual machine scale set.
 */
@added(Versions.v2025_04_01)
model MaxInstancePercentPerZonePolicy {
  /**
   * Specifies whether maxInstancePercentPerZonePolicy should be enabled on the virtual machine scale set.
   */
  enabled?: boolean;

  /**
   * Limit on the number of instances in each zone as a percentage of the total capacity of the virtual machine scale set.
   */
  @maxValue(100)
  value?: int32;
}

/**
 * Specifies the sku profile for the virtual machine scale set. With this property the customer is able to specify a list of VM sizes and an allocation strategy.
 */
model SkuProfile {
  /**
   * Specifies the VM sizes for the virtual machine scale set.
   */
  @identifiers(#["name"])
  vmSizes?: SkuProfileVMSize[];

  /**
   * Specifies the allocation strategy for the virtual machine scale set based on which the VMs will be allocated.
   */
  allocationStrategy?: AllocationStrategy;
}

/**
 * Specifies the VM Size.
 */
model SkuProfileVMSize {
  /**
   * Specifies the name of the VM Size.
   */
  name?: string;

  /**
   * Specifies the rank (a.k.a priority) associated with the VM Size.
   */
  rank?: int32;
}

/**
 * Identity for the virtual machine scale set.
 */
model VirtualMachineScaleSetIdentity {
  /**
   * The principal id of virtual machine scale set identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id associated with the virtual machine scale set. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the virtual machine scale set. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine scale set.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the virtual machine scale set. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UserAssignedIdentitiesValue {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The List Virtual Machine operation response.
 */
model VirtualMachineScaleSetListWithLinkResult
  is Azure.Core.Page<VirtualMachineScaleSet>;

@@doc(VirtualMachineScaleSetListWithLinkResult.value,
  "The list of virtual machine scale sets."
);
@@doc(VirtualMachineScaleSetListWithLinkResult.nextLink,
  "The uri to fetch the next page of Virtual Machine Scale Sets. Call ListNext() with this to fetch the next page of Virtual Machine Scale Sets."
);
/**
 * Describes a Virtual Machine Scale Set.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineScaleSetUpdate extends UpdateResource {
  /**
   * The virtual machine scale set sku.
   */
  sku?: Sku;

  /**
   * The purchase plan when deploying a virtual machine scale set from VM Marketplace images.
   */
  plan?: Plan;

  /**
   * Describes the properties of a Virtual Machine Scale Set.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineScaleSetUpdateProperties;

  /**
   * The identity of the virtual machine scale set, if configured.
   */
  identity?: VirtualMachineScaleSetIdentity;

  /**
   * The virtual machine scale set zones.
   */
  zones?: string[];
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
   * When Overprovision is enabled, extensions are launched only on the requested number of VMs which are finally kept. This property will hence ensure that the extensions do not run on the extra overprovisioned VMs.
   */
  doNotRunExtensionsOnOverprovisionedVMs?: boolean;

  /**
   * When true this limits the scale set to a single placement group, of max size 100 virtual machines. NOTE: If singlePlacementGroup is true, it may be modified to false. However, if singlePlacementGroup is false, it may not be modified to true.
   */
  singlePlacementGroup?: boolean;

  /**
   * Specifies additional capabilities enabled or disabled on the Virtual Machines in the Virtual Machine Scale Set. For instance: whether the Virtual Machines have the capability to support attaching managed data disks with UltraSSD_LRS storage account type.
   */
  additionalCapabilities?: AdditionalCapabilities;

  /**
   * Specifies the policies applied when scaling in Virtual Machines in the Virtual Machine Scale Set.
   */
  scaleInPolicy?: ScaleInPolicy;

  /**
   * Specifies information about the proximity placement group that the virtual machine scale set should be assigned to. <br><br>Minimum api-version: 2018-04-01.
   */
  proximityPlacementGroup?: SubResource;

  /**
   * Specifies the desired targets for mixing Spot and Regular priority VMs within the same VMSS Flex instance.
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

  /**
   * Specifies the align mode between Virtual Machine Scale Set compute and storage Fault Domain count.
   */
  zonalPlatformFaultDomainAlignMode?: ZonalPlatformFaultDomainAlignMode;

  /**
   * Specifies the sku profile for the virtual machine scale set.
   */
  skuProfile?: SkuProfile;
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
   * The virtual machine scale set security posture reference.
   */
  securityPostureReference?: SecurityPostureReferenceUpdate;

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
   * Specifies the billing related details of a Azure Spot VMSS. Minimum api-version: 2019-03-01.
   */
  billingProfile?: BillingProfile;

  /**
   * Specifies Scheduled Event related configurations.
   */
  scheduledEventsProfile?: ScheduledEventsProfile;

  /**
   * UserData for the VM, which must be base-64 encoded. Customer should not pass any secrets in here. <br><br>Minimum api-version: 2021-03-01
   */
  userData?: string;

  /**
   * Specifies the hardware profile related details of a scale set. Minimum api-version: 2021-11-01.
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
  @identifiers(#["sourceVault/id"])
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
  @identifiers(#["name", "lun"])
  dataDisks?: VirtualMachineScaleSetDataDisk[];

  /**
   * Specifies the disk controller type configured for the virtual machines in the scale set. **Note:** You need to deallocate the virtual machines in the scale set before updating its disk controller type based on the upgrade mode configured for the scale set. Minimum api-version: 2022-08-01
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  diskControllerType?: DiskControllerTypes;
}

/**
 * Describes virtual machine scale set operating system disk Update Object. This should be used for Updating VMSS OS Disk.
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
   * Specifies the ephemeral disk Settings for the operating system disk used by the virtual machine scale set.
   */
  diffDiskSettings?: DiffDiskSettings;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used to overwrite the size of the disk in a virtual machine image. <br><br> diskSizeGB is the number of bytes x 1024^3 for the disk and the value cannot be larger than 1023
   */
  diskSizeGB?: int32;

  /**
   * The Source User Image VirtualHardDisk. This VirtualHardDisk will be copied before using it to attach to the Virtual Machine. If SourceImage is provided, the destination VirtualHardDisk should not exist.
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
   * Specifies whether OS Disk should be deleted or detached upon VMSS Flex deletion (This feature is available for VMSS with Flexible OrchestrationMode only). <br><br> Possible values: <br><br> **Delete** If this value is used, the OS disk is deleted when VMSS Flex VM is deleted.<br><br> **Detach** If this value is used, the OS disk is retained after VMSS Flex VM is deleted. <br><br> The default value is set to **Delete**. For an Ephemeral OS Disk, the default value is set to **Delete**. User cannot change the delete option for Ephemeral OS Disk.
   */
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * Describes a virtual machine scale set network profile.
 */
model VirtualMachineScaleSetUpdateNetworkProfile {
  /**
   * A reference to a load balancer probe used to determine the health of an instance in the virtual machine scale set. The reference will be in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}'.
   */
  healthProbe?: ApiEntityReference;

  /**
   * The list of network configurations.
   */
  @identifiers(#["name"])
  networkInterfaceConfigurations?: VirtualMachineScaleSetUpdateNetworkConfiguration[];

  /**
   * specifies the Microsoft.Network API version used when creating networking resources in the Network Interface Configurations for Virtual Machine Scale Set with orchestration mode 'Flexible'
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
   * Describes a virtual machine scale set updatable network profile's IP configuration.Use this object for updating network profile's IP Configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineScaleSetUpdateNetworkConfigurationProperties;

  /**
   * Resource tags applied to the networkInterface address created by this NetworkInterfaceConfiguration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @added(Versions.v2025_04_01)
  tags?: Record<string>;
}

/**
 * Describes a virtual machine scale set updatable network profile's IP configuration.Use this object for updating network profile's IP Configuration.
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
  @identifiers(#["name"])
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
   * Specifies whether the Auxiliary mode is enabled for the Network Interface resource.
   */
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;

  /**
   * Specifies whether the Auxiliary sku is enabled for the Network Interface resource.
   */
  auxiliarySku?: NetworkInterfaceAuxiliarySku;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration. NOTE: The subnet of a scale set may be modified as long as the original subnet and the new subnet are in the same virtual network
 */
model VirtualMachineScaleSetUpdateIPConfiguration {
  /**
   * The IP configuration name.
   */
  name?: string;

  /**
   * Describes a virtual machine scale set network profile's IP configuration properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineScaleSetUpdateIPConfigurationProperties;
}

/**
 * Describes a virtual machine scale set network profile's IP configuration properties.
 */
model VirtualMachineScaleSetUpdateIPConfigurationProperties {
  /**
   * The subnet.
   */
  subnet?: ApiEntityReference;

  /**
   * Specifies the primary IP Configuration in case the network interface has more than one IP Configuration.
   */
  primary?: boolean;

  /**
   * The publicIPAddressConfiguration.
   */
  publicIPAddressConfiguration?: VirtualMachineScaleSetUpdatePublicIPAddressConfiguration;

  /**
   * Available from Api-Version 2017-03-30 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible values are: 'IPv4' and 'IPv6'.
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
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress configuration
 */
model VirtualMachineScaleSetUpdatePublicIPAddressConfiguration {
  /**
   * The publicIP address configuration name.
   */
  name?: string;

  /**
   * Describes a virtual machines scale set IP Configuration's PublicIPAddress configuration
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineScaleSetUpdatePublicIPAddressConfigurationProperties;

  /**
   * Resource tags applied to the publicIP address created by this PublicIPAddressConfiguration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @added(Versions.v2025_04_01)
  tags?: Record<string>;
}

/**
 * Describes a virtual machines scale set IP Configuration's PublicIPAddress configuration
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
 * Specifies the security posture to be used in the scale set. Minimum api-version: 2023-03-01
 */
model SecurityPostureReferenceUpdate {
  /**
   * The security posture reference id in the form of /CommunityGalleries/{communityGalleryName}/securityPostures/{securityPostureName}/versions/{major.minor.patch}|latest
   */
  id?: string;

  /**
   * The list of virtual machine extension names to exclude when applying the security posture.
   */
  excludeExtensions?: string[];

  /**
   * Whether the security posture can be overridden by the user.
   */
  isOverridable?: boolean;
}

/**
 * The Update Resource model definition.
 */
model UpdateResource {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Specifies a list of virtual machine instance IDs from the VM scale set.
 */
model VirtualMachineScaleSetVMInstanceIDs {
  /**
   * The virtual machine scale set instance ids. Omitting the virtual machine scale set instance ids will result in the operation being performed on all virtual machines in the virtual machine scale set.
   */
  instanceIds?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VMScaleSetConvertToSinglePlacementGroupInput {
  /**
   * Id of the placement group in which you want future virtual machine instances to be placed. To query placement group Id, please use Virtual Machine Scale Set VMs - Get API. If not provided, the platform will choose one with maximum number of virtual machine instances.
   */
  activePlacementGroupId?: string;
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
 * The List VM scale set extension operation response.
 */
model VirtualMachineScaleSetExtensionListResult
  is Azure.Core.Page<VirtualMachineScaleSetExtension>;

@@identifiers(VirtualMachineScaleSetExtensionListResult.value, #["name", "id"]);

@@doc(VirtualMachineScaleSetExtensionListResult.value,
  "The list of VM scale set extensions."
);
@@doc(VirtualMachineScaleSetExtensionListResult.nextLink,
  "The uri to fetch the next page of VM scale set extensions. Call ListNext() with this to fetch the next page of VM scale set extensions."
);

/**
 * Describes a Virtual Machine Scale Set Extension.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineScaleSetExtensionUpdate extends SubResourceReadOnly {
  /**
   * The name of the extension.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Describes the properties of a Virtual Machine Scale Set Extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineScaleSetExtensionProperties;
}

/**
 * Response after calling a manual recovery walk
 */
model RecoveryWalkResponse {
  /**
   * Whether the recovery walk was performed
   */
  @visibility(Lifecycle.Read)
  walkPerformed?: boolean;

  /**
   * The next update domain that needs to be walked. Null means walk spanning all update domains has been completed
   */
  @visibility(Lifecycle.Read)
  nextPlatformUpdateDomain?: int32;
}

/**
 * The instance view of a virtual machine scale set.
 */
model VirtualMachineScaleSetInstanceView {
  /**
   * The instance view status summary for the virtual machine scale set.
   */
  @visibility(Lifecycle.Read)
  virtualMachine?: VirtualMachineScaleSetInstanceViewStatusesSummary;

  /**
   * The extensions information.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  extensions?: VirtualMachineScaleSetVMExtensionsSummary[];

  /**
   * The resource status information.
   */
  @identifiers(#[])
  statuses?: InstanceViewStatus[];

  /**
   * The orchestration services information.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["serviceName"])
  orchestrationServices?: OrchestrationServiceSummary[];
}

/**
 * Instance view statuses summary for virtual machines of a virtual machine scale set.
 */
model VirtualMachineScaleSetInstanceViewStatusesSummary {
  /**
   * The extensions information.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  statusesSummary?: VirtualMachineStatusCodeCount[];
}

/**
 * The status code and count of the virtual machine scale set instance view status summary.
 */
model VirtualMachineStatusCodeCount {
  /**
   * The instance view status code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The number of instances having a particular status code.
   */
  @visibility(Lifecycle.Read)
  count?: int32;
}

/**
 * Extensions summary for virtual machines of a virtual machine scale set.
 */
model VirtualMachineScaleSetVMExtensionsSummary {
  /**
   * The extension name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The extensions information.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  statusesSummary?: VirtualMachineStatusCodeCount[];
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
  time?: utcDateTime;
}

/**
 * Summary for an orchestration service of a virtual machine scale set.
 */
model OrchestrationServiceSummary {
  /**
   * The name of the service.
   */
  @visibility(Lifecycle.Read)
  serviceName?: OrchestrationServiceNames;

  /**
   * The current state of the service.
   */
  @visibility(Lifecycle.Read)
  serviceState?: OrchestrationServiceState;

  /**
   * The latest operation status of the service. Minimum API version for this property is 2025-04-01.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_04_01)
  latestOperationStatus?: OrchestrationServiceOperationStatus;

  /**
   * The last UTC time when the operation status changed. Minimum API version for this property is 2025-04-01.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_04_01)
  lastStatusChangeTime?: utcDateTime;
}

@@identifiers(VirtualMachineScaleSetListOSUpgradeHistory.value,
  #["location", "type"]
);

/**
 * List of Virtual Machine Scale Set OS Upgrade History operation response.
 */
model VirtualMachineScaleSetListOSUpgradeHistory
  is Azure.Core.Page<UpgradeOperationHistoricalStatusInfo>;

@@doc(VirtualMachineScaleSetListOSUpgradeHistory.value,
  "The list of OS upgrades performed on the virtual machine scale set."
);
@@doc(VirtualMachineScaleSetListOSUpgradeHistory.nextLink,
  "The uri to fetch the next page of OS Upgrade History. Call ListNext() with this to fetch the next page of history of upgrades."
);

/**
 * Virtual Machine Scale Set OS Upgrade History operation response.
 */
model UpgradeOperationHistoricalStatusInfo {
  /**
   * Information about the properties of the upgrade operation.
   */
  @visibility(Lifecycle.Read)
  properties?: UpgradeOperationHistoricalStatusInfoProperties;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * Describes each OS upgrade on the Virtual Machine Scale Set.
 */
model UpgradeOperationHistoricalStatusInfoProperties {
  /**
   * Information about the overall status of the upgrade operation.
   */
  @visibility(Lifecycle.Read)
  runningStatus?: UpgradeOperationHistoryStatus;

  /**
   * Counts of the VMs in each state.
   */
  @visibility(Lifecycle.Read)
  progress?: RollingUpgradeProgressInfo;

  /**
   * Error Details for this upgrade if there are any.
   */
  @visibility(Lifecycle.Read)
  error?: ApiError;

  /**
   * Invoker of the Upgrade Operation
   */
  @visibility(Lifecycle.Read)
  startedBy?: UpgradeOperationInvoker;

  /**
   * Image Reference details
   */
  @visibility(Lifecycle.Read)
  targetImageReference?: ImageReference;

  /**
   * Information about OS rollback if performed
   */
  @visibility(Lifecycle.Read)
  rollbackInfo?: RollbackStatusInfo;
}

/**
 * Information about the current running state of the overall upgrade.
 */
model UpgradeOperationHistoryStatus {
  /**
   * Code indicating the current status of the upgrade.
   */
  @visibility(Lifecycle.Read)
  code?: UpgradeState;

  /**
   * Start time of the upgrade.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * End time of the upgrade.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;
}

/**
 * Information about the number of virtual machine instances in each upgrade state.
 */
model RollingUpgradeProgressInfo {
  /**
   * The number of instances that have been successfully upgraded.
   */
  @visibility(Lifecycle.Read)
  successfulInstanceCount?: int32;

  /**
   * The number of instances that have failed to be upgraded successfully.
   */
  @visibility(Lifecycle.Read)
  failedInstanceCount?: int32;

  /**
   * The number of instances that are currently being upgraded.
   */
  @visibility(Lifecycle.Read)
  inProgressInstanceCount?: int32;

  /**
   * The number of instances that have not yet begun to be upgraded.
   */
  @visibility(Lifecycle.Read)
  pendingInstanceCount?: int32;
}

/**
 * Information about rollback on failed VM instances after a OS Upgrade operation.
 */
model RollbackStatusInfo {
  /**
   * The number of instances which have been successfully rolled back.
   */
  @visibility(Lifecycle.Read)
  successfullyRolledbackInstanceCount?: int32;

  /**
   * The number of instances which failed to rollback.
   */
  @visibility(Lifecycle.Read)
  failedRolledbackInstanceCount?: int32;

  /**
   * Error details if OS rollback failed.
   */
  @visibility(Lifecycle.Read)
  rollbackError?: ApiError;
}

/**
 * Describes a Virtual Machine Scale Set VM Reimage Parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineScaleSetReimageParameters
  extends VirtualMachineScaleSetVMReimageParameters {
  /**
   * The virtual machine scale set instance ids. Omitting the virtual machine scale set instance ids will result in the operation being performed on all virtual machines in the virtual machine scale set.
   */
  instanceIds?: string[];
}

/**
 * Describes a Virtual Machine Scale Set VM Reimage Parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineScaleSetVMReimageParameters
  extends VirtualMachineReimageParameters {
  /**
   * Parameter to force update ephemeral OS disk for a virtual machine scale set VM
   */
  forceUpdateOSDiskForEphemeral?: boolean;
}

/**
 * Parameters for Reimaging Virtual Machine. NOTE: Virtual Machine OS disk will always be reimaged
 */
model VirtualMachineReimageParameters {
  /**
   * Specifies whether to reimage temp disk. Default value: false. Note: This temp disk reimage parameter is only supported for VM/VMSS with Ephemeral OS disk.
   */
  tempDisk?: boolean;

  /**
   * Specifies in decimal number, the version the OS disk should be reimaged to. If exact version is not provided, the OS disk is reimaged to the existing version of OS Disk.
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
  @doc("Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)")
  @secret
  adminPassword?: string;

  /**
   * Specifies a base-64 encoded string of custom data. The base-64 encoded string is decoded to a binary array that is saved as a file on the Virtual Machine. The maximum length of the binary array is 65535 bytes. **Note: Do not pass any secrets or passwords in customData property.** This property cannot be updated after the VM is created. The property customData is passed to the VM to be saved as a file, for more information see [Custom Data on Azure VMs](https://azure.microsoft.com/blog/custom-data-and-cloud-init-on-windows-azure/). If using cloud-init for your Linux VM, see [Using cloud-init to customize a Linux VM during creation](https://docs.microsoft.com/azure/virtual-machines/linux/using-cloud-init).
   */
  customData?: string;
}

/**
 * The status of the latest virtual machine scale set rolling upgrade.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RollingUpgradeStatusInfoProperties {
  /**
   * The rolling upgrade policies applied for this upgrade.
   */
  @visibility(Lifecycle.Read)
  policy?: RollingUpgradePolicy;

  /**
   * Information about the current running state of the overall upgrade.
   */
  @visibility(Lifecycle.Read)
  runningStatus?: RollingUpgradeRunningStatus;

  /**
   * Information about the number of virtual machine instances in each upgrade state.
   */
  @visibility(Lifecycle.Read)
  progress?: RollingUpgradeProgressInfo;

  /**
   * Error details for this upgrade, if there are any.
   */
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/**
 * Information about the current running state of the overall upgrade.
 */
model RollingUpgradeRunningStatus {
  /**
   * Code indicating the current status of the upgrade.
   */
  @visibility(Lifecycle.Read)
  code?: RollingUpgradeStatusCode;

  /**
   * Start time of the upgrade.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The last action performed on the rolling upgrade.
   */
  @visibility(Lifecycle.Read)
  lastAction?: RollingUpgradeActionType;

  /**
   * Last action time of the upgrade.
   */
  @visibility(Lifecycle.Read)
  lastActionTime?: utcDateTime;
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

@@identifiers(VirtualMachineScaleSetListSkusResult.value,
  #["resourceType", "sku/name"]
);
/**
 * The Virtual Machine Scale Set List Skus operation response.
 */
model VirtualMachineScaleSetListSkusResult
  is Azure.Core.Page<VirtualMachineScaleSetSku>;

@@doc(VirtualMachineScaleSetListSkusResult.value,
  "The list of skus available for the virtual machine scale set."
);
@@doc(VirtualMachineScaleSetListSkusResult.nextLink,
  "The uri to fetch the next page of Virtual Machine Scale Set Skus. Call ListNext() with this to fetch the next page of VMSS Skus."
);

/**
 * Describes an available virtual machine scale set sku.
 */
model VirtualMachineScaleSetSku {
  /**
   * The type of resource the sku applies to.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The Sku.
   */
  @visibility(Lifecycle.Read)
  sku?: Sku;

  /**
   * Specifies the number of virtual machines in the scale set.
   */
  @visibility(Lifecycle.Read)
  capacity?: VirtualMachineScaleSetSkuCapacity;
}

/**
 * Describes scaling information of a sku.
 */
model VirtualMachineScaleSetSkuCapacity {
  /**
   * The minimum capacity.
   */
  @visibility(Lifecycle.Read)
  minimum?: int64;

  /**
   * The maximum capacity that can be set.
   */
  @visibility(Lifecycle.Read)
  maximum?: int64;

  /**
   * The default capacity.
   */
  @visibility(Lifecycle.Read)
  defaultCapacity?: int64;

  /**
   * The scale type applicable to the sku.
   */
  @visibility(Lifecycle.Read)
  scaleType?: VirtualMachineScaleSetSkuScaleType;
}

/**
 * The List Virtual Machine Scale Set VMs operation response.
 */
model VirtualMachineScaleSetVMListResult
  is Azure.Core.Page<VirtualMachineScaleSetVM>;

@@doc(VirtualMachineScaleSetVMListResult.value,
  "The list of virtual machine scale sets VMs."
);
@@doc(VirtualMachineScaleSetVMListResult.nextLink,
  "The uri to fetch the next page of Virtual Machine Scale Set VMs. Call ListNext() with this to fetch the next page of VMSS VMs."
);

/**
 * Describes the properties of a virtual machine scale set virtual machine.
 */
model VirtualMachineScaleSetVMProperties {
  /**
   * Specifies whether the latest model has been applied to the virtual machine.
   */
  @visibility(Lifecycle.Read)
  latestModelApplied?: boolean;

  /**
   * Azure VM unique ID.
   */
  @visibility(Lifecycle.Read)
  vmId?: string;

  /**
   * The virtual machine instance view.
   */
  @visibility(Lifecycle.Read)
  instanceView?: VirtualMachineScaleSetVMInstanceView;

  /**
   * Specifies the hardware settings for the virtual machine.
   */
  hardwareProfile?: HardwareProfile;

  /**
   * Specifies the resilient VM deletion status for the virtual machine.
   */
  resilientVMDeletionStatus?: ResilientVMDeletionStatus;

  /**
   * Specifies the storage settings for the virtual machine disks.
   */
  storageProfile?: StorageProfile;

  /**
   * Specifies additional capabilities enabled or disabled on the virtual machine in the scale set. For instance: whether the virtual machine has the capability to support attaching managed data disks with UltraSSD_LRS storage account type.
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
   * Specifies information about the availability set that the virtual machine should be assigned to. Virtual machines specified in the same availability set are allocated to different nodes to maximize availability. For more information about availability sets, see [Availability sets overview](https://docs.microsoft.com/azure/virtual-machines/availability-set-overview). For more information on Azure planned maintenance, see [Maintenance and updates for Virtual Machines in Azure](https://docs.microsoft.com/azure/virtual-machines/maintenance-and-updates). Currently, a VM can only be added to availability set at creation time. An existing VM cannot be added to an availability set.
   */
  availabilitySet?: SubResource;

  /**
   * The provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Specifies that the image or disk that is being used was licensed on-premises. <br><br> Possible values for Windows Server operating system are: <br><br> Windows_Client <br><br> Windows_Server <br><br> Possible values for Linux Server operating system are: <br><br> RHEL_BYOS (for RHEL) <br><br> SLES_BYOS (for SUSE) <br><br> For more information, see [Azure Hybrid Use Benefit for Windows Server](https://docs.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing) <br><br> [Azure Hybrid Use Benefit for Linux Server](https://docs.microsoft.com/azure/virtual-machines/linux/azure-hybrid-benefit-linux) <br><br> Minimum api-version: 2015-06-15
   */
  licenseType?: string;

  /**
   * Specifies whether the model applied to the virtual machine is the model of the virtual machine scale set or the customized model for the virtual machine.
   */
  @visibility(Lifecycle.Read)
  modelDefinitionApplied?: string;

  /**
   * Specifies the protection policy of the virtual machine.
   */
  protectionPolicy?: VirtualMachineScaleSetVMProtectionPolicy;

  /**
   * UserData for the VM, which must be base-64 encoded. Customer should not pass any secrets in here. Minimum api-version: 2021-03-01
   */
  userData?: string;

  /**
   * Specifies the time at which the Virtual Machine resource was created. Minimum api-version: 2021-11-01.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["name"])
  disks?: DiskInstanceView[];

  /**
   * The extensions information.
   */
  @identifiers(#["name", "type"])
  extensions?: VirtualMachineExtensionInstanceView[];

  /**
   * The health status for the VM.
   */
  @visibility(Lifecycle.Read)
  vmHealth?: VirtualMachineHealthStatus;

  /**
   * Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. You can easily view the output of your console log. Azure also enables you to see a screenshot of the VM from the hypervisor.
   */
  bootDiagnostics?: BootDiagnosticsInstanceView;

  /**
   * The resource status information.
   */
  @identifiers(#[])
  statuses?: InstanceViewStatus[];

  /**
   * Resource id of the dedicated host, on which the virtual machine is allocated through automatic placement, when the virtual machine is associated with a dedicated host group that has automatic placement enabled. Minimum api-version: 2020-06-01.
   */
  @visibility(Lifecycle.Read)
  assignedHost?: string;

  /**
   * The placement group in which the VM is running. If the VM is deallocated it will not have a placementGroupId.
   */
  placementGroupId?: string;

  /**
   * Specifies the host OS name of the virtual machine. <br><br> This name cannot be updated after the VM is created. <br><br> **Max-length (Windows):** 15 characters <br><br> **Max-length (Linux):** 64 characters. <br><br> For naming conventions and restrictions see [Azure infrastructure services implementation guidelines](https://docs.microsoft.com/azure/virtual-machines/virtual-machines-linux-infrastructure-subscription-accounts-guidelines?toc=%2fazure%2fvirtual-machines%2flinux%2ftoc.json#1-naming-conventions).
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
  @identifiers(#[])
  extensionHandlers?: VirtualMachineExtensionHandlerInstanceView[];

  /**
   * The resource status information.
   */
  @identifiers(#[])
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
  preMaintenanceWindowStartTime?: utcDateTime;

  /**
   * End Time for the Pre Maintenance Window.
   */
  preMaintenanceWindowEndTime?: utcDateTime;

  /**
   * Start Time for the Maintenance Window.
   */
  maintenanceWindowStartTime?: utcDateTime;

  /**
   * End Time for the Maintenance Window.
   */
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
   * Specifies the encryption settings for the OS Disk. <br><br> Minimum api-version: 2015-06-15
   */
  @identifiers(#["diskEncryptionKey/sourceVault/id"])
  encryptionSettings?: DiskEncryptionSettings[];

  /**
   * The resource status information.
   */
  @identifiers(#[])
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
  @identifiers(#[])
  substatuses?: InstanceViewStatus[];

  /**
   * The resource status information.
   */
  @identifiers(#[])
  statuses?: InstanceViewStatus[];
}

/**
 * The health status of the VM.
 */
model VirtualMachineHealthStatus {
  /**
   * The health status information for the VM.
   */
  @visibility(Lifecycle.Read)
  status?: InstanceViewStatus;
}

/**
 * The instance view of a virtual machine boot diagnostics.
 */
model BootDiagnosticsInstanceView {
  /**
   * The console screenshot blob URI. **Note:** This will **not** be set if boot diagnostics is currently enabled with managed storage.
   */
  @visibility(Lifecycle.Read)
  consoleScreenshotBlobUri?: string;

  /**
   * The serial console log blob Uri. **Note:** This will **not** be set if boot diagnostics is currently enabled with managed storage.
   */
  @visibility(Lifecycle.Read)
  serialConsoleLogBlobUri?: string;

  /**
   * The boot diagnostics status information for the VM. **Note:** It will be set only if there are errors encountered in enabling boot diagnostics.
   */
  @visibility(Lifecycle.Read)
  status?: InstanceViewStatus;
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
  @visibility(Lifecycle.Read)
  diskIOPSReadWrite?: int64;

  /**
   * Specifies the bandwidth in MB per second for the managed disk when StorageAccountType is UltraSSD_LRS. Returned only for VirtualMachine ScaleSet VM disks. Can be updated only via updates to the VirtualMachine Scale Set.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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

/**
 * Describes a virtual machine scale set VM network profile.
 */
model VirtualMachineScaleSetVMNetworkProfileConfiguration {
  /**
   * The list of network configurations.
   */
  @identifiers(#["name"])
  networkInterfaceConfigurations?: VirtualMachineScaleSetNetworkConfiguration[];
}

/**
 * The protection policy of a virtual machine scale set VM.
 */
model VirtualMachineScaleSetVMProtectionPolicy {
  /**
   * Indicates that the virtual machine scale set VM shouldn't be considered for deletion during a scale-in operation.
   */
  protectFromScaleIn?: boolean;

  /**
   * Indicates that model updates or actions (including scale-in) initiated on the virtual machine scale set should not be applied to the virtual machine scale set VM.
   */
  protectFromScaleSetActions?: boolean;
}

/**
 * Describes the properties of a Virtual Machine Extension.
 */
model VirtualMachineExtensionProperties {
  /**
   * How the extension handler should be forced to update even if the extension configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "backcompat"
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  settings?: unknown;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  protectedSettings?: unknown;

  /**
   * The provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The virtual machine extension instance view.
   */
  instanceView?: VirtualMachineExtensionInstanceView;

  /**
   * Indicates whether failures stemming from the extension will be suppressed (Operational failures such as not connecting to the VM will not be suppressed regardless of this value). The default is false.
   */
  suppressFailures?: boolean;

  /**
   * The extensions protected settings that are passed by reference, and consumed from key vault
   */
  protectedSettingsFromKeyVault?: KeyVaultSecretReference;

  /**
   * Collection of extension names after which this extension needs to be provisioned.
   */
  provisionAfterExtensions?: string[];
}

/**
 * Identity for the virtual machine.
 */
model VirtualMachineIdentity {
  /**
   * The principal id of virtual machine identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id associated with the virtual machine. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the virtual machine. The type 'SystemAssigned, UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the virtual machine.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the Virtual Machine. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentitiesValue>;
}

/**
 * The List VMSS VM Extension operation response
 */
model VirtualMachineScaleSetVMExtensionsListResult {
  /**
   * The list of VMSS VM extensions
   */
  @identifiers(#["name", "id"])
  @pageItems
  value?: VirtualMachineScaleSetVMExtension[];
}

/**
 * Describes a VMSS VM Extension.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineScaleSetVMExtensionUpdate extends SubResourceReadOnly {
  /**
   * The name of the extension.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Describes the properties of a Virtual Machine Extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineExtensionUpdateProperties;
}

/**
 * Describes the properties of a Virtual Machine Extension.
 */
model VirtualMachineExtensionUpdateProperties {
  /**
   * How the extension handler should be forced to update even if the extension configuration has not changed.
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
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  settings?: unknown;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  protectedSettings?: unknown;

  /**
   * Indicates whether failures stemming from the extension will be suppressed (Operational failures such as not connecting to the VM will not be suppressed regardless of this value). The default is false.
   */
  suppressFailures?: boolean;

  /**
   * The extensions protected settings that are passed by reference, and consumed from key vault
   */
  protectedSettingsFromKeyVault?: KeyVaultSecretReference;
}

/**
 * Specifies the input for attaching and detaching a list of managed data disks.
 */
model AttachDetachDataDisksRequest {
  /**
   * The list of managed data disks to be attached.
   */
  @identifiers(#["diskId"])
  @minItems(1)
  dataDisksToAttach?: DataDisksToAttach[];

  /**
   * The list of managed data disks to be detached.
   */
  @identifiers(#["diskId"])
  @minItems(1)
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
   * The logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM. If not specified, lun would be auto assigned.
   */
  lun?: int32;

  /**
   * Specifies the caching requirements. Possible values are: **None,** **ReadOnly,** **ReadWrite.** The defaulting behavior is: **None for Standard storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies whether data disk should be deleted or detached upon VM deletion. Possible values are: **Delete.** If this value is used, the data disk is deleted when VM is deleted. **Detach.** If this value is used, the data disk is retained after VM is deleted. The default value is set to **Detach**.
   */
  deleteOption?: DiskDeleteOptionTypes;

  /**
   * Specifies the customer managed disk encryption set resource id for the managed disk.
   */
  diskEncryptionSet?: DiskEncryptionSetParameters;

  /**
   * Specifies whether writeAccelerator should be enabled or disabled on the disk.
   */
  writeAcceleratorEnabled?: boolean;
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
   * Supported options available for Detach of a disk from a VM. Refer to DetachOption object reference for more details.
   */
  detachOption?: DiskDetachOptionTypes;
}

/**
 * The SAS URIs of the console screenshot and serial log blobs.
 */
model RetrieveBootDiagnosticsDataResult {
  /**
   * The console screenshot blob URI
   */
  @visibility(Lifecycle.Read)
  consoleScreenshotBlobUri?: string;

  /**
   * The serial console log blob URI.
   */
  @visibility(Lifecycle.Read)
  serialConsoleLogBlobUri?: string;
}

/**
 * The List Virtual Machine operation response.
 */
model VirtualMachineListResult is Azure.Core.Page<VirtualMachine>;

@@doc(VirtualMachineListResult.value, "The list of virtual machines.");
@@doc(VirtualMachineListResult.nextLink,
  "The URI to fetch the next page of VMs. Call ListNext() with this URI to fetch the next page of Virtual Machines."
);
/**
 * Describes the properties of a Virtual Machine.
 */
model VirtualMachineProperties {
  /**
   * Specifies the hardware settings for the virtual machine.
   */
  hardwareProfile?: HardwareProfile;

  /**
   * Specifies Redeploy, Reboot and ScheduledEventsAdditionalPublishingTargets Scheduled Event related configurations for the virtual machine.
   */
  scheduledEventsPolicy?: ScheduledEventsPolicy;

  /**
   * Specifies the storage settings for the virtual machine disks.
   */
  storageProfile?: StorageProfile;

  /**
   * Specifies additional capabilities enabled or disabled on the virtual machine.
   */
  additionalCapabilities?: AdditionalCapabilities;

  /**
   * Specifies the operating system settings used while creating the virtual machine. Some of the settings cannot be changed once VM is provisioned.
   */
  osProfile?: OSProfile;

  /**
   * Specifies the network interfaces of the virtual machine.
   */
  networkProfile?: NetworkProfile;

  /**
   * Specifies the Security related profile settings for the virtual machine.
   */
  securityProfile?: SecurityProfile;

  /**
   * Specifies the boot diagnostic settings state. Minimum api-version: 2015-06-15.
   */
  diagnosticsProfile?: DiagnosticsProfile;

  /**
   * Specifies information about the availability set that the virtual machine should be assigned to. Virtual machines specified in the same availability set are allocated to different nodes to maximize availability. For more information about availability sets, see [Availability sets overview](https://docs.microsoft.com/azure/virtual-machines/availability-set-overview). For more information on Azure planned maintenance, see [Maintenance and updates for Virtual Machines in Azure](https://docs.microsoft.com/azure/virtual-machines/maintenance-and-updates). Currently, a VM can only be added to availability set at creation time. The availability set to which the VM is being added should be under the same resource group as the availability set resource. An existing VM cannot be added to an availability set. This property cannot exist along with a non-null properties.virtualMachineScaleSet reference.
   */
  availabilitySet?: SubResource;

  /**
   * Specifies information about the virtual machine scale set that the virtual machine should be assigned to. Virtual machines specified in the same virtual machine scale set are allocated to different nodes to maximize availability. Currently, a VM can only be added to virtual machine scale set at creation time. An existing VM cannot be added to a virtual machine scale set. This property cannot exist along with a non-null properties.availabilitySet reference. Minimum api‐version: 2019‐03‐01.
   */
  virtualMachineScaleSet?: SubResource;

  /**
   * Specifies information about the proximity placement group that the virtual machine should be assigned to. Minimum api-version: 2018-04-01.
   */
  proximityPlacementGroup?: SubResource;

  /**
   * Specifies the priority for the virtual machine. Minimum api-version: 2019-03-01
   */
  priority?: VirtualMachinePriorityTypes;

  /**
   * Specifies the eviction policy for the Azure Spot virtual machine and Azure Spot scale set. For Azure Spot virtual machines, both 'Deallocate' and 'Delete' are supported and the minimum api-version is 2019-03-01. For Azure Spot scale sets, both 'Deallocate' and 'Delete' are supported and the minimum api-version is 2017-10-30-preview.
   */
  evictionPolicy?: VirtualMachineEvictionPolicyTypes;

  /**
   * Specifies the billing related details of a Azure Spot virtual machine. Minimum api-version: 2019-03-01.
   */
  billingProfile?: BillingProfile;

  /**
   * Specifies information about the dedicated host that the virtual machine resides in. Minimum api-version: 2018-10-01.
   */
  host?: SubResource;

  /**
   * Specifies information about the dedicated host group that the virtual machine resides in. **Note:** User cannot specify both host and hostGroup properties. Minimum api-version: 2020-06-01.
   */
  hostGroup?: SubResource;

  /**
   * The provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The virtual machine instance view.
   */
  @visibility(Lifecycle.Read)
  instanceView?: VirtualMachineInstanceView;

  /**
   * Specifies that the image or disk that is being used was licensed on-premises. <br><br> Possible values for Windows Server operating system are: <br><br> Windows_Client <br><br> Windows_Server <br><br> Possible values for Linux Server operating system are: <br><br> RHEL_BYOS (for RHEL) <br><br> SLES_BYOS (for SUSE) <br><br> For more information, see [Azure Hybrid Use Benefit for Windows Server](https://docs.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing) <br><br> [Azure Hybrid Use Benefit for Linux Server](https://docs.microsoft.com/azure/virtual-machines/linux/azure-hybrid-benefit-linux) <br><br> Minimum api-version: 2015-06-15
   */
  licenseType?: string;

  /**
   * Specifies the VM unique ID which is a 128-bits identifier that is encoded and stored in all Azure IaaS VMs SMBIOS and can be read using platform BIOS commands.
   */
  @visibility(Lifecycle.Read)
  vmId?: string;

  /**
   * Specifies the time alloted for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. The default value is 90 minutes (PT1H30M). Minimum api-version: 2020-06-01.
   */
  extensionsTimeBudget?: string;

  /**
   * Specifies the scale set logical fault domain into which the Virtual Machine will be created. By default, the Virtual Machine will by automatically assigned to a fault domain that best maintains balance across available fault domains. This is applicable only if the 'virtualMachineScaleSet' property of this Virtual Machine is set. The Virtual Machine Scale Set that is referenced, must have 'platformFaultDomainCount' greater than 1. This property cannot be updated once the Virtual Machine is created. Fault domain assignment can be viewed in the Virtual Machine Instance View. Minimum api‐version: 2020‐12‐01.
   */
  platformFaultDomain?: int32;

  /**
   * Specifies Scheduled Event related configurations.
   */
  scheduledEventsProfile?: ScheduledEventsProfile;

  /**
   * UserData for the VM, which must be base-64 encoded. Customer should not pass any secrets in here. Minimum api-version: 2021-03-01.
   */
  userData?: string;

  /**
   * Specifies information about the capacity reservation that is used to allocate virtual machine. Minimum api-version: 2021-04-01.
   */
  capacityReservation?: CapacityReservationProfile;

  /**
   * Specifies the gallery applications that should be made available to the VM/VMSS.
   */
  applicationProfile?: ApplicationProfile;

  /**
   * Specifies the time at which the Virtual Machine resource was created. Minimum api-version: 2021-11-01.
   */
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;
}

/**
 * The instance view of a virtual machine.
 */
model VirtualMachineInstanceView {
  /**
   * Specifies the update domain of the virtual machine.
   */
  platformUpdateDomain?: int32;

  /**
   * Specifies the fault domain of the virtual machine.
   */
  platformFaultDomain?: int32;

  /**
   * The computer name assigned to the virtual machine.
   */
  computerName?: string;

  /**
   * The Operating System running on the virtual machine.
   */
  osName?: string;

  /**
   * The version of Operating System running on the virtual machine.
   */
  osVersion?: string;

  /**
   * Specifies the HyperVGeneration Type associated with a resource
   */
  hyperVGeneration?: HyperVGenerationType;

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
   * The virtual machine disk information.
   */
  @identifiers(#["name"])
  disks?: DiskInstanceView[];

  /**
   * The extensions information.
   */
  @identifiers(#["name", "type"])
  extensions?: VirtualMachineExtensionInstanceView[];

  /**
   * The health status for the VM.
   */
  @visibility(Lifecycle.Read)
  vmHealth?: VirtualMachineHealthStatus;

  /**
   * Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. You can easily view the output of your console log. Azure also enables you to see a screenshot of the VM from the hypervisor.
   */
  bootDiagnostics?: BootDiagnosticsInstanceView;

  /**
   * Resource id of the dedicated host, on which the virtual machine is allocated through automatic placement, when the virtual machine is associated with a dedicated host group that has automatic placement enabled. Minimum api-version: 2020-06-01.
   */
  @visibility(Lifecycle.Read)
  assignedHost?: string;

  /**
   * The resource status information.
   */
  @identifiers(#[])
  statuses?: InstanceViewStatus[];

  /**
   * [Preview Feature] The status of virtual machine patch operations.
   */
  patchStatus?: VirtualMachinePatchStatus;

  /**
   * [Preview Feature] Specifies whether the VM is currently in or out of the Standby Pool.
   */
  @visibility(Lifecycle.Read)
  isVMInStandbyPool?: boolean;
}

/**
 * The status of virtual machine patch operations.
 */
model VirtualMachinePatchStatus {
  /**
   * The available patch summary of the latest assessment operation for the virtual machine.
   */
  availablePatchSummary?: AvailablePatchSummary;

  /**
   * The installation summary of the latest installation operation for the virtual machine.
   */
  lastPatchInstallationSummary?: LastPatchInstallationSummary;

  /**
   * The enablement status of the specified patchMode
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  configurationStatuses?: InstanceViewStatus[];
}

/**
 * Describes the properties of an virtual machine instance view for available patch summary.
 */
model AvailablePatchSummary {
  /**
   * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Unknown", "Failed", "Succeeded", or "CompletedWithWarnings."
   */
  @visibility(Lifecycle.Read)
  status?: PatchOperationStatus;

  /**
   * The activity ID of the operation that produced this result. It is used to correlate across CRP and extension logs.
   */
  @visibility(Lifecycle.Read)
  assessmentActivityId?: string;

  /**
   * The overall reboot status of the VM. It will be true when partially installed patches require a reboot to complete installation but the reboot has not yet occurred.
   */
  @visibility(Lifecycle.Read)
  rebootPending?: boolean;

  /**
   * The number of critical or security patches that have been detected as available and not yet installed.
   */
  @visibility(Lifecycle.Read)
  criticalAndSecurityPatchCount?: int32;

  /**
   * The number of all available patches excluding critical and security.
   */
  @visibility(Lifecycle.Read)
  otherPatchCount?: int32;

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility(Lifecycle.Read)
  lastModifiedTime?: utcDateTime;

  /**
   * The errors that were encountered during execution of the operation. The details array contains the list of them.
   */
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/**
 * Describes the properties of the last installed patch summary.
 */
model LastPatchInstallationSummary {
  /**
   * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Unknown", "Failed", "Succeeded", or "CompletedWithWarnings."
   */
  @visibility(Lifecycle.Read)
  status?: PatchOperationStatus;

  /**
   * The activity ID of the operation that produced this result. It is used to correlate across CRP and extension logs.
   */
  @visibility(Lifecycle.Read)
  installationActivityId?: string;

  /**
   * Describes whether the operation ran out of time before it completed all its intended actions
   */
  @visibility(Lifecycle.Read)
  maintenanceWindowExceeded?: boolean;

  /**
   * The number of all available patches but not going to be installed because it didn't match a classification or inclusion list entry.
   */
  @visibility(Lifecycle.Read)
  notSelectedPatchCount?: int32;

  /**
   * The number of all available patches but excluded explicitly by a customer-specified exclusion list match.
   */
  @visibility(Lifecycle.Read)
  excludedPatchCount?: int32;

  /**
   * The number of all available patches expected to be installed over the course of the patch installation operation.
   */
  @visibility(Lifecycle.Read)
  pendingPatchCount?: int32;

  /**
   * The count of patches that successfully installed.
   */
  @visibility(Lifecycle.Read)
  installedPatchCount?: int32;

  /**
   * The count of patches that failed installation.
   */
  @visibility(Lifecycle.Read)
  failedPatchCount?: int32;

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility(Lifecycle.Read)
  lastModifiedTime?: utcDateTime;

  /**
   * The errors that were encountered during execution of the operation. The details array contains the list of them.
   */
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/**
 * Describes the user-defined constraints for resource hardware placement.
 */
model Placement {
  /**
   * Specifies the policy for resource's placement in availability zone. Possible values are: **Any** (used for Virtual Machines), **Auto** (used for Virtual Machine Scale Sets) - An availability zone will be automatically picked by system as part of resource creation.
   */
  zonePlacementPolicy?: ZonePlacementPolicyType;

  /**
   * This property supplements the 'zonePlacementPolicy' property. If 'zonePlacementPolicy' is set to 'Any'/'Auto', availability zone selected by the system must be present in the list of availability zones passed with 'includeZones'. If 'includeZones' is not provided, all availability zones in region will be considered for selection.
   */
  includeZones?: string[];

  /**
   * This property supplements the 'zonePlacementPolicy' property. If 'zonePlacementPolicy' is set to 'Any'/'Auto', availability zone selected by the system must not be present in the list of availability zones passed with 'excludeZones'. If 'excludeZones' is not provided, all availability zones in region will be considered for selection.
   */
  excludeZones?: string[];
}

/**
 * Describes a Virtual Machine Update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope"
model VirtualMachineUpdate extends UpdateResource {
  /**
   * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use.  In the Azure portal, find the marketplace image that you want to use and then click **Want to deploy programmatically, Get Started ->**. Enter any required information and then click **Save**.
   */
  plan?: Plan;

  /**
   * Describes the properties of a Virtual Machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineProperties;

  /**
   * The identity of the virtual machine, if configured.
   */
  identity?: VirtualMachineIdentity;

  /**
   * The virtual machine zones.
   */
  zones?: string[];
}

/**
 * Describes the properties of an AssessPatches result.
 */
model VirtualMachineAssessPatchesResult {
  /**
   * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Unknown", "Failed", "Succeeded", or "CompletedWithWarnings."
   */
  @visibility(Lifecycle.Read)
  status?: PatchOperationStatus;

  /**
   * The activity ID of the operation that produced this result. It is used to correlate across CRP and extension logs.
   */
  @visibility(Lifecycle.Read)
  assessmentActivityId?: string;

  /**
   * The overall reboot status of the VM. It will be true when partially installed patches require a reboot to complete installation but the reboot has not yet occurred.
   */
  @visibility(Lifecycle.Read)
  rebootPending?: boolean;

  /**
   * The number of critical or security patches that have been detected as available and not yet installed.
   */
  @visibility(Lifecycle.Read)
  criticalAndSecurityPatchCount?: int32;

  /**
   * The number of all available patches excluding critical and security.
   */
  @visibility(Lifecycle.Read)
  otherPatchCount?: int32;

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility(Lifecycle.Read)
  startDateTime?: utcDateTime;

  /**
   * The list of patches that have been detected as available for installation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["patchId"])
  availablePatches?: VirtualMachineSoftwarePatchProperties[];

  /**
   * The errors that were encountered during execution of the operation. The details array contains the list of them.
   */
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/**
 * Describes the properties of a Virtual Machine software patch.
 */
model VirtualMachineSoftwarePatchProperties {
  /**
   * A unique identifier for the patch.
   */
  @visibility(Lifecycle.Read)
  patchId?: string;

  /**
   * The friendly name of the patch.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The version number of the patch. This property applies only to Linux patches.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The KBID of the patch. Only applies to Windows patches.
   */
  @visibility(Lifecycle.Read)
  kbId?: string;

  /**
   * The classification(s) of the patch as provided by the patch publisher.
   */
  @visibility(Lifecycle.Read)
  classifications?: string[];

  /**
   * Describes the reboot requirements of the patch.
   */
  @visibility(Lifecycle.Read)
  rebootBehavior?: VMGuestPatchRebootBehavior;

  /**
   * The activity ID of the operation that produced this result. It is used to correlate across CRP and extension logs.
   */
  @visibility(Lifecycle.Read)
  activityId?: string;

  /**
   * The UTC timestamp when the repository published this patch.
   */
  @visibility(Lifecycle.Read)
  publishedDate?: utcDateTime;

  /**
   * The UTC timestamp of the last update to this patch record.
   */
  @visibility(Lifecycle.Read)
  lastModifiedDateTime?: utcDateTime;

  /**
   * Describes the availability of a given patch.
   */
  @visibility(Lifecycle.Read)
  assessmentState?: PatchAssessmentState;
}

/**
 * Capture Virtual Machine parameters.
 */
model VirtualMachineCaptureParameters {
  /**
   * The captured virtual hard disk's name prefix.
   */
  vhdPrefix: string;

  /**
   * The destination container name.
   */
  destinationContainerName: string;

  /**
   * Specifies whether to overwrite the destination virtual hard disk, in case of conflict.
   */
  overwriteVhds: boolean;
}

/**
 * Output of virtual machine capture operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineCaptureResult extends SubResource {
  /**
   * the schema of the captured virtual machine
   */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "$schema")
  schema?: string;

  /**
   * the version of the content
   */
  @visibility(Lifecycle.Read)
  contentVersion?: string;

  /**
   * parameters of the captured virtual machine
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  @visibility(Lifecycle.Read)
  parameters?: unknown;

  /**
   * a list of resource items of the captured virtual machine
   */
  @visibility(Lifecycle.Read)
  resources?: unknown[];
}

/**
 * The List Extension operation response
 */
model VirtualMachineExtensionsListResult {
  /**
   * The list of extensions
   */
  @pageItems
  value?: VirtualMachineExtension[];
}

/**
 * Describes a Virtual Machine Extension.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineExtensionUpdate extends UpdateResource {
  /**
   * Describes the properties of a Virtual Machine Extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineExtensionUpdateProperties;
}

/**
 * Input for InstallPatches as directly received by the API
 */
model VirtualMachineInstallPatchesParameters {
  /**
   * Specifies the maximum amount of time that the operation will run. It must be an ISO 8601-compliant duration string such as PT4H (4 hours)
   */
  maximumDuration?: duration;

  /**
   * Defines when it is acceptable to reboot a VM during a software update operation.
   */
  rebootSetting: VMGuestPatchRebootSetting;

  /**
   * Input for InstallPatches on a Windows VM, as directly received by the API
   */
  windowsParameters?: WindowsParameters;

  /**
   * Input for InstallPatches on a Linux VM, as directly received by the API
   */
  linuxParameters?: LinuxParameters;
}

/**
 * Input for InstallPatches on a Windows VM, as directly received by the API
 */
model WindowsParameters {
  /**
   * The update classifications to select when installing patches for Windows.
   */
  classificationsToInclude?: VMGuestPatchClassificationWindows[];

  /**
   * Kbs to include in the patch operation
   */
  kbNumbersToInclude?: string[];

  /**
   * Kbs to exclude in the patch operation
   */
  kbNumbersToExclude?: string[];

  /**
   * Filters out Kbs that don't have an InstallationRebootBehavior of 'NeverReboots' when this is set to true.
   */
  excludeKbsRequiringReboot?: boolean;

  /**
   * This is used to install patches that were published on or before this given max published date.
   */
  maxPatchPublishDate?: utcDateTime;

  /**
   * This is used to include patches that match the given patch name masks. Alphanumeric strings and wildcard expressions consisting of * and ? are only supported as input values in the list. Null, empty and only whitespaces strings as inputs values are not supported.
   */
  @added(Versions.v2025_04_01)
  patchNameMasksToInclude?: string[];

  /**
   * This is used to exclude patches that match the given patch name masks. Alphanumeric strings and wildcard expressions consisting of * and ? are only supported as input values in the list. Null, empty and only whitespaces strings as inputs values are not supported.
   */
  @added(Versions.v2025_04_01)
  patchNameMasksToExclude?: string[];
}

/**
 * Input for InstallPatches on a Linux VM, as directly received by the API
 */
model LinuxParameters {
  /**
   * The update classifications to select when installing patches for Linux.
   */
  classificationsToInclude?: VMGuestPatchClassificationLinux[];

  /**
   * packages to include in the patch operation. Format: packageName_packageVersion
   */
  packageNameMasksToInclude?: string[];

  /**
   * packages to exclude in the patch operation. Format: packageName_packageVersion
   */
  packageNameMasksToExclude?: string[];

  /**
   * This is used as a maintenance run identifier for Auto VM Guest Patching in Linux.
   */
  maintenanceRunId?: string;
}

/**
 * The result summary of an installation operation.
 */
model VirtualMachineInstallPatchesResult {
  /**
   * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Failed", "Succeeded", "Unknown" or "CompletedWithWarnings."
   */
  @visibility(Lifecycle.Read)
  status?: PatchOperationStatus;

  /**
   * The activity ID of the operation that produced this result. It is used to correlate across CRP and extension logs.
   */
  @visibility(Lifecycle.Read)
  installationActivityId?: string;

  /**
   * The reboot state of the VM following completion of the operation.
   */
  @visibility(Lifecycle.Read)
  rebootStatus?: VMGuestPatchRebootStatus;

  /**
   * Whether the operation ran out of time before it completed all its intended actions.
   */
  @visibility(Lifecycle.Read)
  maintenanceWindowExceeded?: boolean;

  /**
   * The number of patches that were not installed due to the user blocking their installation.
   */
  @visibility(Lifecycle.Read)
  excludedPatchCount?: int32;

  /**
   * The number of patches that were detected as available for install, but did not meet the operation's criteria.
   */
  @visibility(Lifecycle.Read)
  notSelectedPatchCount?: int32;

  /**
   * The number of patches that were identified as meeting the installation criteria, but were not able to be installed. Typically this happens when maintenanceWindowExceeded == true.
   */
  @visibility(Lifecycle.Read)
  pendingPatchCount?: int32;

  /**
   * The number of patches successfully installed.
   */
  @visibility(Lifecycle.Read)
  installedPatchCount?: int32;

  /**
   * The number of patches that could not be installed due to some issue. See errors for details.
   */
  @visibility(Lifecycle.Read)
  failedPatchCount?: int32;

  /**
   * The patches that were installed during the operation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["patchId"])
  patches?: PatchInstallationDetail[];

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility(Lifecycle.Read)
  startDateTime?: utcDateTime;

  /**
   * The errors that were encountered during execution of the operation. The details array contains the list of them.
   */
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/**
 * Information about a specific patch that was encountered during an installation action.
 */
model PatchInstallationDetail {
  /**
   * A unique identifier for the patch.
   */
  @visibility(Lifecycle.Read)
  patchId?: string;

  /**
   * The friendly name of the patch.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The version string of the package. It may conform to Semantic Versioning. Only applies to Linux.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The KBID of the patch. Only applies to Windows patches.
   */
  @visibility(Lifecycle.Read)
  kbId?: string;

  /**
   * The classification(s) of the patch as provided by the patch publisher.
   */
  @visibility(Lifecycle.Read)
  classifications?: string[];

  /**
   * The state of the patch after the installation operation completed.
   */
  @visibility(Lifecycle.Read)
  installationState?: PatchInstallationState;
}

/**
 * The input of virtual machine migration from Availability Set to Flexible Virtual Machine Scale Set.
 */
model MigrateVMToVirtualMachineScaleSetInput {
  /**
   * The target zone of VM migration to Flexible Virtual Machine Scale Set.
   */
  targetZone?: string;

  /**
   * The target compute fault domain of VM migration to Flexible Virtual Machine Scale Set.
   */
  targetFaultDomain?: int32;

  /**
   * The target Virtual Machine size of VM migration to Flexible Virtual Machine Scale Set.
   */
  targetVMSize?: string;
}

/**
 * Virtual machine image resource information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineImageResource extends SubResource {
  /**
   * The name of the resource.
   */
  name: string;

  /**
   * The supported Azure location of the resource.
   */
  location: string;

  /**
   * Specifies the tags that are assigned to the virtual machine. For more information about using tags, see [Using tags to organize your Azure resources](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-using-tags.md).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The extended location of the Virtual Machine.
   */
  extendedLocation?: ExtendedLocation;
}

/**
 * Describes a Virtual Machine Image.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineImage extends VirtualMachineImageResource {
  /**
   * Describes the properties of a Virtual Machine Image.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineImageProperties;
}

/**
 * Describes the properties of a Virtual Machine Image.
 */
model VirtualMachineImageProperties {
  /**
   * Used for establishing the purchase context of any 3rd Party artifact through MarketPlace.
   */
  plan?: PurchasePlan;

  /**
   * Contains the os disk image information.
   */
  osDiskImage?: OSDiskImage;

  /**
   * The list of data disk images information.
   */
  @identifiers(#["lun"])
  dataDiskImages?: DataDiskImage[];

  /**
   * Describes automatic OS upgrade properties on the image.
   */
  automaticOSUpgradeProperties?: AutomaticOSUpgradeProperties;

  /**
   * Specifies the HyperVGeneration Type
   */
  hyperVGeneration?: HyperVGenerationTypes;

  /**
   * Specifies disallowed configuration for the VirtualMachine created from the image
   */
  disallowed?: DisallowedConfiguration;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @identifiers(#["name"])
  features?: VirtualMachineImageFeature[];

  /**
   * Specifies the Architecture Type
   */
  architecture?: ArchitectureTypes;

  /**
   * Describes image deprecation status properties on the image.
   */
  imageDeprecationStatus?: ImageDeprecationStatus;
}

/**
 * Used for establishing the purchase context of any 3rd Party artifact through MarketPlace.
 */
model PurchasePlan {
  /**
   * The publisher ID.
   */
  publisher: string;

  /**
   * The plan ID.
   */
  name: string;

  /**
   * Specifies the product of the image from the marketplace. This is the same value as Offer under the imageReference element.
   */
  product: string;
}

/**
 * Contains the os disk image information.
 */
model OSDiskImage {
  /**
   * The operating system of the osDiskImage.
   */
  operatingSystem: OperatingSystemTypes;
}

/**
 * Contains the data disk images information.
 */
model DataDiskImage {
  /**
   * Specifies the logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM.
   */
  @visibility(Lifecycle.Read)
  lun?: int32;
}

/**
 * Describes automatic OS upgrade properties on the image.
 */
model AutomaticOSUpgradeProperties {
  /**
   * Specifies whether automatic OS upgrade is supported on the image.
   */
  automaticOSUpgradeSupported: boolean;
}

/**
 * Specifies the disallowed configuration for a virtual machine image.
 */
model DisallowedConfiguration {
  /**
   * VM disk types which are disallowed.
   */
  vmDiskType?: VmDiskTypes;
}

/**
 * Specifies additional capabilities supported by the image
 */
model VirtualMachineImageFeature {
  /**
   * The name of the feature.
   */
  name?: string;

  /**
   * The corresponding value for the feature.
   */
  value?: string;
}

/**
 * Describes image deprecation status properties on the image.
 */
model ImageDeprecationStatus {
  /**
   * Describes the state of the image.
   */
  imageState?: ImageState;

  /**
   * The time, in future, at which this image will be marked as deprecated. This scheduled time is chosen by the Publisher.
   */
  scheduledDeprecationTime?: utcDateTime;

  /**
   * Describes the alternative option specified by the Publisher for this image when this image is deprecated.
   */
  alternativeOption?: AlternativeOption;
}

/**
 * Describes the alternative option specified by the Publisher for this image when this image is deprecated.
 */
model AlternativeOption {
  /**
   * Describes the type of the alternative option.
   */
  type?: AlternativeType;

  /**
   * Indicates the alternative option value specified by the Publisher. This is the Offer name when the type is Offer or the Plan name when the type is Plan.
   */
  value?: string;
}

/**
 * The List VmImages in EdgeZone operation response.
 */
model VmImagesInEdgeZoneListResult {
  /**
   * The list of VMImages in EdgeZone
   */
  value?: VirtualMachineImageResource[];

  /**
   * The URI to fetch the next page of VMImages in EdgeZone. Call ListNext() with this URI to fetch the next page of VmImages.
   */
  nextLink?: string;
}

/**
 * Describes the properties of a Virtual Machine Extension Image.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model VirtualMachineExtensionImageProperties {
  /**
   * The operating system this extension supports.
   */
  operatingSystem: string;

  /**
   * The type of role (IaaS or PaaS) this extension supports.
   */
  computeRole: string;

  /**
   * The schema defined by publisher, where extension consumers should provide settings in a matching schema.
   */
  handlerSchema: string;

  /**
   * Whether the extension can be used on xRP VMScaleSets. By default existing extensions are usable on scalesets, but there might be cases where a publisher wants to explicitly indicate the extension is only enabled for CRP VMs but not VMSS.
   */
  vmScaleSetEnabled?: boolean;

  /**
   * Whether the handler can support multiple extensions.
   */
  supportsMultipleExtensions?: boolean;
}

/**
 * The List Availability Set operation response.
 */
model AvailabilitySetListResult is Azure.Core.Page<AvailabilitySet>;

@@doc(AvailabilitySetListResult.value, "The list of availability sets.");
@@doc(AvailabilitySetListResult.nextLink,
  "The URI to fetch the next page of AvailabilitySets. Call ListNext() with this URI to fetch the next page of AvailabilitySets."
);

/**
 * The instance view of a resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AvailabilitySetProperties {
  /**
   * Update Domain count.
   */
  platformUpdateDomainCount?: int32;

  /**
   * Fault Domain count.
   */
  platformFaultDomainCount?: int32;

  /**
   * A list of references to all virtual machines in the availability set.
   */
  virtualMachines?: SubResource[];

  /**
   * Specifies information about the proximity placement group that the availability set should be assigned to. Minimum api-version: 2018-04-01.
   */
  proximityPlacementGroup?: SubResource;

  /**
   * The resource status information.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  statuses?: InstanceViewStatus[];

  /**
   * Specifies Redeploy, Reboot and ScheduledEventsAdditionalPublishingTargets Scheduled Event related configurations for the availability set.
   */
  scheduledEventsPolicy?: ScheduledEventsPolicy;

  /**
   * Describes the migration properties on the Availability Set.
   */
  @visibility(Lifecycle.Read)
  virtualMachineScaleSetMigrationInfo?: VirtualMachineScaleSetMigrationInfo;
}

/**
 * Describes the Availability Set properties related to migration to Flexible Virtual Machine Scale Set.
 */
model VirtualMachineScaleSetMigrationInfo {
  /**
   * Indicates the target Virtual Machine ScaleSet properties upon triggering a seamless migration without downtime of the VMs via the ConvertToVirtualMachineScaleSet API.
   */
  @visibility(Lifecycle.Read)
  defaultVirtualMachineScaleSetInfo?: DefaultVirtualMachineScaleSetInfo;

  /**
   * Specifies the Virtual Machine Scale Set that the Availability Set is migrated to.
   */
  @visibility(Lifecycle.Read)
  migrateToVirtualMachineScaleSet?: SubResource;
}

/**
 * Indicates the target Virtual Machine ScaleSet properties upon triggering a seamless migration without downtime of the VMs via the ConvertToVirtualMachineScaleSet API.
 */
model DefaultVirtualMachineScaleSetInfo {
  /**
   *  Indicates if the the maximum capacity of the default migrated Virtual Machine Scale Set after its migration will be constrained to a limited number of VMs.
   */
  @visibility(Lifecycle.Read)
  constrainedMaximumCapacity?: boolean;

  /**
   *  The default Virtual Machine ScaleSet Uri that the Availability Set will be moved to upon triggering a seamless migration via the ConvertToVirtualMachineScaleSet API.
   */
  @visibility(Lifecycle.Read)
  defaultVirtualMachineScaleSet?: SubResource;
}

/**
 * Describes the Virtual Machine Scale Set to migrate from Availability Set.
 */
model MigrateToVirtualMachineScaleSetInput {
  /**
   * Specifies information about the Virtual Machine Scale Set that the Availability Set should be migrated to. Minimum api‐version: 2024‐11‐01.
   */
  virtualMachineScaleSetFlexible: SubResource;
}

/**
 * Describes the Virtual Machine Scale Set to convert from Availability Set.
 */
model ConvertToVirtualMachineScaleSetInput {
  /**
   * Specifies information about the Virtual Machine Scale Set that the Availability Set should be converted to.
   */
  virtualMachineScaleSetName?: string;
}
/**
 * Specifies information about the availability set that the virtual machine should be assigned to. Only tags may be updated.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AvailabilitySetUpdate extends UpdateResource {
  /**
   * The instance view of a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AvailabilitySetProperties;

  /**
   * Sku of the availability set
   */
  sku?: Sku;
}

/**
 * The List Proximity Placement Group operation response.
 */
model ProximityPlacementGroupListResult
  is Azure.Core.Page<ProximityPlacementGroup>;

@@doc(ProximityPlacementGroupListResult.value,
  "The list of proximity placement groups."
);
@@doc(ProximityPlacementGroupListResult.nextLink,
  "The URI to fetch the next page of proximity placement groups."
);

/**
 * Describes the properties of a Proximity Placement Group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ProximityPlacementGroupProperties {
  /**
   * Specifies the type of the proximity placement group. Possible values are: **Standard** : Co-locate resources within an Azure region or Availability Zone. **Ultra** : For future use.
   */
  proximityPlacementGroupType?: ProximityPlacementGroupType;

  /**
   * A list of references to all virtual machines in the proximity placement group.
   */
  @visibility(Lifecycle.Read)
  virtualMachines?: SubResourceWithColocationStatus[];

  /**
   * A list of references to all virtual machine scale sets in the proximity placement group.
   */
  @visibility(Lifecycle.Read)
  virtualMachineScaleSets?: SubResourceWithColocationStatus[];

  /**
   * A list of references to all availability sets in the proximity placement group.
   */
  @visibility(Lifecycle.Read)
  availabilitySets?: SubResourceWithColocationStatus[];

  /**
   * Describes colocation status of the Proximity Placement Group.
   */
  colocationStatus?: InstanceViewStatus;

  /**
   * Specifies the user intent of the proximity placement group.
   */
  intent?: ProximityPlacementGroupPropertiesIntent;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SubResourceWithColocationStatus extends SubResource {
  /**
   * Describes colocation status of a resource in the Proximity Placement Group.
   */
  colocationStatus?: InstanceViewStatus;
}

/**
 * Specifies the user intent of the proximity placement group.
 */
model ProximityPlacementGroupPropertiesIntent {
  /**
   * Specifies possible sizes of virtual machines that can be created in the proximity placement group.
   */
  vmSizes?: string[];
}

/**
 * Specifies information about the proximity placement group.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
model ProximityPlacementGroupUpdate extends UpdateResource {}

/**
 * The List Dedicated Host Group with resource group response.
 */
model DedicatedHostGroupListResult is Azure.Core.Page<DedicatedHostGroup>;

@@doc(DedicatedHostGroupListResult.value, "The list of dedicated host groups.");
@@doc(DedicatedHostGroupListResult.nextLink,
  "The URI to fetch the next page of Dedicated Host Groups. Call ListNext() with this URI to fetch the next page of Dedicated Host Groups."
);

/**
 * Dedicated Host Group Properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DedicatedHostGroupProperties {
  /**
   * Number of fault domains that the host group can span.
   */
  @minValue(1)
  platformFaultDomainCount: int32;

  /**
   * A list of references to all dedicated hosts in the dedicated host group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "For backward compatibility"
  @visibility(Lifecycle.Read)
  hosts?: SubResourceReadOnly[];

  /**
   * The dedicated host group instance view, which has the list of instance view of the dedicated hosts under the dedicated host group.
   */
  @visibility(Lifecycle.Read)
  instanceView?: DedicatedHostGroupInstanceView;

  /**
   * Specifies whether virtual machines or virtual machine scale sets can be placed automatically on the dedicated host group. Automatic placement means resources are allocated on dedicated hosts, that are chosen by Azure, under the dedicated host group. The value is defaulted to 'false' when not provided. Minimum api-version: 2020-06-01.
   */
  supportAutomaticPlacement?: boolean;

  /**
   * Enables or disables a capability on the dedicated host group. Minimum api-version: 2022-03-01.
   */
  additionalCapabilities?: DedicatedHostGroupPropertiesAdditionalCapabilities;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DedicatedHostGroupInstanceView {
  /**
   * List of instance view of the dedicated hosts under the dedicated host group.
   */
  @identifiers(#["name"])
  hosts?: DedicatedHostInstanceViewWithName[];
}

/**
 * The instance view of a dedicated host that includes the name of the dedicated host. It is used for the response to the instance view of a dedicated host group.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DedicatedHostInstanceViewWithName extends DedicatedHostInstanceView {
  /**
   * The name of the dedicated host.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * The instance view of a dedicated host.
 */
model DedicatedHostInstanceView {
  /**
   * Specifies the unique id of the dedicated physical machine on which the dedicated host resides.
   */
  @visibility(Lifecycle.Read)
  assetId?: string;

  /**
   * Unutilized capacity of the dedicated host.
   */
  availableCapacity?: DedicatedHostAvailableCapacity;

  /**
   * The resource status information.
   */
  @identifiers(#[])
  statuses?: InstanceViewStatus[];
}

/**
 * Dedicated host unutilized capacity.
 */
model DedicatedHostAvailableCapacity {
  /**
   * The unutilized capacity of the dedicated host represented in terms of each VM size that is allowed to be deployed to the dedicated host.
   */
  @identifiers(#[])
  allocatableVMs?: DedicatedHostAllocatableVM[];
}

/**
 * Represents the dedicated host unutilized capacity in terms of a specific VM size.
 */
model DedicatedHostAllocatableVM {
  /**
   * VM size in terms of which the unutilized capacity is represented.
   */
  vmSize?: string;

  /**
   * Maximum number of VMs of size vmSize that can fit in the dedicated host's remaining capacity.
   */
  count?: float64;
}

/**
 * Enables or disables a capability on the dedicated host group. Minimum api-version: 2022-03-01.
 */
model DedicatedHostGroupPropertiesAdditionalCapabilities {
  /**
   * The flag that enables or disables a capability to have UltraSSD Enabled Virtual Machines on Dedicated Hosts of the Dedicated Host Group. For the Virtual Machines to be UltraSSD Enabled, UltraSSDEnabled flag for the resource needs to be set true as well. The value is defaulted to 'false' when not provided. Please refer to https://docs.microsoft.com/en-us/azure/virtual-machines/disks-enable-ultra-ssd for more details on Ultra SSD feature. **Note:** The ultraSSDEnabled setting can only be enabled for Host Groups that are created as zonal. Minimum api-version: 2022-03-01.
   */
  ultraSSDEnabled?: boolean;
}

/**
 * Specifies information about the dedicated host group that the dedicated host should be assigned to. Only tags may be updated.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DedicatedHostGroupUpdate extends UpdateResource {
  /**
   * Dedicated Host Group Properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DedicatedHostGroupProperties;

  /**
   * Availability Zone to use for this host group. Only single zone is supported. The zone can be assigned only during creation. If not provided, the group supports all zones in the region. If provided, enforces each host in the group to be in the same zone.
   */
  zones?: string[];
}

/**
 * The list dedicated host operation response.
 */
model DedicatedHostListResult is Azure.Core.Page<DedicatedHost>;

@@doc(DedicatedHostListResult.value, "The list of dedicated hosts.");
@@doc(DedicatedHostListResult.nextLink,
  "The URI to fetch the next page of dedicated hosts. Call ListNext() with this URI to fetch the next page of dedicated hosts."
);

/**
 * Properties of the dedicated host.
 */
model DedicatedHostProperties {
  /**
   * Fault domain of the dedicated host within a dedicated host group.
   */
  platformFaultDomain?: int32;

  /**
   * Specifies whether the dedicated host should be replaced automatically in case of a failure. The value is defaulted to 'true' when not provided.
   */
  autoReplaceOnFailure?: boolean;

  /**
   * A unique id generated and assigned to the dedicated host by the platform. Does not change throughout the lifetime of the host.
   */
  @visibility(Lifecycle.Read)
  hostId?: string;

  /**
   * A list of references to all virtual machines in the Dedicated Host.
   */
  @visibility(Lifecycle.Read)
  virtualMachines?: SubResourceReadOnly[];

  /**
   * Specifies the software license type that will be applied to the VMs deployed on the dedicated host. Possible values are: **None,** **Windows_Server_Hybrid,** **Windows_Server_Perpetual.** The default value is: **None.**
   */
  licenseType?: DedicatedHostLicenseTypes;

  /**
   * The date when the host was first provisioned.
   */
  @visibility(Lifecycle.Read)
  provisioningTime?: utcDateTime;

  /**
   * The provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The dedicated host instance view.
   */
  @visibility(Lifecycle.Read)
  instanceView?: DedicatedHostInstanceView;

  /**
   * Specifies the time at which the Dedicated Host resource was created. Minimum api-version: 2021-11-01.
   */
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;
}

/**
 * Specifies information about the dedicated host. Only tags, autoReplaceOnFailure and licenseType may be updated.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DedicatedHostUpdate extends UpdateResource {
  /**
   * Properties of the dedicated host.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DedicatedHostProperties;

  /**
   * [List all available dedicated host sizes for resizing] (https://docs.microsoft.com/rest/api/compute/dedicated-hosts/listavailablesizes). Resizing can be only used to scale up DedicatedHost. Only name is required to be set.
   */
  sku?: Sku;
}

/**
 * The List Dedicated Host sizes operation response.
 */
model DedicatedHostSizeListResult {
  /**
   * The list of dedicated host sizes.
   */
  @pageItems
  value?: string[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The list SSH public keys operation response.
 */
model SshPublicKeysGroupListResult is Azure.Core.Page<SshPublicKeyResource>;

@@doc(SshPublicKeysGroupListResult.value, "The list of SSH public keys.");
@@doc(SshPublicKeysGroupListResult.nextLink,
  "The URI to fetch the next page of SSH public keys. Call ListNext() with this URI to fetch the next page of SSH public keys."
);

/**
 * Properties of the SSH public key.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SshPublicKeyResourceProperties {
  /**
   * SSH public key used to authenticate to a virtual machine through ssh. If this property is not initially provided when the resource is created, the publicKey property will be populated when generateKeyPair is called. If the public key is provided upon resource creation, the provided public key needs to be at least 2048-bit and in ssh-rsa format.
   */
  publicKey?: string;
}

/**
 * Specifies information about the SSH public key.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SshPublicKeyUpdateResource extends UpdateResource {
  /**
   * Properties of the SSH public key.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SshPublicKeyResourceProperties;
}

/**
 * Parameters for GenerateSshKeyPair.
 */
model SshGenerateKeyPairInputParameters {
  /**
   * The encryption type of the SSH keys to be generated. See SshEncryptionTypes for possible set of values. If not provided, will default to RSA
   */
  encryptionType?: SshEncryptionTypes;
}

/**
 * Response from generation of an SSH key pair.
 */
model SshPublicKeyGenerateKeyPairResult {
  /**
   * Private key portion of the key pair used to authenticate to a virtual machine through ssh. The private key is returned in RFC3447 format and should be treated as a secret.
   */
  privateKey: string;

  /**
   * Public key portion of the key pair used to authenticate to a virtual machine through ssh. The public key is in ssh-rsa format.
   */
  publicKey: string;

  /**
   * The ARM resource id in the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/sshPublicKeys/{SshPublicKeyName}
   */
  id: string;
}

/**
 * The List Image operation response.
 */
model ImageListResult is Azure.Core.Page<Image>;

@@doc(ImageListResult.value, "The list of Images");
@@doc(ImageListResult.nextLink,
  "The uri to fetch the next page of Images. Call ListNext() with this to fetch the next page of Images."
);

/**
 * Describes the properties of an Image.
 */
model ImageProperties {
  /**
   * The source virtual machine from which Image is created.
   */
  sourceVirtualMachine?: SubResource;

  /**
   * Specifies the storage settings for the virtual machine disks.
   */
  storageProfile?: ImageStorageProfile;

  /**
   * The provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Specifies the HyperVGenerationType of the VirtualMachine created from the image. From API Version 2019-03-01 if the image source is a blob, then we need the user to specify the value, if the source is managed resource like disk or snapshot, we may require the user to specify the property if we cannot deduce it from the source managed resource.
   */
  hyperVGeneration?: HyperVGenerationTypes;
}

/**
 * Describes a storage profile.
 */
model ImageStorageProfile {
  /**
   * Specifies information about the operating system disk used by the virtual machine. <br><br> For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  osDisk?: ImageOSDisk;

  /**
   * Specifies the parameters that are used to add a data disk to a virtual machine. <br><br> For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).
   */
  @identifiers(#["lun"])
  dataDisks?: ImageDataDisk[];

  /**
   * Specifies whether an image is zone resilient or not. Default is false. Zone resilient images can be created only in regions that provide Zone Redundant Storage (ZRS).
   */
  zoneResilient?: boolean;
}

/**
 * Describes an Operating System disk.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageOSDisk extends ImageDisk {
  /**
   * This property allows you to specify the type of the OS that is included in the disk if creating a VM from a custom image. Possible values are: **Windows,** **Linux.**
   */
  osType: OperatingSystemTypes;

  /**
   * The OS State. For managed images, use Generalized.
   */
  osState: OperatingSystemStateTypes;
}

/**
 * Describes a image disk.
 */
model ImageDisk {
  /**
   * The snapshot.
   */
  snapshot?: SubResource;

  /**
   * The managedDisk.
   */
  managedDisk?: SubResource;

  /**
   * The Virtual Hard Disk.
   */
  blobUri?: string;

  /**
   * Specifies the caching requirements. Possible values are: **None,** **ReadOnly,** **ReadWrite.** The default values are: **None for Standard storage. ReadOnly for Premium storage.**
   */
  caching?: CachingTypes;

  /**
   * Specifies the size of empty data disks in gigabytes. This element can be used to overwrite the name of the disk in a virtual machine image. This value cannot be larger than 1023 GB.
   */
  diskSizeGB?: int32;

  /**
   * Specifies the storage account type for the managed disk. NOTE: UltraSSD_LRS can only be used with data disks, it cannot be used with OS Disk.
   */
  storageAccountType?: StorageAccountTypes;

  /**
   * Specifies the customer managed disk encryption set resource id for the managed image disk.
   */
  diskEncryptionSet?: DiskEncryptionSetParameters;
}

/**
 * Describes a data disk.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageDataDisk extends ImageDisk {
  /**
   * Specifies the logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM.
   */
  lun: int32;
}

/**
 * The source user image virtual hard disk. Only tags may be updated.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageUpdate extends UpdateResource {
  /**
   * Describes the properties of an Image.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ImageProperties;
}

/**
 * The List restore point collection operation response.
 */
model RestorePointCollectionListResult
  is Azure.Core.Page<RestorePointCollection>;

@@doc(RestorePointCollectionListResult.value,
  "Gets the list of restore point collections."
);
@@doc(RestorePointCollectionListResult.nextLink,
  "The uri to fetch the next page of RestorePointCollections. Call ListNext() with this to fetch the next page of RestorePointCollections."
);

/**
 * The restore point collection properties.
 */
model RestorePointCollectionProperties {
  /**
   * The properties of the source resource that this restore point collection is created from.
   */
  source?: RestorePointCollectionSourceProperties;

  /**
   * The provisioning state of the restore point collection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique id of the restore point collection.
   */
  @visibility(Lifecycle.Read)
  restorePointCollectionId?: string;

  /**
   * A list containing all restore points created under this restore point collection.
   */
  @visibility(Lifecycle.Read)
  restorePoints?: RestorePoint[];
}

/**
 * The properties of the source resource that this restore point collection is created from.
 */
model RestorePointCollectionSourceProperties {
  /**
   * Location of the source resource used to create this restore point collection.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Resource Id of the source resource used to create this restore point collection
   */
  id?: string;
}

/**
 * The restore point properties.
 */
model RestorePointProperties {
  /**
   * List of disk resource ids that the customer wishes to exclude from the restore point. If no disks are specified, all disks will be included.
   */
  excludeDisks?: ApiEntityReference[];

  /**
   * Gets the details of the VM captured at the time of the restore point creation.
   */
  sourceMetadata?: RestorePointSourceMetadata;

  /**
   * Gets the provisioning state of the restore point.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * ConsistencyMode of the RestorePoint. Can be specified in the input while creating a restore point. For now, only CrashConsistent is accepted as a valid input. Please refer to https://aka.ms/RestorePoints for more details.
   */
  consistencyMode?: ConsistencyModeTypes;

  /**
   * Gets the creation time of the restore point.
   */
  timeCreated?: utcDateTime;

  /**
   * Resource Id of the source restore point from which a copy needs to be created.
   */
  sourceRestorePoint?: ApiEntityReference;

  /**
   * The restore point instance view.
   */
  @visibility(Lifecycle.Read)
  instanceView?: RestorePointInstanceView;
}

/**
 * Describes the properties of the Virtual Machine for which the restore point was created. The properties provided are a subset and the snapshot of the overall Virtual Machine properties captured at the time of the restore point creation.
 */
model RestorePointSourceMetadata {
  /**
   * Gets the hardware profile.
   */
  @visibility(Lifecycle.Read)
  hardwareProfile?: HardwareProfile;

  /**
   * Gets the storage profile.
   */
  storageProfile?: RestorePointSourceVMStorageProfile;

  /**
   * Gets the OS profile.
   */
  @visibility(Lifecycle.Read)
  osProfile?: OSProfile;

  /**
   * Gets the diagnostics profile.
   */
  @visibility(Lifecycle.Read)
  diagnosticsProfile?: DiagnosticsProfile;

  /**
   * Gets the license type, which is for bring your own license scenario.
   */
  @visibility(Lifecycle.Read)
  licenseType?: string;

  /**
   * Gets the virtual machine unique id.
   */
  @visibility(Lifecycle.Read)
  vmId?: string;

  /**
   * Gets the security profile.
   */
  @visibility(Lifecycle.Read)
  securityProfile?: SecurityProfile;

  /**
   * Location of the VM from which the restore point was created.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * UserData associated with the source VM for which restore point is captured, which is a base-64 encoded value.
   */
  @visibility(Lifecycle.Read)
  userData?: string;

  /**
   * HyperVGeneration of the source VM for which restore point is captured.
   */
  @visibility(Lifecycle.Read)
  hyperVGeneration?: HyperVGenerationTypes;
}

/**
 * Describes the storage profile.
 */
model RestorePointSourceVMStorageProfile {
  /**
   * Gets the OS disk of the VM captured at the time of the restore point creation.
   */
  osDisk?: RestorePointSourceVMOSDisk;

  /**
   * Gets the data disks of the VM captured at the time of the restore point creation.
   */
  @identifiers(#["lun"])
  dataDisks?: RestorePointSourceVMDataDisk[];

  /**
   * Gets the disk controller type of the VM captured at the time of the restore point creation.
   */
  @visibility(Lifecycle.Read)
  diskControllerType?: DiskControllerTypes;
}

/**
 * Describes an Operating System disk.
 */
model RestorePointSourceVMOSDisk {
  /**
   * Gets the Operating System type.
   */
  @visibility(Lifecycle.Read)
  osType?: OperatingSystemType;

  /**
   * Gets the disk encryption settings.
   */
  @visibility(Lifecycle.Read)
  encryptionSettings?: DiskEncryptionSettings;

  /**
   * Gets the disk name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets the caching type.
   */
  @visibility(Lifecycle.Read)
  caching?: CachingTypes;

  /**
   * Gets the disk size in GB.
   */
  @visibility(Lifecycle.Read)
  diskSizeGB?: int32;

  /**
   * Gets the managed disk details
   */
  managedDisk?: ManagedDiskParameters;

  /**
   * Contains Disk Restore Point properties.
   */
  diskRestorePoint?: DiskRestorePointAttributes;

  /**
   * Shows true if the disk is write-accelerator enabled.
   */
  @visibility(Lifecycle.Read)
  writeAcceleratorEnabled?: boolean;
}

/**
 * Disk Restore Point details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DiskRestorePointAttributes extends SubResourceReadOnly {
  /**
   * Encryption at rest settings for disk restore point. It is an optional property that can be specified in the input while creating a restore point.
   */
  encryption?: RestorePointEncryption;

  /**
   * Resource Id of the source disk restore point.
   */
  sourceDiskRestorePoint?: ApiEntityReference;
}

/**
 * Encryption at rest settings for disk restore point. It is an optional property that can be specified in the input while creating a restore point.
 */
model RestorePointEncryption {
  /**
   * Describes the parameter of customer managed disk encryption set resource id that can be specified for disk. **Note:** The disk encryption set resource id can only be specified for managed disk. Please refer https://aka.ms/mdssewithcmkoverview for more details.
   */
  diskEncryptionSet?: DiskEncryptionSetParameters;

  /**
   * The type of key used to encrypt the data of the disk restore point.
   */
  type?: RestorePointEncryptionType;
}

/**
 * Describes a data disk.
 */
model RestorePointSourceVMDataDisk {
  /**
   * Gets the logical unit number.
   */
  @visibility(Lifecycle.Read)
  lun?: int32;

  /**
   * Gets the disk name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets the caching type.
   */
  @visibility(Lifecycle.Read)
  caching?: CachingTypes;

  /**
   * Gets the initial disk size in GB for blank data disks, and the new desired size for existing OS and Data disks.
   */
  @visibility(Lifecycle.Read)
  diskSizeGB?: int32;

  /**
   * Contains the managed disk details.
   */
  managedDisk?: ManagedDiskParameters;

  /**
   * Contains Disk Restore Point properties.
   */
  diskRestorePoint?: DiskRestorePointAttributes;

  /**
   * Shows true if the disk is write-accelerator enabled.
   */
  @visibility(Lifecycle.Read)
  writeAcceleratorEnabled?: boolean;
}

/**
 * The instance view of a restore point.
 */
model RestorePointInstanceView {
  /**
   * The disk restore points information.
   */
  diskRestorePoints?: DiskRestorePointInstanceView[];

  /**
   * The resource status information.
   */
  @identifiers(#[])
  statuses?: InstanceViewStatus[];
}

/**
 * The instance view of a disk restore point.
 */
model DiskRestorePointInstanceView {
  /**
   * Disk restore point Id.
   */
  id?: string;

  /**
   * The disk restore point replication status information.
   */
  replicationStatus?: DiskRestorePointReplicationStatus;
}

/**
 * The instance view of a disk restore point.
 */
model DiskRestorePointReplicationStatus {
  /**
   * The resource status information.
   */
  status?: InstanceViewStatus;

  /**
   * Replication completion percentage.
   */
  completionPercent?: int32;
}

/**
 * Update Restore Point collection parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RestorePointCollectionUpdate extends UpdateResource {
  /**
   * The restore point collection properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: RestorePointCollectionProperties;
}

/**
 * The List capacity reservation group with resource group response.
 */
model CapacityReservationGroupListResult
  is Azure.Core.Page<CapacityReservationGroup>;

@@doc(CapacityReservationGroupListResult.value,
  "The list of capacity reservation groups."
);
@@doc(CapacityReservationGroupListResult.nextLink,
  "The URI to fetch the next page of capacity reservation groups. Call ListNext() with this URI to fetch the next page of capacity reservation groups."
);
/**
 * capacity reservation group Properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CapacityReservationGroupProperties {
  /**
   * A list of all capacity reservation resource ids that belong to capacity reservation group.
   */
  @visibility(Lifecycle.Read)
  capacityReservations?: SubResourceReadOnly[];

  /**
   * A list of references to all virtual machines associated to the capacity reservation group.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociated?: SubResourceReadOnly[];

  /**
   * The capacity reservation group instance view which has the list of instance views for all the capacity reservations that belong to the capacity reservation group.
   */
  @visibility(Lifecycle.Read)
  instanceView?: CapacityReservationGroupInstanceView;

  /**
   * Specifies the settings to enable sharing across subscriptions for the capacity reservation group resource. The capacity reservation group resource can generally be shared across subscriptions belonging to a single Azure AAD tenant or across AAD tenants if there is a trust relationship established between the tenants.  Block capacity reservation does not support sharing across subscriptions. **Note:** Minimum api-version: 2023-09-01. Please refer to https://aka.ms/computereservationsharing for more details.
   */
  sharingProfile?: ResourceSharingProfile;

  /**
   * Indicates the type of capacity reservation. Allowed values are 'Block' for block capacity reservations and 'Targeted' for reservations that enable a VM to consume a specific capacity reservation when a capacity reservation group is provided. The reservation type is immutable and cannot be changed after it is assigned.
   */
  @added(Versions.v2025_04_01)
  reservationType?: ReservationType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CapacityReservationGroupInstanceView {
  /**
   * List of instance view of the capacity reservations under the capacity reservation group.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  capacityReservations?: CapacityReservationInstanceViewWithName[];

  /**
   * List of the subscriptions that the capacity reservation group is shared with. **Note:** Minimum api-version: 2023-09-01. Please refer to https://aka.ms/computereservationsharing for more details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  sharedSubscriptionIds?: SubResourceReadOnly[];
}

/**
 * The instance view of a capacity reservation that includes the name of the capacity reservation. It is used for the response to the instance view of a capacity reservation group.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CapacityReservationInstanceViewWithName
  extends CapacityReservationInstanceView {
  /**
   * The name of the capacity reservation.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * The instance view of a capacity reservation that provides as snapshot of the runtime properties of the capacity reservation that is managed by the platform and can change outside of control plane operations.
 */
model CapacityReservationInstanceView {
  /**
   * Unutilized capacity of the capacity reservation.
   */
  utilizationInfo?: CapacityReservationUtilization;

  /**
   * The resource status information.
   */
  @identifiers(#[])
  statuses?: InstanceViewStatus[];
}

/**
 * Defines the schedule for Block-type capacity reservations. Specifies the schedule during which capacity reservation is active and VM or VMSS resource can be allocated using reservation. This property is required and only supported when the capacity reservation group type is 'Block'. The scheduleProfile, start, and end fields are immutable after creation. Minimum API version: 2025-04-01. Please refer to https://aka.ms/blockcapacityreservation for more details.
 */
@added(Versions.v2025_04_01)
model ScheduleProfile {
  /**
   * The required start date for block capacity reservations. Must be today or within 56 days in the future. For same-day scheduling, requests must be submitted before 11:30 AM UTC. Example: 2025-06-27.
   */
  start?: string;

  /**
   * The required end date for block capacity reservations. Must be after the start date, with a duration of either 1–14 whole days or 3–26 whole weeks. Example: 2025-06-28.
   */
  end?: string;
}

/**
 * Represents the capacity reservation utilization in terms of resources allocated.
 */
model CapacityReservationUtilization {
  /**
   * The value provides the current capacity of the VM size which was reserved successfully and for which the customer is getting billed. Minimum api-version: 2022-08-01.
   */
  @visibility(Lifecycle.Read)
  currentCapacity?: int32;

  /**
   * A list of all virtual machines resource ids allocated against the capacity reservation.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAllocated?: SubResourceReadOnly[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceSharingProfile {
  /**
   * Specifies an array of subscription resource IDs that capacity reservation group is shared with. Block Capacity Reservations does not support sharing across subscriptions. **Note:** Minimum api-version: 2023-09-01. Please refer to https://aka.ms/computereservationsharing for more details.
   */
  subscriptionIds?: SubResource[];
}

/**
 * Indicates the type of capacity reservation. Allowed values are 'Block' for block capacity reservations and 'Targeted' for reservations that enable a VM to consume a specific capacity reservation when a capacity reservation group is provided. The reservation type is immutable and cannot be changed after it is assigned.
 */
@added(Versions.v2025_04_01)
union ReservationType {
  /**
   * Custom reservation type value.
   */
  string,

  /**
   * To consume on demand allocated capacity reservation when a capacity reservation group is provided.
   */
  Targeted: "Targeted",

  /**
   * To consume scheduled allocated block capacity reservation when a capacity reservation group is provided.
   */
  Block: "Block",
}

/**
 * Specifies information about the capacity reservation group. Only tags can be updated.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CapacityReservationGroupUpdate extends UpdateResource {
  /**
   * capacity reservation group Properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CapacityReservationGroupProperties;
}

/**
 * The list capacity reservation operation response.
 */
model CapacityReservationListResult is Azure.Core.Page<CapacityReservation>;

@@doc(CapacityReservationListResult.value,
  "The list of capacity reservations."
);
@@doc(CapacityReservationListResult.nextLink,
  "The URI to fetch the next page of capacity reservations. Call ListNext() with this URI to fetch the next page of capacity reservations."
);

/**
 * Properties of the Capacity reservation.
 */
model CapacityReservationProperties {
  /**
   * A unique id generated and assigned to the capacity reservation by the platform which does not change throughout the lifetime of the resource.
   */
  @visibility(Lifecycle.Read)
  reservationId?: string;

  /**
   * Specifies the value of fault domain count that Capacity Reservation supports for requested VM size. **Note:** The fault domain count specified for a resource (like virtual machines scale set) must be less than or equal to this value if it deploys using capacity reservation. Minimum api-version: 2022-08-01.
   */
  @visibility(Lifecycle.Read)
  platformFaultDomainCount?: int32;

  /**
   * A list of all virtual machine resource ids that are associated with the capacity reservation.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociated?: SubResourceReadOnly[];

  /**
   * The date time when the capacity reservation was last updated.
   */
  @visibility(Lifecycle.Read)
  provisioningTime?: utcDateTime;

  /**
   * The provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The Capacity reservation instance view.
   */
  @visibility(Lifecycle.Read)
  instanceView?: CapacityReservationInstanceView;

  /**
   * Specifies the time at which the Capacity Reservation resource was created. Minimum api-version: 2021-11-01.
   */
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;

  /**
   * Defines the schedule for Block-type capacity reservations. Specifies the schedule during which capacity reservation is active and VM or VMSS resource can be allocated using reservation. This property is required and only supported when the capacity reservation group type is 'Block'. The scheduleProfile, start, and end fields are immutable after creation. Minimum API version: 2025-04-01. Please refer to https://aka.ms/blockcapacityreservation for more details.
   */
  @added(Versions.v2025_04_01)
  scheduleProfile?: ScheduleProfile;
}

/**
 * Specifies information about the capacity reservation. sku.capacity cannot be updated for Block Capacity Reservation. Tags can be update for all Capacity Reservation Types.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CapacityReservationUpdate extends UpdateResource {
  /**
   * Properties of the Capacity reservation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CapacityReservationProperties;

  /**
   * SKU of the resource for which capacity needs be reserved. The SKU name and capacity is required to be set. Currently VM Skus with the capability called 'CapacityReservationSupported' set to true are supported. When 'CapacityReservationSupported' is true, the SKU capability also specifies the 'SupportedCapacityReservationTypes', which lists the types of capacity reservations (such as Targeted or Block) that the SKU supports. Refer to List Microsoft.Compute SKUs in a region (https://docs.microsoft.com/rest/api/compute/resourceskus/list) for supported values. **Note:** The SKU name and capacity cannot be updated for Block capacity reservations.
   */
  sku?: Sku;
}

/**
 * Api request input for LogAnalytics getRequestRateByInterval Api.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RequestRateByIntervalInput extends LogAnalyticsInputBase {
  /**
   * Interval value in minutes used to create LogAnalytics call rate logs.
   */
  intervalLength: IntervalInMins;
}

/**
 * Api input base class for LogAnalytics Api.
 */
model LogAnalyticsInputBase {
  /**
   * SAS Uri of the logging blob container to which LogAnalytics Api writes output logs to.
   */
  blobContainerSasUri: string;

  /**
   * From time of the query
   */
  fromTime: utcDateTime;

  /**
   * To time of the query
   */
  toTime: utcDateTime;

  /**
   * Group query result by Throttle Policy applied.
   */
  groupByThrottlePolicy?: boolean;

  /**
   * Group query result by Operation Name.
   */
  groupByOperationName?: boolean;

  /**
   * Group query result by Resource Name.
   */
  groupByResourceName?: boolean;

  /**
   * Group query result by Client Application ID.
   */
  groupByClientApplicationId?: boolean;

  /**
   * Group query result by User Agent.
   */
  groupByUserAgent?: boolean;
}

/**
 * LogAnalytics operation status response
 */
model LogAnalyticsOperationResult {
  /**
   * LogAnalyticsOutput
   */
  @visibility(Lifecycle.Read)
  properties?: LogAnalyticsOutput;
}

/**
 * LogAnalytics output properties
 */
model LogAnalyticsOutput {
  /**
   * Output file Uri path to blob container.
   */
  @visibility(Lifecycle.Read)
  output?: string;
}

/**
 * Api request input for LogAnalytics getThrottledRequests Api.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
model ThrottledRequestsInput extends LogAnalyticsInputBase {}

/**
 * The List Virtual Machine operation response.
 */
model RunCommandListResult is Azure.Core.Page<RunCommandDocumentBase>;

@@doc(RunCommandListResult.value, "The list of virtual machine run commands.");
@@doc(RunCommandListResult.nextLink,
  "The uri to fetch the next page of run commands. Call ListNext() with this to fetch the next page of run commands."
);

/**
 * Describes the properties of a Run Command metadata.
 */
model RunCommandDocumentBase {
  /**
   * The VM run command schema.
   */
  @encodedName("application/json", "$schema")
  schema: string;

  /**
   * The VM run command id.
   */
  id: string;

  /**
   * The Operating System type.
   */
  osType: OperatingSystemTypes;

  /**
   * The VM run command label.
   */
  label: string;

  /**
   * The VM run command description.
   */
  description: string;
}

/**
 * Describes the properties of a Run Command.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RunCommandDocument extends RunCommandDocumentBase {
  /**
   * The script to be executed.
   */
  script: string[];

  /**
   * The parameters used by the script.
   */
  @identifiers(#["name", "type"])
  parameters?: RunCommandParameterDefinition[];
}

/**
 * Describes the properties of a run command parameter.
 */
model RunCommandParameterDefinition {
  /**
   * The run command parameter name.
   */
  name: string;

  /**
   * The run command parameter type.
   */
  type: string;

  /**
   * The run command parameter default value.
   */
  defaultValue?: string;

  /**
   * The run command parameter required.
   */
  required?: boolean;
}

/**
 * The List run command operation response
 */
model VirtualMachineRunCommandsListResult
  is Azure.Core.Page<VirtualMachineRunCommand>;

@@doc(VirtualMachineRunCommandsListResult.value, "The list of run commands.");
@@doc(VirtualMachineRunCommandsListResult.nextLink,
  "The uri to fetch the next page of run commands."
);

/**
 * Describes the properties of a Virtual Machine run command.
 */
model VirtualMachineRunCommandProperties {
  /**
   * The source of the run command script.
   */
  source?: VirtualMachineRunCommandScriptSource;

  /**
   * The parameters used by the script.
   */
  @identifiers(#["name"])
  parameters?: RunCommandInputParameter[];

  /**
   * The parameters used by the script.
   */
  @identifiers(#["name"])
  protectedParameters?: RunCommandInputParameter[];

  /**
   * Optional. If set to true, provisioning will complete as soon as the script starts and will not wait for script to complete.
   */
  asyncExecution?: boolean;

  /**
   * Specifies the user account on the VM when executing the run command.
   */
  runAsUser?: string;

  /**
   * Specifies the user account password on the VM when executing the run command.
   */
  runAsPassword?: string;

  /**
   * The timeout in seconds to execute the run command.
   */
  timeoutInSeconds?: int32;

  /**
   * Specifies the Azure storage blob where script output stream will be uploaded. Use a SAS URI with read, append, create, write access OR use managed identity to provide the VM access to the blob. Refer outputBlobManagedIdentity parameter.
   */
  outputBlobUri?: string;

  /**
   * Specifies the Azure storage blob where script error stream will be uploaded. Use a SAS URI with read, append, create, write access OR use managed identity to provide the VM access to the blob. Refer errorBlobManagedIdentity parameter.
   */
  errorBlobUri?: string;

  /**
   * User-assigned managed identity that has access to outputBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged
   */
  outputBlobManagedIdentity?: RunCommandManagedIdentity;

  /**
   * User-assigned managed identity that has access to errorBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged
   */
  errorBlobManagedIdentity?: RunCommandManagedIdentity;

  /**
   * The provisioning state, which only appears in the response. If treatFailureAsDeploymentFailure set to true, any failure in the script will fail the deployment and ProvisioningState will be marked as Failed. If treatFailureAsDeploymentFailure set to false, ProvisioningState would only reflect whether the run command was run or not by the extensions platform, it would not indicate whether script failed in case of script failures. See instance view of run command in case of script failures to see executionMessage, output, error: https://aka.ms/runcommandmanaged#get-execution-status-and-results
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The virtual machine run command instance view.
   */
  @visibility(Lifecycle.Read)
  instanceView?: VirtualMachineRunCommandInstanceView;

  /**
   * Optional. If set to true, any failure in the script will fail the deployment and ProvisioningState will be marked as Failed. If set to false, ProvisioningState would only reflect whether the run command was run or not by the extensions platform, it would not indicate whether script failed in case of script failures. See instance view of run command in case of script failures to see executionMessage, output, error: https://aka.ms/runcommandmanaged#get-execution-status-and-results
   */
  treatFailureAsDeploymentFailure?: boolean;
}

/**
 * Describes the script sources for run command. Use only one of these script sources: script, scriptUri, commandId, galleryScriptReferenceId.
 */
model VirtualMachineRunCommandScriptSource {
  /**
   * Specifies the script content to be executed on the VM.
   */
  script?: string;

  /**
   * Specifies the script download location. It can be either SAS URI of an Azure storage blob with read access or public URI.
   */
  scriptUri?: string;

  /**
   * Specifies a commandId of predefined built-in script. Command IDs available for Linux are listed at https://aka.ms/RunCommandManagedLinux#available-commands, Windows at https://aka.ms/RunCommandManagedWindows#available-commands.
   */
  commandId?: string;

  /**
   * User-assigned managed identity that has access to scriptUri in case of Azure storage blob. Use an empty object in case of system-assigned identity. Make sure the Azure storage blob exists, and managed identity has been given access to blob's container with 'Storage Blob Data Reader' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged.
   */
  scriptUriManagedIdentity?: RunCommandManagedIdentity;

  /**
   * Optional. Specify which shell to use for running the script. These values must match those expected by the extension. Currently supported only for Windows VMs, script uses Powershell 7 when specified. Powershell 7 must be already installed on the machine to use Powershell7 parameter value.
   */
  @added(Versions.v2025_04_01)
  scriptShell?: ScriptShellTypes;

  /**
   * The resource ID of a Gallery Script version that needs to be executed. Example ID looks like /subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/galleries/{galleryName}/scripts/{scriptName}/versions/{version}.
   */
  @added(Versions.v2025_04_01)
  galleryScriptReferenceId?: string;
}

/**
 *  Contains clientId or objectId (use only one, not both) of a user-assigned managed identity that has access to storage blob used in Run Command. Use an empty RunCommandManagedIdentity object in case of system-assigned identity. Make sure the Azure storage blob exists in case of scriptUri, and managed identity has been given access to blob's container with 'Storage Blob Data Reader' role assignment with scriptUri blob and 'Storage Blob Data Contributor' for Append blobs(outputBlobUri, errorBlobUri). In case of user assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged.
 */
model RunCommandManagedIdentity {
  /**
   * Client Id (GUID value) of the user-assigned managed identity. ObjectId should not be used if this is provided.
   */
  clientId?: string;

  /**
   * Object Id (GUID value) of the user-assigned managed identity. ClientId should not be used if this is provided.
   */
  objectId?: string;
}

/**
 * Describes the properties of a run command parameter.
 */
model RunCommandInputParameter {
  /**
   * The run command parameter name.
   */
  name: string;

  /**
   * The run command parameter value.
   */
  value: string;
}

/**
 * The instance view of a virtual machine run command.
 */
model VirtualMachineRunCommandInstanceView {
  /**
   * Script execution status.
   */
  executionState?: ExecutionState;

  /**
   * Communicate script configuration errors or execution messages.
   */
  executionMessage?: string;

  /**
   * Exit code returned from script execution.
   */
  exitCode?: int32;

  /**
   * Script output stream.
   */
  output?: string;

  /**
   * Script error stream.
   */
  error?: string;

  /**
   * Script start time.
   */
  startTime?: utcDateTime;

  /**
   * Script end time.
   */
  endTime?: utcDateTime;

  /**
   * The resource status information.
   */
  @identifiers(#[])
  statuses?: InstanceViewStatus[];
}

/**
 * Describes a Virtual Machine run command.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualMachineRunCommandUpdate extends UpdateResource {
  /**
   * Describes the properties of a Virtual Machine run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualMachineRunCommandProperties;
}

/**
 * Capture Virtual Machine parameters.
 */
model RunCommandInput {
  /**
   * Specifies a commandId of predefined built-in script. Command IDs available for Linux are listed at https://aka.ms/RunCommandManagedLinux#available-commands, Windows at https://aka.ms/RunCommandManagedWindows#available-commands.
   */
  commandId: string;

  /**
   * Optional. The script to be executed.  When this value is given, the given script will override the default script of the command.
   */
  script?: string[];

  /**
   * The run command parameters.
   */
  @identifiers(#["name"])
  parameters?: RunCommandInputParameter[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RunCommandResult {
  /**
   * Run command operation response.
   */
  @identifiers(#[])
  value?: InstanceViewStatus[];
}

/**
 * The input for ScaleOut
 */
@added(Versions.v2025_04_01)
model VMScaleSetScaleOutInput {
  /**
   * Specifies the number of virtual machines in the scale set.
   */
  capacity: int64;

  /**
   * The input properties for ScaleOut
   */
  properties?: VMScaleSetScaleOutInputProperties;
}

/**
 * The input properties for ScaleOut
 */
@added(Versions.v2025_04_01)
model VMScaleSetScaleOutInputProperties {
  /**
   * The zone in which the scale out is requested for the virtual machine scale set.
   */
  zone?: string;
}
