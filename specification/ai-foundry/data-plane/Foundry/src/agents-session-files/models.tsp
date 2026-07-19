using TypeSpec.Http;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Request parameter models
// ---------------------------------------------------------------------------

// Parameters for uploading a file to a session sandbox
alias UploadSessionFileParams = {
  /** The name of the agent. */
  @path agent_name: string;

  /** The session ID. */
  @path agent_session_id: string;

  /** The destination file path within the sandbox, relative to the session home directory. */
  @query path: string;

  /** The binary file content to upload. */
  @header("Content-Type") contentType: "application/octet-stream";

  @body content: bytes;
};

// Parameters for downloading a file from a session sandbox
alias DownloadSessionFileParams = {
  /** The name of the agent. */
  @path agent_name: string;

  /** The session ID. */
  @path agent_session_id: string;

  /** The file path to download from the sandbox, relative to the session home directory. */
  @query path: string;
};

// Parameters for listing files in a session sandbox
alias ListSessionFilesParams = {
  /** The name of the agent. */
  @path agent_name: string;

  /** The session ID. */
  @path agent_session_id: string;

  /** The directory path to list, relative to the session home directory. Defaults to the home directory if not provided. */
  @query path?: string;
};

// Parameters for deleting a file from a session sandbox
alias DeleteSessionFileParams = {
  /** The name of the agent. */
  @path agent_name: string;

  /** The session ID. */
  @path agent_session_id: string;

  /** The file or directory path to delete, relative to the session home directory. */
  @query path: string;

  /** Whether to recursively delete directory contents. The service defaults to `false` if a value is not specified by the caller. */
  @query recursive?: boolean = false;
};

// ---------------------------------------------------------------------------
// Response models
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-client-generator-core/csharp-no-response-suffix" "Name kept for backward compatibility"
@doc("Response from uploading a file to a session sandbox.")
model SessionFileWriteResponse {
  @doc("The path where the file was written, relative to the session home directory.")
  path: string;

  @doc("Number of bytes written.")
  bytes_written: safeint;
}

@doc("A single entry in a directory listing.")
model SessionDirectoryEntry {
  @doc("The name of the file or directory.")
  @maxLength(255)
  name: string;

  @doc("The size in bytes (0 for directories).")
  size: safeint;

  @doc("Whether this entry is a directory.")
  is_directory: boolean;

  /** The Unix timestamp (in seconds) when the file was last modified. */
  @encode("unixTimestamp", int64)
  modified_time: utcDateTime;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-no-response-suffix" "Name kept for backward compatibility"
model SessionDirectoryListResponse {
  /** The first ID represented in this list. */
  first_id?: string;

  /** The last ID represented in this list. */
  @continuationToken
  last_id?: string;

  /** A value indicating whether there are additional values available not captured in this list. */
  has_more: boolean;

  /** The path that was listed, relative to the session home directory. */
  path: string;

  /** The directory entries. */
  @pageItems
  entries: SessionDirectoryEntry[];
}
