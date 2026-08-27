using Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace AzureDevCompute;

/** OK. */
model PostSandboxesCommitResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: CommitSandboxResponse;
}

/** Errors returned by postSandboxesCommit. */
alias PostSandboxesCommitErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesDownloadContentPackageResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;
}

/** Errors returned by postSandboxesDownloadContentPackage. */
alias PostSandboxesDownloadContentPackageErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** No Content. */
@removed(ApiVersions.v2026_09_01)
model PostSandboxesPodVolumesAddResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by postSandboxesPodVolumesAdd. */
alias PostSandboxesPodVolumesAddErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** No Content. */
@added(ApiVersions.v2026_09_01)
model PostSandboxesPodVolumesAdd2Response {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by postSandboxesPodVolumesAdd2. */
alias PostSandboxesPodVolumesAdd2Errors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model PostSandboxesSnapshotResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SnapshotResponse;
}

/** Errors returned by postSandboxesSnapshot. */
alias PostSandboxesSnapshotErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

/** No Content. */
model PostSandboxesVolumesAddResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by postSandboxesVolumesAdd. */
alias PostSandboxesVolumesAddErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("sandboxes")
interface SandboxStorageOperations {
  /** Commits a running sandbox as a new disk image. */
  @summary("Commits a running sandbox as a new disk image.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/commit")
  @post
  postSandboxesCommit is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body?: CommitSandboxRequest;
    },
    PostSandboxesCommitResponse,
    DataPlaneStandardTraits,
    PostSandboxesCommitErrors
  >;

  /** Downloads a content package to a running sandbox. */
  @summary("Downloads a content package to a running sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/downloadContentPackage")
  @post
  postSandboxesDownloadContentPackage is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: DownloadContentPackageToSandboxRequest;
    },
    PostSandboxesDownloadContentPackageResponse,
    DataPlaneStandardTraits,
    PostSandboxesDownloadContentPackageErrors
  >;

  /** Adds pod volume mounts to a sandbox. */
  @removed(ApiVersions.v2026_09_01)
  @summary("Adds pod volume mounts to a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/pod-volumes/add")
  @post
  postSandboxesPodVolumesAdd is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: AddPodVolumeMountsRequest;
    },
    PostSandboxesPodVolumesAddResponse,
    DataPlaneStandardTraits,
    PostSandboxesPodVolumesAddErrors
  >;

  /** Adds pod volume mounts to a sandbox. */
  @added(ApiVersions.v2026_09_01)
  @summary("Adds pod volume mounts to a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/podVolumes/add")
  @post
  postSandboxesPodVolumesAdd2 is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: AddPodVolumeMountsRequest;
    },
    PostSandboxesPodVolumesAdd2Response,
    DataPlaneStandardTraits,
    PostSandboxesPodVolumesAdd2Errors
  >;

  /** Takes a snapshot of a running sandbox. */
  @summary("Takes a snapshot of a running sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/snapshot")
  @post
  postSandboxesSnapshot is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** Request body. */
      @body body: SnapshotRequest;
    },
    PostSandboxesSnapshotResponse,
    DataPlaneStandardTraits,
    PostSandboxesSnapshotErrors
  >;

  /** Adds a volume mount to a sandbox. */
  @summary("Adds a volume mount to a sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/volumes/add")
  @post
  postSandboxesVolumesAdd is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: AddVolumeMountRequest;
    },
    PostSandboxesVolumesAddResponse,
    DataPlaneStandardTraits,
    PostSandboxesVolumesAddErrors
  >;
}
