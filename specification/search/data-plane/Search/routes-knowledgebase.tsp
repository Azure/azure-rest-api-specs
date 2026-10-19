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
   * Retrieves relevant data from backing stores and streams progress and results as server-sent
   * events.
   *
   * Process the response incrementally using server-sent event framing. Each event contains an
   * event name and a JSON-encoded data payload. The stream ends with either a `response.completed`
   * event or an `error` event. OpenAPI 2.0 represents the response body as a string, so generated
   * clients may expose the raw response without typed event parsing. Do not deserialize the
   * complete response body as a single JSON document.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API contract"
  @added(Versions.v2026_08_01_preview)
  @sharedRoute
  @post
  @route("/knowledgebases('{knowledgeBaseName}')/retrieve")
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
    SSEStream<KnowledgeBaseRetrievalStreamEvents>,
    {},
    ErrorResponse
  >;
}
