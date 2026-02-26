import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models-knowledgebase.tsp";
import "./models-shared.tsp";

using TypeSpec.Http;
using Azure.Core;

namespace Search;

interface KnowledgeRetrieval {
  /** KnowledgeBase retrieves relevant data from backing stores. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @post
  @route("/knowledgebases('{knowledgeBaseName}')/retrieve")
  retrieve is Foundations.Operation<
    {
      ...acceptHeaderMinimal;

      /** The name of the knowledge base. */
      @path
      knowledgeBaseName: string;

      ...querySourceAuthorizationHeader;

      /** The retrieval request to process. */
      @body
      retrievalRequest: KnowledgeBaseRetrievalRequest;
    } & ClientRequestIdHeader,
    KnowledgeBaseRetrievalSuccessResponse | KnowledgeBaseRetrievalPartialResponse,
    {},
    ErrorResponse
  >;
}
