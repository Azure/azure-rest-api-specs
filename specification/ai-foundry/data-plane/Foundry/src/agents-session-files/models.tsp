using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Response models
// ---------------------------------------------------------------------------

@removed(Versions.v1)
@doc("Response from uploading a file to a session sandbox.")
model SessionFileWriteResponse {
  @doc("The path where the file was written.")
  path: string;

  @doc("Number of bytes written.")
  bytes_written: int64;
}

@removed(Versions.v1)
@doc("A single entry in a directory listing.")
model SessionDirectoryEntry {
  @doc("The name of the file or directory.")
  name: string;

  @doc("The size in bytes (0 for directories).")
  size: int64;

  @doc("Whether this entry is a directory.")
  is_dir: boolean;

  @doc("The last modification time in UTC (ISO 8601).")
  @encode(DateTimeKnownEncoding.rfc3339)
  modified_time: utcDateTime;
}

@removed(Versions.v1)
@doc("Response from listing a directory in a session sandbox.")
model SessionDirectoryListResponse {
  @doc("The path that was listed.")
  path: string;

  @doc("The directory entries.")
  entries: SessionDirectoryEntry[];
}

@removed(Versions.v1)
@doc("Generic response for session file operations (delete).")
model SessionFileOperationResponse {
  @doc("A human-readable message describing the result.")
  message: string;
}
