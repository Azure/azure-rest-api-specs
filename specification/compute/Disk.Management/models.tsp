import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

/**
 * The sku name.
 */
union DiskStorageAccountTypes {
  string,

  /**
   * Standard HDD locally redundant storage. Best for backup, non-critical, and infrequent access.
   */
  Standard_LRS: "Standard_LRS",

  /**
   * Premium SSD locally redundant storage. Best for production and performance sensitive workloads.
   */
  Premium_LRS: "Premium_LRS",

  /**
   * Standard SSD locally redundant storage. Best for web servers, lightly used enterprise applications and dev/test.
   */
  StandardSSD_LRS: "StandardSSD_LRS",

  /**
   * Ultra SSD locally redundant storage. Best for IO-intensive workloads such as SAP HANA, top tier databases (for example, SQL, Oracle), and other transaction-heavy workloads.
   */
  UltraSSD_LRS: "UltraSSD_LRS",

  /**
   * Premium SSD zone redundant storage. Best for the production workloads that need storage resiliency against zone failures.
   */
  Premium_ZRS: "Premium_ZRS",

  /**
   * Standard SSD zone redundant storage. Best for web servers, lightly used enterprise applications and dev/test that need storage resiliency against zone failures.
   */
  StandardSSD_ZRS: "StandardSSD_ZRS",

  /**
   * Premium SSD v2 locally redundant storage. Best for production and performance-sensitive workloads that consistently require low latency and high IOPS and throughput.
   */
  PremiumV2_LRS: "PremiumV2_LRS",
}

/**
 * The hypervisor generation of the Virtual Machine. Applicable to OS disks only.
 */
union HyperVGeneration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V1: "V1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  V2: "V2",
}

/**
 * CPU architecture supported by an OS disk.
 */
union Architecture {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  x64: "x64",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Arm64: "Arm64",
}

/**
 * Refers to the security capability of the disk supported to create a Trusted launch or Confidential VM
 */
@added(Versions.v2025_01_02)
union SupportedSecurityOption {
  string,

  /**
   * The disk supports creating Trusted Launch VMs.
   */
  TrustedLaunchSupported: "TrustedLaunchSupported",

  /**
   * The disk supports creating both Trusted Launch and Confidential VMs.
   */
  TrustedLaunchAndConfidentialVMSupported: "TrustedLaunchAndConfidentialVMSupported",
}

/**
 * This enumerates the possible sources of a disk's creation.
 */
union DiskCreateOption {
  string,

  /**
   * Create an empty data disk of a size given by diskSizeGB.
   */
  Empty: "Empty",

  /**
   * Disk will be attached to a VM.
   */
  Attach: "Attach",

  /**
   * Create a new disk from a platform image specified by the given imageReference or galleryImageReference.
   */
  FromImage: "FromImage",

  /**
   * Create a disk by importing from a blob specified by a sourceUri in a storage account specified by storageAccountId.
   */
  Import: "Import",

  /**
   * Create a new disk or snapshot by copying from a disk or snapshot specified by the given sourceResourceId.
   */
  Copy: "Copy",

  /**
   * Create a new disk by copying from a backup recovery point.
   */
  Restore: "Restore",

  /**
   * Create a new disk by obtaining a write token and using it to directly upload the contents of the disk.
   */
  Upload: "Upload",

  /**
   * Create a new disk by using a deep copy process, where the resource creation is considered complete only after all data has been copied from the source.
   */
  CopyStart: "CopyStart",

  /**
   * Similar to Import create option. Create a new Trusted Launch VM or Confidential VM supported disk by importing additional blobs for VM guest state specified by securityDataUri and VM metadata specified by securityMetadataUri in storage account specified by storageAccountId. The VM metadata is optional and only required for certain Confidential VM configurations and not required for Trusted Launch VM.
   */
  ImportSecure: "ImportSecure",

  /**
   * Similar to Upload create option. Create a new Trusted Launch VM or Confidential VM supported disk and upload using write token in disk, VM guest state and VM metadata. The VM metadata is optional and only required for certain Confidential VM configurations and not required for Trusted Launch VM.
   */
  UploadPreparedSecure: "UploadPreparedSecure",

  /**
   * Create a new disk by exporting from elastic san volume snapshot
   */
  CopyFromSanSnapshot: "CopyFromSanSnapshot",
}

/**
 * If this field is set on a snapshot and createOption is CopyStart, the snapshot will be copied at a quicker speed.
 */
union ProvisionedBandwidthCopyOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enhanced: "Enhanced",
}

/**
 * This enumerates the possible state of the disk.
 */
union DiskState {
  string,

  /**
   * The disk is not being used and can be attached to a VM.
   */
  Unattached: "Unattached",

  /**
   * The disk is currently attached to a running VM.
   */
  Attached: "Attached",

  /**
   * The disk is attached to a stopped-deallocated VM.
   */
  Reserved: "Reserved",

  /**
   * The disk is attached to a VM which is in hibernated state.
   */
  Frozen: "Frozen",

  /**
   * The disk currently has an Active SAS Uri associated with it.
   */
  ActiveSAS: "ActiveSAS",

  /**
   * The disk is attached to a VM in hibernated state and has an active SAS URI associated with it.
   */
  ActiveSASFrozen: "ActiveSASFrozen",

  /**
   * A disk is ready to be created by upload by requesting a write token.
   */
  ReadyToUpload: "ReadyToUpload",

  /**
   * A disk is created for upload and a write token has been issued for uploading to it.
   */
  ActiveUpload: "ActiveUpload",
}

/**
 * The type of key used to encrypt the data of the disk.
 */
union EncryptionType {
  string,

