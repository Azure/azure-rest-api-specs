import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@route("openai/responses")
@tag("Responses")
interface Responses {
  /**
   * Creates a model response.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @operationId("createResponse")
  @post
  @sharedRoute
  createResponse is AgentOperation<OpenAI.CreateResponse, OpenAI.Response>;

  /**
   * Creates a model response (streaming response).
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @operationId("createResponseStream")
  @post
  @sharedRoute
  createResponseStream(
    @body request: OpenAI.CreateResponse,
  ): OpenAI.SseResponseOf<OpenAI.ResponseStreamEvent>;

  /**
   * Retrieves a model response with the given ID.
   *
   * @param response_id The ID of the response to retrieve.
   * @param include Specifies additional output data to include in the model response.
   * @param stream If set to true, model response data will be streamed to the client as it is generated using server-sent events.
   * @param starting_after The sequence number of the event after which to start streaming.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @operationId("getResponse")
  @get
  @route("{response_id}")
  @sharedRoute
  getResponse is AgentOperation<
    {
      @path
      @example("resp_677efb5139a88190b512bc3fef8e535d")
      response_id: string;

      @query(#{ name: "include[]", explode: true })
      includables?: OpenAI.Includable[] = #[];

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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @operationId("getResponseStream")
  @get
  @route("{response_id}")
  @sharedRoute
  getResponseStream(
    @path
    @example("resp_677efb5139a88190b512bc3fef8e535d")
    response_id: string,

    @query(#{ name: "include[]", explode: true })
    includables?: OpenAI.Includable[] = #[],

    @header accept: "text/event-stream",
    @query starting_after?: int32,
  ): OpenAI.SseResponseOf<OpenAI.ResponseStreamEvent>;

  /**
   * Deletes a model response.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @delete
  @route("{response_id}")
  @operationId("deleteResponse")
  deleteResponse is AgentOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @post
  @route("{response_id}/cancel")
  @operationId("cancelResponse")
  cancelResponse is AgentOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @operationId("listInputItems")
  @get
  @route("{response_id}/input_items")
  @list
  listInputItems(
    ...ApiVersionParameter,

    @path
    @example("resp_677efb5139a88190b512bc3fef8e535d")
    response_id: string,

    ...OpenAI.CommonPageQueryParameters,
  ): AgentsPagedResult<OpenAI.ItemResource> | ApiErrorResponse;

  /**
   * Returns the list of all responses.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @get
  @operationId("listResponses")
  @list
  listResponses(
    ...ApiVersionParameter,
    ...OpenAI.CommonPageQueryParameters,
    ...AgentNameQueryParam,
    ...AgentIdQueryParam,
    ...ConversationIdQueryParam,
  ): AgentsPagedResult<OpenAI.Response> | ApiErrorResponse;
}
