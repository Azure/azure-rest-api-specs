import "@typespec/openapi";
import "../common/models.tsp";
import "../specialized-types/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** The default strategy. This strategy currently uses a `max_chunk_size_tokens` of `800` and `chunk_overlap_tokens` of `400`. */
@summary("Auto Chunking Strategy")
model AutoChunkingStrategyRequestParam {
  /** Always `auto`. */
  @extension("x-stainless-const", true)
  type: "auto";
}

/** Customize your own chunking strategy by setting chunk size and chunk overlap. */
@summary("Static Chunking Strategy")
model StaticChunkingStrategyRequestParam {
  /** Always `static`. */
  @extension("x-stainless-const", true)
  type: "static";

  static: StaticChunkingStrategy;
}

model StaticChunkingStrategy {
  /** The maximum number of tokens in each chunk. The default value is `800`. The minimum value is `100` and the maximum value is `4096`. */
  @maxValue(4096)
  @minValue(100)
  max_chunk_size_tokens: integer;

  /**The number of tokens that overlap between chunks. The default value is `400`.

  Note that the overlap must not exceed half of `max_chunk_size_tokens`.*/
  chunk_overlap_tokens: integer;
}

/** The chunking strategy used to chunk the file(s). If not set, will use the `auto` strategy. Only applicable if `file_ids` is non-empty. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union ChunkingStrategyRequestParam {
  auto: AutoChunkingStrategyRequestParam,
  static: StaticChunkingStrategyRequestParam,
}

model CreateVectorStoreFileBatchRequest {
  /** A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that the vector store should use. Useful for tools like `file_search` that can access files. */
  @maxItems(500)
  @minItems(1)
  file_ids: string[];

  chunking_strategy?: ChunkingStrategyRequestParam;
  attributes?: VectorStoreFileAttributes;
}

model CreateVectorStoreFileRequest {
  /** A [File](https://platform.openai.com/docs/api-reference/files) ID that the vector store should use. Useful for tools like `file_search` that can access files. */
  file_id: string;

  chunking_strategy?: ChunkingStrategyRequestParam;
  attributes?: VectorStoreFileAttributes;
}

model CreateVectorStoreRequest {
  /** A list of [File](https://platform.openai.com/docs/api-reference/files) IDs that the vector store should use. Useful for tools like `file_search` that can access files. */
  @maxItems(500)
  file_ids?: string[];

  /** The name of the vector store. */
  name?: string;

  expires_after?: VectorStoreExpirationAfter;
  chunking_strategy?: ChunkingStrategyRequestParam;
  metadata?: Metadata;
}

/** The expiration policy for a vector store. */
@summary("Vector store expiration policy")
model VectorStoreExpirationAfter {
  /** Anchor timestamp after which the expiration policy applies. Supported anchors: `last_active_at`. */
  @extension("x-stainless-const", true)
  anchor: "last_active_at";

  /** The number of days after the anchor time that the vector store will expire. */
  @maxValue(365)
  @minValue(1)
  days: integer;
}

model DeleteVectorStoreFileResponse {
  id: string;
  deleted: boolean;

  @extension("x-stainless-const", true)
  object: "vector_store.file.deleted";
}

model DeleteVectorStoreResponse {
  id: string;
  deleted: boolean;

  @extension("x-stainless-const", true)
  object: "vector_store.deleted";
}

