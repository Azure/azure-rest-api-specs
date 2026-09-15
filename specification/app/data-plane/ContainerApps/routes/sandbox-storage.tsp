using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** OK. */
model PostSandboxCommitResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: CommitSandboxResponse;
}

/** Errors returned by postSandboxCommit. */
alias PostSandboxCommitErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<429>
  | ErrorResult<500>;

/** Standard resource operations for committing sandboxes. */
alias SandboxCommitOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxCommitErrors
>;

/** OK. */
model PostSandboxDownloadContentPackageResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;
}

/** Errors returned by postSandboxDownloadContentPackage. */
alias PostSandboxDownloadContentPackageErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** Standard resource operations for downloading sandbox content packages. */
alias SandboxDownloadContentPackageOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxDownloadContentPackageErrors
>;

/** No Content. */
model PostSandboxPodVolumesAdd2Result {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by postSandboxPodVolumesAdd2. */
alias PostSandboxPodVolumesAdd2Errors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** Standard resource operations for adding sandbox pod volumes. */
alias SandboxPodVolumesAddOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxPodVolumesAdd2Errors
>;

/** OK. */
model PostSandboxSnapshotResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Snapshot;
}

/** Errors returned by postSandboxSnapshot. */
alias PostSandboxSnapshotErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<429>
  | ErrorResult<500>;

/** Standard resource operations for snapshotting sandboxes. */
alias SandboxSnapshotOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxSnapshotErrors
>;

/** No Content. */
model PostSandboxVolumeAddResult {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by postSandboxVolumeAdd. */
alias PostSandboxVolumeAddErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** Standard resource operations for adding sandbox volumes. */
alias SandboxVolumeAddOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxVolumeAddErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
@tag("sandboxes")
interface SandboxStorageOperations {
  /** Commits a running sandbox as a new disk image. */
  @summary("Commits a running sandbox as a new disk image.")
  @action("commit")
  @actionSeparator("/")
  postSandboxCommit is SandboxCommitOperations.ResourceAction<
    Sandbox,
    {
      /** Request body. */
      @body body?: CommitSandboxContent;
    },
    PostSandboxCommitResult
  >;

  /** Downloads a content package to a running sandbox. */
  @summary("Downloads a content package to a running sandbox.")
  @action("downloadContentPackage")
  @actionSeparator("/")
  postSandboxDownloadContentPackage is SandboxDownloadContentPackageOperations.ResourceAction<
    Sandbox,
    {
      /** Request body. */
      @body body: DownloadContentPackageToSandboxContent;
    },
    PostSandboxDownloadContentPackageResult
  >;

  /** Adds pod volume mounts to a sandbox. */
  @summary("Adds pod volume mounts to a sandbox.")
  @action("podVolumes/add")
  @actionSeparator("/")
  postSandboxPodVolumesAdd2 is SandboxPodVolumesAddOperations.ResourceAction<
    Sandbox,
    {
      /** Request body. */
      @body body: AddPodVolumeMountsContent;
    },
    PostSandboxPodVolumesAdd2Result
  >;

  /** Takes a snapshot of a running sandbox. */
  @summary("Takes a snapshot of a running sandbox.")
  @action("snapshot")
  @actionSeparator("/")
  postSandboxSnapshot is SandboxSnapshotOperations.ResourceAction<
    Sandbox,
    {
      /** Request body. */
      @body body: CreateSnapshotContent;
    },
    PostSandboxSnapshotResult
  >;

  /** Adds a volume mount to a sandbox. */
  @summary("Adds a volume mount to a sandbox.")
  @action("volumes/add")
  @actionSeparator("/")
  postSandboxVolumeAdd is SandboxVolumeAddOperations.ResourceAction<
    Sandbox,
    {
      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: AddVolumeMountContent;
    },
    PostSandboxVolumeAddResult
  >;
}
