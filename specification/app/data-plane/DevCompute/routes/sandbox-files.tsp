using Http;
using Azure.Core;

namespace AzureDevCompute;

/** OK. */
model DeleteSandboxesFilesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileOpStatusResponse;
}

/** Errors returned by deleteSandboxesFiles. */
alias DeleteSandboxesFilesErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>;

/** OK. */
model GetSandboxesFilesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileStreamResult;
}

/** Errors returned by getSandboxesFiles. */
alias GetSandboxesFilesErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>;

/** OK. */
model GetSandboxesFilesListResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DirListingResponse;
}

/** Errors returned by getSandboxesFilesList. */
alias GetSandboxesFilesListErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>;

/** OK. */
model GetSandboxesFilesStatResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileInfoResponse;
}

/** Errors returned by getSandboxesFilesStat. */
alias GetSandboxesFilesStatErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>;

/** OK. */
model PostSandboxesFilesMkdirResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileOpStatusResponse;
}

/** Errors returned by postSandboxesFilesMkdir. */
alias PostSandboxesFilesMkdirErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>;

/** OK. */
model PutSandboxesFilesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: WriteFileResponse;
}

/** Errors returned by putSandboxesFiles. */
alias PutSandboxesFilesErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<409>
  | ErrorResponse<413>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("sandboxes")
interface SandboxFilesOperations {
  /** Deletes a file or directory in a running sandbox. If the target is a directory, the `recursive` query parameter must be set to true to delete it and its contents. */
  @summary("Deletes a file or directory in a running sandbox. If the target is a directory, the `recursive` query\nparameter must be set to true to delete it and its contents.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
  @delete
  deleteSandboxesFiles is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** path parameter. */
      @query path?: string;

      /** recursive parameter. */
      @query recursive?: boolean;

      /** containerName parameter. */
      @query containerName?: string;
    },
    DeleteSandboxesFilesResponse,
    DataPlaneStandardTraits,
    DeleteSandboxesFilesErrors
  >;

  /** Reads a file from a running sandbox. The file is streamed directly to the response body. */
  @summary("Reads a file from a running sandbox. The file is streamed directly to the response body.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
  @get
  getSandboxesFiles is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** path parameter. */
      @query path?: string;

      /** containerName parameter. */
      @query containerName?: string;
    },
    GetSandboxesFilesResponse,
    DataPlaneStandardTraits,
    GetSandboxesFilesErrors
  >;

  /** Lists the contents of a directory in a running sandbox. The response includes file and directory names, sizes, and metadata. */
  @summary("Lists the contents of a directory in a running sandbox. The response includes file and directory names, sizes,\nand metadata.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/list")
  @get
  getSandboxesFilesList is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** path parameter. */
      @query path?: string;

      /** containerName parameter. */
      @query containerName?: string;
    },
    GetSandboxesFilesListResponse,
    DataPlaneStandardTraits,
    GetSandboxesFilesListErrors
  >;

  /** Gets metadata for a file or directory in a running sandbox, including size, permissions, and timestamps. */
  @summary("Gets metadata for a file or directory in a running sandbox, including size, permissions, and timestamps.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/stat")
  @get
  getSandboxesFilesStat is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** path parameter. */
      @query path?: string;

      /** containerName parameter. */
      @query containerName?: string;
    },
    GetSandboxesFilesStatResponse,
    DataPlaneStandardTraits,
    GetSandboxesFilesStatErrors
  >;

  /** Creates a directory in a running sandbox. If the `createParents` property is set to true, any missing parent directories will also be created. */
  @summary("Creates a directory in a running sandbox. If the `createParents` property is set to true,\nany missing parent directories will also be created.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/mkdir")
  @post
  postSandboxesFilesMkdir is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: MkDirRequest;
    },
    PostSandboxesFilesMkdirResponse,
    DataPlaneStandardTraits,
    PostSandboxesFilesMkdirErrors
  >;

  /** Writes a file to a running sandbox. The file is streamed directly from the request body. */
  @summary("Writes a file to a running sandbox. The file is streamed directly from the request body.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
  @put
  putSandboxesFiles is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** path parameter. */
      @query path?: string;

      /** createDirs parameter. */
      @query createDirs?: boolean;

      /** mode parameter. */
      @query mode?: int32;

      /** containerName parameter. */
      @query containerName?: string;
    },
    PutSandboxesFilesResponse,
    DataPlaneStandardTraits,
    PutSandboxesFilesErrors
  >;
}
