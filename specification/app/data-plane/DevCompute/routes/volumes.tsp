using Http;
using Azure.Core;

namespace AzureDevCompute;

/** No Content. */
model DeleteVolumesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteVolumes. */
alias DeleteVolumesErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** No Content. */
model DeleteVolumesFilesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Errors returned by deleteVolumesFiles. */
alias DeleteVolumesFilesErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model ListVolumeResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumeResponse[];
}

/** Errors returned by listVolumes. */
alias ListVolumeErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetVolumesCountResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumeCountResponse;
}

/** Errors returned by getVolumesCount. */
alias GetVolumesCountErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetVolumeResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumeResponse;
}

/** Errors returned by getVolumes. */
alias GetVolumeErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model GetVolumesFilesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumeListDirectoryResponse;
}

/** Errors returned by getVolumesFiles. */
alias GetVolumesFilesErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model GetVolumesFilesDownloadResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileStreamResult;
}

/** Errors returned by getVolumesFilesDownload. */
alias GetVolumesFilesDownloadErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** Created. */
model PostVolumesFilesMkdirResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: VolumePathItem;
}

/** Errors returned by postVolumesFilesMkdir. */
alias PostVolumesFilesMkdirErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** Created. */
model PostVolumesForkResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: VolumeResponse;
}

/** Errors returned by postVolumesFork. */
alias PostVolumesForkErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** Created. */
model PutVolumesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: VolumeResponse;
}

/** Errors returned by putVolumes. */
alias PutVolumesErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model PutVolumesFilesUploadResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: VolumePathItem;
}

/** Errors returned by putVolumesFilesUpload. */
alias PutVolumesFilesUploadErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | ErrorResponse<412>
  | InternalServerErrorNoBody;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("volumes")
interface VolumesOperations {
  /** Deletes a volume by name. */
  @summary("Deletes a volume by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}")
  @delete
  deleteVolumes is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;
    },
    DeleteVolumesResponse,
    DataPlaneStandardTraits,
    DeleteVolumesErrors
  >;

  /** Delete a file or directory from a volume. */
  @summary("Delete a file or directory from a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files")
  @delete
  deleteVolumesFiles is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
      @query path?: string;

      /** recursive parameter. */
      @query recursive?: boolean;
    },
    DeleteVolumesFilesResponse,
    DataPlaneStandardTraits,
    DeleteVolumesFilesErrors
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
    ListVolumeResponse,
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
    GetVolumesCountResponse,
    DataPlaneStandardTraits,
    GetVolumesCountErrors
  >;

  /** Gets a specific volume by name. */
  @summary("Gets a specific volume by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}")
  @get
  getVolumes is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;
    },
    GetVolumeResponse,
    DataPlaneStandardTraits,
    GetVolumeErrors
  >;

  /** List directory contents within a volume. */
  @summary("List directory contents within a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files")
  @get
  getVolumesFiles is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
      @query path?: string;
    },
    GetVolumesFilesResponse,
    DataPlaneStandardTraits,
    GetVolumesFilesErrors
  >;

  /** Download a file from a volume. */
  @summary("Download a file from a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/download")
  @get
  getVolumesFilesDownload is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
      @query path?: string;
    },
    GetVolumesFilesDownloadResponse,
    DataPlaneStandardTraits,
    GetVolumesFilesDownloadErrors
  >;

  /** Create a directory within a volume. */
  @summary("Create a directory within a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/mkdir")
  @post
  postVolumesFilesMkdir is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
      @query path?: string;
    },
    PostVolumesFilesMkdirResponse,
    DataPlaneStandardTraits,
    PostVolumesFilesMkdirErrors
  >;

  /** Forks a data disk volume. */
  @summary("Forks a data disk volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/fork")
  @post
  postVolumesFork is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** Request body. */
      @body body: ForkDataDiskVolumeRequest;
    },
    PostVolumesForkResponse,
    DataPlaneStandardTraits,
    PostVolumesForkErrors
  >;

  /** Creates a new volume. */
  @summary("Creates a new volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}")
  @put
  putVolumes is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** Request body. */
      @body body: VolumeRequest;
    },
    PutVolumesResponse,
    DataPlaneStandardTraits,
    PutVolumesErrors
  >;

  /** Upload a file to a volume. */
  @summary("Upload a file to a volume.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/volumes/{volumeName}/files/upload")
  @put
  putVolumesFilesUpload is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** volumeName parameter. */
      @path volumeName: string;

      /** path parameter. */
      @query path?: string;

      /** overwrite parameter. */
      @query overwrite?: boolean;
    },
    PutVolumesFilesUploadResponse,
    DataPlaneStandardTraits,
    PutVolumesFilesUploadErrors
  >;
}
