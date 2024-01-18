import "@typespec/versioning";
import "./functions.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

// tool_choice: "auto" | "none" | { "type": "function", "name": string }

#suppress "@azure-tools/typespec-autorest/union-unsupported" "External API shape is defined in OpenAPI 3.0 as oneOf."
alias ChatCompletionsToolSelection = ChatCompletionsToolSelectionPreset | ChatCompletionsNamedToolSelection;

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("Represents a generic policy for how a chat completions tool may be selected.")
enum ChatCompletionsToolSelectionPreset {
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

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("A tool selection of a specific, named function tool that will limit chat completions to using the named function.")
model ChatCompletionsNamedFunctionToolSelection
  extends ChatCompletionsNamedToolSelection {
  @doc("The object type, which is always 'function'.")
  type: "function";

  @doc("The name of the function that should be called.")
  name: string;
}

// tool definitions: provided in the request options

@discriminator("type")
@doc("An abstract representation of a tool that can be used by the model to improve a chat completions response.")
@added(ServiceApiVersions.v2023_12_01_Preview)
model ChatCompletionsToolDefinition {
  @doc("The object type.")
  type: string;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
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

// tool calls: received in responses

@discriminator("type")
@doc("""
An abstract representation of a tool call that must be resolved in a subsequent request to perform the requested
chat completion.
""")
@added(ServiceApiVersions.v2023_12_01_Preview)
model ChatCompletionsToolCall {
  @doc("The object type.")
  type: string;

  @doc("The ID of the tool call.")
  id: string;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
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