  /**
   * Disk is encrypted at rest with Platform managed key. It is the default encryption type. This is not a valid encryption type for disk encryption sets.
   */
  EncryptionAtRestWithPlatformKey: "EncryptionAtRestWithPlatformKey",

  /**
   * Disk is encrypted at rest with Customer managed key that can be changed and revoked by a customer.
   */
  EncryptionAtRestWithCustomerKey: "EncryptionAtRestWithCustomerKey",

  /**
   * Disk is encrypted at rest with 2 layers of encryption. One of the keys is Customer managed and the other key is Platform managed.
   */
  EncryptionAtRestWithPlatformAndCustomerKeys: "EncryptionAtRestWithPlatformAndCustomerKeys",
}

/**
 * Determines on how to handle disks with slow I/O.
 */
@added(Versions.v2025_01_02)
union AvailabilityPolicyDiskDelay {
  string,

  /**
   * Defaults to behavior without av policy specified, which is VM restart upon slow disk io.
   */
  None: "None",

  /**
   * Upon a disk io failure or slow response, try detaching then reattaching the disk.
   */
  AutomaticReattach: "AutomaticReattach",
}

/**
 * The state of snapshot which determines the access availability of the snapshot.
 */
@added(Versions.v2025_01_02)
union SnapshotAccessState {
  string,

  /**
   * Default value.
   */
  Unknown: "Unknown",

  /**
   * The snapshot cannot be used for restore, copy or download to offline.
   */
  Pending: "Pending",

  /**
   * The snapshot can be used for restore, copy to different region, and download to offline.
   */
  Available: "Available",

  /**
   * The snapshot can be used for restoring disks with fast performance but cannot be copied or downloaded.
   */
  InstantAccess: "InstantAccess",

  /**
   * The snapshot can be used for restoring disks with fast performance, copied and downloaded.
   */
  AvailableWithInstantAccess: "AvailableWithInstantAccess",
}

/**
 * Policy for accessing the disk via network.
 */
union NetworkAccessPolicy {
  string,

  /**
   * The disk can be exported or uploaded to from any network.
   */
  AllowAll: "AllowAll",

  /**
   * The disk can be exported or uploaded to using a DiskAccess resource's private endpoints.
   */
  AllowPrivate: "AllowPrivate",

  /**
   * The disk cannot be exported.
   */
  DenyAll: "DenyAll",
}

/**
 * Specifies the SecurityType of the VM. Applicable for OS disks only.
 */
union DiskSecurityTypes {
  string,

  /**
   * Trusted Launch provides security features such as secure boot and virtual Trusted Platform Module (vTPM)
   */
  TrustedLaunch: "TrustedLaunch",

  /**
   * Indicates Confidential VM disk with only VM guest state encrypted
   */
  ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey: "ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey",

  /**
   * Indicates Confidential VM disk with both OS disk and VM guest state encrypted with a platform managed key
   */
  ConfidentialVM_DiskEncryptedWithPlatformKey: "ConfidentialVM_DiskEncryptedWithPlatformKey",

  /**
   * Indicates Confidential VM disk with both OS disk and VM guest state encrypted with a customer managed key
   */
  ConfidentialVM_DiskEncryptedWithCustomerKey: "ConfidentialVM_DiskEncryptedWithCustomerKey",

  /**
   * Indicates Confidential VM disk with a ephemeral vTPM. vTPM state is not persisted across VM reboots.
   */
  ConfidentialVM_NonPersistedTPM: "ConfidentialVM_NonPersistedTPM",
}

/**
 * Policy for controlling export on the disk.
 */
union PublicNetworkAccess {
  string,

  /**
   * You can generate a SAS URI to access the underlying data of the disk publicly on the internet when NetworkAccessPolicy is set to AllowAll. You can access the data via the SAS URI only from your trusted Azure VNET when NetworkAccessPolicy is set to AllowPrivate.
   */
  Enabled: "Enabled",

  /**
   * You cannot access the underlying data of the disk publicly on the internet even when NetworkAccessPolicy is set to AllowAll. You can access the data via the SAS URI only from your trusted Azure VNET when NetworkAccessPolicy is set to AllowPrivate.
   */
  Disabled: "Disabled",
}

/**
 * Additional authentication requirements when exporting or uploading to a disk or snapshot.
 */
union DataAccessAuthMode {
  string,

  /**
   * When export/upload URL is used, the system checks if the user has an identity in Azure Active Directory and has necessary permissions to export/upload the data. Please refer to aka.ms/DisksAzureADAuth.
   */
  AzureActiveDirectory: "AzureActiveDirectory",

  /**
   * No additional authentication would be performed when accessing export/upload URL.
   */
  None: "None",
}

/**
 * The Access Level, accepted values include None, Read, Write.
 */
union AccessLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Read: "Read",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Write: "Write",
}

/**
 * Used to specify the file format when making request for SAS on a VHDX file format snapshot
 */
union FileFormat {
  string,

  /**
   * A VHD file is a disk image file in the Virtual Hard Disk file format.
   */
  VHD: "VHD",

  /**
   * A VHDX file is a disk image file in the Virtual Hard Disk v2 file format.
   */
  VHDX: "VHDX",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * The type of Managed Identity used by the DiskEncryptionSet. Only SystemAssigned is supported for new creations. Disk Encryption Sets can be updated with Identity type None during migration of subscription to a new Azure Active Directory tenant; it will cause the encrypted resources to lose access to the keys.
 */
union DiskEncryptionSetIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The type of key used to encrypt the data of the disk.
 */
union DiskEncryptionSetType {
  string,

  /**
   * Resource using diskEncryptionSet would be encrypted at rest with Customer managed key that can be changed and revoked by a customer.
   */
  EncryptionAtRestWithCustomerKey: "EncryptionAtRestWithCustomerKey",

