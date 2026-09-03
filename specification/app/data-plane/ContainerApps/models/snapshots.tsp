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

/** Snapshot wire model. */
model Snapshot {
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

}
