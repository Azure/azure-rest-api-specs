namespace ContainerAppsSandbox {
  /** AddPodVolumeMountsContent wire model. */
  model AddPodVolumeMountsContent {
    /** volumes value. */
    volumes: PodVolume[];

    /** containerMounts value. */
    containerMounts: ContainerVolumeMounts[];
  }

  /** AddVolumeMountContent wire model. */
  model AddVolumeMountContent {
    /** volumeMount value. */
    volumeMount: SandboxVolume;
  }

  /** CommitSandboxContent wire model. */
  model CommitSandboxContent {
    /** labels value. */
    labels?: Record<string>;
  }

  /** CommitSandboxResult wire model. */
  model CommitSandboxResult {
    /** diskImage value. */
    diskImage: DiskImage;
  }

  /** Per-container grouping of volume mounts for the add operation. */
  model ContainerVolumeMounts {
    /** containerName value. */
    containerName: PodContainerName;

    /** volumeMounts value. */
    volumeMounts: ContainerVolumeMount[];
  }

  /** DownloadContentPackageToSandboxContent wire model. */
  model DownloadContentPackageToSandboxContent {
    /** contentPackageId value. */
    contentPackageId: ContentPackageId;

    /** targetPath value. */
    targetPath: AbsoluteFilePath;
  }

  /** SnapshotContent wire model. */
  model SnapshotContent {
    /** labels value. */
    labels?: Record<string>;
  }
}
