import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Client.Agents;

//
// Tool inputs -- definitions used before model evaluation to configure agents, threads, and messages
//

@doc("An abstract representation of an input tool definition that an agent can use.")
@discriminator("type")
model ToolDefinition {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;
}

@doc("The input definition information for a code interpreter tool as used to configure an agent.")
model CodeInterpreterToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'code_interpreter'.")
  type: "code_interpreter";
}

@doc("The input definition information for a file search tool as used to configure an agent.")
model FileSearchToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'file_search'.")
  type: "file_search";

  /**
   * Options overrides for the file search tool.
   */
  @encodedName("application/json", "file_search")
  fileSearch?: FileSearchToolDefinitionDetails;
}

@doc("The input definition information for a function tool as used to configure an agent.")
model FunctionToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'function'.")
  type: "function";

  @doc("The definition of the concrete function that the function tool should call.")
  function: FunctionDefinition;
}

// Azure Custom Tools

@doc("The input definition information for a bing grounding search tool as used to configure an agent.")
model BingGroundingToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'bing_grounding'.")
  type: "bing_grounding";
}

@doc("The input definition information for a Microsoft Fabric tool as used to configure an agent.")
model MicrosoftFabricToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'microsoft_fabric'.")
  type: "microsoft_fabric";
}

@doc("The input definition information for a sharepoint tool as used to configure an agent.")
model SharepointToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'sharepoint'.")
  type: "sharepoint";
}

@doc("The input definition information for an Azure AI search tool as used to configure an agent.")
model AzureAISearchToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'azure_ai_search'.")
  type: "azure_ai_search";
}

// Definition details: File Search

/**
 * Options overrides for the file search tool.
 */
model FileSearchToolDefinitionDetails {
  /**
   * The maximum number of results the file search tool should output. The default is 20 for gpt-4* models and 5 for gpt-3.5-turbo. This number should be between 1 and 50 inclusive.
   *
   * Note that the file search tool may output fewer than `max_num_results` results. See the file search tool documentation for more information.
   */
  @encodedName("application/json", "max_num_results")
  @minValue(1)
  @maxValue(50)
  maxNumResults?: int32;
}

// Definition details: Functions

@doc("The input definition information for a function.")
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
model RequiredToolCall {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type for the required tool call.")
  type: string;

  @doc("The ID of the tool call. This ID must be referenced when submitting tool outputs.")
  id: string;
}

@doc("A representation of a requested call to a function tool, needed by the model to continue evaluation of a run.")
model RequiredFunctionToolCall extends RequiredToolCall {
  @doc("The object type of the required tool call. Always 'function' for function tools.")
  type: "function";

  @doc("Detailed information about the function to be executed by the tool that includes name and arguments.")
  function: RequiredFunctionToolCallDetails;
}

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
model RunStepToolCall {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;

  @doc("The ID of the tool call. This ID must be referenced when you submit tool outputs.")
  id: string;
}

@doc("""
  A record of a call to a code interpreter tool, issued by the model in evaluation of a defined tool, that
  represents inputs and outputs consumed and emitted by the code interpreter.
  """)
model RunStepCodeInterpreterToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'code_interpreter'.")
  type: "code_interpreter";

  @encodedName("application/json", "code_interpreter")
  @doc("The details of the tool call to the code interpreter tool.")
  codeInterpreter: RunStepCodeInterpreterToolCallDetails;
}

@doc("""
  A record of a call to a file search tool, issued by the model in evaluation of a defined tool, that represents
  executed file search.
  """)
model RunStepFileSearchToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'file_search'.")
  type: "file_search";

  @doc("Reserved for future use.")
  @encodedName("application/json", "file_search")
  fileSearch: Record<string>;
}

@doc("""
  A record of a call to a bing grounding tool, issued by the model in evaluation of a defined tool, that represents
  executed search with bing grounding.
  """)
model RunStepBingGroundingToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'bing_grounding'.")
  type: "bing_grounding";

  @doc("Reserved for future use.")
  @encodedName("application/json", "bing_grounding")
  bingGrounding: Record<string>;
}

@doc("""
  A record of a call to an Azure AI Search tool, issued by the model in evaluation of a defined tool, that represents
  executed Azure AI search.
  """)
model RunStepAzureAISearchToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'azure_ai_search'.")
  type: "azure_ai_search";

  @doc("Reserved for future use.")
  @encodedName("application/json", "azure_ai_search")
  azureAISearch: Record<string>;
}

@doc("""
  A record of a call to a SharePoint tool, issued by the model in evaluation of a defined tool, that represents
  executed SharePoint actions.
  """)
model RunStepSharepointToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'sharepoint'.")
  type: "sharepoint";

  @doc("Reserved for future use.")
  @encodedName("application/json", "sharepoint")
  sharePoint: Record<string>;
}

@doc("""
  A record of a call to a Microsoft Fabric tool, issued by the model in evaluation of a defined tool, that represents
  executed Microsoft Fabric operations.
  """)
model RunStepMicrosoftFabricToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'microsoft_fabric'.")
  type: "microsoft_fabric";

  @doc("Reserved for future use.")
  @encodedName("application/json", "microsoft_fabric")
  microsoftFabric: Record<string>;
}

@doc("""
  A record of a call to a function tool, issued by the model in evaluation of a defined tool, that represents the inputs
  and output consumed and emitted by the specified function.
  """)
model RunStepFunctionToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'function'.")
  type: "function";

  @doc("The detailed information about the function called by the model.")
  function: RunStepFunctionToolCallDetails;
}

// Call details: Code Interpreter

@doc("The detailed information about a code interpreter invocation by the model.")
model RunStepCodeInterpreterToolCallDetails {
  @doc("The input provided by the model to the code interpreter tool.")
  input: string;

  @doc("The outputs produced by the code interpreter tool back to the model in response to the tool call.")
  outputs: RunStepCodeInterpreterToolCallOutput[];
}

@discriminator("type")
@doc("An abstract representation of an emitted output from a code interpreter tool.")
model RunStepCodeInterpreterToolCallOutput {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;
}

@doc("A representation of a log output emitted by a code interpreter tool in response to a tool call by the model.")
model RunStepCodeInterpreterLogOutput
  extends RunStepCodeInterpreterToolCallOutput {
  @doc("The object type, which is always 'logs'.")
  type: "logs";

  @doc("The serialized log output emitted by the code interpreter.")
  logs: string;
}

@doc("A representation of an image output emitted by a code interpreter tool in response to a tool call by the model.")
model RunStepCodeInterpreterImageOutput
  extends RunStepCodeInterpreterToolCallOutput {
  @doc("The object type, which is always 'image'.")
  type: "image";

  @doc("Referential information for the image associated with this output.")
  image: RunStepCodeInterpreterImageReference;
}

@doc("An image reference emitted by a code interpreter tool in response to a tool call by the model.")
model RunStepCodeInterpreterImageReference {
  @encodedName("application/json", "file_id")
  @doc("The ID of the file associated with this image.")
  fileId: string;
}

// Call details: Functions

@doc("The detailed information about the function called by the model.")
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
model ToolOutput {
  @doc("The ID of the tool call being resolved, as provided in the tool calls of a required action from a run.")
  @encodedName("application/json", "tool_call_id")
  toolCallId?: string;

  @doc("The output from the tool to be submitted.")
  output?: string;
}

/**
 * Controls which (if any) tool is called by the model.
 * - `none` means the model will not call any tools and instead generates a message.
 * - `auto` is the default value and means the model can pick between generating a message or calling a tool.
 * Specifying a particular tool like `{"type": "file_search"}` or `{"type": "function", "function": {"name": "my_function"}}`
 * forces the model to call that tool.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the OpenAI API"
union AgentsApiToolChoiceOption {
  string,

  /** Specifies how the tool choice will be used */
  AgentsApiToolChoiceOptionMode,

  /** Specifies a tool the model should use. Use to force the model to call a specific tool. */
  AgentsNamedToolChoice,
}

/** Specifies how the tool choice will be used */
union AgentsApiToolChoiceOptionMode {
  string,

  /** The model will not call a function and instead generates a message. */
  none: "none",

  /** The model can pick between generating a message or calling a function. */
  auto: "auto",
}
/** Specifies a tool the model should use. Use to force the model to call a specific tool. */
model AgentsNamedToolChoice {
  /** the type of tool. If type is `function`, the function name must be set. */
  type: AgentsNamedToolChoiceType;

  /** The name of the function to call */
  function?: FunctionName;
}

/** Available tool types for agents named tools. */
union AgentsNamedToolChoiceType {
  string,

  /** Tool type `function` */
  function: "function",

  /** Tool type `code_interpreter` */
  codeInterpreter: "code_interpreter",

  /** Tool type `file_search` */
  fileSearch: "file_search",

  /** Tool type `bing_grounding` */
  bingGrounding: "bing_grounding",

  /** Tool type `microsoft_fabric` */
  microsoftFabric: "microsoft_fabric",

  /** Tool type `sharepoint` */
  sharepoint: "sharepoint",

  /** Tool type `azure_ai_search` */
  azureAISearch: "azure_ai_search",
}

/** The function name that will be used, if using the `function` tool */
model FunctionName {
  /** The name of the function to call */
  name: string;
}
