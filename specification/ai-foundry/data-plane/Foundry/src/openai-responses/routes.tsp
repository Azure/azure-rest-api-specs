import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("openai/v1/responses")
@tag("Responses")
interface Responses {
  /**
   * Creates a model response.
   */
  @operationId("createResponse")
  @post
  @sharedRoute
  createResponse is OpenAIOperation<OpenAI.CreateResponse, OpenAI.Response>;

  /**
   * Creates a model response (streaming response).
   */
  @operationId("createResponseStream")
  @post
  @sharedRoute
  createResponseStream is OpenAIOperation<
    OpenAI.CreateResponse,
    SseResponseOf<OpenAI.CreateResponseStreamingResponse>
  >;

  /**
   * Retrieves a model response with the given ID.
   *
   * @param response_id The ID of the response to retrieve.
   * @param include Specifies additional output data to include in the model response.
   * @param stream If set to true, model response data will be streamed to the client as it is generated using server-sent events.
   * @param starting_after The sequence number of the event after which to start streaming.
   */
  @operationId("getResponse")
  @get
  @route("{response_id}")
  @sharedRoute
  getResponse is OpenAIOperation<
    {
      @path
      @example("resp_677efb5139a88190b512bc3fef8e535d")
      response_id: string;

      @query(#{ name: "include[]", explode: true })
      includables?: OpenAI.IncludeEnum[] = #[];

      @query stream?: boolean = false;
      @query starting_after?: int32;
    },
    OpenAI.Response
  >;

  /**
   * Retrieves a model response with the given ID (streaming response).
   *
   * @param response_id The ID of the response to retrieve.
   * @param include Specifies additional output data to include in the model response.
   * @param starting_after The sequence number of the event after which to start streaming.
   */
  @operationId("getResponseStream")
  @get
  @route("{response_id}")
  @sharedRoute
  getResponseStream is OpenAIOperation<
    {
      @path
      @example("resp_677efb5139a88190b512bc3fef8e535d")
      response_id: string;

      @query(#{ name: "include[]", explode: true })
      includables?: OpenAI.IncludeEnum[] = #[];

      @header accept: "text/event-stream";
      @query starting_after?: int32;
    },
    SseResponseOf<OpenAI.CreateResponseStreamingResponse>
  >;

  /**
   * Deletes a model response.
   */
  @delete
  @route("{response_id}")
  @operationId("deleteResponse")
  deleteResponse is OpenAIOperation<
    {
      /**
       * The ID of the response to delete.
       */
      @path
      @example("resp_677efb5139a88190b512bc3fef8e535d")
      response_id: string;
    },
    DeleteResponseResult
  >;

  /**
   * Cancels a model response.
   */
  @post
  @route("{response_id}/cancel")
  @operationId("cancelResponse")
  cancelResponse is OpenAIOperation<
    {
      /**
       * The ID of the response to cancel.
       */
      @path
      @example("resp_677efb5139a88190b512bc3fef8e535d")
      response_id: string;
    },
    OpenAI.Response
  >;

  /**
   * Returns a list of input items for a given response.
   */
  @operationId("listInputItems")
  @get
  @route("{response_id}/input_items")
  @list
  listInputItems is OpenAIOperation<
    {
      @path
      @example("resp_677efb5139a88190b512bc3fef8e535d")
      response_id: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<OpenAI.ItemResource>
  >;

  /**
   * Returns the list of all responses.
   */
  @get
  @operationId("listResponses")
  @list
  listResponses is OpenAIOperation<
    {
      ...CommonPageQueryParameters;
      ...AgentNameQueryParam;
      ...AgentIdQueryParam;
      ...ConversationIdQueryParam;
    },
    AgentsPagedResult<OpenAI.Response>
  >;
}
