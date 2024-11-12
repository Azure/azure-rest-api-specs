namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Versioning;

/** The expiration policy for a vector store. */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreExpirationPolicy {
  /** Anchor timestamp after which the expiration policy applies. Supported anchors: `last_active_at`. */
  anchor: VectorStoreExpirationPolicyAnchor;

  /** The anchor timestamp after which the expiration policy applies. */
  @minValue(1)
  @maxValue(365)
  days: int32;
}

/** Describes the relationship between the days and the expiration of this vector store */
@added(ServiceApiVersions.v2024_05_01_preview)
union VectorStoreExpirationPolicyAnchor {
  string,

  /** The expiration policy is based on the last time the vector store was active. */
  lastActiveAt: "last_active_at",
}

/** Vector store possible status */
@added(ServiceApiVersions.v2024_05_01_preview)
union VectorStoreStatus {
  string,

  /** expired status indicates that this vector store has expired and is no longer available for use. */
  expired: "expired",

  /** in_progress status indicates that this vector store is still processing files. */
  inProgress: "in_progress",

  /** completed status indicates that this vector store is ready for use. */
  completed: "completed",
}

/** Counts of files processed or being processed by this vector store grouped by status. */
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
}

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

  /** The Unix timestamp (in seconds) for when the vector store will expire. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @encode("unixTimestamp", int32)
  @encodedName("application/json", "expires_at")
  expiresAt?: utcDateTime | null;

  /** The Unix timestamp (in seconds) for when the vector store was last active. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
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
  /** A list of file IDs that the vector store should use. Useful for tools like `file_search` that can access files. */
  @maxItems(500)
  @encodedName("application/json", "file_ids")
  fileIds?: string[];

  /** The name of the vector store. */
  name?: string;

  /** Details on when this vector store expires */
  @encodedName("application/json", "expires_after")
  expiresAfter?: VectorStoreExpirationPolicy;

  /** The chunking strategy used to chunk the file(s). If not set, will use the auto strategy. Only applicable if file_ids is non-empty. */
  @encodedName("application/json", "chunking_strategy")
  @added(ServiceApiVersions.v2024_07_01_preview)
  chunkingStrategy?: VectorStoreChunkingStrategyRequest;

  ...OptionalNullableMetadata;
}

/** Request object for updating a vector store. */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreUpdateOptions {
  /** The name of the vector store. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  name?: string | null;

  /** Details on when this vector store expires */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
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
