import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

//
// Tool inputs -- definitions used before model evaluation to configure assistants, threads, and messages
//

@doc("An abstract representation of an input tool definition that an assistant can use.")
@discriminator("type")
@added(ServiceApiVersions.v2024_02_15_preview)
model ToolDefinition {
  @doc("The object type.")
  type: string;
}

@doc("The input definition information for a code interpreter tool as used to configure an assistant.")
@added(ServiceApiVersions.v2024_02_15_preview)
model CodeInterpreterToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'code_interpreter'.")
  type: "code_interpreter";
}

@doc("The input definition information for a retrieval tool as used to configure an assistant.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RetrievalToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'retrieval'.")
  type: "retrieval";
}

@doc("The input definition information for a function tool as used to configure an assistant.")
@added(ServiceApiVersions.v2024_02_15_preview)
model FunctionToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'function'.")
  type: "function";

  @doc("The definition of the concrete function that the function tool should call.")
  function: FunctionDefinition;
}

// Definition details: Functions

@doc("The input definition information for a function.")
@added(ServiceApiVersions.v2024_02_15_preview)
model FunctionDefinition {
  @doc("The name of the function to be called.")
  name: string;

  @doc("A description of what the function does, used by the model to choose when and how to call the function.")
  description?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
  @doc("The parameters the functions accepts, described as a JSON Schema object.")
  parameters: unknown;
}

//
// Tool calls -- provided during and after model evaluation to represent needed and past tool use
//

@discriminator("type")
@doc("""
An abstract representation a tool call, issued by the model in evaluation of a configured tool definition, that must
be fulfilled and have its outputs submitted before the model can continue.
""")
@added(ServiceApiVersions.v2024_02_15_preview)
model ToolCall {
  @doc("The object type.")
  type: string;

  @doc("The ID of the tool call. This ID must be referenced when you submit tool outputs.")
  id: string;
}

@doc("""
A tool call to a code interpreter tool, issued by the model in evaluation of a configured code interpreter tool, that
represents submitted output needed or already fulfilled by the tool for the model to continue.
""")
@added(ServiceApiVersions.v2024_02_15_preview)
model CodeInterpreterToolCall extends ToolCall {
  @doc("The object type, which is always 'code_interpreter'.")
  type: "code_interpreter";

  @projectedName("json", "code_interpreter")
  @doc("The details of the tool call to the code interpreter tool.")
  codeInterpreter: CodeInterpreterToolCallDetails;
}

@doc("""
A tool call to a retrieval tool, issued by the model in evaluation of a configured retrieval tool, that represents
submitted output needed or already fulfilled by the tool for the model to continue.
""")
@added(ServiceApiVersions.v2024_02_15_preview)
model RetrievalToolCall extends ToolCall {
  @doc("The object type, which is always 'retrieval'.")
  type: "retrieval";

  @doc("The key/value pairs produced by the retrieval tool.")
  retrieval: Record<string>;
}

@doc("""
A tool call to a function tool, issued by the model in evaluation of a configured function tool, that represents
given function inputs and submitted function outputs needed or already fulfilled by the tool for the model to continue.
""")
@added(ServiceApiVersions.v2024_02_15_preview)
model FunctionToolCall extends ToolCall {
  @doc("The object type, which is always 'function'.")
  type: "function";

  @doc("The detailed information about the function called by the model.")
  function: FunctionToolCallDetails;
}

// Call details: Code Interpreter

@doc("The detailed information about a code interpreter invocation by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model CodeInterpreterToolCallDetails {
  @doc("The input provided by the model to the code interpreter tool.")
  input: string;

  @doc("The outputs produced by the code interpreter tool back to the model in response to the tool call.")
  outputs: CodeInterpreterToolCallOutput[];
}

@discriminator("type")
@doc("An abstract representation of an emitted output from a code interpreter tool.")
@added(ServiceApiVersions.v2024_02_15_preview)
model CodeInterpreterToolCallOutput {
  @doc("The object type.")
  type: string;
}

@doc("A representation of a log output emitted by a code interpreter tool in response to a tool call by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model CodeInterpreterLogOutput extends CodeInterpreterToolCallOutput {
  @doc("The object type, which is always 'logs'.")
  type: "logs";

  @doc("The serialized log output emitted by the code interpreter.")
  logs: string;
}

@doc("A representation of an image output emitted by a code interpreter tool in response to a tool call by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model CodeInterpreterImageOutput extends CodeInterpreterToolCallOutput {
  @doc("The object type, which is always 'image'.")
  type: "image";

  @doc("Referential information for the image associated with this output.")
  image: CodeInterpreterImageReference;
}

@doc("An image reference emitted by a code interpreter tool in response to a tool call by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model CodeInterpreterImageReference {
  @projectedName("json", "file_id")
  @doc("The ID of the file associated with this image.")
  fileId: string;
}

// Call details: Functions

@doc("The detailed information about the function called by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model FunctionToolCallDetails {
  @doc("The name of the function.")
  name: string;

  @doc("The arguments that the model requires are provided to the named function.")
  arguments: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The output of the function, only populated for function calls that have already have had their outputs submitted.")
  output: string | null;
}

//
// Tool submissions -- structured data that provides requested information from tools back to the model
//

@doc("The data provided during a tool outputs submission to resolve pending tool calls and allow the model to continue.")
@added(ServiceApiVersions.v2024_02_15_preview)
model ToolOutput {
  @doc("The ID of the tool call being resolved, as provided in the tool calls of a required action from a run.")
  @projectedName("json", "tool_call_id")
  toolCallId?: string;

  @doc("The output from the tool to be submitted.")
  output?: string;
}
