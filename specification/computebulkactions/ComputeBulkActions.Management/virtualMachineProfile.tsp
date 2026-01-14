import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using Azure.ResourceManager;

namespace Microsoft.ComputeBulkActions;
@doc("Describes the properties of a Virtual Machine.")
model VirtualMachineProfile {
  @doc("Specifies Redeploy, Reboot and ScheduledEventsAdditionalPublishingTargets Scheduled Event related configurations for the virtual machine.")
  scheduledEventsPolicy?: ScheduledEventsPolicy;

  @doc("Specifies the storage settings for the virtual machine disks.")
  storageProfile?: StorageProfile;

  @doc("Specifies additional capabilities enabled or disabled on the virtual machine.")
  additionalCapabilities?: AdditionalCapabilities;

  @doc("Specifies the operating system settings used while creating the virtual machine. Some of the settings cannot be changed once VM is provisioned.")
  osProfile?: OSProfile;

  @doc("Specifies the network interfaces of the virtual machine.")
  networkProfile?: NetworkProfile;

  @doc("Specifies the Security related profile settings for the virtual machine.")
  securityProfile?: SecurityProfile;

  @doc("Specifies the boot diagnostic settings state. Minimum compute api-version: 2015-06-15.")
  diagnosticsProfile?: DiagnosticsProfile;

  @doc("Specifies that the image or disk that is being used was licensed on-premises. <br><br> Possible values for Windows Server operating system are: <br><br> Windows_Client <br><br> Windows_Server <br><br> Possible values for Linux Server operating system are: <br><br> RHEL_BYOS (for RHEL) <br><br> SLES_BYOS (for SUSE) <br><br> For more information, see [Azure Hybrid Use Benefit for Windows Server](https://docs.microsoft.com/azure/virtual-machines/windows/hybrid-use-benefit-licensing) <br><br> [Azure Hybrid Use Benefit for Linux Server](https://docs.microsoft.com/azure/virtual-machines/linux/azure-hybrid-benefit-linux) <br><br> Minimum api-version: 2015-06-15")
  licenseType?: string;

  @doc("Specifies the time alloted for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. The default value is 90 minutes (PT1H30M). Minimum compute api-version: 2020-06-01.")
  extensionsTimeBudget?: string;

  @doc("Specifies Scheduled Event related configurations.")
  scheduledEventsProfile?: ScheduledEventsProfile;

  @doc("UserData for the VM, which must be base-64 encoded. Customer should not pass any secrets in here. Minimum compute api-version: 2021-03-01.")
  userData?: string;

  @doc("Specifies information about the capacity reservation that is used to allocate virtual machine. Minimum compute api-version: 2021-04-01.")
  capacityReservation?: CapacityReservationProfile;

  @doc("Specifies the gallery applications that should be made available to the VM.")
  applicationProfile?: ApplicationProfile;
}

@doc("Specifies Redeploy, Reboot and ScheduledEventsAdditionalPublishingTargets Scheduled Event related configurations.")
model ScheduledEventsPolicy {
  @doc("The configuration parameters used while creating userInitiatedRedeploy scheduled event setting creation.")
  userInitiatedRedeploy?: UserInitiatedRedeploy;

  @doc("The configuration parameters used while creating userInitiatedReboot scheduled event setting creation.")
  userInitiatedReboot?: UserInitiatedReboot;

  @doc("The configuration parameters used while publishing scheduledEventsAdditionalPublishingTargets.")
  scheduledEventsAdditionalPublishingTargets?: ScheduledEventsAdditionalPublishingTargets;

  @doc("The configuration parameters used while creating AllInstancesDown scheduled event setting creation.")
  allInstancesDown?: AllInstancesDown;
}

@doc("Specifies Redeploy related Scheduled Event related configurations.")
model UserInitiatedRedeploy {
  @doc("Specifies Redeploy Scheduled Event related configurations.")
  automaticallyApprove?: boolean;
}

@doc("Specifies Reboot related Scheduled Event related configurations.")
model UserInitiatedReboot {
  @doc("Specifies Reboot Scheduled Event related configurations.")
  automaticallyApprove?: boolean;
}

@doc("Specifies additional publishing targets for scheduled events.")
model ScheduledEventsAdditionalPublishingTargets {
  @doc("The configuration parameters used while creating eventGridAndResourceGraph Scheduled Event setting.")
  eventGridAndResourceGraph?: EventGridAndResourceGraph;
}

@doc("Specifies eventGridAndResourceGraph related Scheduled Event related configurations.")
model EventGridAndResourceGraph {
  @doc("Specifies if event grid and resource graph is enabled for Scheduled event related configurations.")
  enable?: boolean;

  @doc("Specifies the api-version to determine which Scheduled Events configuration schema version will be delivered.")
  scheduledEventsApiVersion?: string;
}

@doc("Specifies if Scheduled Events should be auto-approved when all instances are down.")
model AllInstancesDown {
  @doc("Specifies if Scheduled Events should be auto-approved when all instances are down. Its default value is true.")
  automaticallyApprove?: boolean;
}

