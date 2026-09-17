using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Errors returned by deleteVolume. */
alias DeleteVolumeErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Standard resource operations for deleting volumes. */
alias VolumeDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteVolumeErrors
>;

/** No Content. */
model DeleteVolumeFileResult {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteVolumeFile. */
alias DeleteVolumeFileErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Errors returned by listVolumes. */
alias ListVolumeErrors = UnauthorizedErrorResult | InternalServerErrorResult;

/** Query parameters for listing volumes. */
alias ListVolumeTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;

    /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
    @query labels?: string;
  },
  TraitContext.List
>;

/** Standard resource operations for listing volumes. */
alias VolumeListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListVolumeErrors
>;

/** OK. */
model GetVolumesCountResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumeCountResponse;
}

/** Errors returned by getVolumesCount. */
alias GetVolumesCountErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Errors returned by getVolume. */
alias GetVolumeErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Standard resource operations for reading volumes. */
alias VolumeGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetVolumeErrors
>;

/** OK. */
model GetVolumeFilesResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumeListDirectoryResponse;
}

/** Errors returned by getVolumeFiles. */
alias GetVolumeFilesErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** OK. */
model GetVolumeFileDownloadResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: bytes;
}

/** Errors returned by getVolumeFileDownload. */
alias GetVolumeFileDownloadErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Created. */
model PostVolumeFileMkdirResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: VolumePathItem;
}

/** Errors returned by postVolumeFileMkdir. */
alias PostVolumeFileMkdirErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Standard resource operations for creating volume directories. */
alias VolumeFileMkdirOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostVolumeFileMkdirErrors
>;

/** Created. */
model PostVolumeForkResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: Volume;
}

/** Errors returned by postVolumeFork. */
alias PostVolumeForkErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Standard resource operations for forking volumes. */
alias VolumeForkOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostVolumeForkErrors
>;

/** Created. */
model PutVolumeResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: Volume;
}

/** Errors returned by putVolume. */
alias PutVolumeErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Created. */
model PutVolumeFileResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: VolumePathItem;
}

/** Errors returned by putVolumeFile. */
alias PutVolumeFileErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | PreconditionFailedErrorResult
  | InternalServerErrorResult;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
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

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
      @query path: string;

      /** recursive parameter. */
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

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
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

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
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
      /** path parameter. */
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
      /** Request body. */
      @body body: ForkDataDiskVolumeContent;
    },
    PostVolumeForkResult
  >;

  /** Creates a new volume. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
  @summary("Creates a new volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}")
  @put
  putVolume is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** Request body. */
      @body body: Volume;
    },
    PutVolumeResult,
    DataPlaneStandardTraits,
    PutVolumeErrors
  >;

  /** Upload a file to a volume. */
  #suppress "@azure-tools/typespec-azure-core/byos" "The content is a byte stream, not a BYOS model."
  @summary("Upload a file to a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/upload")
  @put
  createOrReplaceVolumeFile is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** content parameter. */
      @body content: bytes;

      /** path parameter. */
      @query path: string;

      /** overwrite parameter. */
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
