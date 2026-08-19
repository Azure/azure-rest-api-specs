using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

model AddPodVolumeMountsRequest {
  volumes: null | PodVolumeView[];
  containerMounts: ContainerVolumeMountsView[];
}

model AddVolumeMountRequest {
  volumeMount: SandboxVolumeView;
}

/** ARM resource ID for an Azure Storage blob container. */
scalar ArmStorageContainerId;

/**
 * Authentication for a bring-your-own (BYO) Azure Blob container volume:
 * how ADC obtains credentials to access the customer-owned container.
 */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union AzureBlobByoVolumeAuth {
  ManagedIdentity: AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth,
}

/**
 * Managed-identity authentication for a BYO blob volume. ADC accesses the
 * container with a managed identity already on the sandbox group.
 */
model AzureBlobByoVolumeAuthAzureBlobByoIdentityAuth {
  kind?: "ManagedIdentity";
  identity: SandboxGroupIdentitySelector;
}

/** A strongly-typed blob URI (with or without SAS token). */
scalar BlobUri;

model BlobVolumeUsageView {
  usedBytes: Bytes;
  itemCount: Int64OrString;
  calculatedAtUtc: utcDateTime;
}

/** Per-container volume mount specifying which volume to mount and where. */
model ContainerVolumeMountView {
  name: VolumeName;
  mountPath: AbsoluteDirectoryPath;
  readOnly?: boolean;
}

/** Per-container grouping of volume mounts for the add operation. */
model ContainerVolumeMountsView {
  containerName: PodContainerName;
  volumeMounts: ContainerVolumeMountView[];
}

model DataDiskVolumeUsageView {
  compressedBlobSizeBytes: Bytes;
  usedSizeBytes: Bytes;
  lastUploadedAtUtc: utcDateTime;
}

model ForkDataDiskVolumeRequestView {
  destinationVolumeName: VolumeName;
  labels?: null | Record<string>;
}

/**
 * Pod-level volume declaration. Declares a named volume source that can be referenced
 * by containers via GlobalContainerVolumeMountView.
 */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union PodVolumeView {
  AzureBlob: PodVolumeViewAzureBlobPodVolumeView,
  AzureBlobByo: PodVolumeViewAzureBlobByoPodVolumeView,
  Local: PodVolumeViewLocalPodVolumeView,
  DataDisk: PodVolumeViewDataDiskPodVolumeView,
}

/**
 * Bring-your-own (BYO) Azure Blob container volume source,
 * backed by blobfuse2.
 */
model PodVolumeViewAzureBlobByoPodVolumeView {
  kind?: "AzureBlobByo";
  fileCacheSizeLimit: StorageQuantity;
  readOnly?: boolean;
  name: VolumeName;
}

/** Azure Blob Storage volume source, backed by blobfuse2. */
model PodVolumeViewAzureBlobPodVolumeView {
  kind?: "AzureBlob";
  fileCacheSizeLimit: StorageQuantity;
  readOnly?: boolean;
  name: VolumeName;
}

/** Data disk volume source backed by a persistent ext4 block device in cluster storage. */
model PodVolumeViewDataDiskPodVolumeView {
  kind?: "DataDisk";
  name: VolumeName;
}

/** Local volume source backed by rootfs space. */
model PodVolumeViewLocalPodVolumeView {
  kind?: "Local";
  size: StorageQuantity;
  name: VolumeName;
}

/** Volume configuration for a sandbox. */
model SandboxVolumeView {
  volumeName: VolumeName;
  mountpoint: AbsoluteDirectoryPath;
  readOnly?: boolean;
}

