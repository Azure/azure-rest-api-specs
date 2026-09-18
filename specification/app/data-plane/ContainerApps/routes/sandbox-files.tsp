using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** The HTTP 200 response for the deleteSandboxFile operation. */
model DeleteSandboxFileResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned file operation result. */
  @body body: FileOpStatusResponse;
}

/** Error responses for the deleteSandboxFile operation. */
alias DeleteSandboxFileErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult;

/** The HTTP 200 response for the getSandboxFile operation. */
model GetSandboxFileResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The requested file content. */
  @body body: bytes;
}

/** Error responses for the getSandboxFile operation. */
alias GetSandboxFileErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult;

/** The HTTP 200 response for the getSandboxFilesList operation. */
model GetSandboxFilesListResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned directory listing. */
  @body body: DirListingResponse;
}

/** Error responses for the getSandboxFilesList operation. */
alias GetSandboxFilesListErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult;

/** The HTTP 200 response for the getSandboxFileStat operation. */
model GetSandboxFileStatResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned file metadata. */
  @body body: FileInfo;
}

/** Error responses for the getSandboxFileStat operation. */
alias GetSandboxFileStatErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult;

/** The HTTP 200 response for the postSandboxFileMkdir operation. */
model PostSandboxFileMkdirResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned file operation result. */
  @body body: FileOpStatusResponse;
}

/** Error responses for the postSandboxFileMkdir operation. */
alias PostSandboxFileMkdirErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult;

/** Shared operation traits for creating sandbox directories. */
alias SandboxFileMkdirOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxFileMkdirErrors
>;

/** The HTTP 201 response for the postSandboxFile operation. */
model PostSandboxFileResult {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned file write result. */
  @body body: WriteFileResponse;
}

/** Error responses for the postSandboxFile operation. */
alias PostSandboxFileErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | ConflictErrorResult
  | RequestBodyTooLargeErrorResult;

/** Shared operation traits for writing sandbox files. */
alias SandboxFileWriteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostSandboxFileErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The controller uses path query parameters on shared /files routes, streams file content, and returns operation-specific file results."
@tag("sandboxes")
interface SandboxFilesOperations {
  /** Deletes a file or directory in a running sandbox. If the target is a directory, the `recursive` query parameter must be set to true to delete it and its contents. */
  @summary("Deletes a file or directory in a running sandbox. If the target is a directory, the `recursive` query\nparameter must be set to true to delete it and its contents.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/files")
  @delete
  deleteSandboxFile is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The sandbox identifier. */
      @path id: SandboxId;

      /** The file or directory path to delete. */
      @query path: string;

      /** Whether to delete a directory and all of its contents. */
      @query recursive?: boolean;

      /** The target container name. */
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

      /** The sandbox identifier. */
      @path id: SandboxId;

      /** The file path to download. */
      @query path: string;

      /** The target container name. */
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

      /** The sandbox identifier. */
      @path id: SandboxId;

      /** The directory path to list. */
      @query path: string;

      /** The target container name. */
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

      /** The sandbox identifier. */
      @path id: SandboxId;

      /** The file or directory path to inspect. */
      @query path: string;

      /** The target container name. */
      @query containerName?: string;
    },
    GetSandboxFileStatResult,
    DataPlaneStandardTraits,
    GetSandboxFileStatErrors
  >;

  /** Creates a directory in a running sandbox. If the `createParents` property is set to true, any missing parent directories will also be created. */
  @summary("Creates a directory in a running sandbox. If the `createParents` property is set to true,\nany missing parent directories will also be created.")
  @action("files/mkdir")
  @actionSeparator("/")
  postSandboxFileMkdir is SandboxFileMkdirOperations.ResourceAction<
    Sandbox,
    {
      /** The target container name. */
      @query containerName?: string;

      /** The directory path and creation options. */
      @body body: MkDirContent;
    },
    PostSandboxFileMkdirResult
  >;

  /** Writes a file to a running sandbox. The file is streamed directly from the request body. */
  #suppress "@azure-tools/typespec-azure-core/byos" "PUT /sandboxes/{id}/files reads raw file bytes directly from Request.Body."
  @summary("Writes a file to a running sandbox. The file is streamed directly from the request body.")
  @action("files")
  @actionSeparator("/")
  postSandboxFile is SandboxFileWriteOperations.ResourceAction<
    Sandbox,
    {
      /** contentType header. */
      @header contentType: "application/octet-stream";

      /** The file content to upload. */
      @body content: bytes;

      /** The destination file path. */
      @query path: string;

      /** Whether to create missing parent directories. */
      @query createDirs?: boolean;

      /** The Unix mode for the uploaded file. */
      @query mode?: int32;

      /** The target container name. */
      @query containerName?: string;
    },
    PostSandboxFileResult
  >;
}
