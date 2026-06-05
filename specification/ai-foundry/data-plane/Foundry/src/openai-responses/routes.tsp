import "../common/openai-templates.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/responses";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/responses")
@tag("Responses")
interface Responses {
  @post
  @summary("""
    Creates a model response. Provide [text](/docs/guides/text) or
    [image](/docs/guides/images) inputs to generate [text](/docs/guides/text)
    or [JSON](/docs/guides/structured-outputs) outputs. Have the model call
    your own [custom code](/docs/guides/function-calling) or use built-in
    [tools](/docs/guides/tools) like [web search](/docs/guides/tools-web-search)
    or [file search](/docs/guides/tools-file-search) to use your own data
    as input for the model's response.
    
    """)
  createResponse is OpenAIAgentSessionOperation<
    {
      @body
      body: OpenAI.CreateResponse;
    },
    OpenAI.Response
  >;

  @route("{response_id}")
  @delete
  @summary("""
    Deletes a model response with the given ID.
    
    """)
  deleteResponse is OpenAIAgentSessionOperation<
    {
      /** The ID of the response to delete. */
      @path
      response_id: string;
    },
    OpenAI.DeleteResponseResponse
  >;

  @route("{response_id}")
  @get
  @summary("""
    Retrieves a model response with the given ID.
    
    """)
  getResponse is OpenAIAgentSessionOperation<
    {
      /** The ID of the response to retrieve. */
      @path
      response_id: string;

      /**Additional fields to include in the response. See the `include`
  parameter for Response creation above for more information.*/
      @query(#{ explode: true })
      include?: OpenAI.IncludeEnum[];

      /**If set to true, the model response data will be streamed to the client
  as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format).
  See the [Streaming section below](/docs/api-reference/responses-streaming)
  for more information.*/
      @query(#{ explode: true })
      stream?: boolean;

      /** The sequence number of the event after which to start streaming. */
      @query(#{ explode: true })
      starting_after?: integer;

      /**When true, stream obfuscation will be enabled. Stream obfuscation adds
  random characters to an `obfuscation` field on streaming delta events
  to normalize payload sizes as a mitigation to certain side-channel
  attacks. These obfuscation fields are included by default, but add a
  small amount of overhead to the data stream. You can set
  `include_obfuscation` to false to optimize for bandwidth if you trust
  the network links between your application and the OpenAI API.*/
      @query(#{ explode: true })
      include_obfuscation?: boolean;
    },
    OpenAI.Response
  >;

  @route("{response_id}/cancel")
  @post
  @summary("""
    Cancels a model response with the given ID. Only responses created with
    the `background` parameter set to `true` can be cancelled.
    [Learn more](/docs/guides/background).
    
    """)
  cancelResponse is OpenAIAgentSessionOperation<
    {
      /** The ID of the response to cancel. */
      @path
      response_id: string;
    },
    OpenAI.Response
  >;

  @list
  @route("{response_id}/input_items")
  @get
  @summary("Returns a list of input items for a given response.")
  listInputItems is OpenAIAgentPagedOperation<
    {
      /** The ID of the response to retrieve input items for. */
      @path
      response_id: string;

      /**A limit on the number of objects to be returned. Limit can range between
  1 and 100, and the default is 20.*/
      @query(#{ explode: true })
      limit?: integer = 20;

      /**The order to return the input items in. Default is `desc`.
  - `asc`: Return the input items in ascending order.
  - `desc`: Return the input items in descending order.*/
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum;

      /** An item ID to list items after, used in pagination. */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;

      /**Additional fields to include in the response. See the `include`
  parameter for Response creation above for more information.*/
      @query(#{ explode: true })
      include?: OpenAI.IncludeEnum[];
    },
    OpenAI.ResponseItemList
  >;

  @route("compact")
  @post
  @summary("""
    Compact a conversation. Returns a compacted response object.
    
    Learn when and how to compact long-running conversations in the [conversation state guide](/docs/guides/conversation-state#managing-the-context-window). For ZDR-compatible compaction details, see [Compaction (advanced)](/docs/guides/conversation-state#compaction-advanced).
    """)
  Compactconversation is OpenAISharedOperation<
    {
      @header
      contentType: "application/json" | "application/x-www-form-urlencoded";

      @body
      body: OpenAI.CompactResponseMethodPublicBody;
    },
    OpenAI.CompactResource
  >;

  @operationId("createResponseStream")
  @post
  createResponseStream is OpenAIAgentStreamingOperation<
    {
      @body
      body: OpenAI.CreateResponse;
    },
    OpenAI.ResponseAudioDeltaEvent
  >;

  @operationId("getResponseStream")
  @get
  @route("{response_id}")
  getResponseStream is OpenAIAgentStreamingOperation<
    {
      @path
      response_id: string;

      @query(#{ name: "include[]", explode: true })
      includables?: OpenAI.IncludeEnum[] = #[];

      @header
      accept: "text/event-stream";

      @query
      starting_after?: int32;
    },
    OpenAI.ResponseAudioDeltaEvent
  >;

  @operationId("listResponses")
  @get
  listResponses is OpenAIAgentFilteredPagedOperation<
    {
      /** Filter by agent name. If provided, only items associated with the specified agent will be returned. */
      @query
      agent_name?: string;

      /** Filter by agent ID in the format `name:version`. If provided, only items associated with the specified agent ID will be returned. */
      @query
      agent_id?: string;

      /** Filter by conversation ID. If provided, only responses associated with the specified conversation will be returned. */
      @query
      conversation_id?: string;
    },
    OpenAI.Response
  >;

  @operationId("compactResponseConversation")
  @post
  @route("compact")
  compactResponseConversation is OpenAIAgentSessionOperation<
    {
      @body
      body: OpenAI.CompactResponseMethodPublicBody;
    },
    OpenAI.CompactResource
  >;
}
