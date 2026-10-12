namespace ContainerAppsSandbox {
  /** Pod volumes and container mounts to add to a sandbox. */
  model AddPodVolumeMountsContent {
    /** The pod-level volume definitions. */
    volumes: PodVolume[];

    /** Volume mounts grouped by container. */
    containerMounts: ContainerVolumeMounts[];
  }

  /** A data volume mount to add to a sandbox. */
  model AddVolumeMountContent {
    /** The volume and mount path to add. */
    volumeMount: SandboxVolume;
  }

  /** Options for creating a disk image from a sandbox. */
  model CommitSandboxContent {
    /** Labels to assign to the new disk image. */
    labels?: Record<string>;
  }

  /** Disk image created from a running sandbox. */
  model CommitSandboxResponse {
    /** The disk image created from the sandbox. */
    diskImage: DiskImage;
  }

  /** Per-container grouping of volume mounts for the add operation. */
  model ContainerVolumeMounts {
    /** The container that receives the mounts. */
    containerName: PodContainerName;

    /** The volume mounts to add to the container. */
    volumeMounts: ContainerVolumeMount[];
  }

  /** A content package to download into a sandbox. */
  model DownloadContentPackageToSandboxContent {
    /** The content package identifier. */
    contentPackageId: ContentPackageId;

    /** The destination file path in the sandbox. */
    targetPath: AbsoluteFilePath;
  }
}