model ListVectorStoreFilesResponse {
  object: string;
  data: VectorStoreFileObject[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

/** A list of files attached to a vector store. */
@summary("Vector store files")
@extension(
  "x-oaiMeta",
  #{
    name: "The vector store file object",
    beta: true,
    example: "{\n  \"id\": \"file-abc123\",\n  \"object\": \"vector_store.file\",\n  \"usage_bytes\": 1234,\n  \"created_at\": 1698107661,\n  \"vector_store_id\": \"vs_abc123\",\n  \"status\": \"completed\",\n  \"last_error\": null,\n  \"chunking_strategy\": {\n    \"type\": \"static\",\n    \"static\": {\n      \"max_chunk_size_tokens\": 800,\n      \"chunk_overlap_tokens\": 400\n    }\n  }\n}\n",
  }
)
model VectorStoreFileObject {
  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `vector_store.file`. */
  @extension("x-stainless-const", true)
  object: "vector_store.file";

  /** The total vector store usage in bytes. Note that this may be different from the original file size. */
  usage_bytes: integer;

  /** The Unix timestamp (in seconds) for when the vector store file was created. */
  created_at: integer;

  /** The ID of the [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object) that the [File](https://platform.openai.com/docs/api-reference/files) is attached to. */
  vector_store_id: string;

  /** The status of the vector store file, which can be either `in_progress`, `completed`, `cancelled`, or `failed`. The status `completed` indicates that the vector store file is ready for use. */
  status: "in_progress" | "completed" | "cancelled" | "failed";

  /** The last error associated with this vector store file. Will be `null` if there are no errors. */
  last_error: {
    code: "server_error" | "unsupported_file" | "invalid_file";
    message: string;
  } | null;

  chunking_strategy?: ChunkingStrategyResponse;
  attributes?: VectorStoreFileAttributes;
}

/** The strategy used to chunk the file. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union ChunkingStrategyResponse {
  static: StaticChunkingStrategyResponseParam,
  other: OtherChunkingStrategyResponseParam,
}

@summary("Static Chunking Strategy")
model StaticChunkingStrategyResponseParam {
  /** Always `static`. */
  @extension("x-stainless-const", true)
  type: "static";

  static: StaticChunkingStrategy;
}

/** This is returned when the chunking strategy is unknown. Typically, this is because the file was indexed before the `chunking_strategy` concept was introduced in the API. */
@summary("Other Chunking Strategy")
model OtherChunkingStrategyResponseParam {
  /** Always `other`. */
  @extension("x-stainless-const", true)
  type: "other";
}

model ListVectorStoresResponse {
  object: string;
  data: VectorStoreObject[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

/** A vector store is a collection of processed files can be used by the `file_search` tool. */
@summary("Vector store")
@extension(
  "x-oaiMeta",
  #{
    name: "The vector store object",
    example: "{\n  \"id\": \"vs_123\",\n  \"object\": \"vector_store\",\n  \"created_at\": 1698107661,\n  \"usage_bytes\": 123456,\n  \"last_active_at\": 1698107661,\n  \"name\": \"my_vector_store\",\n  \"status\": \"completed\",\n  \"file_counts\": {\n    \"in_progress\": 0,\n    \"completed\": 100,\n    \"cancelled\": 0,\n    \"failed\": 0,\n    \"total\": 100\n  },\n  \"last_used_at\": 1698107661\n}\n",
  }
)
model VectorStoreObject {
  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `vector_store`. */
  @extension("x-stainless-const", true)
  object: "vector_store";

  /** The Unix timestamp (in seconds) for when the vector store was created. */
  created_at: integer;

  /** The name of the vector store. */
  name: string;

  /** The total number of bytes used by the files in the vector store. */
  usage_bytes: integer;

  file_counts: {
    in_progress: integer;
    completed: integer;
    failed: integer;
    cancelled: integer;
    total: integer;
  };

  /** The status of the vector store, which can be either `expired`, `in_progress`, or `completed`. A status of `completed` indicates that the vector store is ready for use. */
  status: "expired" | "in_progress" | "completed";

  expires_after?: VectorStoreExpirationAfter;

  /** The Unix timestamp (in seconds) for when the vector store will expire. */
  expires_at?: integer | null;

  /** The Unix timestamp (in seconds) for when the vector store was last active. */
  last_active_at: integer | null;

  metadata: Metadata;
}

@extension(
  "x-oaiMeta",
  #{ name: "Update vector store file attributes request" }
)
model UpdateVectorStoreFileAttributesRequest {
  attributes: VectorStoreFileAttributes;
}

model UpdateVectorStoreRequest {
  /** The name of the vector store. */
  name?: string | null;

  expires_after?: VectorStoreExpirationAfter;
  metadata?: Metadata;
}

/** A batch of files attached to a vector store. */
@summary("Vector store file batch")
@extension(
  "x-oaiMeta",
  #{
    name: "The vector store files batch object",
    beta: true,
    example: "{\n  \"id\": \"vsfb_123\",\n  \"object\": \"vector_store.files_batch\",\n  \"created_at\": 1698107661,\n  \"vector_store_id\": \"vs_abc123\",\n  \"status\": \"completed\",\n  \"file_counts\": {\n    \"in_progress\": 0,\n    \"completed\": 100,\n    \"failed\": 0,\n    \"cancelled\": 0,\n    \"total\": 100\n  }\n}\n",
  }
)
model VectorStoreFileBatchObject {
  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `vector_store.file_batch`. */
  @extension("x-stainless-const", true)
  object: "vector_store.files_batch";

  /** The Unix timestamp (in seconds) for when the vector store files batch was created. */
  created_at: integer;

  /** The ID of the [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object) that the [File](https://platform.openai.com/docs/api-reference/files) is attached to. */
  vector_store_id: string;

  /** The status of the vector store files batch, which can be either `in_progress`, `completed`, `cancelled` or `failed`. */
  status: "in_progress" | "completed" | "cancelled" | "failed";

  file_counts: {
    in_progress: integer;
    completed: integer;
    failed: integer;
    cancelled: integer;
    total: integer;
  };
}