  /**
   * Resource using diskEncryptionSet would be encrypted at rest with two layers of encryption. One of the keys is Customer managed and the other key is Platform managed.
   */
  EncryptionAtRestWithPlatformAndCustomerKeys: "EncryptionAtRestWithPlatformAndCustomerKeys",

  /**
   * Confidential VM supported disk and VM guest state would be encrypted with customer managed key.
   */
  ConfidentialVmEncryptedWithCustomerKey: "ConfidentialVmEncryptedWithCustomerKey",
}

/**
 * The sku name.
 */
union SnapshotStorageAccountTypes {
  string,

  /**
   * Standard HDD locally redundant storage
   */
  Standard_LRS: "Standard_LRS",

  /**
   * Premium SSD locally redundant storage
   */
  Premium_LRS: "Premium_LRS",

  /**
   * Standard zone redundant storage
   */
  Standard_ZRS: "Standard_ZRS",
}

/**
 * Indicates the error code if the background copy of a resource created via the CopyStart operation fails.
 */
union CopyCompletionErrorReason {
  string,

  /**
   * Indicates that the source snapshot was deleted while the background copy of the resource created via CopyStart operation was in progress.
   */
  CopySourceNotFound: "CopySourceNotFound",
}

/**
 * The Operating System type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperatingSystemTypes {
  Windows,
  Linux,
}

/**
 * The List Disks operation response.
 */
model DiskList is Azure.Core.Page<Disk>;

/**
 * The disks sku name. Can be Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS, Premium_ZRS, StandardSSD_ZRS, or PremiumV2_LRS.
 */
model DiskSku {
  /**
   * The sku name.
   */
  name?: DiskStorageAccountTypes;

  /**
   * The sku tier.
   */
  @visibility(Lifecycle.Read)
  tier?: string;
}

/**
 * In the case of an availability or connectivity issue with the data disk, specify the behavior of your VM
 */
@added(Versions.v2025_01_02)
model AvailabilityPolicy {
  /**
   * Determines on how to handle disks with slow I/O.
   */
  actionOnDiskDelay?: AvailabilityPolicyDiskDelay;
}

/**
 * Disk resource properties.
 */
model DiskProperties {
  /**
   * The time when the disk was created.
   */
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;

  /**
   * The Operating System type.
   */
  osType?: OperatingSystemTypes;

  /**
   * The hypervisor generation of the Virtual Machine. Applicable to OS disks only.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  hyperVGeneration?: HyperVGeneration;

  /**
   * Purchase plan information for the the image from which the OS disk was created. E.g. - {name: 2019-Datacenter, publisher: MicrosoftWindowsServer, product: WindowsServer}
   */
  purchasePlan?: DiskPurchasePlan;

  /**
   * List of supported capabilities for the image from which the OS disk was created.
   */
  supportedCapabilities?: SupportedCapabilities;

  /**
   * Disk source information. CreationData information cannot be changed after the disk has been created.
   */
  creationData: CreationData;

  /**
   * If creationData.createOption is Empty, this field is mandatory and it indicates the size of the disk to create. If this field is present for updates or creation with other options, it indicates a resize. Resizes are only allowed if the disk is not attached to a running VM, and can only increase the disk's size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  diskSizeGB?: int32;

  /**
   * The size of the disk in bytes. This field is read only.
   */
  @visibility(Lifecycle.Read)
  diskSizeBytes?: int64;

  /**
   * Unique Guid identifying the resource.
   */
  @visibility(Lifecycle.Read)
  uniqueId?: string;

  /**
   * Encryption settings collection used for Azure Disk Encryption, can contain multiple encryption settings per disk or snapshot.
   */
  encryptionSettingsCollection?: EncryptionSettingsCollection;

  /**
   * The disk provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The number of IOPS allowed for this disk; only settable for UltraSSD disks. One operation can transfer between 4k and 256k bytes.
   */
  diskIOPSReadWrite?: int64;

  /**
   * The bandwidth allowed for this disk; only settable for UltraSSD disks. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  diskMBpsReadWrite?: int64;

  /**
   * The total number of IOPS that will be allowed across all VMs mounting the shared disk as ReadOnly. One operation can transfer between 4k and 256k bytes.
   */
  diskIOPSReadOnly?: int64;

  /**
   * The total throughput (MBps) that will be allowed across all VMs mounting the shared disk as ReadOnly. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  diskMBpsReadOnly?: int64;

  /**
   * The state of the disk.
   */
  @visibility(Lifecycle.Read)
  diskState?: DiskState;

  /**
   * Encryption property can be used to encrypt data at rest with customer managed keys or platform managed keys.
   */
  encryption?: Encryption;

  /**
   * The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time.
   */
  maxShares?: int32;

  /**
   * Details of the list of all VMs that have the disk attached. maxShares should be set to a value greater than one for disks to allow attaching them to multiple VMs.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["vmUri"])
  shareInfo?: ShareInfoElement[];

  /**
   * Policy for accessing the disk via network.
   */
  networkAccessPolicy?: NetworkAccessPolicy;

  /**
   * ARM id of the DiskAccess resource for using private endpoints on disks.
   */
  diskAccessId?: string;

  /**
   * Latest time when bursting was last enabled on a disk.
   */
  @visibility(Lifecycle.Read)
  burstingEnabledTime?: utcDateTime;

  /**
   * Performance tier of the disk (e.g, P4, S10) as described here: https://azure.microsoft.com/en-us/pricing/details/managed-disks/. Does not apply to Ultra disks.
   */
  tier?: string;

  /**
   * Set to true to enable bursting beyond the provisioned performance target of the disk. Bursting is disabled by default. Does not apply to Ultra disks.
   */
  burstingEnabled?: boolean;

  /**
   * Properties of the disk for which update is pending.
   */
  @visibility(Lifecycle.Read)
  propertyUpdatesInProgress?: PropertyUpdatesInProgress;

  /**
   * Indicates the OS on a disk supports hibernation.
   */
  supportsHibernation?: boolean;

  /**
   * Contains the security related information for the resource.
   */
  securityProfile?: DiskSecurityProfile;

  /**
   * Percentage complete for the background copy when a resource is created via the CopyStart operation.
   */
  completionPercent?: float32;

  /**
   * Policy for controlling export on the disk.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Additional authentication requirements when exporting or uploading to a disk or snapshot.
   */
  dataAccessAuthMode?: DataAccessAuthMode;

  /**
   * Setting this property to true improves reliability and performance of data disks that are frequently (more than 5 times a day) by detached from one virtual machine and attached to another. This property should not be set for disks that are not detached and attached frequently as it causes the disks to not align with the fault domain of the virtual machine.
   */
  optimizedForFrequentAttach?: boolean;

  /**
   * The UTC time when the ownership state of the disk was last changed i.e., the time the disk was last attached or detached from a VM or the time when the VM to which the disk was attached was deallocated or started.
   */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "LastOwnershipUpdateTime")
  lastOwnershipUpdateTime?: utcDateTime;

