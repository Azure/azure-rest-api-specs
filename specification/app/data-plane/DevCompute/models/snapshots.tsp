using TypeSpec.Versioning;

namespace AzureDevCompute;

/** SnapshotGpu wire model. */
@removed(ApiVersions.v2026_09_01)
model SnapshotGpu {
  /** sku value. */
  @removed(ApiVersions.v2026_09_01)
  sku?: string;

  /** quantity value. */
  @removed(ApiVersions.v2026_09_01)
  quantity?: string;
}

/** SnapshotPodContainer wire model. */
model SnapshotPodContainer {
  /** name value. */
  name: PodContainerName;

  /** diskImageId value. */
  diskImageId: DiskImageId;
}

/** SnapshotResources wire model. */
model SnapshotResources {
  /** cpu value. */
  cpu?: CpuQuantity;

  /** memory value. */
  memory?: MemoryQuantity;

  /** disk value. */
  disk?: StorageQuantity;

  /** gpu value. */
  @removed(ApiVersions.v2026_09_01)
  gpu?: SnapshotGpu;
}

/** SnapshotResponse wire model. */
model SnapshotResponse {
  /** id value. */
  id: string;

  /** labels value. */
  labels?: Record<string>;

  /** sandboxId value. */
  sandboxId?: SandboxId;

  /** createdAtUtc value. */
  createdAtUtc: utcDateTime;

  /** resources value. */
  resources?: SnapshotResources;

  /** sourcePodContainers value. */
  sourcePodContainers?: SnapshotPodContainer[];

  /** sizeInMB value. */
  @encodedName("application/json", "sizeInMB")
  sizeInMb?: MegaBytes;

  /** vmmType value. */
  @removed(ApiVersions.v2026_09_01)
  vmmType?: VmmType;
}
