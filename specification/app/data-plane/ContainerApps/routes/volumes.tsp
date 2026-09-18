using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Error responses for the deleteVolume operation. */
alias DeleteVolumeErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for deleting volumes. */
alias VolumeDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteVolumeErrors
>;

/** The HTTP 204 response for the deleteVolumeFile operation. */
model DeleteVolumeFileResult {
  /** The HTTP 204 status code. */
  @statusCode statusCode: 204;
}

/** Error responses for the deleteVolumeFile operation. */
alias DeleteVolumeFileErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Error responses for the listVolume operation. */
alias ListVolumeErrors = UnauthorizedErrorResult | InternalServerErrorResult;

/** Query parameters for listing volumes. */
alias ListVolumeTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;

    /** Comma-separated key=value labels that all resources must match. */
    @query labels?: string;
  },
  TraitContext.List
>;

/** Shared operation traits for listing volumes. */
alias VolumeListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListVolumeErrors
>;

/** The HTTP 200 response for the getVolumesCount operation. */
model GetVolumesCountResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned volume count. */
  @body body: VolumeCountResponse;
}

/** Error responses for the getVolumesCount operation. */
alias GetVolumesCountErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Error responses for the getVolume operation. */
alias GetVolumeErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for reading volumes. */
alias VolumeGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetVolumeErrors
>;

/** The HTTP 200 response for the getVolumeFiles operation. */
model GetVolumeFilesResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned directory listing. */
  @body body: VolumeListDirectoryResponse;
}

/** Error responses for the getVolumeFiles operation. */
alias GetVolumeFilesErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** The HTTP 200 response for the getVolumeFileDownload operation. */
model GetVolumeFileDownloadResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The requested file content. */
  @body body: bytes;
}

/** Error responses for the getVolumeFileDownload operation. */
alias GetVolumeFileDownloadErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** The HTTP 201 response for the postVolumeFileMkdir operation. */
model PostVolumeFileMkdirResult {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned file or directory metadata. */
  @body body: VolumePathItem;
}

/** Error responses for the postVolumeFileMkdir operation. */
alias PostVolumeFileMkdirErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for creating volume directories. */
alias VolumeFileMkdirOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostVolumeFileMkdirErrors
>;

/** The HTTP 201 response for the postVolumeFork operation. */
model PostVolumeForkResult {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned volume. */
  @body body: Volume;
}

/** Error responses for the postVolumeFork operation. */
alias PostVolumeForkErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for creating volume forks. */
alias VolumeForkOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostVolumeForkErrors
>;

/** The HTTP 201 response for the putVolume operation. */
model PutVolumeResult {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned volume. */
  @body body: Volume;
}

/** Error responses for the putVolume operation. */
alias PutVolumeErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** The HTTP 201 response for the putVolumeFile operation. */
model PutVolumeFileResult {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned file or directory metadata. */
  @body body: VolumePathItem;
}

/** Error responses for the putVolumeFile operation. */
alias PutVolumeFileErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | PreconditionFailedErrorResult
  | InternalServerErrorResult;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The controller exposes /count, /fork, and file subroutes with streamed content, query paths, and operation-specific statuses."
@tag("volumes")
interface VolumesOperations {
  /** Deletes a volume by name. */
  @summary("Deletes a volume by name.")
  deleteVolume is VolumeDeleteOperations.ResourceDelete<Volume>;

  /** Delete a file or directory from a volume. */
  @summary("Delete a file or directory from a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files")
  @delete
  deleteVolumeFile is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The volume name. */
      @path volumeName: string;

      /** The file or directory path to delete. */
      @query path: string;

      /** Whether to delete a directory and all of its contents. */
      @query recursive?: boolean;
    },
    DeleteVolumeFileResult,
    DataPlaneStandardTraits,
    DeleteVolumeFileErrors
  >;

  /** Lists volumes with pagination support. */
  @summary("Lists volumes with pagination support.")
  listVolumes is VolumeListOperations.ResourceList<Volume, ListVolumeTraits>;

  /** Gets the count of volumes, grouped by volume type. */
  @summary("Gets the count of volumes, grouped by volume type.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/count")
  @get
  getVolumesCount is Foundations.Operation<
    {
      ...AzureResourceScope;
    },
    GetVolumesCountResult,
    DataPlaneStandardTraits,
    GetVolumesCountErrors
  >;

  /** Gets a specific volume by name. */
  @summary("Gets a specific volume by name.")
  getVolume is VolumeGetOperations.ResourceRead<Volume>;

  /** List directory contents within a volume. */
  @summary("List directory contents within a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files")
  @get
  getVolumeFiles is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The volume name. */
      @path volumeName: string;

      /** The directory path to list. */
      @query path?: string;
    },
    GetVolumeFilesResult,
    DataPlaneStandardTraits,
    GetVolumeFilesErrors
  >;

  /** Download a file from a volume. */
  @summary("Download a file from a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/download")
  @get
  getVolumeFileDownload is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The volume name. */
      @path volumeName: string;

      /** The file path to download. */
      @query path: string;
    },
    GetVolumeFileDownloadResult,
    DataPlaneStandardTraits,
    GetVolumeFileDownloadErrors
  >;

  /** Create a directory within a volume. */
  @summary("Create a directory within a volume.")
  @action("files/mkdir")
  @actionSeparator("/")
  postVolumeFileMkdir is VolumeFileMkdirOperations.ResourceAction<
    Volume,
    {
      /** The directory path to create. */
      @query path: string;
    },
    PostVolumeFileMkdirResult
  >;

  /** Forks a data disk volume. */
  @summary("Forks a data disk volume.")
  @action("fork")
  @actionSeparator("/")
  postVolumeFork is VolumeForkOperations.ResourceAction<
    Volume,
    {
      /** The destination name and labels for the forked volume. */
      @body body: ForkDataDiskVolumeContent;
    },
    PostVolumeForkResult
  >;

  /** Creates a new volume. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "The existing client method mirrors PUT /volumes/{volumeName} and is intentionally named putVolume."
  @summary("Creates a new volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}")
  @put
  putVolume is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The volume name. */
      @path volumeName: string;

      /** The volume configuration to create. */
      @body body: Volume;
    },
    PutVolumeResult,
    DataPlaneStandardTraits,
    PutVolumeErrors
  >;

  /** Upload a file to a volume. */
  #suppress "@azure-tools/typespec-azure-core/byos" "PUT /volumes/{volumeName}/files/upload reads raw file bytes directly from Request.Body."
  @summary("Upload a file to a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/upload")
  @put
  createOrReplaceVolumeFile is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The volume name. */
      @path volumeName: string;

      /** The file content to upload. */
      @body content: bytes;

      /** The destination file path. */
      @query path: string;

      /** Whether to replace an existing file. */
      @query overwrite?: boolean;

      /** Entity tag required for the request to be applied. */
      @header("If-Match") ifMatch?: string;

      /** Entity tag required for the request to be applied when no current representation exists. */
      @header("If-None-Match") ifNoneMatch?: string;
    },
    PutVolumeFileResult,
    DataPlaneStandardTraits,
    PutVolumeFileErrors
  >;
}