@doc("Specifies the storage settings for the virtual machine disks.")
model StorageProfile {
  @doc("Specifies information about the image to use. You can specify information about platform images, marketplace images, or virtual machine images. This element is required when you want to use a platform image, marketplace image, or virtual machine image, but is not used in other creation operations.")
  imageReference?: ImageReference;

  @doc("Specifies information about the operating system disk used by the virtual machine. For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).")
  osDisk?: OSDisk;

  @doc("Specifies the parameters that are used to add a data disk to a virtual machine. For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).")
  @identifiers(#["lun"])
  dataDisks?: DataDisk[];

  @doc("Specifies the disk controller type configured for the VM. **Note:** This property will be set to the default disk controller type if not specified provided virtual machine is being created with 'hyperVGeneration' set to V2 based on the capabilities of the operating system disk and VM size from the the specified minimum api version. You need to deallocate the VM before updating its disk controller type unless you are updating the VM size in the VM configuration which implicitly deallocates and reallocates the VM. Minimum api-version: 2022-08-01.")
  diskControllerType?: DiskControllerTypes;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("Specifies information about the image to use. You can specify information about platform images, marketplace images, or virtual machine images. This element is required when you want to use a platform image, marketplace image, or virtual machine image, but is not used in other creation operations. NOTE: Image reference publisher and offer can only be set when you create the scale set.")
model ImageReference extends SubResource {
  @doc("The image publisher.")
  publisher?: string;

  @doc("Specifies the offer of the platform image or marketplace image used to create the virtual machine.")
  offer?: string;

  @doc("The image SKU.")
  sku?: string;

  @doc("Specifies the version of the platform image or marketplace image used to create the virtual machine. The allowed formats are Major.Minor.Build or 'latest'. Major, Minor, and Build are decimal numbers. Specify 'latest' to use the latest version of an image available at deploy time. Even if you use 'latest', the VM image will not automatically update after deploy time even if a new version becomes available. Please do not use field 'version' for gallery image deployment, gallery image should always use 'id' field for deployment, to use 'latest' version of gallery image, just set '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/images/{imageName}' in the 'id' field without version input.")
  version?: string;

  @doc("Specified the shared gallery image unique id for vm deployment. This can be fetched from shared gallery image GET call.")
  sharedGalleryImageId?: string;

  @doc("Specified the community gallery image unique id for vm deployment. This can be fetched from community gallery image GET call.")
  communityGalleryImageId?: string;
}

@doc("Specifies information about the operating system disk used by the virtual machine. For more information about disks, see [About disks and VHDs for Azure virtual machines](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview).")
model OSDisk {
  @doc("This property allows you to specify the type of the OS that is included in the disk if creating a VM from user-image or a specialized VHD. Possible values are: Windows, Linux.")
  osType?: OperatingSystemTypes;

  @doc("Specifies the encryption settings for the OS Disk. Minimum compute api-version: 2015-06-15.")
  encryptionSettings?: DiskEncryptionSettings;

  @doc("The disk name.")
  name?: string;

  @doc("The virtual hard disk.")
  vhd?: VirtualHardDisk;

  @doc("The source user image virtual hard disk. The virtual hard disk will be copied before being attached to the virtual machine. If SourceImage is provided, the destination virtual hard drive must not exist.")
  image?: VirtualHardDisk;

  @doc("Specifies the caching requirements. Possible values are: None, ReadOnly, ReadWrite. The defaulting behavior is: None for Standard storage. ReadOnly for Premium storage.")
  caching?: CachingTypes;

  @doc("Specifies whether writeAccelerator should be enabled or disabled on the disk.")
  writeAcceleratorEnabled?: boolean;

  @doc("Specifies the ephemeral Disk Settings for the operating system disk used by the virtual machine.")
  diffDiskSettings?: DiffDiskSettings;

  @doc("Specifies how the virtual machine disk should be created. Possible values are Attach, FromImage. If you are using a platform image, you should also use the imageReference element described above. If you are using a marketplace image, you should also use the plan element previously described.")
  createOption: DiskCreateOptionTypes;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is an abbreviation for Gigabyte"
  @doc("Specifies the size of an empty data disk in gigabytes. This element can be used to overwrite the size of the disk in a virtual machine image. The property 'diskSizeGB' is the number of bytes x 1024^3 for the disk and the value cannot be larger than 1023.")
  diskSizeGB?: int32;

  @doc("The managed disk parameters.")
  managedDisk?: ManagedDiskParameters;

  @doc("Specifies whether OS Disk should be deleted or detached upon VM deletion. Possible values are: Delete, Detach. The default value is set to Detach. For an ephemeral OS Disk, the default value is set to Delete. The user cannot change the delete option for an ephemeral OS Disk.")
  deleteOption?: DiskDeleteOptionTypes;
}

@doc("Describes the parameters of ephemeral disk settings that can be specified for operating system disk. Note: The ephemeral disk settings can only be specified for managed disk.")
model DiffDiskSettings {
  @doc("Specifies the ephemeral disk settings for operating system disk.")
  option?: DiffDiskOptions;

  @doc("Specifies the ephemeral disk placement for operating system disk. Possible values are: CacheDisk, ResourceDisk, NvmeDisk. The defaulting behavior is: CacheDisk if one is configured for the VM size otherwise ResourceDisk or NvmeDisk is used. Minimum api-version for NvmeDisk: 2024-03-01.")
  placement?: DiffDiskPlacement;
}

@doc("Specifies the ephemeral disk option for operating system disk.")
union DiffDiskOptions {
  string,

  @doc("Local Ephemeral disk option: Local")
  Local: "Local",
}

@doc("Specifies the ephemeral disk placement for operating system disk. This property can be used by user in the request to choose the location i.e, cache disk, resource disk or nvme disk space for Ephemeral OS disk provisioning. For more information on Ephemeral OS disk size requirements, please refer Ephemeral OS disk size requirements for Windows VM at https://docs.microsoft.com/azure/virtual-machines/windows/ephemeral-os-disks#size-requirements and Linux VM at https://docs.microsoft.com/azure/virtual-machines/linux/ephemeral-os-disks#size-requirements. Minimum api-version for NvmeDisk: 2024-03-01.")
union DiffDiskPlacement {
  string,

  @doc("CacheDisk disk placement")
  CacheDisk: "CacheDisk",

  @doc("ResourceDisk disk placement")
  ResourceDisk: "ResourceDisk",

  @doc("NvmeDisk disk placement")
  NvmeDisk: "NvmeDisk",
}

@doc("Specifies how the virtual machine disk should be created. Possible values are **Attach:** This value is used when you are using a specialized disk to create the virtual machine. **FromImage:** This value is used when you are using an image to create the virtual machine. If you are using a platform image, you should also use the imageReference element described above. If you are using a marketplace image, you should also use the plan element previously described. **Empty:** This value is used when creating an empty data disk. **Copy:** This value is used to create a data disk from a snapshot or another disk. **Restore:** This value is used to create a data disk from a disk restore point.")
union DiskCreateOptionTypes {
  string,

  @doc("Create disk FromImage")
  FromImage: "FromImage",

  @doc("Empty value")
  Empty: "Empty",

  @doc("Create disk by Attach")
  Attach: "Attach",

  @doc("Create disk by Copy")
  Copy: "Copy",

  @doc("Create disk by Restore")
  Restore: "Restore",
}

@doc("Specifies the behavior of the managed disk when the VM gets deleted, for example whether the managed disk is deleted or detached. Supported values are: **Delete.** If this value is used, the managed disk is deleted when VM gets deleted. **Detach.** If this value is used, the managed disk is retained after VM gets deleted. Minimum api-version: 2021-03-01.")
union DiskDeleteOptionTypes {
  string,

  @doc("Delete the disk upon VM deletion")
  Delete: "Delete",

  @doc("Detach the disk upon VM deletion")
  Detach: "Detach",
}

@doc("This property allows you to specify the supported type of the OS that application is built for. Possible values are: **Windows,** **Linux.**")
union OperatingSystemTypes {
  string,

  @doc("Windows OS")
  Windows: "Windows",

  @doc("Linux OS")
  Linux: "Linux",
}

@doc("Specifies the caching requirements. Possible values are: **None,** **ReadOnly,** **ReadWrite.** The default values are: **None for Standard storage. ReadOnly for Premium storage**")
union CachingTypes {
  string,

  @doc("Caching type:None")
  None: "None",

  @doc("Caching type:ReadOnly")
  ReadOnly: "ReadOnly",

  @doc("Caching type:ReadWrite")
  ReadWrite: "ReadWrite",
}

/**
 * Specifies the storage account type for the managed disk. Managed OS disk storage account type can only be set when you create the scale set. NOTE: UltraSSD_LRS can only be used with data disks. It cannot be used with OS Disk. Standard_LRS uses Standard HDD. StandardSSD_LRS uses Standard SSD. Premium_LRS uses Premium SSD. UltraSSD_LRS uses Ultra disk. Premium_ZRS uses Premium SSD zone redundant storage. StandardSSD_ZRS uses Standard SSD zone redundant storage. For more information regarding disks supported for Windows Virtual Machines, refer to https://docs.microsoft.com/azure/virtual-machines/windows/disks-types and, for Linux Virtual Machines, refer to https://docs.microsoft.com/azure/virtual-machines/linux/disks-types
 */
union StorageAccountTypes {
  string,

  @doc("Standard_LRS storage account type")
  Standard_LRS: "Standard_LRS",

  @doc("Premium_LRS storage account type")
  Premium_LRS: "Premium_LRS",

  @doc("StandardSSD_LRS storage account type")
  StandardSSD_LRS: "StandardSSD_LRS",

  @doc("UltraSSD_LRS storage account type")
  UltraSSD_LRS: "UltraSSD_LRS",

  @doc("Premium_ZRS storage account type")
  Premium_ZRS: "Premium_ZRS",

  @doc("StandardSSD_ZRS storage account type")
  StandardSSD_ZRS: "StandardSSD_ZRS",

  @doc("PremiumV2_LRS storage account type")
  PremiumV2_LRS: "PremiumV2_LRS",
}

/**
 * Describes the uri of a disk.
 */
model VirtualHardDisk {
  @doc("Specifies the virtual hard disk's uri.")
  uri?: string;
}

/**
 * Describes a Encryption Settings for a Disk
 */
model DiskEncryptionSettings {
  @doc("Specifies the location of the disk encryption key, which is a Key Vault Secret.")
  diskEncryptionKey?: KeyVaultSecretReference;

  @doc("Specifies the location of the key encryption key in Key Vault.")
  keyEncryptionKey?: KeyVaultKeyReference;

  @doc("Specifies whether disk encryption should be enabled on the virtual machine.")
  enabled?: boolean;
}

/**
 * Describes a reference to Key Vault Key
 */
model KeyVaultKeyReference {
  @doc("The URL referencing a key encryption key in Key Vault.")
  keyUrl: string;

  @doc("The relative URL of the Key Vault containing the key.")
  sourceVault: SubResource;
}

/**
 * The parameters of a managed disk.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ManagedDiskParameters extends SubResource {
  @doc("Specifies the storage account type for the managed disk. NOTE: UltraSSD_LRS can only be used with data disks, it cannot be used with OS Disk.")
  storageAccountType?: StorageAccountTypes;

  @doc("Specifies the customer managed disk encryption set resource id for the managed disk.")
  diskEncryptionSet?: DiskEncryptionSetParameters;

  @doc("Specifies the security profile for the managed disk.")
  securityProfile?: VMDiskSecurityProfile;
}

/**
 * Describes the parameter of customer managed disk encryption set resource id that can be specified for disk. **Note:** The disk encryption set resource id can only be specified for managed disk. Please refer https://aka.ms/mdssewithcmkoverview for more details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Maintaining existing struct in compute model"
model DiskEncryptionSetParameters extends SubResource {}

/**
 * Specifies the security profile settings for the managed disk. **Note:** It can only be set for Confidential VMs.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is an abbreviation for Virtual Machine"
model VMDiskSecurityProfile {
  @doc("Specifies the EncryptionType of the managed disk. It is set to DiskWithVMGuestState for encryption of the managed disk along with VMGuestState blob, VMGuestStateOnly for encryption of just the VMGuestState blob, and NonPersistedTPM for not persisting firmware state in the VMGuestState blob.. **Note:** It can be set for only Confidential VMs.")
  securityEncryptionType?: SecurityEncryptionTypes;

  @doc("Specifies the customer managed disk encryption set resource id for the managed disk that is used for Customer Managed Key encrypted ConfidentialVM OS Disk and VMGuest blob.")
  diskEncryptionSet?: DiskEncryptionSetParameters;
}

/**
 * Specifies the EncryptionType of the managed disk. It is set to DiskWithVMGuestState for encryption of the managed disk along with VMGuestState blob, VMGuestStateOnly for encryption of just the VMGuestState blob, and NonPersistedTPM for not persisting firmware state in the VMGuestState blob.. **Note:** It can be set for only Confidential VMs.
 */
union SecurityEncryptionTypes {
  string,

  @doc("VMGuestStateOnly encryption")
  VMGuestStateOnly: "VMGuestStateOnly",

  @doc("DiskWithVMGuestState encryption")
  DiskWithVMGuestState: "DiskWithVMGuestState",

  @doc("NonPersistedTPM encryption")
  NonPersistedTPM: "NonPersistedTPM",
}

@doc("Describes a data disk.")
model DataDisk {
  @doc("Specifies the logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM.")
  lun: int32;

  @doc("The disk name.")
  name?: string;

  @doc("The virtual hard disk.")
  vhd?: VirtualHardDisk;

  @doc("The source user image virtual hard disk. The virtual hard disk will be copied before being attached to the virtual machine. If SourceImage is provided, the destination virtual hard drive must not exist.")
  image?: VirtualHardDisk;

  @doc("Specifies the caching requirements. Possible values are: None, ReadOnly, ReadWrite. The defaulting behavior is: None for Standard storage. ReadOnly for Premium storage.")
  caching?: CachingTypes;

  @doc("Specifies whether writeAccelerator should be enabled or disabled on the disk.")
  writeAcceleratorEnabled?: boolean;

  @doc("Specifies how the virtual machine disk should be created. Possible values are Attach, FromImage, Empty, Copy, Restore.")
  createOption: DiskCreateOptionTypes;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is an abbreviation for Gigabyte"
  @doc("Specifies the size of an empty data disk in gigabytes. This element can be used to overwrite the size of the disk in a virtual machine image. The property 'diskSizeGB' is the number of bytes x 1024^3 for the disk and the value cannot be larger than 1023.")
  diskSizeGB?: int32;

  @doc("The managed disk parameters.")
  managedDisk?: ManagedDiskParameters;

  @doc("The source resource identifier. It can be a snapshot, or disk restore point from which to create a disk.")
  sourceResource?: ApiEntityReference;

  @doc("Specifies whether the data disk is in process of detachment from the VirtualMachine/VirtualMachineScaleset.")
  toBeDetached?: boolean;

  @doc("Specifies the detach behavior to be used while detaching a disk or which is already in the process of detachment from the virtual machine. Supported values: ForceDetach. This feature is still in preview. To force-detach a data disk update toBeDetached to 'true' along with setting detachOption: 'ForceDetach'.")
  detachOption?: DiskDetachOptionTypes;

  @doc("Specifies whether data disk should be deleted or detached upon VM deletion. Possible values are: Delete, Detach. The default value is set to Detach.")
  deleteOption?: DiskDeleteOptionTypes;
}

/**
 * The API entity reference.
 */
model ApiEntityReference {
  @doc("The ARM resource id in the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/...")
  id?: string;
}

@doc("Specifies the detach behavior to be used while detaching a disk or which is already in the process of detachment from the virtual machine. Supported values are: **ForceDetach.** detachOption: **ForceDetach** is applicable only for managed data disks. If a previous detachment attempt of the data disk did not complete due to an unexpected failure from the virtual machine and the disk is still not released then use force-detach as a last resort option to detach the disk forcibly from the VM. All writes might not have been flushed when using this detach behavior. **This feature is still in preview**. To force-detach a data disk update toBeDetached to 'true' along with setting detachOption: 'ForceDetach'.")
union DiskDetachOptionTypes {
  string,

  @doc("ForceDetach the disk")
  ForceDetach: "ForceDetach",
}

/**
 * Specifies the disk controller type configured for the VM and VirtualMachineScaleSet. This property is only supported for virtual machines whose operating system disk and VM sku supports Generation 2 (https://docs.microsoft.com/en-us/azure/virtual-machines/generation-2), please check the HyperVGenerations capability returned as part of VM sku capabilities in the response of Microsoft.Compute SKUs api for the region contains V2 (https://docs.microsoft.com/rest/api/compute/resourceskus/list). For more information about Disk Controller Types supported please refer to https://aka.ms/azure-diskcontrollertypes.
 */
union DiskControllerTypes {
  string,

  @doc("SCSI disk controller type")
  SCSI: "SCSI",

  @doc("NVMe disk controller type")
  NVMe: "NVMe",
}

/**
 * Enables or disables a capability on the virtual machine or virtual machine scale set.
 */
model AdditionalCapabilities {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "SSD is an abbreviation for Solid State Drive"
  @doc("The flag that enables or disables a capability to have one or more managed data disks with UltraSSD_LRS storage account type on the VM or VMSS. Managed disks with storage account type UltraSSD_LRS can be added to a virtual machine or virtual machine scale set only if this property is enabled.")
  ultraSSDEnabled?: boolean;

  @doc("The flag that enables or disables hibernation capability on the VM.")
  hibernationEnabled?: boolean;
}

@doc("Specifies the operating system settings for the virtual machine. Some of the settings cannot be changed once VM is provisioned.")
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
 * Specifies Windows operating system settings on the virtual machine.
 */
model WindowsConfiguration {
  /**
   * Indicates whether virtual machine agent should be provisioned on the virtual machine. When this property is not specified in the request body, it is set to true by default. This will ensure that VM Agent is installed on the VM so that extensions can be added to the VM later.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is an abbreviation for Virtual Machine"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "RM is an abbreviation for Remote Management"
  winRM?: WinRMConfiguration;
}

/**
 * Specifies additional XML formatted information that can be included in the Unattend.xml file, which is used by Windows Setup. Contents are defined by setting name, component name, and the pass in which the content is applied.
 */
model AdditionalUnattendContent {
  /**
   * The pass name. Currently, the only allowable value is OobeSystem.
   */
  passName?: "OobeSystem";

  /**
   * The component name. Currently, the only allowable value is Microsoft-Windows-Shell-Setup.
   */
  componentName?: "Microsoft-Windows-Shell-Setup";

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
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is an abbreviation for Virtual Machine"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "RM is an abbreviation for Remote Management"
@doc("Describes Windows Remote Management configuration of the VM")
model WinRMConfiguration {
  /**
   * The list of Windows Remote Management listeners
   */
  @identifiers(#[])
  listeners?: WinRMListener[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "RM is an abbreviation for Remote Management"
@doc("Describes Protocol and thumbprint of Windows Remote Management listener")
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

@doc("Specifies the name of the setting to which the content applies. Possible values are: FirstLogonCommands and AutoLogon.")
union SettingNames {
  string,

  @doc("AutoLogon mode")
  AutoLogon: "AutoLogon",

  @doc("FirstLogonCommands mode")
  FirstLogonCommands: "FirstLogonCommands",
}

/**
 * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual machines associated to virtual machine scale set with OrchestrationMode as Flexible.<br /><br /> Possible values are:<br /><br /> **Manual** - You  control the application of patches to a virtual machine. You do this by applying patches manually inside the VM. In this mode, automatic updates are disabled; the property WindowsConfiguration.enableAutomaticUpdates must be false<br /><br /> **AutomaticByOS** - The virtual machine will automatically be updated by the OS. The property WindowsConfiguration.enableAutomaticUpdates must be true. <br /><br /> **AutomaticByPlatform** - the virtual machine will automatically updated by the platform. The properties provisionVMAgent and WindowsConfiguration.enableAutomaticUpdates must be true
 */
union WindowsVMGuestPatchMode {
  string,

  @doc("Manual VM guest patch mode")
  Manual: "Manual",

  @doc("AutomaticByOS VM guest patch mode")
  AutomaticByOS: "AutomaticByOS",

  @doc("AutomaticByPlatform VM guest patch mode")
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the mode of VM Guest patch assessment for the IaaS virtual machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You control the timing of patch assessments on a virtual machine.<br /><br /> **AutomaticByPlatform** - The platform will trigger periodic patch assessments. The property provisionVMAgent must be true.
 */
union WindowsPatchAssessmentMode {
  string,

  @doc("ImageDefault patch assessment mode")
  ImageDefault: "ImageDefault",

  @doc("AutomaticByPlatform patch assessment mode")
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the reboot setting for all AutomaticByPlatform patch installation operations.
 */
union WindowsVMGuestPatchAutomaticByPlatformRebootSetting {
  string,

  @doc("Reboot setting for Unknown")
  Unknown: "Unknown",

  @doc("Reboot setting for IfRequired")
  IfRequired: "IfRequired",

  @doc("Reboot setting for Never")
  Never: "Never",

  @doc("Reboot setting for Always")
  Always: "Always",
}

/**
 * Specifies the protocol of WinRM listener. Possible values are: **http,** **https.**
 */
union ProtocolTypes {
  string,

  @doc("Http protocol")
  Http: "Http",

  @doc("Https protocol")
  Https: "Https",
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is an abbreviation for Virtual Machine"
  provisionVMAgent?: boolean;

  /**
   * [Preview Feature] Specifies settings related to VM Guest Patching on Linux.
   */
  patchSettings?: LinuxPatchSettings;

  /**
   * Indicates whether VMAgent Platform Updates is enabled for the Linux virtual machine. Default value is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is an abbreviation for Virtual Machine"
  enableVMAgentPlatformUpdates?: boolean;
}

@doc("SSH configuration for Linux based VMs running on Azure")
model SshConfiguration {
  /**
   * The list of SSH public keys used to authenticate with linux based VMs.
   */
  @identifiers(#["path"])
  publicKeys?: SshPublicKey[];
}

@doc("Contains information about SSH certificate public key and the path on the Linux VM where the public key is placed.")
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

@doc("Specifies settings related to VM Guest Patching on Linux.")
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is an abbreviation for Virtual Machine"
@doc("Specifies additional settings to be applied when patch mode AutomaticByPlatform is selected in Linux patch settings.")
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
 * Specifies the mode of VM Guest Patching to IaaS virtual machine or virtual machines associated to virtual machine scale set with OrchestrationMode as Flexible.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - The virtual machine's default patching configuration is used. <br /><br /> **AutomaticByPlatform** - The virtual machine will be automatically updated by the platform. The property provisionVMAgent must be true
 */
union LinuxVMGuestPatchMode {
  string,

  @doc("ImageDefault linux VM guest patch mode")
  ImageDefault: "ImageDefault",

  @doc("AutomaticByPlatform linux VM guest patch mode")
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the mode of VM Guest Patch Assessment for the IaaS virtual machine.<br /><br /> Possible values are:<br /><br /> **ImageDefault** - You control the timing of patch assessments on a virtual machine. <br /><br /> **AutomaticByPlatform** - The platform will trigger periodic patch assessments. The property provisionVMAgent must be true.
 */
union LinuxPatchAssessmentMode {
  string,

  @doc("ImageDefault mode")
  ImageDefault: "ImageDefault",

  @doc("AutomaticByPlatform mode")
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the reboot setting for all AutomaticByPlatform patch installation operations.
 */
union LinuxVMGuestPatchAutomaticByPlatformRebootSetting {
  string,

  @doc("Unknown reboot setting")
  Unknown: "Unknown",

  @doc("Reboot if required")
  IfRequired: "IfRequired",

  @doc("Never reboot")
  Never: "Never",

  @doc("Always reboot")
  Always: "Always",
}

@doc("Describes a set of certificates which are all in the same Key Vault.")
model VaultSecretGroup {
  @doc("The relative URL of the Key Vault containing all of the certificates in VaultCertificates.")
  sourceVault?: SubResource;

  @doc("The list of key vault references in SourceVault which contain certificates.")
  @identifiers(#["certificateUrl"])
  vaultCertificates?: VaultCertificate[];
}

@doc("Describes a single certificate reference in a Key Vault, and where the certificate should reside on the VM.")
model VaultCertificate {
  @doc("This is the URL of a certificate that has been uploaded to Key Vault as a secret. For adding a secret to the Key Vault, see [Add a key or secret to the key vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add). In this case, your certificate needs to be It is the Base64 encoding of the following JSON Object which is encoded in UTF-8: <br><br> {<br>  'data':'<Base64-encoded-certificate>',<br>  'dataType':'pfx',<br>  'password':'<pfx-file-password>'<br>} <br> To install certificates on a virtual machine it is recommended to use the [Azure Key Vault virtual machine extension for Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-linux) or the [Azure Key Vault virtual machine extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/key-vault-windows).")
  certificateUrl?: string;

  @doc("For Windows VMs, specifies the certificate store on the Virtual Machine to which the certificate should be added. The specified certificate store is implicitly in the LocalMachine account. For Linux VMs, the certificate file is placed under the /var/lib/waagent directory, with the file name <UppercaseThumbprint>.crt for the X509 certificate file and <UppercaseThumbprint>.prv for private key. Both of these files are .pem formatted.")
  certificateStore?: string;
}

@doc("Specifies the network interfaces or the networking configuration of the virtual machine.")
model NetworkProfile {
  @doc("Specifies the list of resource Ids for the network interfaces associated with the virtual machine.")
  networkInterfaces?: NetworkInterfaceReference[];

  @doc("specifies the Microsoft.Network API version used when creating networking resources in the Network Interface Configurations")
  networkApiVersion?: NetworkApiVersion;

  @doc("Specifies the networking configurations that will be used to create the virtual machine networking resources.")
  @identifiers(#["name"])
  networkInterfaceConfigurations?: VirtualMachineNetworkInterfaceConfiguration[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@doc("Describes a network interface reference.")
model NetworkInterfaceReference extends SubResource {
  @doc("Describes a network interface reference properties.")
  properties?: NetworkInterfaceReferenceProperties;
}

@doc("Describes a network interface reference properties.")
model NetworkInterfaceReferenceProperties {
  @doc("Specifies the primary network interface in case the virtual machine has more than 1 network interface.")
  primary?: boolean;

  @doc("Specify what happens to the network interface when the VM is deleted")
  deleteOption?: DeleteOptions;
}

@doc("Describes a virtual machine network interface configurations.")
model VirtualMachineNetworkInterfaceConfiguration {
  @doc("The network interface configuration name.")
  name: string;

  @doc("Describes a virtual machine network profile's IP configuration.")
  properties?: VirtualMachineNetworkInterfaceConfigurationProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This field is using the existing compute context for tags where this field is a free-form JSON object."
  @doc("Resource tags applied to the networkInterface address created by this NetworkInterfaceConfiguration")
  tags?: Record<string>;
}

@doc("Describes a virtual machine network profile's IP configuration.")
model VirtualMachineNetworkInterfaceConfigurationProperties {
  @doc("Specifies the primary network interface in case the virtual machine has more than 1 network interface.")
  primary?: boolean;

  @doc("Specify what happens to the network interface when the VM is deleted")
  deleteOption?: DeleteOptions;

  @doc("Specifies whether the network interface is accelerated networking-enabled.")
  enableAcceleratedNetworking?: boolean;

  @doc("Specifies whether the network interface is disabled for tcp state tracking.")
  disableTcpStateTracking?: boolean;

  @doc("Specifies whether the network interface is FPGA networking-enabled.")
  enableFpga?: boolean;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
  @doc("Whether IP forwarding enabled on this NIC.")
  enableIPForwarding?: boolean;

  @doc("The network security group.")
  networkSecurityGroup?: SubResource;

  @doc("The dns settings to be applied on the network interfaces.")
  dnsSettings?: VirtualMachineNetworkInterfaceDnsSettingsConfiguration;

  @doc("Specifies the IP configurations of the network interface.")
  @identifiers(#["name"])
  ipConfigurations: VirtualMachineNetworkInterfaceIPConfiguration[];

  @doc("The DSCP configuration for the network interface.")
  dscpConfiguration?: SubResource;

  @doc("Specifies whether the Auxiliary mode is enabled for the Network Interface resource.")
  auxiliaryMode?: NetworkInterfaceAuxiliaryMode;

  @doc("Specifies whether the Auxiliary sku is enabled for the Network Interface resource.")
  auxiliarySku?: NetworkInterfaceAuxiliarySku;
}

@doc("Describes a virtual machines network configuration's DNS settings.")
model VirtualMachineNetworkInterfaceDnsSettingsConfiguration {
  @doc("List of DNS servers IP addresses")
  dnsServers?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
@doc("Describes a virtual machine network profile's IP configuration.")
model VirtualMachineNetworkInterfaceIPConfiguration {
  @doc("The IP configuration name.")
  name: string;

  @doc("Describes a virtual machine network interface IP configuration properties.")
  properties?: VirtualMachineNetworkInterfaceIPConfigurationProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
@doc("Describes a virtual machine network interface IP configuration properties.")
model VirtualMachineNetworkInterfaceIPConfigurationProperties {
  @doc("Specifies the identifier of the subnet.")
  subnet?: SubResource;

  @doc("Specifies the primary network interface in case the virtual machine has more than 1 network interface.")
  primary?: boolean;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
  @doc("The publicIPAddressConfiguration.")
  publicIPAddressConfiguration?: VirtualMachinePublicIPAddressConfiguration;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
  @doc("Available from Api-Version 2017-03-30 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4.  Possible values are: 'IPv4' and 'IPv6'.")
  privateIPAddressVersion?: IPVersions;

  @doc("Specifies an array of references to application security group.")
  applicationSecurityGroups?: SubResource[];

  @doc("Specifies an array of references to backend address pools of application gateways. A virtual machine can reference backend address pools of multiple application gateways. Multiple virtual machines cannot use the same application gateway.")
  applicationGatewayBackendAddressPools?: SubResource[];

  @doc("Specifies an array of references to backend address pools of load balancers. A virtual machine can reference backend address pools of one public and one internal load balancer. [Multiple virtual machines cannot use the same basic sku load balancer].")
  loadBalancerBackendAddressPools?: SubResource[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
@doc("Describes a virtual machines IP Configuration's PublicIPAddress configuration")
model VirtualMachinePublicIPAddressConfiguration {
  @doc("The publicIP address configuration name.")
  name: string;

  @doc("Describes a virtual machines IP Configuration's PublicIPAddress configuration")
  properties?: VirtualMachinePublicIPAddressConfigurationProperties;

  @doc("Describes the public IP Sku. It can only be set with OrchestrationMode as Flexible.")
  sku?: PublicIPAddressSku;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This field is using the existing compute context for tags where this field is a free-form JSON object."
  @doc("Resource tags applied to the publicIP address created by this PublicIPAddressConfiguration")
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
@doc("Describes a virtual machines IP Configuration's PublicIPAddress configuration")
model VirtualMachinePublicIPAddressConfigurationProperties {
  @doc("The idle timeout of the public IP address.")
  idleTimeoutInMinutes?: int32;

  @doc("Specify what happens to the public IP address when the VM is deleted")
  deleteOption?: DeleteOptions;

  @doc("The dns settings to be applied on the publicIP addresses .")
  dnsSettings?: VirtualMachinePublicIPAddressDnsSettingsConfiguration;

  @doc("The list of IP tags associated with the public IP address.")
  @identifiers(#[])
  ipTags?: VirtualMachineIpTag[];

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
  @doc("The PublicIPPrefix from which to allocate publicIP addresses.")
  publicIPPrefix?: SubResource;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
  @doc("Available from Api-Version 2019-07-01 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. Possible values are: 'IPv4' and 'IPv6'.")
  publicIPAddressVersion?: IPVersions;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
  @doc("Specify the public IP allocation type")
  publicIPAllocationMethod?: PublicIPAllocationMethod;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
@doc("Describes a virtual machines network configuration's DNS settings.")
model VirtualMachinePublicIPAddressDnsSettingsConfiguration {
  @doc("The Domain name label prefix of the PublicIPAddress resources that will be created. The generated name label is the concatenation of the domain name label and vm network profile unique ID.")
  domainNameLabel: string;

  @doc("The Domain name label scope of the PublicIPAddress resources that will be created. The generated name label is the concatenation of the hashed domain name label with policy according to the domain name label scope and vm network profile unique ID.")
  domainNameLabelScope?: DomainNameLabelScopeTypes;
}

@doc("Contains the IP tag associated with the public IP address.")
model VirtualMachineIpTag {
  @doc("IP tag type. Example: FirstPartyUsage.")
  ipTagType?: string;

  @doc("IP tag associated with the public IP. Example: SQL, Storage etc.")
  tag?: string;
}

@doc("Specify what happens to the network interface when the VM is deleted")
union DeleteOptions {
  string,

  @doc("Delete network interface when the VM is deleted")
  Delete: "Delete",

  @doc("Detach network interface when the VM is deleted")
  Detach: "Detach",
}

@doc("The Domain name label scope.The concatenation of the hashed domain name label that generated according to the policy from domain name label scope and vm index will be the domain name labels of the PublicIPAddress resources that will be created")
union DomainNameLabelScopeTypes {
  string,

  @doc("TenantReuse scope type")
  TenantReuse: "TenantReuse",

  @doc("SubscriptionReuse scope type")
  SubscriptionReuse: "SubscriptionReuse",

  @doc("ResourceGroupReuse scope type")
  ResourceGroupReuse: "ResourceGroupReuse",

  @doc("NoReuse scope type")
  NoReuse: "NoReuse",
}

@doc("Available from compute Api-Version 2017-03-30 onwards, it represents whether the specific ipconfiguration is IPv4 or IPv6. Default is taken as IPv4. Possible values are: 'IPv4' and 'IPv6'.")
union IPVersions {
  string,

  @doc("IPv4 version")
  IPv4: "IPv4",

  @doc("IPv6 version")
  IPv6: "IPv6",
}

@doc("Specifies the Microsoft.Network API version used when creating networking resources in the Network Interface Configurations")
union NetworkApiVersion {
  string,

  @doc("2020-11-01 version")
  `2020-11-01`: "2020-11-01",

  @doc("2022-11-01 version")
  `2022-11-01`: "2022-11-01",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbreviation for Internet Protocol"
@doc("Describes the public IP Sku. It can only be set with OrchestrationMode as Flexible.")
model PublicIPAddressSku {
  @doc("Specify public IP sku name")
  name?: PublicIPAddressSkuName;

  @doc("Specify public IP sku tier")
  tier?: PublicIPAddressSkuTier;
}

@doc("Specify public IP sku name")
union PublicIPAddressSkuName {
  string,

  @doc("Basic IP sku name")
  Basic: "Basic",

  @doc("Standard IP sku name")
  Standard: "Standard",
}

@doc("Specify public IP sku tier")
union PublicIPAddressSkuTier {
  string,

  @doc("Regional IP address sku tier")
  Regional: "Regional",

  @doc("Global IP address sku tier")
  Global: "Global",
}

@doc("Specify the public IP allocation type")
union PublicIPAllocationMethod {
  string,

  @doc("Dynamic IP allocation")
  Dynamic: "Dynamic",

  @doc("Static IP allocation")
  Static: "Static",
}

/**
 * Specifies whether the Auxiliary mode is enabled for the Network Interface resource.
 */
union NetworkInterfaceAuxiliaryMode {
  string,

  @doc("None mode")
  None: "None",

  @doc("AcceleratedConnections mode")
  AcceleratedConnections: "AcceleratedConnections",

  @doc("Floating mode")
  Floating: "Floating",
}

/**
 * Specifies whether the Auxiliary sku is enabled for the Network Interface resource.
 */
union NetworkInterfaceAuxiliarySku {
  string,

  @doc("None: None sku")
  None: "None",

  @doc("A1 sku")
  A1: "A1",

  @doc("A2 sku")
  A2: "A2",

  @doc("A4 sku")
  A4: "A4",

  @doc("A8 sku")
  A8: "A8",
}

/**
 * Contains the list of gallery applications that should be made available to the VM
 */
model ApplicationProfile {
  @doc("Specifies the gallery applications that should be made available to the VM")
  @identifiers(#["packageReferenceId"])
  galleryApplications?: VMGalleryApplication[];
}

/**
 * Specifies the required information to reference a compute gallery application version
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is an abbreviation for virtual machine"
model VMGalleryApplication {
  @doc("Optional, Specifies a passthrough value for more generic context.")
  tags?: string;

  @doc("Optional, Specifies the order in which the packages have to be installed")
  order?: int32;

  @doc("Specifies the GalleryApplicationVersion resource id on the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{application}/versions/{version}")
  packageReferenceId: string;

  @doc("Optional, Specifies the uri to an azure blob that will replace the default configuration for the package if provided")
  configurationReference?: string;

  @doc("Optional, If true, any failure for any operation in the VmApplication will fail the deployment")
  treatFailureAsDeploymentFailure?: boolean;

  @doc("If set to true, when a new Gallery Application version is available in PIR/SIG, it will be automatically updated for the VM/VMSS")
  enableAutomaticUpgrade?: boolean;
}

/**
 * The parameters of a capacity reservation Profile.
 */
model CapacityReservationProfile {
  @doc("Specifies the capacity reservation group resource id that should be used for allocating the virtual machine provided enough capacity has been reserved. Please refer to https://aka.ms/CapacityReservation for more details.")
  capacityReservationGroup?: SubResource;
}

@doc("Profile for the scheduled events.")
model ScheduledEventsProfile {
  @doc("Specifies Terminate Scheduled Event related configurations.")
  terminateNotificationProfile?: TerminateNotificationProfile;

  @doc("Specifies OS Image Scheduled Event related configurations.")
  osImageNotificationProfile?: OSImageNotificationProfile;
}

@doc("Profile properties for the Terminate Scheduled event.")
model TerminateNotificationProfile {
  @doc("Configurable length of time a Virtual Machine being deleted will have to potentially approve the Terminate Scheduled Event before the event is auto approved (timed out). The configuration must be specified in ISO 8601 format, the default value is 5 minutes (PT5M)")
  notBeforeTimeout?: string;

  @doc("Specifies whether the Terminate Scheduled event is enabled or disabled.")
  enable?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "OS is an abbreviation for operating system"
@doc("Profile for the OS Image Scheduled event.")
model OSImageNotificationProfile {
  @doc("Length of time a Virtual Machine being reimaged or having its OS upgraded will have to potentially approve the OS Image Scheduled Event before the event is auto approved (timed out). The configuration is specified in ISO 8601 format, and the value must be 15 minutes (PT15M)")
  notBeforeTimeout?: string;

  @doc("Specifies whether the OS Image Scheduled event is enabled or disabled.")
  enable?: boolean;
}

/**
 * Specifies the boot diagnostic settings state. Minimum compute api-version: 2015-06-15.
 */
model DiagnosticsProfile {
  @doc("Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. **NOTE**: If storageUri is being specified then ensure that the storage account is in the same region and subscription as the VM. You can easily view the output of your console log. Azure also enables you to see a screenshot of the VM from the hypervisor.")
  bootDiagnostics?: BootDiagnostics;
}

/**
 * Boot Diagnostics is a debugging feature which allows you to view Console Output and Screenshot to diagnose VM status. You can easily view the output of your console log. Azure also enables you to see a screenshot of the VM from the hypervisor.
 */
model BootDiagnostics {
  @doc("Whether boot diagnostics should be enabled on the Virtual Machine.")
  enabled?: boolean;

  @doc("Uri of the storage account to use for placing the console output and screenshot. If storageUri is not specified while enabling boot diagnostics, managed storage will be used.")
  storageUri?: string;
}

/**
 * Specifies the Security profile settings for the virtual machine or virtual machine scale set.
 */
model SecurityProfile {
  @doc("Specifies the security settings like secure boot and vTPM used while creating the virtual machine. Minimum compute api-version: 2020-12-01.")
  uefiSettings?: UefiSettings;

  @doc("This property can be used by user in the request to enable or disable the Host Encryption for the virtual machine or virtual machine scale set. This will enable the encryption for all the disks including Resource/Temp disk at host itself. The default behavior is: The Encryption at host will be disabled unless this property is set to true for the resource.")
  encryptionAtHost?: boolean;

  @doc("Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings. The default behavior is: UefiSettings will not be enabled unless this property is set.")
  securityType?: SecurityTypes;

  @doc("Specifies the Managed Identity used by ADE to get access token for keyvault operations.")
  encryptionIdentity?: EncryptionIdentity;

  @doc("Specifies ProxyAgent settings while creating the virtual machine. Minimum compute api-version: 2023-09-01.")
  proxyAgentSettings?: ProxyAgentSettings;
}

/**
 * Specifies the security settings like secure boot and vTPM used while creating the virtual machine. Minimum api-version: 2020-12-01.
 */
model UefiSettings {
  @doc("Specifies whether secure boot should be enabled on the virtual machine. Minimum compute api-version: 2020-12-01.")
  secureBootEnabled?: boolean;

  @doc("Specifies whether vTPM should be enabled on the virtual machine. Minimum compute api-version: 2020-12-01.")
  vTpmEnabled?: boolean;
}

/**
 * Specifies the Managed Identity used by ADE to get access token for keyvault operations.
 */
model EncryptionIdentity {
  @doc("Specifies ARM Resource ID of one of the user identities associated with the VM.")
  userAssignedIdentityResourceId?: string;
}

/**
 * Specifies ProxyAgent settings for the virtual machine or virtual machine scale set. Minimum api-version: 2023-09-01.
 */
model ProxyAgentSettings {
  @doc("Specifies whether ProxyAgent feature should be enabled on the virtual machine or virtual machine scale set.")
  enabled?: boolean;

  @doc("Specifies the mode that ProxyAgent will execute on. Warning: this property has been deprecated, please specify 'mode' under particular hostendpoint setting.")
  mode?: Mode;

  @doc("Increase the value of this property allows users to reset the key used for securing communication channel between guest and host.")
  keyIncarnationId?: int32;

  @doc("Specifies the Wire Server endpoint settings while creating the virtual machine or virtual machine scale set. Minimum api-version: 2024-03-01.")
  wireServer?: HostEndpointSettings;

  @doc("Specifies the IMDS endpoint settings while creating the virtual machine or virtual machine scale set. Minimum api-version: 2024-03-01.")
  imds?: HostEndpointSettings;

  @doc("Specify whether to implicitly install the ProxyAgent Extension. This option is currently applicable only for Linux Os.")
  addProxyAgentExtension?: boolean;
}

/**
 * Specifies particular host endpoint settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is an abbreviation for virtual machine"
model HostEndpointSettings {
  @doc("Specifies the execution mode. In Audit mode, the system acts as if it is enforcing the access control policy, including emitting access denial entries in the logs but it does not actually deny any requests to host endpoints. In Enforce mode, the system will enforce the access control and it is the recommended mode of operation.")
  mode?: Modes;

  @doc("Specifies the InVMAccessControlProfileVersion resource id in the format of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/inVMAccessControlProfiles/{profile}/versions/{version}")
  inVMAccessControlProfileReferenceId?: string;
}

/**
 * Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings. The default behavior is: UefiSettings will not be enabled unless this property is set.
 */
union SecurityTypes {
  string,

  @doc("TrustedLaunch security type")
  TrustedLaunch: "TrustedLaunch",

  @doc("ConfidentialVM security type")
  ConfidentialVM: "ConfidentialVM",
}

/**
 * Specifies the mode that ProxyAgent will execute on if the feature is enabled. ProxyAgent will start to audit or monitor but not enforce access control over requests to host endpoints in Audit mode, while in Enforce mode it will enforce access control. The default value is Enforce mode.
 */
union Mode {
  string,

  @doc("Audit mode")
  Audit: "Audit",

  @doc("Enforce mode")
  Enforce: "Enforce",
}

/**
 * Specifies the execution mode. In Audit mode, the system acts as if it is enforcing the access control policy, including emitting access denial entries in the logs but it does not actually deny any requests to host endpoints. In Enforce mode, the system will enforce the access control and it is the recommended mode of operation.
 */
union Modes {
  string,

  @doc("Audit mode")
  Audit: "Audit",

  @doc("Enforce mode")
  Enforce: "Enforce",

  @doc("Disabled mode")
  Disabled: "Disabled",
}
