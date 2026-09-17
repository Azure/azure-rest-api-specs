using Rest;

namespace ContainerAppsSandbox {
  /** Azure resource ID of a Blob Storage container. */
  scalar ArmStorageContainerId extends string;

  /** Azure resource ID of a user-assigned managed identity. */
  scalar ArmUserAssignedIdentityId extends string;

  /** Authentication used to access a customer-owned Blob Storage container. */
  union AzureBlobByoVolumeAuth {
    /** Uses a managed identity assigned to the sandbox group. */
    AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth: AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth,
  }

  /** Managed identity authentication for a customer-owned blob volume. */
  model AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth {
    /** The managed-identity authentication type. */
    kind: "ManagedIdentity";

    /** The managed identity to use. */
    identity: SandboxGroupIdentitySelector;
  }

  /** Usage statistics for a blob-backed volume. */
  model BlobVolumeUsage {
    /** The used storage in bytes. */
    usedBytes: int64;

    /** The number of items in the volume. */
    itemCount: int64;

    /** The time when the usage was calculated. */
    calculatedAtUtc: utcDateTime;
  }

  /** Usage statistics for a data disk volume. */
  model DataDiskVolumeUsage {
    /** The compressed backup size in bytes. */
    compressedBlobSizeBytes: int64;

    /** The used disk space in bytes. */
    usedSizeBytes: int64;

    /** The time when the disk was last uploaded. */
    lastUploadedAtUtc: utcDateTime;
  }

  /** Options for creating a fork of a data disk volume. */
  model ForkDataDiskVolumeContent {
    /** The name of the new volume. */
    destinationVolumeName: VolumeName;

    /** Labels to assign to the new volume. */
    labels?: Record<string>;
  }

  /** The supported managed identity selector types. */
  union SandboxGroupIdentitySelectorKind {
    string,

    /** Selects the sandbox group's system-assigned managed identity. */
    SystemAssigned: "SystemAssigned",

    /** Selects a user-assigned managed identity. */
    UserAssigned: "UserAssigned",
  }

  /** Customer-supplied selector that picks one of the managed identities already on a sandbox group. */
  @discriminator("kind")
  model SandboxGroupIdentitySelector {
    /** The managed identity selector type. */
    kind: SandboxGroupIdentitySelectorKind;
  }

  /** Selects the sandbox group's system-assigned managed identity. */
  model SandboxGroupIdentitySelectorSystemAssignedIdentitySelector
    extends SandboxGroupIdentitySelector {
    /** The system-assigned managed identity selector type. */
    kind: "SystemAssigned";
  }

  /** Selects a user-assigned managed identity by resource ID. */
  model SandboxGroupIdentitySelectorUserAssignedIdentitySelector
    extends SandboxGroupIdentitySelector {
    /** The user-assigned managed identity selector type. */
    kind: "UserAssigned";

    /** The resource ID of the user-assigned managed identity. */
    resourceId: ArmUserAssignedIdentityId;
  }

  /** Volume counts grouped by type. */
  model VolumeCountResponse {
    /** Volume counts grouped by type. */
    counts: VolumeTypeCount[];
  }

  /** The name of a file or directory in a volume. */
  scalar VolumeItemName extends string;

  /** Files and directories returned from a volume path. */
  model VolumeListDirectoryResponse {
    /** The directory path that was listed. */
    path: VolumePath;

    /** Files and directories contained in the path. */
    items: VolumePathItem[];
  }

  /** A path within a volume. */
  scalar VolumePath extends string;

  /** Metadata for a file or directory in a volume. */
  model VolumePathItem {
    /** The file or directory name. */
    itemName: VolumeItemName;

    /** The full path in the volume. */
    path: VolumePath;

    /** Whether the item is a directory. */
    isDirectory: boolean;

    /** The file size in bytes. */
    sizeBytes?: int64;

    /** The time when the item was last modified. */
    lastModifiedUtc?: utcDateTime;

    /** The media type of the file. */
    contentType?: string;

    /** An HTTP entity tag used for optimistic concurrency, as defined by RFC 9110. */
    eTag?: string;
  }

