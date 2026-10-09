import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace Azure.Data.AI;

/** Semantic reranking operations. */
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
}
