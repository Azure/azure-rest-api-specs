namespace Microsoft.MachineLearningServices;

using TypeSpec.Versioning;

@doc("The expiration policy for a vector store.")
model VectorStoreExpirationPolicy {
  @doc("Anchor timestamp after which the expiration policy applies. Supported anchors: `last_active_at`.")
  anchor: VectorStoreExpirationPolicyAnchor;

  @doc("The anchor timestamp after which the expiration policy applies.")
  @minValue(1)
  @maxValue(365)
  days: int32;
}

@doc("Describes the relationship between the days and the expiration of this vector store")
union VectorStoreExpirationPolicyAnchor {
  string,

  @doc("The expiration policy is based on the last time the vector store was active.")
  lastActiveAt: "last_active_at",
}

@doc("Vector store possible status")
union VectorStoreStatus {
  string,

  @doc("expired status indicates that this vector store has expired and is no longer available for use.")
  expired: "expired",

  @doc("in_progress status indicates that this vector store is still processing files.")
  inProgress: "in_progress",

  @doc("completed status indicates that this vector store is ready for use.")
  completed: "completed",
}

@doc("Counts of files processed or being processed by this vector store grouped by status.")
model VectorStoreFileCount {
  @doc("The number of files that are currently being processed.")
  @encodedName("application/json", "in_progress")
  inProgress: int32;

  @doc("The number of files that have been successfully processed.")
  completed: int32;

  @doc("The number of files that have failed to process.")
  failed: int32;

  @doc("The number of files that were cancelled.")
  cancelled: int32;

  @doc("The total number of files.")
  total: int32;
}

@doc("A vector store is a collection of processed files can be used by the `file_search` tool.")
model VectorStore {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always `vector_store`")
  object: "vector_store";

  @doc("The Unix timestamp (in seconds) for when the vector store was created.")
  @encode("unixTimestamp", int32)
  @encodedName("application/json", "created_at")
  createdAt: utcDateTime;

  @doc("The name of the vector store.")
  name: string;

  @doc("The total number of bytes used by the files in the vector store.")
  @encodedName("application/json", "usage_bytes")
  usageBytes: int32;

  @doc("Files count grouped by status processed or being processed by this vector store.")
  @encodedName("application/json", "file_counts")
  fileCounts: VectorStoreFileCount;

  @doc("The status of the vector store, which can be either `expired`, `in_progress`, or `completed`. A status of `completed` indicates that the vector store is ready for use.")
  status: VectorStoreStatus;

  @doc("Details on when this vector store expires")
  @encodedName("application/json", "expires_after")
  expiresAfter?: VectorStoreExpirationPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The Unix timestamp (in seconds) for when the vector store will expire.")
  @encode("unixTimestamp", int32)
  @encodedName("application/json", "expires_at")
  expiresAt?: utcDateTime | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The Unix timestamp (in seconds) for when the vector store was last active.")
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

@doc("Request object for creating a vector store.")
model VectorStoreOptions {
  @doc("A list of file IDs that the vector store should use. Useful for tools like `file_search` that can access files.")
  @maxItems(500)
  @encodedName("application/json", "file_ids")
  fileIds?: string[];

  @doc("The name of the vector store.")
  name?: string;

  @doc("Details on when this vector store expires")
  @encodedName("application/json", "expires_after")
  expiresAfter?: VectorStoreExpirationPolicy;

  @doc("The chunking strategy used to chunk the file(s). If not set, will use the auto strategy. Only applicable if file_ids is non-empty.")
  @encodedName("application/json", "chunking_strategy")
  chunkingStrategy?: VectorStoreChunkingStrategyRequest;

  ...OptionalNullableMetadata;
}

@doc("Request object for updating a vector store.")
model VectorStoreUpdateOptions {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The name of the vector store.")
  name?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("Details on when this vector store expires")
  @encodedName("application/json", "expires_after")
  expiresAfter?: VectorStoreExpirationPolicy | null;

  /**
   * Set of 16 key-value pairs that can be attached to an object. This can be useful for storing
   * additional information about the object in a structured format. Keys can be a maximum of 64
   * characters long and values can be a maximum of 512 characters long.
   */
  ...OptionalNullableMetadata;
}

@doc("Response object for deleting a vector store.")
model VectorStoreDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'vector_store.deleted'.")
  object: "vector_store.deleted";
}
