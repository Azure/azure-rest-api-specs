using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** The HTTP 200 response for the postSandboxCommit operation. */
model PostSandboxCommitResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned created disk image. */
  @body body: CommitSandboxResponse;
}

/** Error responses for the postSandboxCommit operation. */
alias PostSandboxCommitErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | TooManyRequestsErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for committing sandboxes. */
alias SandboxCommitOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxCommitErrors
>;

/** The HTTP 200 response for the postSandboxDownloadContentPackage operation. */
model PostSandboxDownloadContentPackageResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;
}

/** Error responses for the postSandboxDownloadContentPackage operation. */
alias PostSandboxDownloadContentPackageErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for downloading sandbox content packages. */
alias SandboxDownloadContentPackageOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxDownloadContentPackageErrors
>;

/** The HTTP 204 response for the postSandboxPodVolumesAdd2 operation. */
model PostSandboxPodVolumesAdd2Result {
  /** The HTTP 204 status code. */
  @statusCode statusCode: 204;
}

/** Error responses for the postSandboxPodVolumesAdd2 operation. */
alias PostSandboxPodVolumesAdd2Errors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for adding sandbox pod volumes. */
alias SandboxPodVolumesAddOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxPodVolumesAdd2Errors
>;

/** The HTTP 200 response for the postSandboxSnapshot operation. */
model PostSandboxSnapshotResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned snapshot. */
  @body body: Snapshot;
}

/** Error responses for the postSandboxSnapshot operation. */
alias PostSandboxSnapshotErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | TooManyRequestsErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for snapshotting sandboxes. */
alias SandboxSnapshotOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxSnapshotErrors
>;

/** The HTTP 204 response for the postSandboxVolumeAdd operation. */
model PostSandboxVolumeAddResult {
  /** The HTTP 204 status code. */
  @statusCode statusCode: 204;
}

/** Error responses for the postSandboxVolumeAdd operation. */
alias PostSandboxVolumeAddErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for adding sandbox volumes. */
alias SandboxVolumeAddOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxVolumeAddErrors
>;

@tag("sandboxes")
interface SandboxStorageOperations {
  /** Commits a running sandbox as a new disk image. */
  @summary("Commits a running sandbox as a new disk image.")
  @action("commit")
  @actionSeparator("/")
  postSandboxCommit is SandboxCommitOperations.ResourceAction<
    Sandbox,
    {
      /** Optional labels for the new disk image. */
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
      /** The content package and destination path. */
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
      /** The pod volumes and container mounts to add. */
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
      /** Labels for the new snapshot. */
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
      /** The container that receives the mount. */
      @query containerName?: string;

      /** The volume mount to add. */
      @body body: AddVolumeMountContent;
    },
    PostSandboxVolumeAddResult
  >;
}