  /** Current backing-storage provisioning state. */
  union VolumeProvisioningState {
    string,

    /** Backing storage is still being provisioned. */
    Provisioning: "Provisioning",

    /** Backing storage is ready. */
    Succeeded: "Succeeded",
  }

  /** Elastic SAN storage SKU. */
  union EsanSku {
    string,

    /** Premium zone-redundant storage. */
    PremiumZrs: "Premium_ZRS",

    /** Premium locally-redundant storage. */
    PremiumLrs: "Premium_LRS",
  }

  /** Customer-facing volume resource. */
  @discriminator("type")
  @resource("volumes")
  @parentResource(SandboxGroupScope)
  model Volume {
    /** Represents the type of volume. */
    type: VolumeType;

    /** Volume name assigned from the route by the service. */
    @key("volumeName")
    @visibility(Lifecycle.Read)
    volumeName: VolumeName;

    /** Customer-defined labels for the volume. */
    labels?: Record<string>;

    /** Current provisioning state assigned by the service. */
    @visibility(Lifecycle.Read)
    provisioningState: VolumeProvisioningState;
  }

  /** A volume backed by a customer-owned Azure Blob container. */
  model AzureBlobByoVolume extends Volume {
    /** Represents the type of volume. */
    type: "AzureBlobByo";

    /** The Azure resource ID of the blob container. */
    storageContainerResourceId: ArmStorageContainerId;

    /** Authentication used to access the blob container. */
    auth: AzureBlobByoVolumeAuth;
  }

  /** A service-managed Azure Blob volume. */
  model AzureBlobVolume extends Volume {
    /** Represents the type of volume. */
    type: "AzureBlob";

    /** Current volume usage. */
    @visibility(Lifecycle.Read)
    usage?: BlobVolumeUsage;
  }

  /** A volume backed by Azure Files over SMB. */
  model AzureFileCifsVolume extends Volume {
    /** Represents the type of volume. */
    type: "AzureFileCifs";
  }

  /** A volume backed by Azure Files over NFS. */
  model AzureFileNfsVolume extends Volume {
    /** Represents the type of volume. */
    type: "AzureFileNfs";
  }

  /** A persistent data disk volume. */
  model DataDiskVolume extends Volume {
    /** Represents the type of volume. */
    type: "DataDisk";

    /** The requested disk size. */
    size: StorageQuantity;

    /** Whether the volume is currently attached. */
    @visibility(Lifecycle.Read)
    isAttached: boolean;

    /** Resource name of an AKS managed cluster. */
    @visibility(Lifecycle.Read)
    clusterId?: string;

    /** The identifier of the attached sandbox. */
    @visibility(Lifecycle.Read)
    attachedSandboxId?: string;

    /** Current disk usage and upload status. */
    @visibility(Lifecycle.Read)
    usage?: DataDiskVolumeUsage;
  }

  /** Elastic SAN volume. */
  model EsanVolume extends Volume {
    /** Represents the type of volume. */
    type: "Esan";

    /** Requested and provisioned volume size. */
    size: StorageQuantity;

    /** SKU selected by the service. */
    @visibility(Lifecycle.Read)
    sku: EsanSku;
  }

  /** Represents the type of volume. */
  union VolumeType {
    /** An unrecognized volume type returned by the service. */
    StringValue: string,

    /** A service-managed Azure Blob volume. */
    AzureBlob: "AzureBlob",

    /** A customer-owned Azure Blob container volume. */
    AzureBlobByo: "AzureBlobByo",

    /** An Azure Files volume using SMB. */
    AzureFileCifs: "AzureFileCifs",

    /** An Azure Files volume using NFS. */
    AzureFileNfs: "AzureFileNfs",

    /** A persistent data disk volume. */
    DataDisk: "DataDisk",

    /** An Elastic SAN volume. */
    Esan: "Esan",
  }

  /** The number of volumes of one type. */
  model VolumeTypeCount {
    /** The volume type. */
    type: VolumeType;

    /** The number of volumes. */
    count: int32;
  }
}
