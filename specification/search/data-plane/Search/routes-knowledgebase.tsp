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
    // NOTE: SSEStream<T> is the spec-correct construct for this response, but C# SSE codegen is not
    // implemented upstream as of this writing (tracked: github.com/Azure/typespec-azure#614,
    // github.com/Azure/azure-sdk-for-net#47660, closed as not_planned/stale without being built). As a
    // result the OpenAPI 2.0 output for this 200 response is currently just `{"type": "string"}` --
    // no $ref to KnowledgeBaseRetrievalStreamEvents or its variants, and no Content-Type header -- and
    // the generated C# protocol method is a plain buffered Task<Response> with no typed per-event
    // parsing. This is acceptable for preview; revisit before GA once upstream codegen support lands
    // (or hand-roll a documented response alias again, as this operation used before this change).
    SSEStream<KnowledgeBaseRetrievalStreamEvents>,
    {},
    ErrorResponse
  >;
}
