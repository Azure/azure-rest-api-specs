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
// Required tool calls -- provided on a run and represent tools that need outputs submitted for the run to continue
//

@discriminator("type")
@doc("""
An abstract representation a a tool invocation needed by the model to continue a run.
""")
@added(ServiceApiVersions.v2024_02_15_preview)
model RequiredToolCall {
  @doc("The object type for the required tool call.")
  type: string;

  @doc("The ID of the tool call. This ID must be referenced when submitting tool outputs.")
  id: string;
}

@added(ServiceApiVersions.v2024_02_15_preview)
@doc("A representation of a requested call to a function tool, needed by the model to continue evaluation of a run.")
model RequiredFunctionToolCall extends RequiredToolCall {
  @doc("The object type of the required tool call. Always 'function' for function tools.")
  type: "function";

  @doc("Detailed information about the function to be executed by the tool that includes name and arguments.")
  function: RequiredFunctionToolCallDetails;
}

@added(ServiceApiVersions.v2024_02_15_preview)
@doc("The detailed information for a function invocation, as provided by a required action invoking a function tool, that includes the name of and arguments to the function.")
model RequiredFunctionToolCallDetails {
  @doc("The name of the function.")
  name: string;

  @doc("The arguments to use when invoking the named function, as provided by the model. Arguments are presented as a JSON document that should be validated and parsed for evaluation.")
  arguments: string;
}

//
// Tool calls -- present in run steps and provide information about tool execution
//

@discriminator("type")
@doc("An abstract representation of a detailed tool call as recorded within a run step for an existing run.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepToolCall {
  @doc("The object type.")
  type: string;

  @doc("The ID of the tool call. This ID must be referenced when you submit tool outputs.")
  id: string;
}

@doc("""
A record of a call to a code interpreter tool, issued by the model in evaluation of a defined tool, that
represents inputs and outputs consumed and emitted by the code interpreter.
""")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepCodeInterpreterToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'code_interpreter'.")
  type: "code_interpreter";

  @encodedName("application/json", "code_interpreter")
  @doc("The details of the tool call to the code interpreter tool.")
  codeInterpreter: RunStepCodeInterpreterToolCallDetails;
}

@doc("""
A record of a call to a retrieval tool, issued by the model in evaluation of a defined tool, that represents
executed retrieval actions.
""")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepRetrievalToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'retrieval'.")
  type: "retrieval";

  @doc("The key/value pairs produced by the retrieval tool.")
  retrieval: Record<string>;
}

@doc("""
A record of a call to a function tool, issued by the model in evaluation of a defined tool, that represents the inputs
and output consumed and emitted by the specified function.
""")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepFunctionToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'function'.")
  type: "function";

  @doc("The detailed information about the function called by the model.")
  function: RunStepFunctionToolCallDetails;
}

// Call details: Code Interpreter

@doc("The detailed information about a code interpreter invocation by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepCodeInterpreterToolCallDetails {
  @doc("The input provided by the model to the code interpreter tool.")
  input: string;

  @doc("The outputs produced by the code interpreter tool back to the model in response to the tool call.")
  outputs: RunStepCodeInterpreterToolCallOutput[];
}

@discriminator("type")
@doc("An abstract representation of an emitted output from a code interpreter tool.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepCodeInterpreterToolCallOutput {
  @doc("The object type.")
  type: string;
}

@doc("A representation of a log output emitted by a code interpreter tool in response to a tool call by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepCodeInterpreterLogOutput
  extends RunStepCodeInterpreterToolCallOutput {
  @doc("The object type, which is always 'logs'.")
  type: "logs";

  @doc("The serialized log output emitted by the code interpreter.")
  logs: string;
}

@doc("A representation of an image output emitted by a code interpreter tool in response to a tool call by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepCodeInterpreterImageOutput
  extends RunStepCodeInterpreterToolCallOutput {
  @doc("The object type, which is always 'image'.")
  type: "image";

  @doc("Referential information for the image associated with this output.")
  image: RunStepCodeInterpreterImageReference;
}

@doc("An image reference emitted by a code interpreter tool in response to a tool call by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepCodeInterpreterImageReference {
  @encodedName("application/json", "file_id")
  @doc("The ID of the file associated with this image.")
  fileId: string;
}

// Call details: Functions

@doc("The detailed information about the function called by the model.")
@added(ServiceApiVersions.v2024_02_15_preview)
model RunStepFunctionToolCallDetails {
  @doc("The name of the function.")
  name: string;

  @doc("The arguments that the model requires are provided to the named function.")
  arguments: string;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  @doc("The output of the function, only populated for function calls that have already have had their outputs submitted.")
  output: string | null;
}

//
// Tool outputs -- structured data that provides requested information from tools back to the model
//

@doc("The data provided during a tool outputs submission to resolve pending tool calls and allow the model to continue.")
@added(ServiceApiVersions.v2024_02_15_preview)
model ToolOutput {
  @doc("The ID of the tool call being resolved, as provided in the tool calls of a required action from a run.")
  @encodedName("application/json", "tool_call_id")
  toolCallId?: string;

  @doc("The output from the tool to be submitted.")
  output?: string;
}
