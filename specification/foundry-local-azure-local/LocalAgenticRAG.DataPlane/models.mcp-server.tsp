import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

// ──── MCP Server enums ────

/** The JSON-RPC protocol version. */
union JsonRpcVersion {
  string,

  /** JSON-RPC version 2.0. */
  `2.0`: "2.0",
}

/** The MCP method to invoke. */
union McpMethod {
  string,

  /** Initialize the MCP session. */
  initialize: "initialize",

  /** List available tools. */
  `tools/list`: "tools/list",

  /** Call a specific tool. */
  `tools/call`: "tools/call",
}

/** The type of vector used in search results. */
union VectorType {
  string,

  /** A dense vector result. */
  dense: "dense",

  /** A sparse vector result. */
  sparse: "sparse",

  /** An image vector result. */
  image: "image",
}

/** The type of search performed. */
union SearchType {
  string,

  /** A hybrid search combining dense and sparse retrieval. */
  hybrid_search: "hybrid_search",

  /** A vector similarity search. */
  vector_search: "vector_search",

  /** A full text search. */
  full_text_search: "full_text_search",

  /** An image search. */
  image_search: "image_search",

  /** A multimodal search across text and images. */
  multimodal_search: "multimodal_search",
}

// ──── MCP Server models ────

/** A JSON-RPC 2.0 request for the MCP endpoint. */
model JsonRpcRequest {
  /** The JSON-RPC protocol version. */
  jsonrpc: JsonRpcVersion;

  /** The request identifier. */
  id: int32;

  /** The MCP method to invoke. */
  method: McpMethod;

  /** Method-specific parameters. */
  params?: Record<string>;
}

/** A JSON-RPC 2.0 response from the MCP endpoint. */
model JsonRpcResponse {
  /** The JSON-RPC protocol version. */
  jsonrpc?: JsonRpcVersion;

  /** The request identifier this response corresponds to. */
  id?: int32;

  /** Method-specific result. */
  result?: Record<string>;

  /** The error object, present when the request failed. */
  error?: JsonRpcError;
}

/** A JSON-RPC 2.0 error object. */
model JsonRpcError {
  /**
   * -32600 Invalid Request, -32601 Method not found, -32602 Invalid params,
   * -32603 Internal error.
   */
  code?: int32;

  /** A human-readable error message. */
  message?: string;

  /** Any object */
  data?: Record<string>;
}

/** Used by search_hybrid, search_vector, search_text, search_image. */
model SearchToolRequest {
  /** The search query text. */
  query: string;

  /** Default: ["edgeragapp"]. */
  @encodedName("application/json", "collection_names")
  collectionNames?: string[];

  /** Maximum number of results to return. */
  @maxValue(50)
  @minValue(1)
  @encodedName("application/json", "top_n")
  topN?: int32 = 5;

  /** Strictness level for filtering results. */
  @maxValue(5)
  strictness?: int32 = 1;

  /** Milvus boolean filter expression. */
  filters?: string;
}

/** Used by search_multimodal. */
model MultimodalSearchRequest {
  /** The search query text. */
  query: string;

  /** The names of collections to search. */
  @encodedName("application/json", "collection_names")
  collectionNames?: string[];

  /** Maximum number of results to return. */
  @maxValue(50)
  @minValue(1)
  @encodedName("application/json", "top_n")
  topN?: int32 = 5;

  /** Text strictness level for filtering text results. */
  @maxValue(5)
  @encodedName("application/json", "text_strictness")
  textStrictness?: int32 = 1;

  /** Image strictness level for filtering image results. */
  @maxValue(5)
  @encodedName("application/json", "image_strictness")
  imageStrictness?: int32 = 1;

  /** Milvus boolean filter expression. */
  filters?: string;
}

/** A single chunk result from a search tool invocation. */
model ToolChunkResult {
  /** The text content of the chunk. */
  content?: string;

  /** The file path of the source document. */
  @encodedName("application/json", "file_path")
  filePath?: string;

  /** The identifier of the chunk. */
  @encodedName("application/json", "chunk_id")
  chunkId?: string;

  /** The relevance score of the chunk. */
  score?: float32;

  /** The page numbers referenced by the chunk. */
  @encodedName("application/json", "page_numbers")
  pageNumbers?: int32[];

  /** The type of vector used for this result. */
  @encodedName("application/json", "vector_type")
  vectorType?: VectorType = VectorType.dense;
}

/** Metadata about a search operation. */
model SearchMetadata {
  /** The number of results returned. */
  @encodedName("application/json", "results_number")
  resultsNumber?: int32;

  /** The type of search that was performed. */
  @encodedName("application/json", "search_type")
  searchType?: SearchType;

  /** The name of the collection that was searched. */
  collection?: string;
}

/** Returned by search_hybrid, search_vector, search_text, search_image. */
model SearchChunksResponse {
  /** The list of chunk results. */
  results?: ToolChunkResult[];

  /** Metadata about the search operation. */
  metadata?: SearchMetadata;
}

/** Returned by search_multimodal. */
model MultimodalSearchResponse {
  /** The text chunk results. */
  @encodedName("application/json", "text_chunks")
  textChunks?: ToolChunkResult[];

  /** The image chunk results. */
  @encodedName("application/json", "image_chunks")
  imageChunks?: ToolChunkResult[];

  /** Metadata about the search operation. */
  metadata?: SearchMetadata;
}

/** Information about a collection available via MCP. */
model McpCollectionInfo {
  /** The name of the collection. */
  name?: string;

  /** A description of the collection. */
  description?: string;

  /** The current status of the collection. */
  status?: string;

  /** The timestamp when the collection was created. */
  @encodedName("application/json", "created_at")
  createdAt?: utcDateTime;
}

/** Returned by get_available_collections. */
model McpCollectionsResponse {
  /** The list of available collections. */
  collections?: McpCollectionInfo[];

  /** The total number of available collections. */
  @encodedName("application/json", "total_count")
  totalCount?: int32;
}
