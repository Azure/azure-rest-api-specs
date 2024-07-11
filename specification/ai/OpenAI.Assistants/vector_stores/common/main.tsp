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
union VectorStoreChunkingStrategyType {
    auto: "auto",
    static: "static",
    string,
}

/** An abstract representation of a vector store chunking strategy configuration. */
@discriminator("type")
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreChunkingStrategy {
    /** The object type. */
    type: VectorStoreChunkingStrategyType;
}

/**
 * The default strategy. This strategy currently uses a max_chunk_size_tokens of 800 and chunk_overlap_tokens of 400.
 */
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreAutoChunkingStrategy {
    /** The object type, which is always 'auto'. */
    type: VectorStoreChunkingStrategyType.auto;
}

/** A statically configured chunking strategy. */
@added(ServiceApiVersions.v2024_07_01_preview)
model VectorStoreStaticChunkingStrategy {
    /** The object type, which is always 'static'. */
    type: VectorStoreChunkingStrategyType.static;

    /** The options for the static chunking strategy. */
    static: VectorStoreStaticChunkingStrategyOptions;
}
