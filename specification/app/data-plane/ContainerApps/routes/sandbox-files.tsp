using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** OK. */
model DeleteSandboxFileResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileOpStatusResult;
}

/** Errors returned by deleteSandboxFile. */
alias DeleteSandboxFileErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>;

/** OK. */
model GetSandboxFileResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileStreamResult;
}

/** Errors returned by getSandboxFile. */
alias GetSandboxFileErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>;

/** OK. */
model GetSandboxFilesListResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DirListingResult;
}

/** Errors returned by getSandboxFilesList. */
alias GetSandboxFilesListErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>;

/** OK. */
model GetSandboxFileStatResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileInfo;
}

/** Errors returned by getSandboxFileStat. */
alias GetSandboxFileStatErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>;

/** OK. */
model PostSandboxFileMkdirResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: FileOpStatusResult;
}

/** Errors returned by postSandboxFileMkdir. */
alias PostSandboxFileMkdirErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>;

/** OK. */
model PutSandboxFileResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: WriteFileResult;
}

/** Errors returned by putSandboxFile. */
alias PutSandboxFileErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<409>
  | ErrorResult<413>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("sandboxes")
interface SandboxFilesOperations {
  /** Deletes a file or directory in a running sandbox. If the target is a directory, the `recursive` query parameter must be set to true to delete it and its contents. */
  @summary("Deletes a file or directory in a running sandbox. If the target is a directory, the `recursive` query\nparameter must be set to true to delete it and its contents.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
  @delete
  deleteSandboxFile is Foundations.Operation<
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
    DeleteSandboxFileResult,
    DataPlaneStandardTraits,
    DeleteSandboxFileErrors
  >;

  /** Reads a file from a running sandbox. The file is streamed directly to the response body. */
  @summary("Reads a file from a running sandbox. The file is streamed directly to the response body.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
  @get
  getSandboxFile is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** path parameter. */
      @query path?: string;

      /** containerName parameter. */
      @query containerName?: string;
    },
    GetSandboxFileResult,
    DataPlaneStandardTraits,
    GetSandboxFileErrors
  >;

  /** Lists the contents of a directory in a running sandbox. The response includes file and directory names, sizes, and metadata. */
  @summary("Lists the contents of a directory in a running sandbox. The response includes file and directory names, sizes,\nand metadata.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/list")
  @get
  getSandboxFilesList is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** path parameter. */
      @query path?: string;

      /** containerName parameter. */
      @query containerName?: string;
    },
    GetSandboxFilesListResult,
    DataPlaneStandardTraits,
    GetSandboxFilesListErrors
  >;

  /** Gets metadata for a file or directory in a running sandbox, including size, permissions, and timestamps. */
  @summary("Gets metadata for a file or directory in a running sandbox, including size, permissions, and timestamps.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/stat")
  @get
  getSandboxFileStat is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** path parameter. */
      @query path?: string;

      /** containerName parameter. */
      @query containerName?: string;
    },
    GetSandboxFileStatResult,
    DataPlaneStandardTraits,
    GetSandboxFileStatErrors
  >;

  /** Creates a directory in a running sandbox. If the `createParents` property is set to true, any missing parent directories will also be created. */
  @summary("Creates a directory in a running sandbox. If the `createParents` property is set to true,\nany missing parent directories will also be created.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files/mkdir")
  @post
  postSandboxFileMkdir is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;

      /** Request body. */
      @body body: MkDirContent;
    },
    PostSandboxFileMkdirResult,
    DataPlaneStandardTraits,
    PostSandboxFileMkdirErrors
  >;

  /** Writes a file to a running sandbox. The file is streamed directly from the request body. */
  #suppress "@azure-tools/typespec-azure-core/byos" "The content is a byte stream, not a BYOS model."
  @summary("Writes a file to a running sandbox. The file is streamed directly from the request body.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
  @put
  putSandboxFile is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** contentType header. */
      @header contentType: "application/octet-stream";

      /** Request body. */
      @body content: bytes;

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
    PutSandboxFileResult,
    DataPlaneStandardTraits,
    PutSandboxFileErrors
  >;
}
