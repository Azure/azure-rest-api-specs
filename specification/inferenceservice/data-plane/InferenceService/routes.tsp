import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.Data.AI;

/** Semantic reranking and embedding operations. */
interface InferenceOperationGroup {
  /** Reranks documents by their relevance to a query. */
  #suppress "@azure-tools/typespec-azure-core/no-error-status-codes" "Provide error status codes for the semantic reranking operation."
  @route("/inference/semanticReranking")
  @post
  semanticRerank is Azure.Core.RpcOperation<
    {
      /** The semantic reranking request. */
      @bodyRoot
      request: SemanticRerankingInferenceContent;
    },
    SemanticRerankingResult,
    {},
    InferenceOperationError
  >;

  /**
   * Embeds text, queries and document images and returns dense or multi-vector embeddings as numbers or base64. Text
   * and queries are sent inline. Images are read from the caller's Azure Blob Storage with a caller-signed user
   * delegation SAS (Microsoft Entra callers only). Results come back in the response or, with `delivery: link`, as a
   * time-limited read-only link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-error-status-codes" "Provide error status codes for the multimodal embedding operation."
  @added(Versions.v2026_11_01_preview)
  @route("/inference/embedding")
  @post
  embed is Azure.Core.RpcOperation<
    {
      ...EmbeddingContent;
    },
    EmbeddingOperationResult,
    {},
    EmbeddingOperationError
  >;
}
