#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Response identifies a JSON response body; Result is reserved for HTTP response envelopes."
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

  /** Commit-sandbox response body. */
  model CommitSandboxResponse {
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
}
