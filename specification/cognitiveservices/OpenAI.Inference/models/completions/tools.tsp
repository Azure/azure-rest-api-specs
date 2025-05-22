import "@typespec/versioning";
import "./functions.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

// tool_choice: "auto" | "none" | { "type": "function", "name": string }

#suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
alias ChatCompletionsToolSelection = ChatCompletionsToolSelectionPreset | ChatCompletionsNamedToolSelection;

@added(ServiceApiVersions.v2024_02_15_Preview)
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

  /**
   * Specifies that the model must call one or more tools.
   */
  @added(ServiceApiVersions.v2024_07_01_Preview)
  required: "required",
}

@discriminator("type")
@doc("An abstract representation of an explicit, named tool selection to use for a chat completions request.")
model ChatCompletionsNamedToolSelection {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A tool selection of a specific, named function tool that will limit chat completions to using the named function.")
model ChatCompletionsNamedFunctionToolSelection
  extends ChatCompletionsNamedToolSelection {
  @doc("The object type, which is always 'function'.")
  type: "function";

  @doc("The function that should be called.")
  function: ChatCompletionsFunctionToolSelection;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A tool selection of a specific, named function tool that will limit chat completions to using the named function.")
model ChatCompletionsFunctionToolSelection {
  @doc("The name of the function that should be called.")
  name: string;
}

// tool definitions: provided in the request options

@discriminator("type")
@doc("An abstract representation of a tool that can be used by the model to improve a chat completions response.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model ChatCompletionsToolDefinition {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  The definition information for a chat completions function tool that can call a function in response to a tool call.
  """)
model ChatCompletionsFunctionToolDefinition
  extends ChatCompletionsToolDefinition {
  @doc("The object name, which is always 'function'.")
  type: "function";

  @doc("The function definition details for the function tool.")
  @typeChangedFrom(ServiceApiVersions.v2024_08_01_Preview, FunctionDefinition)
  function: {
    /** A description of what the function does, used by the model to choose when and how to call the function. */
    description?: string;

    /** The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. */
    name: string;

    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Non-Azure service uses loosely constrained JSON"
    parameters?: unknown;

    #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicitly nullable types"
    @doc("""
      Whether to enable strict schema adherence when generating the function call. If set to true, the model will follow the exact schema defined in the `parameters` field. Only a subset of JSON Schema is supported when `strict` is `true`. Learn more about Structured Outputs in the [function calling guide](docs/guides/function-calling).
      """)
    strict?: boolean | null = false;
  };
}

// tool calls: received in responses

@discriminator("type")
@doc("""
  An abstract representation of a tool call that must be resolved in a subsequent request to perform the requested
  chat completion.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model ChatCompletionsToolCall {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;

  @doc("The ID of the tool call.")
  id: string;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
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
