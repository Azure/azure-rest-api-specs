import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

// ──── Collections enums ────

/** The status of a collection. */
union CollectionStatus {
  string,

  /** The collection is active and available. */
  active: "active",
}

/** The status indicating a resource has been deleted. */
union DeleteStatus {
  string,

  /** The resource has been deleted. */
  deleted: "deleted",
}

// ──── Collections models ────

/** Request body for creating a new collection. */
model CreateCollectionRequest {
  /** Lowercase letters, digits, hyphens. 2-49 chars. */
  @maxLength(49)
  @minLength(2)
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  name: string;

  /** A description of the collection. */
  @maxLength(500)
  description?: string;
}

/** Represents a document collection. */
model Collection {
  /** The name of the collection. */
  name?: string;

  /** A description of the collection. */
  description?: string;

  /** The timestamp when the collection was created. */
  @encodedName("application/json", "created_at")
  createdAt?: utcDateTime;

  /** The identifier of the user who created the collection. */
  @encodedName("application/json", "created_by")
  createdBy?: string;

  /** The current status of the collection. */
  status?: CollectionStatus;

  /** The timestamp of the last ingestion into this collection. */
  @encodedName("application/json", "last_ingestion_at")
  lastIngestionAt?: utcDateTime;
}

/** A list of collections with a total count. */
model CollectionList {
  /** The list of collections. */
  collections?: Collection[];

  /** The total number of collections. */
  @encodedName("application/json", "total_count")
  totalCount?: int32;
}

/** Request body for updating a collection. */
model UpdateCollectionRequest {
  /** The updated description of the collection. */
  @maxLength(500)
  description: string;
}

/** Response returned after deleting a collection. */
model DeleteCollectionResponse {
  /** The deletion status. */
  status?: DeleteStatus;

  /** Details of the resources that were deleted. */
  @encodedName("application/json", "deleted_resources")
  deletedResources?: DeleteCollectionResponseDeletedResources;
}

/** Details of resources deleted as part of a collection deletion. */
model DeleteCollectionResponseDeletedResources {
  /** The names of the Milvus collections that were deleted. */
  @encodedName("application/json", "milvus_collections")
  milvusCollections?: string[];

  /** The names of the Postgres tables that were deleted. */
  @encodedName("application/json", "postgres_tables")
  postgresTables?: string[];
}
