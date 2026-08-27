namespace AzureDevCompute {
  /** AddPodVolumeMountsRequest wire model. */
  model AddPodVolumeMountsRequest {
    /** volumes value. */
    volumes: PodVolume[];

    /** containerMounts value. */
    containerMounts: ContainerVolumeMounts[];
  }

  /** AddVolumeMountRequest wire model. */
  model AddVolumeMountRequest {
    /** volumeMount value. */
    volumeMount: SandboxVolume;
  }

  /** CommitSandboxRequest wire model. */
  model CommitSandboxRequest {
    /** labels value. */
    labels?: Record<string>;
  }

  /** CommitSandboxResponse wire model. */
  model CommitSandboxResponse {
    /** diskImage value. */
    diskImage: DiskImageResponse;
  }

  /** Per-container grouping of volume mounts for the add operation. */
  model ContainerVolumeMounts {
    /** containerName value. */
    containerName: PodContainerName;

    /** volumeMounts value. */
    volumeMounts: ContainerVolumeMount[];
  }

  /** DownloadContentPackageToSandboxRequest wire model. */
  model DownloadContentPackageToSandboxRequest {
    /** contentPackageId value. */
    contentPackageId: ContentPackageId;

    /** targetPath value. */
    targetPath: AbsoluteFilePath;
  }

  /** SnapshotRequest wire model. */
  model SnapshotRequest {
    /** labels value. */
    labels?: Record<string>;
  }
}