  /**
   * Determines how platform treats disk failures
   */
  @added(Versions.v2025_01_02)
  availabilityPolicy?: AvailabilityPolicy;
}

/**
 * Used for establishing the purchase context of any 3rd Party artifact through MarketPlace.
 */
model DiskPurchasePlan {
  /**
   * The plan ID.
   */
  name: string;

  /**
   * The publisher ID.
   */
  publisher: string;

  /**
   * Specifies the product of the image from the marketplace. This is the same value as Offer under the imageReference element.
   */
  product: string;

  /**
   * The Offer Promotion Code.
   */
  promotionCode?: string;
}

/**
 * List of supported capabilities persisted on the disk resource for VM use.
 */
model SupportedCapabilities {
  /**
   * The disk controllers that an OS disk supports. If set it can be SCSI or SCSI, NVME or NVME, SCSI.
   */
  diskControllerTypes?: string;

  /**
   * True if the image from which the OS disk is created supports accelerated networking.
   */
  acceleratedNetwork?: boolean;

  /**
   * CPU architecture supported by an OS disk.
   */
  architecture?: Architecture;

  /**
   * Refers to the security capability of the disk supported to create a Trusted launch or Confidential VM
   */
  @added(Versions.v2025_01_02)
  supportedSecurityOption?: SupportedSecurityOption;
}

/**
 * Data used when creating a disk.
 */
model CreationData {
  /**
   * This enumerates the possible sources of a disk's creation.
   */
  createOption: DiskCreateOption;

  /**
   * Required if createOption is Import. The Azure Resource Manager identifier of the storage account containing the blob to import as a disk.
   */
  storageAccountId?: string;

  /**
   * Disk source information for PIR or user images.
   */
  imageReference?: ImageDiskReference;

  /**
   * Required if creating from a Gallery Image. The id/sharedGalleryImageId/communityGalleryImageId of the ImageDiskReference will be the ARM id of the shared galley image version from which to create a disk.
   */
  galleryImageReference?: ImageDiskReference;

  /**
   * If createOption is Import, this is the URI of a blob to be imported into a managed disk.
   */
  sourceUri?: string;

  /**
   * If createOption is Copy, this is the ARM id of the source snapshot or disk.
   */
  sourceResourceId?: string;

  /**
   * If this field is set, this is the unique id identifying the source of this resource.
   */
  @visibility(Lifecycle.Read)
  sourceUniqueId?: string;

  /**
   * If createOption is Upload, this is the size of the contents of the upload including the VHD footer. This value should be between 20972032 (20 MiB + 512 bytes for the VHD footer) and 35183298347520 bytes (32 TiB + 512 bytes for the VHD footer).
   */
  uploadSizeBytes?: int64;

  /**
   * Logical sector size in bytes for Ultra disks. Supported values are 512 ad 4096. 4096 is the default.
   */
  logicalSectorSize?: int32;

  /**
   * If createOption is ImportSecure, this is the URI of a blob to be imported into VM guest state.
   */
  securityDataUri?: string;

  /** If createOption is ImportSecure, this is the URI of a blob to be imported into VM metadata for Confidential VM. */
  @added(Versions.v2025_01_02)
  securityMetadataUri?: url;

  /**
   * Set this flag to true to get a boost on the performance target of the disk deployed, see here on the respective performance target. This flag can only be set on disk creation time and cannot be disabled after enabled.
   */
  performancePlus?: boolean;

  /**
   * Required if createOption is CopyFromSanSnapshot. This is the ARM id of the source elastic san volume snapshot.
   */
  elasticSanResourceId?: string;

  /**
   * If this field is set on a snapshot and createOption is CopyStart, the snapshot will be copied at a quicker speed.
   */
  provisionedBandwidthCopySpeed?: ProvisionedBandwidthCopyOption;

  /**
   * For snapshots created from Premium SSD v2 or Ultra disk, this property determines the time in minutes the snapshot is retained for instant access to enable faster restore.
   */
  @added(Versions.v2025_01_02)
  @minValue(1)
  instantAccessDurationMinutes?: int64;
}

/**
 * The source image used for creating the disk.
 */
