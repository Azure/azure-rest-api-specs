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

  /** The Unix timestamp (in seconds) when the file was last modified. */
  @encode("unixTimestamp", int64)
  modified_time: utcDateTime;
}

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