/** Represents the parsed content of a vector store file. */
model VectorStoreFileContentResponse {
  /** The object type, which is always `vector_store.file_content.page` */
  @extension("x-stainless-const", true)
  object: "vector_store.file_content.page";

  /** Parsed content of the file. */
  data: {
    type?: string;
    text?: string;
  }[];

  /** Indicates if there are more content pages to fetch. */
  has_more: boolean;

  /** The token for the next page, if any. */
  next_page: string | null;
}

@extension("x-oaiMeta", #{ name: "Vector store search request" })
model VectorStoreSearchRequest {
  /** A query string for a search */
  query: string | string[];

  /** Whether to rewrite the natural language query for vector search. */
  rewrite_query?: boolean;

  /** The maximum number of results to return. This number should be between 1 and 50 inclusive. */
  @maxValue(50)
  @minValue(1)
  max_num_results?: integer = 10;

  /** A filter to apply based on file attributes. */
  filters?: ComparisonFilter | CompoundFilter;

  /** Ranking options for search. */
  ranking_options?: {
    ranker?: "none" | "auto" | "default-2024-11-15" = "auto";

    @maxValue(1)
    @minValue(0)
    score_threshold?: numeric;
  };
}

@extension("x-oaiMeta", #{ name: "Vector store search result content object" })
model VectorStoreSearchResultContentObject {
  /** The type of content. */
  type: "text";

  /** The text content returned from search. */
  text: string;
}

@extension("x-oaiMeta", #{ name: "Vector store search result item" })
model VectorStoreSearchResultItem {
  /** The ID of the vector store file. */
  file_id: string;

  /** The name of the vector store file. */
  filename: string;

  /** The similarity score for the result. */
  @maxValue(1)
  @minValue(0)
  score: numeric;

  attributes: VectorStoreFileAttributes;

  /** Content chunks from the file. */
  content: VectorStoreSearchResultContentObject[];
}

@extension("x-oaiMeta", #{ name: "Vector store search results page" })
model VectorStoreSearchResultsPage {
  /** The object type, which is always `vector_store.search_results.page` */
  @extension("x-stainless-const", true)
  object: "vector_store.search_results.page";

  search_query: string[];

  /** The list of search result items. */
  data: VectorStoreSearchResultItem[];

  /** Indicates if there are more results to fetch. */
  has_more: boolean;

  /** The token for the next page, if any. */
  next_page: string | null;
}