model ImageDiskReference {
  /**
   * A relative uri containing either a Platform Image Repository, user image, or Azure Compute Gallery image reference.
   */
  id?: string;

  /**
   * A relative uri containing a direct shared Azure Compute Gallery image reference.
   */
  sharedGalleryImageId?: string;

  /**
   * A relative uri containing a community Azure Compute Gallery image reference.
   */
  communityGalleryImageId?: string;

  /**
   * If the disk is created from an image's data disk, this is an index that indicates which of the data disks in the image to use. For OS disks, this field is null.
   */
  lun?: int32;
}

/**
 * Encryption settings for disk or snapshot
 */
model EncryptionSettingsCollection {
  /**
   * Set this flag to true and provide DiskEncryptionKey and optional KeyEncryptionKey to enable encryption. Set this flag to false and remove DiskEncryptionKey and KeyEncryptionKey to disable encryption. If EncryptionSettings is null in the request object, the existing settings remain unchanged.
   */
  enabled: boolean;

  /**
   * A collection of encryption settings, one for each disk volume.
   */
  @identifiers(#["diskEncryptionKey/sourceVault/id"])
  encryptionSettings?: EncryptionSettingsElement[];

  /**
   * Describes what type of encryption is used for the disks. Once this field is set, it cannot be overwritten. '1.0' corresponds to Azure Disk Encryption with AAD app.'1.1' corresponds to Azure Disk Encryption.
   */
  encryptionSettingsVersion?: string;
}

/**
 * Encryption settings for one disk volume.
 */
model EncryptionSettingsElement {
  /**
   * Key Vault Secret Url and vault id of the disk encryption key
   */
  diskEncryptionKey?: KeyVaultAndSecretReference;

  /**
   * Key Vault Key Url and vault id of the key encryption key. KeyEncryptionKey is optional and when provided is used to unwrap the disk encryption key.
   */
  keyEncryptionKey?: KeyVaultAndKeyReference;
}

/**
 * Key Vault Secret Url and vault id of the encryption key
 */
model KeyVaultAndSecretReference {
  /**
   * Resource id of the KeyVault containing the key or secret
   */
  sourceVault: SourceVault;

  /**
   * Url pointing to a key or secret in KeyVault
   */
  secretUrl: string;
}

/**
 * The vault id is an Azure Resource Manager Resource id in the form /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}
 */
model SourceVault {
  /**
   * Resource Id
   */
  id?: string;
}

/**
 * Key Vault Key Url and vault id of KeK, KeK is optional and when provided is used to unwrap the encryptionKey
 */
model KeyVaultAndKeyReference {
  /**
   * Resource id of the KeyVault containing the key or secret
   */
  sourceVault: SourceVault;

  /**
   * Url pointing to a key or secret in KeyVault
   */
  keyUrl: string;
}

/**
 * Encryption at rest settings for disk or snapshot
 */
model Encryption {
  /**
   * ResourceId of the disk encryption set to use for enabling encryption at rest.
   */
  diskEncryptionSetId?: string;

  /**
   * The type of key used to encrypt the data of the disk.
   */
  type?: EncryptionType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ShareInfoElement {
  /**
   * A relative URI containing the ID of the VM that has the disk attached.
   */
  @visibility(Lifecycle.Read)
  vmUri?: string;
}

/**
 * Properties of the disk for which update is pending.
 */
model PropertyUpdatesInProgress {
  /**
   * The target performance tier of the disk if a tier change operation is in progress.
   */
  targetTier?: string;
}

/**
 * Contains the security related information for the resource.
 */
model DiskSecurityProfile {
  /**
   * Specifies the SecurityType of the VM. Applicable for OS disks only.
   */
  securityType?: DiskSecurityTypes;

  /**
   * ResourceId of the disk encryption set associated to Confidential VM supported disk encrypted with customer managed key
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  secureVMDiskEncryptionSetId?: string;
}

/**
 * Disk update resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope"
model DiskUpdate {
  /**
   * Disk resource update properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DiskUpdateProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The disks sku name. Can be Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS, Premium_ZRS, StandardSSD_ZRS, or PremiumV2_LRS.
   */
  sku?: DiskSku;
}

/**
 * Disk resource update properties.
 */
model DiskUpdateProperties {
  /**
   * the Operating System type.
   */
  osType?: OperatingSystemTypes;

  /**
   * If creationData.createOption is Empty, this field is mandatory and it indicates the size of the disk to create. If this field is present for updates or creation with other options, it indicates a resize. Resizes are only allowed if the disk is not attached to a running VM, and can only increase the disk's size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  diskSizeGB?: int32;

  /**
   * Encryption settings collection used be Azure Disk Encryption, can contain multiple encryption settings per disk or snapshot.
   */
  encryptionSettingsCollection?: EncryptionSettingsCollection;

  /**
   * The number of IOPS allowed for this disk; only settable for UltraSSD disks. One operation can transfer between 4k and 256k bytes.
   */
  diskIOPSReadWrite?: int64;

  /**
   * The bandwidth allowed for this disk; only settable for UltraSSD disks. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  diskMBpsReadWrite?: int64;

  /**
   * The total number of IOPS that will be allowed across all VMs mounting the shared disk as ReadOnly. One operation can transfer between 4k and 256k bytes.
   */
  diskIOPSReadOnly?: int64;

  /**
   * The total throughput (MBps) that will be allowed across all VMs mounting the shared disk as ReadOnly. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  diskMBpsReadOnly?: int64;

  /**
   * The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time.
   */
  maxShares?: int32;

  /**
   * Encryption property can be used to encrypt data at rest with customer managed keys or platform managed keys.
   */
  encryption?: Encryption;

  /**
   * Policy for accessing the disk via network.
   */
  networkAccessPolicy?: NetworkAccessPolicy;

  /**
   * ARM id of the DiskAccess resource for using private endpoints on disks.
   */
  diskAccessId?: string;

  /**
   * Performance tier of the disk (e.g, P4, S10) as described here: https://azure.microsoft.com/en-us/pricing/details/managed-disks/. Does not apply to Ultra disks.
   */
  tier?: string;

  /**
   * Set to true to enable bursting beyond the provisioned performance target of the disk. Bursting is disabled by default. Does not apply to Ultra disks.
   */
  burstingEnabled?: boolean;

  /**
   * Purchase plan information to be added on the OS disk
   */
  purchasePlan?: DiskPurchasePlan;

  /**
   * List of supported capabilities to be added on the OS disk.
   */
  supportedCapabilities?: SupportedCapabilities;

  /**
   * Properties of the disk for which update is pending.
   */
  @visibility(Lifecycle.Read)
  propertyUpdatesInProgress?: PropertyUpdatesInProgress;

  /**
   * Indicates the OS on a disk supports hibernation.
   */
  supportsHibernation?: boolean;

  /**
   * Policy for controlling export on the disk.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Additional authentication requirements when exporting or uploading to a disk or snapshot.
   */
  dataAccessAuthMode?: DataAccessAuthMode;

  /**
   * Setting this property to true improves reliability and performance of data disks that are frequently (more than 5 times a day) by detached from one virtual machine and attached to another. This property should not be set for disks that are not detached and attached frequently as it causes the disks to not align with the fault domain of the virtual machine.
   */
  optimizedForFrequentAttach?: boolean;

  /**
   * Determines how platform treats disk failures
   */
  @added(Versions.v2025_01_02)
  availabilityPolicy?: AvailabilityPolicy;
}

/**
 * Data used for requesting a SAS.
 */
model GrantAccessData {
  /**
   * The Access Level, accepted values include None, Read, Write.
   */
  access: AccessLevel;

  /**
   * Time duration in seconds until the SAS access expires.
   */
  durationInSeconds: int32;

  /**
   * Set this flag to true to get additional SAS for VM guest state
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  getSecureVMGuestStateSAS?: boolean;

  /**
   * Used to specify the file format when making request for SAS on a VHDX file format snapshot
   */
  fileFormat?: FileFormat;
}

/**
 * A disk access SAS uri.
 */
model AccessUri {
  /**
   * A SAS uri for accessing a disk.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  @visibility(Lifecycle.Read)
  accessSAS?: string;

  /**
   * A SAS uri for accessing a VM guest state.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  @visibility(Lifecycle.Read)
  securityDataAccessSAS?: string;

  /** A SAS uri for accessing a VM metadata. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_01_02)
  securityMetadataAccessSAS?: string;
}

/**
 * The List disk access operation response.
 */
model DiskAccessList is Azure.Core.Page<DiskAccess>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DiskAccessProperties {
  /**
   * A readonly collection of private endpoint connections created on the disk. Currently only one endpoint connection is supported.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The disk access resource provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The time when the disk access was created.
   */
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  @visibility(Lifecycle.Read)
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between DiskAccess and Virtual Network.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Used for updating a disk access resource.
 */
model DiskAccessUpdate {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * A list of private link resources
 */
model PrivateEndpointConnectionListResult
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  value?: PrivateLinkResource[];
}

/**
 * A private link resource
 */
model PrivateLinkResource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PrivateLinkResourceProperties;

  /**
   * private link resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * private link resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * private link resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * The List disk encryption set operation response.
 */
model DiskEncryptionSetList is Azure.Core.Page<DiskEncryptionSet>;

/**
 * The managed identity for the disk encryption set. It should be given permission on the key vault before it can be used to encrypt disks.
 */
model EncryptionSetIdentity {
  /**
   * The type of Managed Identity used by the DiskEncryptionSet. Only SystemAssigned is supported for new creations. Disk Encryption Sets can be updated with Identity type None during migration of subscription to a new Azure Active Directory tenant; it will cause the encrypted resources to lose access to the keys.
   */
  type?: DiskEncryptionSetIdentityType;

  /**
   * The object id of the Managed Identity Resource. This will be sent to the RP from ARM via the x-ms-identity-principal-id header in the PUT request if the resource has a systemAssigned(implicit) identity
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the Managed Identity Resource. This will be sent to the RP from ARM via the x-ms-client-tenant-id header in the PUT request if the resource has a systemAssigned(implicit) identity
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The list of user identities associated with the disk encryption set. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EncryptionSetProperties {
  /**
   * The type of key used to encrypt the data of the disk.
   */
  encryptionType?: DiskEncryptionSetType;

  /**
   * The key vault key which is currently used by this disk encryption set.
   */
  activeKey?: KeyForDiskEncryptionSet;

  /**
   * A readonly collection of key vault keys previously used by this disk encryption set while a key rotation is in progress. It will be empty if there is no ongoing key rotation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["sourceVault/id"])
  previousKeys?: KeyForDiskEncryptionSet[];

  /**
   * The disk encryption set provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Set this flag to true to enable auto-updating of this disk encryption set to the latest key version.
   */
  rotationToLatestKeyVersionEnabled?: boolean;

  /**
   * The time when the active key of this disk encryption set was updated.
   */
  @visibility(Lifecycle.Read)
  lastKeyRotationTimestamp?: utcDateTime;

  /**
   * The error that was encountered during auto-key rotation. If an error is present, then auto-key rotation will not be attempted until the error on this disk encryption set is fixed.
   */
  @visibility(Lifecycle.Read)
  autoKeyRotationError?: ApiError;

  /**
   * Multi-tenant application client id to access key vault in a different tenant. Setting the value to 'None' will clear the property.
   */
  federatedClientId?: string;
}

/**
 * Key Vault Key Url to be used for server side encryption of Managed Disks and Snapshots
 */
model KeyForDiskEncryptionSet {
  /**
   * Resource id of the KeyVault containing the key or secret. This property is optional and cannot be used if the KeyVault subscription is not the same as the Disk Encryption Set subscription.
   */
  sourceVault?: SourceVault;

  /**
   * Fully versioned Key Url pointing to a key in KeyVault. Version segment of the Url is required regardless of rotationToLatestKeyVersionEnabled value.
   */
  keyUrl: string;
}

/**
 * disk encryption set update resource.
 */
model DiskEncryptionSetUpdate {
  /**
   * disk encryption set resource update properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DiskEncryptionSetUpdateProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The managed identity for the disk encryption set. It should be given permission on the key vault before it can be used to encrypt disks.
   */
  identity?: EncryptionSetIdentity;
}

/**
 * disk encryption set resource update properties.
 */
model DiskEncryptionSetUpdateProperties {
  /**
   * The type of key used to encrypt the data of the disk.
   */
  encryptionType?: DiskEncryptionSetType;

  /**
   * Key Vault Key Url to be used for server side encryption of Managed Disks and Snapshots
   */
  activeKey?: KeyForDiskEncryptionSet;

  /**
   * Set this flag to true to enable auto-updating of this disk encryption set to the latest key version.
   */
  rotationToLatestKeyVersionEnabled?: boolean;

  /**
   * Multi-tenant application client id to access key vault in a different tenant. Setting the value to 'None' will clear the property.
   */
  federatedClientId?: string;
}

/**
 * FIXME: Custom Page for string
 */
@Azure.Core.pagedResult
@friendlyName("Paged{name}", Resource)
@doc("Paged collection of string items")
model CustomPage<Resource extends string> {
  @doc("The items on this page")
  @Azure.Core.items
  value: Resource[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: url;
}

/**
 * The List resources which are encrypted with the disk encryption set.
 */
model ResourceUriList is CustomPage<string>;

/**
 * The List Disk Restore Points operation response.
 */
model DiskRestorePointList is Azure.Core.Page<DiskRestorePoint>;

/**
 * Properties of an incremental disk restore point
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DiskRestorePointProperties {
  /**
   * The timestamp of restorePoint creation
   */
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;

  /**
   * arm id of source disk or source disk restore point.
   */
  @visibility(Lifecycle.Read)
  sourceResourceId?: string;

  /**
   * The Operating System type.
   */
  @visibility(Lifecycle.Read)
  osType?: OperatingSystemTypes;

  /**
   * The hypervisor generation of the Virtual Machine. Applicable to OS disks only.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  hyperVGeneration?: HyperVGeneration;

  /**
   * Purchase plan information for the the image from which the OS disk was created.
   */
  purchasePlan?: DiskPurchasePlan;

  /**
   * List of supported capabilities for the image from which the OS disk was created.
   */
  supportedCapabilities?: SupportedCapabilities;

  /**
   * id of the backing snapshot's MIS family
   */
  @visibility(Lifecycle.Read)
  familyId?: string;

  /**
   * unique incarnation id of the source disk
   */
  @visibility(Lifecycle.Read)
  sourceUniqueId?: string;

  /**
   * Encryption property can be used to encrypt data at rest with customer managed keys or platform managed keys.
   */
  @visibility(Lifecycle.Read)
  encryption?: Encryption;

  /**
   * Indicates the OS on a disk supports hibernation.
   */
  supportsHibernation?: boolean;

  /**
   * Policy for accessing the disk via network.
   */
  networkAccessPolicy?: NetworkAccessPolicy;

  /**
   * Policy for controlling export on the disk.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * ARM id of the DiskAccess resource for using private endpoints on disks.
   */
  diskAccessId?: string;

  /**
   * Percentage complete for the background copy of disk restore point when source resource is from a different region.
   */
  completionPercent?: float32;

  /**
   * Replication state of disk restore point when source resource is from a different region.
   */
  @visibility(Lifecycle.Read)
  replicationState?: string;

  /**
   * Location of source disk or source disk restore point when source resource is from a different region.
   */
  @visibility(Lifecycle.Read)
  sourceResourceLocation?: string;

  /**
   * Contains the security related information for the resource.
   */
  securityProfile?: DiskSecurityProfile;

  /**
   * Logical sector size in bytes for disk restore points of UltraSSD_LRS and PremiumV2_LRS disks. Supported values are 512 and 4096. 4096 is the default.
   */
  @visibility(Lifecycle.Read)
  logicalSectorSize?: int32;
}

/**
 * The ProxyOnly Resource model definition.
 */
model ProxyOnlyResource {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The List Snapshots operation response.
 */
model SnapshotList is Azure.Core.Page<Snapshot>;

/**
 * The snapshots sku name. Can be Standard_LRS, Premium_LRS, or Standard_ZRS. This is an optional parameter for incremental snapshot and the default behavior is the SKU will be set to the same sku as the previous snapshot
 */
model SnapshotSku {
  /**
   * The sku name.
   */
  name?: SnapshotStorageAccountTypes;

  /**
   * The sku tier.
   */
  @visibility(Lifecycle.Read)
  tier?: string;
}

/**
 * Snapshot resource properties.
 */
model SnapshotProperties {
  /**
   * The time when the snapshot was created.
   */
  @visibility(Lifecycle.Read)
  timeCreated?: utcDateTime;

  /**
   * The Operating System type.
   */
  osType?: OperatingSystemTypes;

  /**
   * The hypervisor generation of the Virtual Machine. Applicable to OS disks only.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  hyperVGeneration?: HyperVGeneration;

  /**
   * Purchase plan information for the image from which the source disk for the snapshot was originally created.
   */
  purchasePlan?: DiskPurchasePlan;

  /**
   * List of supported capabilities for the image from which the source disk from the snapshot was originally created.
   */
  supportedCapabilities?: SupportedCapabilities;

  /**
   * Disk source information. CreationData information cannot be changed after the disk has been created.
   */
  creationData: CreationData;

  /**
   * If creationData.createOption is Empty, this field is mandatory and it indicates the size of the disk to create. If this field is present for updates or creation with other options, it indicates a resize. Resizes are only allowed if the disk is not attached to a running VM, and can only increase the disk's size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  diskSizeGB?: int32;

  /**
   * The size of the disk in bytes. This field is read only.
   */
  @visibility(Lifecycle.Read)
  diskSizeBytes?: int64;

  /**
   * The state of the snapshot.
   */
  @visibility(Lifecycle.Read)
  diskState?: DiskState;

  /**
   * Unique Guid identifying the resource.
   */
  @visibility(Lifecycle.Read)
  uniqueId?: string;

  /**
   * Encryption settings collection used be Azure Disk Encryption, can contain multiple encryption settings per disk or snapshot.
   */
  encryptionSettingsCollection?: EncryptionSettingsCollection;

  /**
   * The disk provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Whether a snapshot is incremental. Incremental snapshots on the same disk occupy less space than full snapshots and can be diffed.
   */
  incremental?: boolean;

  /**
   * Incremental snapshots for a disk share an incremental snapshot family id. The Get Page Range Diff API can only be called on incremental snapshots with the same family id.
   */
  @visibility(Lifecycle.Read)
  incrementalSnapshotFamilyId?: string;

  /**
   * Encryption property can be used to encrypt data at rest with customer managed keys or platform managed keys.
   */
  encryption?: Encryption;

  /**
   * Policy for accessing the disk via network.
   */
  networkAccessPolicy?: NetworkAccessPolicy;

  /**
   * ARM id of the DiskAccess resource for using private endpoints on disks.
   */
  diskAccessId?: string;

  /**
   * Contains the security related information for the resource.
   */
  securityProfile?: DiskSecurityProfile;

  /**
   * Indicates the OS on a snapshot supports hibernation.
   */
  supportsHibernation?: boolean;

  /**
   * Policy for controlling export on the disk.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Percentage complete for the background copy when a resource is created via the CopyStart operation.
   */
  completionPercent?: float32;

  /**
   * Indicates the error details if the background copy of a resource created via the CopyStart operation fails.
   */
  copyCompletionError?: CopyCompletionError;

  /**
   * Additional authentication requirements when exporting or uploading to a disk or snapshot.
   */
  dataAccessAuthMode?: DataAccessAuthMode;

  /**
   * The state of snapshot which determines the access availability of the snapshot.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_01_02)
  snapshotAccessState?: SnapshotAccessState;
}

/**
 * Indicates the error details if the background copy of a resource created via the CopyStart operation fails.
 */
model CopyCompletionError {
  /**
   * Indicates the error code if the background copy of a resource created via the CopyStart operation fails.
   */
  errorCode: CopyCompletionErrorReason;

  /**
   * Indicates the error message if the background copy of a resource created via the CopyStart operation fails.
   */
  errorMessage: string;
}

/**
 * Snapshot update resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope"
model SnapshotUpdate {
  /**
   * Snapshot resource update properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SnapshotUpdateProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The snapshots sku name. Can be Standard_LRS, Premium_LRS, or Standard_ZRS. This is an optional parameter for incremental snapshot and the default behavior is the SKU will be set to the same sku as the previous snapshot
   */
  sku?: SnapshotSku;
}

/**
 * Snapshot resource update properties.
 */
model SnapshotUpdateProperties {
  /**
   * the Operating System type.
   */
  osType?: OperatingSystemTypes;

  /**
   * If creationData.createOption is Empty, this field is mandatory and it indicates the size of the disk to create. If this field is present for updates or creation with other options, it indicates a resize. Resizes are only allowed if the disk is not attached to a running VM, and can only increase the disk's size.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Respecting name of the variable"
  diskSizeGB?: int32;

  /**
   * Encryption settings collection used be Azure Disk Encryption, can contain multiple encryption settings per disk or snapshot.
   */
  encryptionSettingsCollection?: EncryptionSettingsCollection;

  /**
   * Encryption property can be used to encrypt data at rest with customer managed keys or platform managed keys.
   */
  encryption?: Encryption;

  /**
   * Policy for accessing the disk via network.
   */
  networkAccessPolicy?: NetworkAccessPolicy;

  /**
   * ARM id of the DiskAccess resource for using private endpoints on disks.
   */
  diskAccessId?: string;

  /**
   * Indicates the OS on a snapshot supports hibernation.
   */
  supportsHibernation?: boolean;

  /**
   * Policy for controlling export on the disk.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Additional authentication requirements when exporting or uploading to a disk or snapshot.
   */
  dataAccessAuthMode?: DataAccessAuthMode;

  /**
   * List of supported capabilities for the image from which the OS disk was created.
   */
  supportedCapabilities?: SupportedCapabilities;

  /**
   * The state of snapshot which determines the access availability of the snapshot.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_01_02)
  snapshotAccessState?: SnapshotAccessState;
}

@@doc(SnapshotList.value, "A list of snapshots.");
@@doc(ResourceUriList.nextLink,
  "The uri to fetch the next page of encrypted resources. Call ListNext() with this to fetch the next page of encrypted resources."
);
@@doc(ResourceUriList.value,
  "A list of IDs or Owner IDs of resources which are encrypted with the disk encryption set."
);
