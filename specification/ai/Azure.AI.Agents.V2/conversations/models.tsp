import "@typespec/openapi";
import "../responses/models.tsp";
import "../common/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
model ConversationResource {
  /** The unique ID of the conversation. */
  id: string;

  /** The object type, which is always `conversation`. */
  @extension("x-stainless-const", true)
  object: "conversation" = "conversation";

  /**Set of 16 key-value pairs that can be attached to an object. This can be         useful for storing additional information about the object in a structured         format, and querying for objects via API or the dashboard.
  Keys are strings with a maximum length of 64 characters. Values are strings         with a maximum length of 512 characters.*/
  metadata: unknown;

  /** The time at which the conversation was created, measured in seconds since the Unix epoch. */
  created_at: integer;
}

@summary("The conversation object")
@extension(
  "x-oaiMeta",
  #{ name: "The conversation object", group: "conversations" }
)
model Conversation {
  /** The unique ID of the conversation. */
  id: string;

  /** The object type, which is always `conversation`. */
  @extension("x-stainless-const", true)
  object: "conversation" = "conversation";

  /**Set of 16 key-value pairs that can be attached to an object. This can be         useful for storing additional information about the object in a structured         format, and querying for objects via API or the dashboard.
  Keys are strings with a maximum length of 64 characters. Values are strings         with a maximum length of 512 characters.*/
  metadata: unknown;

  /** The time at which the conversation was created, measured in seconds since the Unix epoch. */
  created_at: integer;
}

@summary("Message")
model Message {
  /** The type of the message. Always set to `message`. */
  @extension("x-stainless-const", true)
  type: "message" = "message";

  /** The unique ID of the message. */
  id: string;

  /** The status of item. One of `in_progress`, `completed`, or `incomplete`. Populated when items are returned via API. */
  status: "in_progress" | "completed" | "incomplete";

  /** The role of the message. One of `unknown`, `user`, `assistant`, `system`, `critic`, `discriminator`, `developer`, or `tool`. */
  role:
    | "unknown"
    | "user"
    | "assistant"
    | "system"
    | "critic"
    | "discriminator"
    | "developer"
    | "tool";

  /** The content of the message */
  content: (
    | InputTextContent
    | OutputTextContent
    | TextContent
    | SummaryTextContent
    | RefusalContent
    | InputImageContent
    | ComputerScreenshotContent
    | InputFileContent)[];
}

@summary("Text Content")
model TextContent {
  @extension("x-stainless-const", true)
  type: "text" = "text";

  text: string;
}

@summary("Summary text")
model SummaryTextContent {
  @extension("x-stainless-const", true)
  type: "summary_text" = "summary_text";

  text: string;
}

@summary("Computer screenshot")
model ComputerScreenshotContent {
  /** Specifies the event type. For a computer screenshot, this property is always set to `computer_screenshot`. */
  @extension("x-stainless-const", true)
  type: "computer_screenshot" = "computer_screenshot";

  image_url: string | null;
  file_id: string | null;
}

/** A list of Conversation items. */
@summary("The conversation item list")
@extension("x-oaiMeta", #{ name: "The item list", group: "conversations" })
model ConversationItemList {
  /** The type of object returned, must be `list`. */
  @extension("x-stainless-const", true)
  object: "list";

  /** A list of conversation items. */
  data: ConversationItem[];

  /** Whether there are more items available. */
  has_more: boolean;

  /** The ID of the first item in the list. */
  first_id: string;

  /** The ID of the last item in the list. */
  last_id: string;
}

/** A single item within a conversation. The set of possible types are the same as the `output` type of a [Response object](https://platform.openai.com/docs/api-reference/responses/object#responses/object-output). */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
@summary("Conversation item")
@extension("x-oaiMeta", #{ name: "The item object", group: "conversations" })
union ConversationItem {
  message: Message,
  function_call: FunctionToolCallResource,
  function_call_output: FunctionToolCallOutputResource,
  file_search_call: FileSearchToolCall,
  web_search_call: WebSearchToolCall,
  image_generation_call: ImageGenToolCall,
  computer_call: ComputerToolCall,
  computer_call_output: ComputerToolCallOutputResource,
  reasoning: ReasoningItem,
  code_interpreter_call: CodeInterpreterToolCall,
  local_shell_call: LocalShellToolCall,
  local_shell_call_output: LocalShellToolCallOutput,
  mcp_list_tools: MCPListTools,
  mcp_approval_request: MCPApprovalRequest,
  mcp_approval_response: MCPApprovalResponseResource,
  mcp_call: MCPToolCall,
  custom_tool_call: CustomToolCall,
  custom_tool_call_output: CustomToolCallOutput,
}

/** Create a conversation */
model CreateConversationRequest {
  /**Set of 16 key-value pairs that can be attached to an object. Useful for
  storing additional information about the object in a structured format.*/
  metadata?: Metadata;

  /**Initial items to include in the conversation context.
  You may add up to 20 items at a time.*/
  @maxItems(20)
  items?: InputItem[];
}

/** The conversation that this response belongs to. */
@summary("Conversation object")
model ConversationParam {
  /** The unique ID of the conversation. */
  id: string;
}

model DeletedConversationResource {
  @extension("x-stainless-const", true)
  object: "conversation.deleted" = "conversation.deleted";

  deleted: boolean;
  id: string;
}

@summary("The deleted conversation object")
@extension(
  "x-oaiMeta",
  #{ name: "The deleted conversation object", group: "conversations" }
)
model DeletedConversation {
  @extension("x-stainless-const", true)
  object: "conversation.deleted" = "conversation.deleted";

  deleted: boolean;
  id: string;
}

model MetadataParam {}

model UpdateConversationBody {
  /**Set of 16 key-value pairs that can be attached to an object. This can be         useful for storing additional information about the object in a structured         format, and querying for objects via API or the dashboard.
  Keys are strings with a maximum length of 64 characters. Values are strings         with a maximum length of 512 characters.*/
  metadata: MetadataParam;
}
