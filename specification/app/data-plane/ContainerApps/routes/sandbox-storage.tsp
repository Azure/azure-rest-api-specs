using Http;
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

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("sandboxes")
interface SandboxStorageOperations {
  /** Commits a running sandbox as a new disk image. */
  @summary("Commits a running sandbox as a new disk image.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/commit")
  @post
  postSandboxCommit is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body?: CommitSandboxContent;
    },
    PostSandboxCommitResult,
    DataPlaneStandardTraits,
    PostSandboxCommitErrors
  >;

  /** Downloads a content package to a running sandbox. */
  @summary("Downloads a content package to a running sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/downloadContentPackage")
  @post
  postSandboxDownloadContentPackage is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: DownloadContentPackageToSandboxContent;
    },
    PostSandboxDownloadContentPackageResult,
    DataPlaneStandardTraits,
    PostSandboxDownloadContentPackageErrors
  >;

  /** Adds pod volume mounts to a sandbox. */
  @summary("Adds pod volume mounts to a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/podVolumes/add")
  @post
  postSandboxPodVolumesAdd2 is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: AddPodVolumeMountsContent;
    },
    PostSandboxPodVolumesAdd2Result,
    DataPlaneStandardTraits,
    PostSandboxPodVolumesAdd2Errors
  >;

  /** Takes a snapshot of a running sandbox. */
  @summary("Takes a snapshot of a running sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/snapshot")
  @post
  postSandboxSnapshot is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: CreateSnapshotContent;
    },
    PostSandboxSnapshotResult,
    DataPlaneStandardTraits,
    PostSandboxSnapshotErrors
  >;

  /** Adds a volume mount to a sandbox. */
  @summary("Adds a volume mount to a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/volumes/add")
  @post
  postSandboxVolumeAdd is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: AddVolumeMountContent;
    },
    PostSandboxVolumeAddResult,
    DataPlaneStandardTraits,
    PostSandboxVolumeAddErrors
  >;
}
