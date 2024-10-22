import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Client.Agents;

/** Options to configure a vector store static chunking strategy. */
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

/** Type of vector storage configuration. */
union VectorStorageDataSourceAssetType {
  uri_asset: "uri_asset",
  id_asset: "id_asset",
  string
}

/** An abstract representation of a vector store asset type. */
@discriminator("type")
model VectorStorageDataSourceAsset {
    /** The object type */
    type: VectorStorageDataSourceAssetType;
}

/** The URI asset type, used when we want to get vector store based of the Azure asset ID. */
model VectorStorageDataSourceURIAsset
  extends VectorStorageDataSourceAsset {
    type: VectorStorageDataSourceAssetType.uri_asset
}

/** The data ID asset. */
model VectorStorageDataSourceIDAsset
  extends VectorStorageDataSourceAsset {
    type: VectorStorageDataSourceAssetType.id_asset
  }
}

/
**
 * The structure to be supplied when the vector store is being created from the Azure asset ID.
 */
model VectorStorageDataSource {
  /** Asset URI. */
  @encodedName("application/json", "uri")
  uri: string;
  
  /** The asset type **/
  @encodedName("application/json", "type")
  assetType: VectorStorageDataSourceURIAsset;
}

/**
 * Vector storage configuration represents the collection of data sources.
 */
model VectorStorageConfiguration {
  /** Data sources */
  @encodedName("application/json", "data_sources")
  dataSources: VectorStorageDataSource[]
}

/**
 * Vector store, keeping several vector store configurations.
 */
model VectorStore {
  /** Name */
  @encodedName("application/json", "name")
  name: string;

  /** Configurations */
  @encodedName("application/json", "configuration")
  configuration: VectorStorageConfiguration;
}

/** A statically configured chunking strategy. */
model VectorStoreStaticChunkingStrategyResponse
  extends VectorStoreChunkingStrategyResponse {
  /** The object type, which is always 'static'. */
  type: VectorStoreChunkingStrategyResponseType.static;

  /** The options for the static chunking strategy. */
  static: VectorStoreStaticChunkingStrategyOptions;
}
