using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Response models
// ---------------------------------------------------------------------------

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

  @doc("The last modification time in UTC (ISO 8601).")
  @encode(DateTimeKnownEncoding.rfc3339)
  modified_time: utcDateTime;
}

@doc("Response from listing a directory in a session sandbox.")
model SessionDirectoryListResponse {
  @doc("The path that was listed, relative to the session home directory.")
  path: string;

  @doc("The directory entries.")
  entries: SessionDirectoryEntry[];
}
