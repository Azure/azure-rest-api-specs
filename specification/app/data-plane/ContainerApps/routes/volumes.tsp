using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** No Content. */
model DeleteVolumeResult {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteVolume. */
alias DeleteVolumeErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** No Content. */
model DeleteVolumeFileResult {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteVolumeFile. */
alias DeleteVolumeFileErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model ListVolumeResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Volume[];
}

/** Errors returned by listVolumes. */
alias ListVolumeErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetVolumesCountResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumeCountResult;
}

/** Errors returned by getVolumesCount. */
alias GetVolumesCountErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetVolumeResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Volume;
}

/** Errors returned by getVolume. */
alias GetVolumeErrors = ErrorResult<401> | ErrorResult<404> | ErrorResult<500>;

/** OK. */
model GetVolumeFilesResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumeListDirectoryResult;
}

/** Errors returned by getVolumeFiles. */
alias GetVolumeFilesErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model GetVolumeFileDownloadResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileStreamResult;
}

/** Errors returned by getVolumeFileDownload. */
alias GetVolumeFileDownloadErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Created. */
model PostVolumeFileMkdirResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: VolumePathItem;
}

/** Errors returned by postVolumeFileMkdir. */
alias PostVolumeFileMkdirErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Created. */
model PostVolumeForkResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: Volume;
}

/** Errors returned by postVolumeFork. */
alias PostVolumeForkErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<500>;

/** Created. */
model PutVolumeResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: Volume;
}

/** Errors returned by putVolume. */
alias PutVolumeErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model PutVolumeFileUploadResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumePathItem;
}

/** Errors returned by putVolumeFileUpload. */
alias PutVolumeFileUploadErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<412>
  | ErrorResult<500>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("volumes")
interface VolumesOperations {
  /** Deletes a volume by name. */
  @summary("Deletes a volume by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}")
  @delete
  deleteVolume is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;
    },
    DeleteVolumeResult,
    DataPlaneStandardTraits,
    DeleteVolumeErrors
  >;

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
      @query path?: string;

      /** recursive parameter. */
      @query recursive?: boolean;
    },
    DeleteVolumeFileResult,
    DataPlaneStandardTraits,
    DeleteVolumeFileErrors
  >;

  /** Lists volumes with pagination support. */
  @summary("Lists volumes with pagination support.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes")
  @get
  listVolumes is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Page number to retrieve. */
      @query("Page") page?: int32;

      /** Number of items to return per page. */
      @query("PageSize") pageSize?: int32;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    ListVolumeResult,
    DataPlaneStandardTraits,
    ListVolumeErrors
  >;

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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}")
  @get
  getVolume is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;
    },
    GetVolumeResult,
    DataPlaneStandardTraits,
    GetVolumeErrors
  >;

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
      @query path?: string;
    },
    GetVolumeFileDownloadResult,
    DataPlaneStandardTraits,
    GetVolumeFileDownloadErrors
  >;

  /** Create a directory within a volume. */
  @summary("Create a directory within a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/mkdir")
  @post
  postVolumeFileMkdir is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
      @query path?: string;
    },
    PostVolumeFileMkdirResult,
    DataPlaneStandardTraits,
    PostVolumeFileMkdirErrors
  >;

  /** Forks a data disk volume. */
  @summary("Forks a data disk volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/fork")
  @post
  postVolumeFork is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** Request body. */
      @body body: ForkDataDiskVolumeContent;
    },
    PostVolumeForkResult,
    DataPlaneStandardTraits,
    PostVolumeForkErrors
  >;

  /** Creates a new volume. */
  @summary("Creates a new volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}")
  @put
  putVolume is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** Request body. */
      @body body: VolumeContent;
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
  putVolumeFileUpload is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** contentType parameter. */
      @header contentType: "application/octet-stream";

      /** content parameter. */
      @body content: bytes;

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
      @query path?: string;

      /** overwrite parameter. */
      @query overwrite?: boolean;
    },
    PutVolumeFileUploadResult,
    DataPlaneStandardTraits,
    PutVolumeFileUploadErrors
  >;
}
