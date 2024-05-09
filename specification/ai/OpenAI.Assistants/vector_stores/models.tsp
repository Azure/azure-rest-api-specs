namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Versioning;

/** The expiration policy for a vector store. */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreExpirationPolicy {
  
  /** Anchor timestamp after which the expiration policy applies. Supported anchors: `last_active_at`. */
  anchor: VectorStoreExpirationPolicyAnchor;

  /** The number of days after the anchor time that the vector store will expire. */
  @minValue(1)
  @maxValue(365)
  days: int32;
}

/** Describes the relationship between the days and the expiration of this vector store */
@added(ServiceApiVersions.v2024_05_01_preview)
union VectorStoreExpirationPolicyAnchor {
  string, 
  
  /** The expiration policy is based on the last time the vector store was active. */
  lastActiveAt: "last_active_at";
};

/** Vectore store possible status */
@added(ServiceApiVersions.v2024_05_01_preview)
union VectorStoreStatus {
  string,

  /** expired status indicates that this vector store has expired and is no longer available for use */
  expired: "expired",
  /** in_progress status indicates that this vector store is still processing files */
  inProgress : "in_progress",
  /** completed status indicates that this vector store is ready for use */
  completed: "completed"
};

/** Counts of files processed or being processed by this vector store grouped by status */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreFileCount {
  /** The number of files that are currently being processed. */
  @encodedName("application/json", "in_progress")
  inProgress: int32;

  /** The number of files that have been successfully processed. */
  completed: int32;

  /** The number of files that have failed to process. */
  failed: int32;

  /** The number of files that were cancelled. */
  cancelled: int32;

  /** The total number of files. */
  total: int32;
};

/** 
 * A vector store is a collection of processed files can be used by the `file_search` tool.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStore {
  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `vector_store` */
  object: "vector_store";

  // Tool customization: _at and created are Unix encoded utcDateTime
  /** The Unix timestamp (in seconds) for when the vector store was created. */
  @encode("unixTimestamp", int32)
  @encodedName("application/json", "created_at")
  createdAt: utcDateTime;

  /** The name of the vector store. */
  name: string;

  /** The total number of bytes used by the files in the vector store. */
  @encodedName("application/json", "usage_bytes")
  usageBytes: int32;

  /** Files count grouped by status processed or being processed by this vector store. */
  @encodedName("application/json", "file_counts")
  fileCounts: VectorStoreFileCount;

  /** The status of the vector store, which can be either `expired`, `in_progress`, or `completed`. A status of `completed` indicates that the vector store is ready for use. */
  status: VectorStoreStatus;

  /** Details on when this vector store expires */
  @encodedName("application/json", "expires_after")
  expiresAfter?: VectorStoreExpirationPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  /** The Unix timestamp (in seconds) for when the vector store will expire. */
  @encode("unixTimestamp", int32)
  @encodedName("application/json", "expires_at")
  expiresAt?: utcDateTime | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  /** The Unix timestamp (in seconds) for when the vector store was last active. */
  @encode("unixTimestamp", int32)
  @encodedName("application/json", "last_active_at")
  lastActiveAt: utcDateTime | null;

  /**
   * Set of 16 key-value pairs that can be attached to an object. This can be useful for storing
   * additional information about the object in a structured format. Keys can be a maximum of 64
   * characters long and values can be a maximum of 512 characters long.
   */
  ...RequiredNullableMetadata;
}

/** Request object for creating a vector store. */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreOptions {
  
  /** A list of file IDs that the vector store should use. Useful for tools like `file_search` that can access files.*/
  @maxItems(500)
  @encodedName("application/json", "file_ids")
  fileIds?: string[];

  /** The name of the vector store. */
  name?: string;

  /** Details on when this vector store expires */
  @encodedName("application/json", "expires_after")
  expiresAfter?: VectorStoreExpirationPolicy;

  /**
   * Set of 16 key-value pairs that can be attached to an object. This can be useful for storing
   * additional information about the object in a structured format. Keys can be a maximum of 64
   * characters long and values can be a maximum of 512 characters long.
   */
  ...OptionalNullableMetadata;
}

/** Request object for updating a vector store. */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreUpdateOptions {

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  /** The name of the vector store. */
  name?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  /** Details on when this vector store expires */
  @encodedName("application/json", "expires_after")
  expiresAfter?: VectorStoreExpirationPolicy | null;

  /**
   * Set of 16 key-value pairs that can be attached to an object. This can be useful for storing
   * additional information about the object in a structured format. Keys can be a maximum of 64
   * characters long and values can be a maximum of 512 characters long.
   */
  ...OptionalNullableMetadata;
}

/** Response object for deleting a vector store. */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreDeletionStatus {
  ...DeletionStatus;

  /** The object type, which is always 'vector_store.deleted'. */
  object: "vector_store.deleted";
}

/** Query parameter filter for vector store file retrieval endpoint */
@added(ServiceApiVersions.v2024_05_01_preview)
union VectorStoreFileStatusFilter {
  string,

  /** Retrieve all files */
  all: "all",
  /** Retrieve only files that are currently being processed */
  inProgress: "in_progress",
  /** Retrieve only files that have been successfully processed */
  completed: "completed",
  /** Retrieve only files that have failed to process */
  failed: "failed",
  /** Retrieve only files that were cancelled */
  cancelled: "cancelled"
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
  cancelled: "cancelled"

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
  unhandledMimeType: "unhandled_mime_type"
}

/** Details on the error that may have ocurred while processing a file for this vector store */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreFileError {

  /** One of `server_error` or `rate_limit_exceeded`. */
  code: VectorStoreFileErrorCode;

  /** A human-readable description of the error. */
  message: string;
};

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

  # suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  /** The last error associated with this vector store file. Will be `null` if there are no errors. */
  @encodedName("application/json", "last_error")
  lastError: VectorStoreFileError | null;
}
