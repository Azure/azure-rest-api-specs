namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Versioning;

/** Query parameter filter for vector store file retrieval endpoint */
@added(ServiceApiVersions.v2024_05_01_preview)
union VectorStoreFileStatusFilter {
  string,

  /** Retrieve only files that are currently being processed */
  inProgress: "in_progress",

  /** Retrieve only files that have been successfully processed */
  completed: "completed",

  /** Retrieve only files that have failed to process */
  failed: "failed",

  /** Retrieve only files that were cancelled */
  cancelled: "cancelled",
}

/** Vector store file status */
@added(ServiceApiVersions.v2024_05_01_preview)
union VectorStoreFileStatus {
  string,

  /** The file is currently being processed. */
  inProgress: "in_progress",

  /** The file has been successfully processed. */
  completed: "completed",

  /** The file has failed to process. */
  failed: "failed",

  /** The file was cancelled. */
  cancelled: "cancelled",
}

/** Error code variants for vector store file processing */
@added(ServiceApiVersions.v2024_05_01_preview)
union VectorStoreFileErrorCode {
  string,

  /** An internal error occurred. */
  internalError: "internal_error",

  /** The file was not found. */
  fileNotFound: "file_not_found",

  /** The file could not be parsed. */
  parsingError: "parsing_error",

  /** The file has an unhandled mime type. */
  unhandledMimeType: "unhandled_mime_type",
}

/** Details on the error that may have ocurred while processing a file for this vector store */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreFileError {
  /** One of `server_error` or `rate_limit_exceeded`. */
  code: VectorStoreFileErrorCode;

  /** A human-readable description of the error. */
  message: string;
}

/** Description of a file attached to a vector store. */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreFile {
  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `vector_store.file`. */
  object: "vector_store.file";

  /**
   * The total vector store usage in bytes. Note that this may be different from the original file
   * size.
   */
  @encodedName("application/json", "usage_bytes")
  usageBytes: int32;

  // Tool customization: _at and created are Unix encoded utcDateTime
  /** The Unix timestamp (in seconds) for when the vector store file was created. */
  @encodedName("application/json", "created_at")
  @encode("unixTimestamp", int32)
  createdAt: utcDateTime;

  /** The ID of the vector store that the file is attached to. */
  @encodedName("application/json", "vector_store_id")
  vectorStoreId: string;

  /** The status of the vector store file, which can be either `in_progress`, `completed`, `cancelled`, or `failed`. The status `completed` indicates that the vector store file is ready for use. */
  status: VectorStoreFileStatus;

  /** The last error associated with this vector store file. Will be `null` if there are no errors. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encodedName("application/json", "last_error")
  lastError: VectorStoreFileError | null;

  /** The strategy used to chunk the file. */
  @encodedName("application/json", "chunking_strategy")
  @added(ServiceApiVersions.v2024_07_01_preview)
  chunkingStrategy: VectorStoreChunkingStrategyResponse;
}

/** Response object for deleting a vector store file relationship. */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreFileDeletionStatus {
  ...DeletionStatus;

  /** The object type, which is always 'vector_store.deleted'. */
  object: "vector_store.file.deleted";
}
