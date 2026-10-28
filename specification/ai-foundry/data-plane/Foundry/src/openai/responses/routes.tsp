import "./models.tsp";
import "../../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** Optional response header containing the session ID for hosted agent requests. */
alias AgentSessionIdResponseHeader = {
  /** Session ID for this request. Only present for hosted agent responses. Returns the provided session ID or an auto-generated one if not provided in the request. */
  @header("x-agent-session-id") agentSessionId?: string;
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("openai/v1/responses")
@tag("Responses")
interface Responses {
  /**
   * Creates a model response. Provide text or image inputs to generate text or JSON outputs. Have the model call your own custom code or use built-in tools like web search or file search to use your own data as input for the model’s response.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "Intentionally combining response schemas for documentation support."
  @summary("Create a model response")
  @operationId("createResponse")
  @post
  createResponse is OpenAIOperation<
    OpenAI.CreateResponse & UserDelegationHeader,
    | (AgentSessionIdResponseHeader & OpenAI.Response)
    | (AgentSessionIdResponseHeader &
        SseResponseOf<OpenAI.CreateResponseStreamingResponse>)
  >;

  /**
   * Retrieves a model response with the given ID.
   *
   * @param response_id The ID of the response to retrieve.
   * @param include Specifies additional output data to include in the model response.
   * @param stream If set to true, model response data will be streamed to the client as it is generated using server-sent events.
   * @param starting_after The sequence number of the event after which to start streaming.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "Intentionally combining response schemas for documentation support."
  @summary("Retrieve a model response")
  @operationId("getResponse")
  @get
  @route("{response_id}")
  getResponse is OpenAIOperation<
    {
      /** The response id path parameter. */
      @path
      @example("resp_677efb5139a88190b512bc3fef8e535d")
      response_id: string;

      /** The includables query parameter. */
      @query(#{ name: "include[]", explode: true })
      includables?: OpenAI.IncludeEnum[] = #[];

      /** The stream query parameter. */
      @query stream?: boolean = false;

      /** The sequence number of the event after which to start streaming. */
      @query starting_after?: int32;

      ...UserDelegationHeader;
    },
    | (AgentSessionIdResponseHeader & {
        /** The request body. */
        @body body: OpenAI.Response;
      })
    | (AgentSessionIdResponseHeader &
        SseResponseOf<OpenAI.CreateResponseStreamingResponse>)
  >;

  /**
   * Deletes a model response.
   */
  @summary("Delete a model response")
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

      ...UserDelegationHeader;
    },
    AgentSessionIdResponseHeader & {
      /** The request body. */
      @body body: DeleteResponseResult;
    }
  >;

  /**
   * Cancels a model response with the given ID. Only responses created with the background parameter set to true can be cancelled.
   */
  @summary("Cancel a model response")
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

      ...UserDelegationHeader;
    },
    AgentSessionIdResponseHeader & {
      /** The request body. */
      @body body: OpenAI.Response;
    }
  >;

  /**
   * Retrieves the input items associated with the specified response.
   */
  @summary("List input items for a response")
  @operationId("listInputItems")
  @get
  @route("{response_id}/input_items")
  @list
  listInputItems is OpenAIOperation<
    {
      /** The response id path parameter. */
      @path
      @example("resp_677efb5139a88190b512bc3fef8e535d")
      response_id: string;

      ...CommonPageQueryParameters;
      ...UserDelegationHeader;
    },
    AgentSessionIdResponseHeader & {
      /** The request body. */
      @body body: AgentsPagedResult<OpenAI.ItemResource>;
    }
  >;

  /**
   * Returns a collection of all stored responses matching specified filter criteria.
   */
  @summary("List responses")
  @get
  @operationId("listResponses")
  @list
  listResponses is OpenAIOperation<
    {
      ...CommonPageQueryParameters;
      ...AgentNameQueryParam;
      ...AgentIdQueryParam;
      ...ConversationIdQueryParam;
      ...UserDelegationHeader;
    },
    AgentsPagedResult<OpenAI.Response>
  >;

  /**
   * Compacts a conversation into a response object suitable for long-running and zero-data-retention scenarios.
   */
  @summary("Compact a conversation")
  @post
  @operationId("Compactconversation")
  @route("compact")
  Compactconversation is OpenAIOperation<
    OpenAI.CompactResponseMethodPublicBody,
    OpenAI.CompactResource
  >;
}
