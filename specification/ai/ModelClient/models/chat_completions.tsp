import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelClient;

alias ChatCompletionsOptions = {
  @doc("""
  The collection of context messages associated with this chat completions request.
  Typical usage begins with a chat message for the System role that provides instructions for
  the behavior of the assistant, followed by alternating messages between the User and
  Assistant roles.
  """)
  @minItems(1)
  messages: ChatRequestMessage[];

  @doc("""
  A value that influences the probability of generated tokens appearing based on their cumulative
  frequency in generated text.
  Positive values will make tokens less likely to appear as their frequency increases and
  decrease the likelihood of the model repeating the same statements verbatim.
  """)
  @maxValue(2.0)
  @minValue(-2.0)
  frequency_penalty?: float32 = 0.0;

  @doc("""
  A value indicating whether chat completions should be streamed for this request.
  """)
  stream?: boolean;

  @doc("""
  A value that influences the probability of generated tokens appearing based on their existing
  presence in generated text.
  Positive values will make tokens less likely to appear when they already exist and increase the
  model's likelihood to output new topics.
  """)
  @maxValue(2.0)
  @minValue(-2.0)
  presence_penalty?: float32 = 0.0;

  @doc("""
  The sampling temperature to use that controls the apparent creativity of generated completions.
  Higher values will make output more random while lower values will make results more focused
  and deterministic.
  It is not recommended to modify temperature and top_p for the same completions request as the
  interaction of these two settings is difficult to predict.
  """)
  @maxValue(1.0)
  @minValue(0.0)
  temperature?: float32 = 0.7;

  @doc("""
  An alternative to sampling with temperature called nucleus sampling. This value causes the
  model to consider the results of tokens with the provided probability mass. As an example, a
  value of 0.15 will cause only the tokens comprising the top 15% of probability mass to be
  considered.
  It is not recommended to modify temperature and top_p for the same completions request as the
  interaction of these two settings is difficult to predict.
  """)
  @maxValue(1.0)
  @minValue(0.0)
  top_p?: float32 = 1.0;

  @doc("The maximum number of tokens to generate.")
  @minValue(0.0)
  max_tokens?: int32;

  @doc("An object specifying the format that the model must output. Used to enable JSON mode.")
  response_format?: ChatCompletionsResponseFormat;

  @doc("""
    A collection of textual sequences that will end completions generation.
    """)
  @minItems(1)
  stop?: string[];

  @doc("The available tool definitions that the chat completions request can use, including caller-defined functions.")
  @minItems(1)
  tools?: ChatCompletionsToolDefinition[];

  @encodedName("application/json", "tool_choice")
  @doc("""
  If specified, the model will configure which of the provided tools it can use for the chat completions response.
  """)
  toolChoice?: ChatCompletionsToolSelection;

  @doc("""
  If specified, the system will make a best effort to sample deterministically such that repeated requests with the
  same seed and parameters should return the same result. Determinism is not guaranteed."
  """)
  seed?: int64;
};

alias ChatCompletionsCommon = {
  @doc("A unique identifier associated with this chat completions response.")
  id: string;

  @doc("The response object type, which is always `chat.completion`.")
  object: string;

  @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  created: utcDateTime;

  @doc("The model used for the chat completion.")
  `model`: string;

  @doc("""
  Usage information for tokens processed and generated as part of this completions operation.
  """)
  usage: CompletionsUsage;
};

@doc("""
Representation of the response data from a chat completions request.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
model ChatCompletions {
  ...ChatCompletionsCommon;

  @doc("""
    The collection of completions choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
  @minItems(1)
  choices: ChatChoice[];
}

