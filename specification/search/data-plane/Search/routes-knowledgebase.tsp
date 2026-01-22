import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models-knowledgebase.tsp";
import "./models-shared.tsp";

using TypeSpec.Http;
using Azure.Core;

namespace Search;

@route("/knowledgebases('{knowledgeBaseName}')")
interface KnowledgeRetrieval {
  /** KnowledgeBase retrieves relevant data from backing stores. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @route("/retrieve")
  @post
  retrieve is Foundations.Operation<
    {
      ...acceptHeaderMinimal;

      /** The name of the knowledge base. */
      @path
      knowledgeBaseName: string;

      /** Token identifying the user for which the query is being executed. This token is used to enforce security restrictions on documents. */
      @header("x-ms-query-source-authorization")
      querySourceAuthorization?: string;

      /** The retrieval request to process. */
      @body
      retrievalRequest: KnowledgeBaseRetrievalRequest;
    } & ClientRequestIdHeader,
    KnowledgeBaseRetrievalSuccessResponse | KnowledgeBaseRetrievalPartialResponse,
    {},
    ErrorResponse
  >;
}
