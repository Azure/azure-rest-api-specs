namespace Microsoft.MachineLearningServices;

using TypeSpec.Versioning;

@doc("The status of the vector store file batch.")
union VectorStoreFileBatchStatus {
  string,

  @doc("The vector store is still processing this file batch.")
  inProgress: "in_progress",

  @doc("The vector store file batch is ready for use.")
  completed: "completed",

  @doc("The vector store file batch was cancelled.")
  cancelled: "cancelled",

  @doc("The vector store file batch failed to process.")
  failed: "failed",
}

@doc("A batch of files attached to a vector store.")
model VectorStoreFileBatch {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always `vector_store.file_batch`.")
  object: "vector_store.files_batch";

  @doc("The Unix timestamp (in seconds) for when the vector store files batch was created.")
  @encode("unixTimestamp", int32)
  @encodedName("application/json", "created_at")
  createdAt: utcDateTime;

  @doc("The ID of the vector store that the file is attached to.")
  @encodedName("application/json", "vector_store_id")
  vectorStoreId: string;

  @doc("The status of the vector store files batch, which can be either `in_progress`, `completed`, `cancelled` or `failed`.")
  status: VectorStoreFileBatchStatus;

  @doc("Files count grouped by status processed or being processed by this vector store.")
  @encodedName("application/json", "file_counts")
  fileCounts: VectorStoreFileCount;
}