/** Kubernetes-style storage/disk resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
scalar StorageQuantity;

model VolumeCountResponseView {
  counts: VolumeTypeCount[];
}

scalar VolumeItemName;

model VolumeListDirectoryResponseView {
  path: VolumePath;
  items: VolumePathItemView[];
}

scalar VolumeName;

scalar VolumePath;

model VolumePathItemView {
  itemName: VolumeItemName;
  path: VolumePath;
  isDirectory: boolean;
  @oneOf sizeBytes: null | Bytes;
  lastModifiedUtc: null | utcDateTime;
  contentType: null | string;

  /**
   * An HTTP entity tag used for optimistic concurrency,
   * as defined by RFC 9110.
   */
  eTag?: unknown;
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union VolumeRequestView {
  AzureBlob: VolumeRequestViewAzureBlobVolumeRequestView,
  AzureBlobByo: VolumeRequestViewAzureBlobByoVolumeRequestView,
  AzureFileCifs: VolumeRequestViewAzureFileCifsVolumeRequestView,
  AzureFileNfs: VolumeRequestViewAzureFileNfsVolumeRequestView,
  DataDisk: VolumeRequestViewDataDiskVolumeRequestView,
}

model VolumeRequestViewAzureBlobByoVolumeRequestView {
  /** Represents the type of volume. */
  type?: "AzureBlobByo";

  storageContainerResourceId: ArmStorageContainerId;
  auth: AzureBlobByoVolumeAuth;
  labels?: null | Record<string>;
}

model VolumeRequestViewAzureBlobVolumeRequestView {
  /** Represents the type of volume. */
  type?: "AzureBlob";

  labels?: null | Record<string>;
}

model VolumeRequestViewAzureFileCifsVolumeRequestView {
  /** Represents the type of volume. */
  type?: "AzureFileCifs";

  labels?: null | Record<string>;
}

model VolumeRequestViewAzureFileNfsVolumeRequestView {
  /** Represents the type of volume. */
  type?: "AzureFileNfs";

  labels?: null | Record<string>;
}

model VolumeRequestViewDataDiskVolumeRequestView {
  /** Represents the type of volume. */
  type?: "DataDisk";

  size: StorageQuantity;
  labels?: null | Record<string>;
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union VolumeResponseView {
  AzureBlob: VolumeResponseViewAzureBlobVolumeResponseView,
  AzureBlobByo: VolumeResponseViewAzureBlobByoVolumeResponseView,
  AzureFileCifs: VolumeResponseViewAzureFileCifsVolumeResponseView,
  AzureFileNfs: VolumeResponseViewAzureFileNfsVolumeResponseView,
  DataDisk: VolumeResponseViewDataDiskVolumeResponseView,
}

model VolumeResponseViewAzureBlobByoVolumeResponseView {
  /** Represents the type of volume. */
  type?: "AzureBlobByo";

  storageContainerResourceId: ArmStorageContainerId;
  auth: AzureBlobByoVolumeAuth;
  volumeName: VolumeName;
  labels?: null | Record<string>;
}

model VolumeResponseViewAzureBlobVolumeResponseView {
  /** Represents the type of volume. */
  type?: "AzureBlob";

  @oneOf usage?: null | BlobVolumeUsageView;
  volumeName: VolumeName;
  labels?: null | Record<string>;
}

model VolumeResponseViewAzureFileCifsVolumeResponseView {
  /** Represents the type of volume. */
  type?: "AzureFileCifs";

  volumeName: VolumeName;
  labels?: null | Record<string>;
}

model VolumeResponseViewAzureFileNfsVolumeResponseView {
  /** Represents the type of volume. */
  type?: "AzureFileNfs";

  volumeName: VolumeName;
  labels?: null | Record<string>;
}

model VolumeResponseViewDataDiskVolumeResponseView {
  /** Represents the type of volume. */
  type?: "DataDisk";

  size: StorageQuantity;
  isAttached: boolean;

  /** Resource name of an AKS managed cluster. */
  clusterId?: unknown;

  attachedSandboxId?: unknown;
  @oneOf usage?: null | DataDiskVolumeUsageView;
  volumeName: VolumeName;
  labels?: null | Record<string>;
}

/** Represents the type of volume. */
union VolumeType {
  "AzureBlob",
  "AzureBlobByo",
  "AzureFileCifs",
  "AzureFileNfs",
  "DataDisk",
}

model VolumeTypeCount {
  type: VolumeType;
  count: Int32OrString;
}
