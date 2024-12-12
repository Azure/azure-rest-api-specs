import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects.Agents;

/** Options to configure a vector store static chunking strategy. */
model VectorStoreStaticChunkingStrategyOptions {
  /** The maximum number of tokens in each chunk. The default value is 800. The minimum value is 100 and the maximum value is 4096. */
  @encodedName("application/json", "max_chunk_size_tokens")
  @minValue(100)
  @maxValue(4096)
  maxChunkSizeTokens: int32;

  /**
   * The number of tokens that overlap between chunks. The default value is 400.
   * Note that the overlap must not exceed half of max_chunk_size_tokens.
   */
  @encodedName("application/json", "chunk_overlap_tokens")
  chunkOverlapTokens: int32;
}

/** Type of chunking strategy */
union VectorStoreChunkingStrategyRequestType {
  auto: "auto",
  static: "static",
  string,
}

/** An abstract representation of a vector store chunking strategy configuration. */
@discriminator("type")
model VectorStoreChunkingStrategyRequest {
  /** The object type. */
  type: VectorStoreChunkingStrategyRequestType;
}

/**
 * The default strategy. This strategy currently uses a max_chunk_size_tokens of 800 and chunk_overlap_tokens of 400.
 */
model VectorStoreAutoChunkingStrategyRequest
  extends VectorStoreChunkingStrategyRequest {
  /** The object type, which is always 'auto'. */
  type: VectorStoreChunkingStrategyRequestType.auto;
}

/** A statically configured chunking strategy. */
model VectorStoreStaticChunkingStrategyRequest
  extends VectorStoreChunkingStrategyRequest {
  /** The object type, which is always 'static'. */
  type: VectorStoreChunkingStrategyRequestType.static;

  /** The options for the static chunking strategy. */
  static: VectorStoreStaticChunkingStrategyOptions;
}

/** Type of chunking strategy */
union VectorStoreChunkingStrategyResponseType {
  other: "other",
  static: "static",
  string,
}

/** An abstract representation of a vector store chunking strategy configuration. */
@discriminator("type")
model VectorStoreChunkingStrategyResponse {
  /** The object type. */
  type: VectorStoreChunkingStrategyResponseType;
}

/**
 * This is returned when the chunking strategy is unknown. Typically, this is because the file was indexed before the chunking_strategy concept was introduced in the API.
 */
model VectorStoreAutoChunkingStrategyResponse
  extends VectorStoreChunkingStrategyResponse {
  /** The object type, which is always 'other'. */
  type: VectorStoreChunkingStrategyResponseType.other;
}

/** A statically configured chunking strategy. */
model VectorStoreStaticChunkingStrategyResponse
  extends VectorStoreChunkingStrategyResponse {
  /** The object type, which is always 'static'. */
  type: VectorStoreChunkingStrategyResponseType.static;

  /** The options for the static chunking strategy. */
  static: VectorStoreStaticChunkingStrategyOptions;
}

/** Type of vector storage asset. Asset type may be a uri_asset, in this case it should contain asset URI ID,
 * in the case of id_asset it should contain the data ID.
 */
union VectorStoreDataSourceAssetType {
  /**
   * Azure URI
   */
  uri_asset: "uri_asset",

  /**
   * The data ID
   */
  id_asset: "id_asset",

  string,
}

/**
 * The structure, containing Azure asset URI path and the asset type of the file used as a data source
 * for the enterprise file search.
 */
model VectorStoreDataSource {
  /** Asset URI. */
  @encodedName("application/json", "uri")
  assetIdentifier: string;

  /** The asset type */
  @encodedName("application/json", "type")
  assetType: VectorStoreDataSourceAssetType;
}

/**
 * Vector storage configuration is the list of data sources, used when multiple
 * files can be used for the enterprise file search.
 */
model VectorStoreConfiguration {
  /** Data sources */
  @encodedName("application/json", "data_sources")
  dataSources: VectorStoreDataSource[];
}

/**
 * The structure, containing the list of vector storage configurations i.e. the list of azure asset IDs.
 */
model VectorStoreConfigurations {
  /** Name */
  @encodedName("application/json", "name")
  storeName: string;

  /** Configurations */
  @encodedName("application/json", "configuration")
  storeConfiguration: VectorStoreConfiguration;
}
