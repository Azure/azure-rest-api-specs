using Rest;

namespace ContainerAppsSandbox;

/** Response containing the total number of snapshots in a scope. */
model SnapshotCountResponse is CountResponse;

/** A container captured in a sandbox snapshot. */
model SnapshotPodContainer {
  /** The container name. */
  name: PodContainerName;

  /** The disk image created for the container. */
  diskImageId: DiskImageId;
}

/** Resources captured in a sandbox snapshot. */
model SnapshotResources {
  /** The captured CPU allocation. */
  cpu?: CpuQuantity;

  /** The captured memory allocation. */
  memory?: MemoryQuantity;

  /** The captured disk allocation. */
  disk?: StorageQuantity;
}

/** Request body for creating a snapshot. */
model CreateSnapshotContent {
  /** Customer-defined labels. */
  labels?: Record<string>;
}

/** Customer-facing snapshot resource returned by the service. */
@resource("snapshots")
@parentResource(SandboxGroupScope)
model Snapshot {
  /** Snapshot identifier assigned by the service. */
  @key("id")
  @visibility(Lifecycle.Read)
  id: string;

  /** Customer-defined labels. */
  labels?: Record<string>;

  /** Source sandbox identifier assigned by the service. */
  @visibility(Lifecycle.Read)
  sandboxId?: SandboxId;

  /** Creation timestamp assigned by the service. */
  @visibility(Lifecycle.Read)
  createdAtUtc: utcDateTime;

  /** Captured resources assigned by the service. */
  @visibility(Lifecycle.Read)
  resources?: SnapshotResources;

  /** Captured pod containers assigned by the service. */
  @visibility(Lifecycle.Read)
  sourcePodContainers?: SnapshotPodContainer[];

  /** Snapshot size assigned by the service. */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "sizeInMB")
  sizeInMb?: int64;
}
