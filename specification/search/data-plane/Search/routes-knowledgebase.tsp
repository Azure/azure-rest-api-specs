import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models-knowledgebase.tsp";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.SSE;
using Azure.Core;

namespace Search;

interface KnowledgeRetrieval {
  /** KnowledgeBase retrieves relevant data from backing stores. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @sharedRoute
  @post
  @route("/knowledgebases('{knowledgeBaseName}')/retrieve")
  retrieve is Foundations.Operation<
    {
      ...acceptHeaderMinimal;

      /** The name of the knowledge base. */
      @path
      knowledgeBaseName: string;

      ...querySourceAuthorizationHeader;
      ...queryWorkIQSourceAuthorizationHeader;

      /** The retrieval request to process. */
      @body
      retrievalRequest: KnowledgeBaseRetrievalRequest;
    } & ClientRequestIdHeader,
    | KnowledgeBaseRetrievalSuccessResponse
    | KnowledgeBaseRetrievalPartialResponse,
    {},
    ErrorResponse
  >;

  /**
   * KnowledgeBase retrieves relevant data from backing stores, streaming progress and results as
   * server-sent events on the same connection as they become available, instead of waiting for the
   * full retrieval to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @added(Versions.v2026_08_01_preview)
  @sharedRoute
  @post
  @route("/knowledgebases('{knowledgeBaseName}')/retrieve")
  @Azure.ClientGenerator.Core.convenientAPI(false)
  retrieveStream is Foundations.Operation<
    {
      /** The Accept header. */
      @header("Accept")
      accept: "text/event-stream";

      /** The name of the knowledge base. */
      @path
      knowledgeBaseName: string;

      ...querySourceAuthorizationHeader;
      ...queryWorkIQSourceAuthorizationHeader;

      /** The retrieval request to process. */
      @body
      retrievalRequest: KnowledgeBaseRetrievalRequest;
    } & ClientRequestIdHeader,
    KnowledgeBaseRetrievalEventStreamResponse,
    {},
    ErrorResponse
  >;
}
