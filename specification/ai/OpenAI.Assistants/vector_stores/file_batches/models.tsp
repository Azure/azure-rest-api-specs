namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Versioning;

/** The status of the vector store file batch. */
union VectorStoreFileBatchStatus {
	string, 

	/** The vector store is still processing this file batch. */
	inProgress: "in_progress",
	
	/** the vector store file batch is ready for use. */
	completed: "completed",
	
	/** The vector store file batch was cancelled. */
	cancelled: "cancelled",
	
	/** The vector store file batch failed to process. */
	failed: "failed"
}

/** A batch of files attached to a vector store. */
@added(ServiceApiVersions.v2024_05_01_preview)
model VectorStoreFileBatch {
	/** The identifier, which can be referenced in API endpoints. */
	id: string;

	/** The object type, which is always `vector_store.file_batch`. */
	object: "vector_store.files_batch";

	/** The Unix timestamp (in seconds) for when the vector store files batch was created. */
	@encode("unixTimestamp", int32)
	@encodedName("application/json", "created_at")
	createdAt: utcDateTime;

	/** The ID of the vector store that the file is attached to. */
	@encodedName("application/json", "vector_store_id")
	vectorStoreId: string;

	/** The status of the vector store files batch, which can be either `in_progress`, `completed`, `cancelled` or `failed`. */
	status: VectorStoreFileBatchStatus;

	/** Files count grouped by status processed or being processed by this vector store. */
	@encodedName("application/json", "file_counts")
	fileCounts: VectorStoreFileCount;
}
