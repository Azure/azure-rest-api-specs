namespace Microsoft.MachineLearningServices;

using TypeSpec.Versioning;

@doc("Query parameter filter for vector store file retrieval endpoint")
union VectorStoreFileStatusFilter {
  string,

  @doc("Retrieve only files that are currently being processed")
  inProgress: "in_progress",

  @doc("Retrieve only files that have been successfully processed")
  completed: "completed",

  @doc("Retrieve only files that have failed to process")
  failed: "failed",

  @doc("Retrieve only files that were cancelled")
  cancelled: "cancelled",
}

@doc("Vector store file status")
union VectorStoreFileStatus {
  string,

  @doc("The file is currently being processed.")
  inProgress: "in_progress",

  @doc("The file has been successfully processed.")
  completed: "completed",

  @doc("The file has failed to process.")
  failed: "failed",

  @doc("The file was cancelled.")
  cancelled: "cancelled",
}

@doc("Error code variants for vector store file processing")
union VectorStoreFileErrorCode {
  string,

  @doc("An internal error occurred.")
  internalError: "internal_error",

  @doc("The file was not found.")
  fileNotFound: "file_not_found",

  @doc("The file could not be parsed.")
  parsingError: "parsing_error",

  @doc("The file has an unhandled mime type.")
  unhandledMimeType: "unhandled_mime_type",
}

@doc("Details on the error that may have ocurred while processing a file for this vector store")
model VectorStoreFileError {
  @doc("One of `server_error` or `rate_limit_exceeded`.")
  code: VectorStoreFileErrorCode;

  @doc("A human-readable description of the error.")
  message: string;
}

@doc("Description of a file attached to a vector store.")
model VectorStoreFile {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always `vector_store.file`.")
  object: "vector_store.file";

  @doc("The total vector store usage in bytes. Note that this may be different from the original file size.")
  @encodedName("application/json", "usage_bytes")
  usageBytes: int32;

  @doc("The Unix timestamp (in seconds) for when the vector store file was created.")
  @encodedName("application/json", "created_at")
  @encode("unixTimestamp", int32)
  createdAt: utcDateTime;

  @doc("The ID of the vector store that the file is attached to.")
  @encodedName("application/json", "vector_store_id")
  vectorStoreId: string;

  @doc("The status of the vector store file, which can be either `in_progress`, `completed`, `cancelled`, or `failed`. The status `completed` indicates that the vector store file is ready for use.")
  status: VectorStoreFileStatus;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The last error associated with this vector store file. Will be `null` if there are no errors.")
  @encodedName("application/json", "last_error")
  lastError: VectorStoreFileError | null;

  @doc("The strategy used to chunk the file.")
  @encodedName("application/json", "chunking_strategy")
  chunkingStrategy: VectorStoreChunkingStrategyResponse;
}

@doc("Response object for deleting a vector store file relationship.")
model VectorStoreFileDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'vector_store.deleted'.")
  object: "vector_store.file.deleted";
}