@doc("""
Represents a response update to a chat completions request, when the service is streaming updates 
using Server Sent Events (SSE).
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
model ChatCompletionsUpdate {
  ...ChatCompletionsCommon;

  @doc("""
    An update to the collection of completion choices associated with this completions response.
    Generally, `n` choices are generated per provided prompt with a default value of 1.
    Token limits and other settings may limit the number of choices generated.
    """)
  @minItems(1)
  choices: ChatChoiceUpdate[];
}

@doc("""
Representation of the token counts processed for a completions request.
Counts consider all tokens across prompts, choices, choice alternates, best_of generations, and
other consumers.
""")
model CompletionsUsage {
  ...CapacityAlias;

  @doc("The number of tokens generated across all completions emissions.")
  completion_tokens: int32;

  @doc("The number of tokens in the provided prompts for the completions request.")
  prompt_tokens: int32;

  @doc("The total number of tokens processed for the completions request and response.")
  total_tokens: int32;
}

@doc("""
Representation of the manner in which a completions response concluded.
""")
union CompletionsFinishReason {
  string,

  @doc("Completions ended normally and reached its end of token generation.")
  stopped: "stop",

  @doc("Completions exhausted available token limits before generation could complete.")
  tokenLimitReached: "length",

  @doc("""
    Completions generated a response that was identified as potentially sensitive per content
    moderation policies.
    """)
  contentFiltered: "content_filter",

  @doc("Completion ended with the model calling a provided tool for output.")
  toolCalls: "tool_calls",
}

@doc("A description of the intended purpose of a message within a chat completions interaction.")
union ChatRole {
  string,

  @doc("The role that instructs or sets the behavior of the assistant.")
  system: "system",

  @doc("The role that provides input for chat completions.")
  user: "user",

  @doc("The role that provides responses to system-instructed, user-prompted input.")
  assistant: "assistant",

  @doc("The role that represents extension tool activity within a chat completions operation.")
  tool: "tool",
}

@doc("""
An representation of a response format configuration usable by Chat Completions. Can be used to enable JSON
mode.
""")
union ChatCompletionsResponseFormat {
  string,

  @doc("""
  The standard Chat Completions response format that can freely generate text and is not guaranteed to produce response
  content that adheres to a specific schema.
  """)
  text: "text",

  @doc("""
  A response format for Chat Completions that restricts responses to emitting valid JSON objects.
  """)
  json_object: "json_object",
}

alias ChatChoiceCommon = {
  @doc("The ordered index associated with this chat completions choice.")
  index: int32;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The operation already returns nulls"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  @doc("The reason that this chat completions choice completed its generated.")
  finish_reason: CompletionsFinishReason | null;
};

@doc("""
The representation of a single prompt completion as part of an overall chat completions request.
Generally, `n` choices are generated per provided prompt with a default value of 1.
Token limits and other settings may limit the number of choices generated.
""")
model ChatChoice {
  ...ChatChoiceCommon;

  @doc("The chat message for a given chat completions prompt.")
  message: ChatResponseMessage;
}

@doc("""
Represents an update to a single prompt completion when the service is streaming updates 
using Server Sent Events (SSE).
Generally, `n` choices are generated per provided prompt with a default value of 1.
Token limits and other settings may limit the number of choices generated.
""")
model ChatChoiceUpdate {
  ...ChatChoiceCommon;

  @doc("An update to the chat message for a given chat completions prompt.")
  delta: ChatResponseMessage;
}

@discriminator("role")
@doc("An abstract representation of a chat message as provided in a request.")
model ChatRequestMessage {
  @doc("The chat role associated with this message.")
  role: ChatRole;
}

@doc("""
A request chat message containing system instructions that influence how the model will generate a chat completions
response.
""")
model SystemMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'system' for system messages.")
  role: ChatRole.system;

  @doc("The contents of the system message.")
  content: string;
}

@doc("A request chat message representing user input to the assistant.")
model UserMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'user' for user messages.")
  role: ChatRole.user;

  @doc("The contents of the user message, with available input types varying by selected model.")
  content: string;
}

@doc("A request chat message representing response or action from the assistant.")
model AssistantMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'assistant' for assistant messages.")
  role: ChatRole.assistant;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content: string | null;

  @encodedName("application/json", "tool_calls")
  @doc("""
  The tool calls that must be resolved and have their outputs appended to subsequent input messages for the chat
  completions request to resolve as configured.
  """)
  toolCalls?: ChatCompletionsToolCall[];
}

@doc("A request chat message representing requested output from a configured tool.")
model ToolMessage extends ChatRequestMessage {
  @doc("The chat role associated with this message, which is always 'tool' for tool messages.")
  role: ChatRole.tool;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content: string | null;

  @encodedName("application/json", "tool_call_id")
  @doc("The ID of the tool call resolved by the provided content.")
  toolCallId: string;
}

@doc("A representation of a chat message as received in a response.")
model ChatResponseMessage {
  @doc("The chat role associated with the message.")
  role: ChatRole;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "explicitly nullable in mirrored API"
  @doc("The content of the message.")
  content: string | null;

  @encodedName("application/json", "tool_calls")
  @doc("""
  The tool calls that must be resolved and have their outputs appended to subsequent input messages for the chat
  completions request to resolve as configured.
  """)
  toolCalls?: ChatCompletionsToolCall[];
}

// tool_choice: "auto" | "none" | { "type": "function", "name": string }

#suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
alias ChatCompletionsToolSelection = ChatCompletionsToolSelectionPreset | ChatCompletionsNamedToolSelection;

@doc("Represents a generic policy for how a chat completions tool may be selected.")
union ChatCompletionsToolSelectionPreset {
  string,

  @doc("""
  Specifies that the model may either use any of the tools provided in this chat completions request or
  instead return a standard chat completions response as if no tools were provided.
  """)
  auto: "auto",

  @doc("""
  Specifies that the model should not respond with a tool call and should instead provide a standard chat
  completions response. Response content may still be influenced by the provided tool definitions.
  """)
  none: "none",
}

@discriminator("type")
@doc("An abstract representation of an explicit, named tool selection to use for a chat completions request.")
model ChatCompletionsNamedToolSelection {
  @doc("The object type.")
  type: string;
}

@discriminator("type")
@doc("An abstract representation of a tool that can be used by the model to improve a chat completions response.")
model ChatCompletionsToolDefinition {
  @doc("The object type.")
  type: string;
}

@doc("""
The definition information for a chat completions function tool that can call a function in response to a tool call.
""")
model ChatCompletionsFunctionToolDefinition
  extends ChatCompletionsToolDefinition {
  @doc("The object name, which is always 'function'.")
  type: "function";

  @doc("The function definition details for the function tool.")
  function: FunctionDefinition;
}

@doc("""
The definition of a caller-specified function that chat completions may invoke in response to matching user input.
""")
model FunctionDefinition {
  @doc("The name of the function to be called.")
  name: string;

  @doc("""
  A description of what the function does. The model will use this description when selecting the function and
  interpreting its parameters.
  """)
  description?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
  @doc("The parameters the function accepts, described as a JSON Schema object.")
  parameters?: unknown;
}

@discriminator("type")
@doc("""
An abstract representation of a tool call that must be resolved in a subsequent request to perform the requested
chat completion.
""")
model ChatCompletionsToolCall {
  @doc("The object type.")
  type: string;

  @doc("The ID of the tool call.")
  id: string;
}

@doc("""
A tool call to a function tool, issued by the model in evaluation of a configured function tool, that represents
a function invocation needed for a subsequent chat completions request to resolve.
""")
model ChatCompletionsFunctionToolCall extends ChatCompletionsToolCall {
  @doc("The type of tool call, in this case always 'function'.")
  type: "function";

  @doc("The details of the function invocation requested by the tool call.")
  function: FunctionCall;
}

@doc("The name and arguments of a function that should be called, as generated by the model.")
model FunctionCall {
  @doc("The name of the function to call.")
  name: string;

  @doc("""
  The arguments to call the function with, as generated by the model in JSON format.
  Note that the model does not always generate valid JSON, and may hallucinate parameters
  not defined by your function schema. Validate the arguments in your code before calling
  your function.
  """)
  arguments: string;
}
