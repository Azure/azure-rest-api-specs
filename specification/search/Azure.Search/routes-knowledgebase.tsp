import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models-knowledgebase.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace Search;

@added(Versions.v2025_11_01_preview)
@route("/knowledgebases('{knowledgeBaseName}')")
interface KnowledgeRetrieval {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @doc("KnowledgeBase retrieves relevant data from backing stores.")
  @route("/retrieve")
  @post
  @added(Versions.v2025_11_01_preview)
  retrieve is Foundations.Operation<
    {
      @doc("The name of the knowledge base.")
      @path
      knowledgeBaseName: string;

      @doc("Token identifying the user for which the query is being executed. This token is used to enforce security restrictions on documents.")
      @header("x-ms-query-source-authorization")
      querySourceAuthorization?: string;

      @doc("The retrieval request to process.")
      @body
      retrievalRequest: KnowledgeBaseRetrievalRequest;
    } & ClientRequestIdHeader,
    KnowledgeBaseRetrievalSuccessResponse | KnowledgeBaseRetrievalPartialResponse
  >;
}
