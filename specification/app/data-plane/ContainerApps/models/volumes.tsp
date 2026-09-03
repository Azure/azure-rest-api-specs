namespace ContainerAppsSandbox {
  /** ARM resource ID for an Azure Storage blob container. */
  scalar ArmStorageContainerId extends string;

  /** ARM resource ID for an Azure user-assigned managed identity. */
  scalar ArmUserAssignedIdentityId extends string;

  /** Authentication for a bring-your-own (BYO) Azure Blob container volume: how ADC obtains credentials to access the customer-owned container. */
  union AzureBlobByoVolumeAuth {
    /** AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth variant. */
    AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth: AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth,
  }

  /** Managed-identity authentication for a BYO blob volume. ADC accesses the container with a managed identity already on the sandbox group. */
  model AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth {
    /** The managed-identity authentication type. */
    kind: "ManagedIdentity";

    /** identity value. */
    identity: SandboxGroupIdentitySelector;
  }

  /** BlobVolumeUsage wire model. */
  model BlobVolumeUsage {
    /** usedBytes value. */
    usedBytes: Bytes;

    /** itemCount value. */
    itemCount: int64;

    /** calculatedAtUtc value. */
    calculatedAtUtc: utcDateTime;
  }

  /** DataDiskVolumeUsage wire model. */
  model DataDiskVolumeUsage {
    /** compressedBlobSizeBytes value. */
    compressedBlobSizeBytes: Bytes;

    /** usedSizeBytes value. */
    usedSizeBytes: Bytes;

    /** lastUploadedAtUtc value. */
    lastUploadedAtUtc: utcDateTime;
  }

  /** ForkDataDiskVolumeContent wire model. */
  model ForkDataDiskVolumeContent {
    /** destinationVolumeName value. */
    destinationVolumeName: VolumeName;

    /** labels value. */
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

  /** Selects a specific user-assigned managed identity by its ARM resource ID. */
  model SandboxGroupIdentitySelectorUserAssignedIdentitySelector
    extends SandboxGroupIdentitySelector {
    /** The user-assigned managed identity selector type. */
    kind: "UserAssigned";

    /** resourceId value. */
    resourceId: ArmUserAssignedIdentityId;
  }

  /** VolumeCountResult wire model. */
  model VolumeCountResult {
    /** counts value. */
    counts: VolumeTypeCount[];
  }

  /** VolumeItemName wire model. */
  scalar VolumeItemName extends string;

  /** VolumeListDirectoryResult wire model. */
  model VolumeListDirectoryResult {
    /** path value. */
    path: VolumePath;

    /** items value. */
    items: VolumePathItem[];
  }

  /** VolumePath wire model. */
  scalar VolumePath extends string;

  /** VolumePathItem wire model. */
  model VolumePathItem {
    /** itemName value. */
    itemName: VolumeItemName;

    /** path value. */
    path: VolumePath;

    /** isDirectory value. */
    isDirectory: boolean;

    /** sizeBytes value. */
    sizeBytes: Bytes;

    /** lastModifiedUtc value. */
    lastModifiedUtc: utcDateTime;

    /** contentType value. */
    contentType: string;

    /** An HTTP entity tag used for optimistic concurrency, as defined by RFC 9110. */
    eTag?: string;
  }

  /** The supported volume request types. */
  union VolumeRequestType {
    string,

    /** An Azure Blob volume. */
    AzureBlob: "AzureBlob",

    /** A bring-your-own Azure Blob volume. */
    AzureBlobByo: "AzureBlobByo",

    /** An Azure Files CIFS volume. */
    AzureFileCifs: "AzureFileCifs",

    /** An Azure Files NFS volume. */
    AzureFileNfs: "AzureFileNfs",

    /** A data disk volume. */
    DataDisk: "DataDisk",
  }

  /** VolumeContent wire model. */
  @discriminator("type")
  model VolumeContent {
    /** The volume request type. */
    type: VolumeRequestType;

    /** labels value. */
    labels?: Record<string>;
  }

  /** VolumeRequestAzureBlobByoVolumeContent wire model. */
  model VolumeRequestAzureBlobByoVolumeContent extends VolumeContent {
    /** Represents the type of volume. */
    type: "AzureBlobByo";

    /** storageContainerResourceId value. */
    storageContainerResourceId: ArmStorageContainerId;

    /** auth value. */
    auth: AzureBlobByoVolumeAuth;
  }

  /** VolumeRequestAzureBlobVolumeContent wire model. */
  model VolumeRequestAzureBlobVolumeContent extends VolumeContent {
    /** Represents the type of volume. */
    type: "AzureBlob";
  }

  /** VolumeRequestAzureFileCifsVolumeContent wire model. */
  model VolumeRequestAzureFileCifsVolumeContent extends VolumeContent {
    /** Represents the type of volume. */
    type: "AzureFileCifs";
  }

  /** VolumeRequestAzureFileNfsVolumeContent wire model. */
  model VolumeRequestAzureFileNfsVolumeContent extends VolumeContent {
    /** Represents the type of volume. */
    type: "AzureFileNfs";
  }

  /** VolumeRequestDataDiskVolumeContent wire model. */
  model VolumeRequestDataDiskVolumeContent extends VolumeContent {
    /** Represents the type of volume. */
    type: "DataDisk";

    /** size value. */
    size: StorageQuantity;
  }

  /** Volume wire model. */
  @discriminator("type")
  model Volume {
    /** Represents the type of volume. */
    type: VolumeType;

    /** volumeName value. */
    volumeName: VolumeName;

    /** labels value. */
    labels?: Record<string>;
  }

  /** AzureBlobByoVolume wire model. */
  model AzureBlobByoVolume extends Volume {
    /** Represents the type of volume. */
    type: "AzureBlobByo";

    /** storageContainerResourceId value. */
    storageContainerResourceId: ArmStorageContainerId;

    /** auth value. */
    auth: AzureBlobByoVolumeAuth;
  }

  /** AzureBlobVolume wire model. */
  model AzureBlobVolume extends Volume {
    /** Represents the type of volume. */
    type: "AzureBlob";

    /** usage value. */
    usage?: BlobVolumeUsage;
  }

  /** AzureFileCifsVolume wire model. */
  model AzureFileCifsVolume extends Volume {
    /** Represents the type of volume. */
    type: "AzureFileCifs";
  }

  /** AzureFileNfsVolume wire model. */
  model AzureFileNfsVolume extends Volume {
    /** Represents the type of volume. */
    type: "AzureFileNfs";
  }

  /** DataDiskVolume wire model. */
  model DataDiskVolume extends Volume {
    /** Represents the type of volume. */
    type: "DataDisk";

    /** size value. */
    size: StorageQuantity;

    /** isAttached value. */
    isAttached: boolean;

    /** Resource name of an AKS managed cluster. */
    clusterId?: string;

    /** attachedSandboxId value. */
    attachedSandboxId?: string;

    /** usage value. */
    usage?: DataDiskVolumeUsage;
  }

  /** Represents the type of volume. */
  union VolumeType {
    /** StringValue variant. */
    StringValue: string,

    /** AzureBlob variant. */
    AzureBlob: "AzureBlob",

    /** AzureBlobByo variant. */
    AzureBlobByo: "AzureBlobByo",

    /** AzureFileCifs variant. */
    AzureFileCifs: "AzureFileCifs",

    /** AzureFileNfs variant. */
    AzureFileNfs: "AzureFileNfs",

    /** DataDisk variant. */
    DataDisk: "DataDisk",
  }

  /** VolumeTypeCount wire model. */
  model VolumeTypeCount {
    /** type value. */
    type: VolumeType;

    /** count value. */
    count: int32;
  }
}
