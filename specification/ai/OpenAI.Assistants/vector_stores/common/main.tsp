import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

/** Options to configure a vector store static chunking strategy. */
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreStaticChunkingStrategyOptions {
  /** The maximum number of tokens in each chunk. The default value is 800. The minimum value is 100 and the maximum value is 4096. */
  @encodedName("application/json", "max_chunk_size_tokens")
  @minValue(100)
  @maxValue(4096)
  maxChunkSizeTokens: int32;

  /**
   * The number of tokens that overlap between chunks. The default value is 400.
   * Note that the overlap must not exceed half of max_chunk_size_tokens.     *
   */
  @encodedName("application/json", "chunk_overlap_tokens")
  chunkOverlapTokens: int32;
}

/** Type of chunking strategy */
@added(ServiceApiVersions.v2024_07_01_preview)
union VectorStoreChunkingStrategyRequestType {
  auto: "auto",
  static: "static",
  string,
}

/** An abstract representation of a vector store chunking strategy configuration. */
@discriminator("type")
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreChunkingStrategyRequest {
  /** The object type. */
  type: VectorStoreChunkingStrategyRequestType;
}

/**
 * The default strategy. This strategy currently uses a max_chunk_size_tokens of 800 and chunk_overlap_tokens of 400.
 */
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreAutoChunkingStrategyRequest
  extends VectorStoreChunkingStrategyRequest {
  /** The object type, which is always 'auto'. */
  type: VectorStoreChunkingStrategyRequestType.auto;
}

/** A statically configured chunking strategy. */
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreStaticChunkingStrategyRequest
  extends VectorStoreChunkingStrategyRequest {
  /** The object type, which is always 'static'. */
  type: VectorStoreChunkingStrategyRequestType.static;

  /** The options for the static chunking strategy. */
  static: VectorStoreStaticChunkingStrategyOptions;
}

/** Type of chunking strategy */
@added(ServiceApiVersions.v2024_07_01_preview)
union VectorStoreChunkingStrategyResponseType {
  other: "other",
  static: "static",
  string,
}

/** An abstract representation of a vector store chunking strategy configuration. */
@discriminator("type")
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreChunkingStrategyResponse {
  /** The object type. */
  type: VectorStoreChunkingStrategyResponseType;
}

/**
 * This is returned when the chunking strategy is unknown. Typically, this is because the file was indexed before the chunking_strategy concept was introduced in the API.
 */
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreAutoChunkingStrategyResponse
  extends VectorStoreChunkingStrategyResponse {
  /** The object type, which is always 'other'. */
  type: VectorStoreChunkingStrategyResponseType.other;
}

/** A statically configured chunking strategy. */
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreStaticChunkingStrategyResponse
  extends VectorStoreChunkingStrategyResponse {
  /** The object type, which is always 'static'. */
  type: VectorStoreChunkingStrategyResponseType.static;

  /** The options for the static chunking strategy. */
  static: VectorStoreStaticChunkingStrategyOptions;
}
