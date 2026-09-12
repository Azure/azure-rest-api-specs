namespace ContainerAppsSandbox;

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
}

/** Request body for creating a snapshot. */
model CreateSnapshotContent {
  /** Customer-defined labels. */
  labels?: Record<string>;
}

/** Customer-facing snapshot resource returned by the service. */
model Snapshot {
  /** Snapshot identifier assigned by the service. */
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
  sizeInMb?: MegaBytes;
}
