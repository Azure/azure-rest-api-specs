import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects.Agents;

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

  @doc("The list of connections used by the bing grounding tool.")
  bing_grounding: ToolConnectionList;
}

@doc("The input definition information for a Microsoft Fabric tool as used to configure an agent.")
model MicrosoftFabricToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'fabric_aiskill'.")
  type: "fabric_aiskill";

  @doc("The list of connections used by the Microsoft Fabric tool.")
  fabric_aiskill: ToolConnectionList;
}

@doc("The input definition information for a sharepoint tool as used to configure an agent.")
model SharepointToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'sharepoint_grounding'.")
  type: "sharepoint_grounding";

  @doc("The list of connections used by the SharePoint tool.")
  sharepoint_grounding: ToolConnectionList;
}

@doc("The input definition information for an Azure AI search tool as used to configure an agent.")
model AzureAISearchToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'azure_ai_search'.")
  type: "azure_ai_search";
}

@doc("The input definition information for an OpenAPI tool as used to configure an agent.")
model OpenApiToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'openapi'.")
  type: "openapi";

  @doc("The openapi function definition.")
  openapi: OpenApiFunctionDefinition;
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

  /**
   * Ranking options for file search.
   */
  @encodedName("application/json", "ranking_options")
  rankingOptions?: FileSearchRankingOptions;
}

@doc("The input definition information for a azure function tool as used to configure an agent.")
model AzureFunctionToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'azure_function'.")
  type: "azure_function";

  @doc("The definition of the concrete function that the function tool should call.")
  @encodedName("application/json", "azure_function")
  azureFunction: AzureFunctionDefinition;
}

/**
 * Ranking options for file search.
 */
model FileSearchRankingOptions {
  @doc("File search ranker.")
  ranker: string;

  @doc("Ranker search threshold.")
  @encodedName("application/json", "score_threshold")
  scoreThreshold: float32;
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

@doc("The definition of Azure function.")
model AzureFunctionDefinition {
  @doc("The definition of azure function and its parameters.")
  function: FunctionDefinition;

  @doc("Input storage queue. The queue storage trigger runs a function as messages are added to it.")
  @encodedName("application/json", "input_binding")
  inputBinding: AzureFunctionBinding;

  @doc("Output storage queue. The function writes output to this queue when the input items are processed.")
  @encodedName("application/json", "output_binding")
  outputBinding: AzureFunctionBinding;
}

// Definition details: OpenAPI

@doc("The input definition information for an openapi function.")
model OpenApiFunctionDefinition {
  @doc("The name of the function to be called.")
  name: string;

  @doc("A description of what the function does, used by the model to choose when and how to call the function.")
  description?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
  @doc("The openapi function shape, described as a JSON Schema object.")
  spec: unknown;

  @doc("Open API authentication details")
  auth: OpenApiAuthDetails;
}

@doc("""
    Authentication type for OpenApi endpoint. Allowed types are:
    - Anonymous (no authentication required)
    - Connection (requires connection_id to endpoint, as setup in AI Foundry)
    - Managed_Identity (requires audience for identity based auth)
  """)
union OpenApiAuthType {
  anonymous: "anonymous",
  connection: "connection",
  managedIdentity: "managed_identity",
  string,
}

@doc("authentication details for OpenApiFunctionDefinition")
@discriminator("type")
model OpenApiAuthDetails {
  @doc("The type of authentication, must be anonymous/connection/managed_identity")
  type: OpenApiAuthType;
}

@doc("Security details for OpenApi anonymous authentication")
model OpenApiAnonymousAuthDetails extends OpenApiAuthDetails {
  @doc("The object type, which is always 'anonymous'.")
  type: OpenApiAuthType.anonymous;
}

@doc("Security details for OpenApi connection authentication")
model OpenApiConnectionAuthDetails extends OpenApiAuthDetails {
  @doc("The object type, which is always 'connection'.")
  type: OpenApiAuthType.connection;

  @doc("Connection auth security details")
  security_scheme: OpenApiConnectionSecurityScheme;
}

@doc("Security details for OpenApi managed_identity authentication")
model OpenApiManagedAuthDetails extends OpenApiAuthDetails {
  @doc("The object type, which is always 'managed_identity'.")
  type: OpenApiAuthType.managedIdentity;

  @doc("Connection auth security details")
  security_scheme: OpenApiManagedSecurityScheme;
}

@doc("Security scheme for OpenApi managed_identity authentication")
model OpenApiManagedSecurityScheme {
  @doc("Authentication scope for managed_identity auth type")
  audience: string;
}

@doc("Security scheme for OpenApi managed_identity authentication")
model OpenApiConnectionSecurityScheme {
  @doc("Connection id for Connection auth type")
  connection_id: string;
}

//
// Required tool calls -- provided on a run and represent tools that need outputs submitted for the run to continue
//

@discriminator("type")
@doc("""
  An abstract representation of a tool invocation needed by the model to continue a run.
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

  @doc("The ID of the tool call. This ID must be referenced when you submit tool outputs.")
  id: string;

  @doc("For now, this is always going to be an empty object.")
  @encodedName("application/json", "file_search")
  fileSearch: RunStepFileSearchToolCallResults;
}

@doc("The results of the file search.")
model RunStepFileSearchToolCallResults {
  @doc("Ranking options for file search.")
  @encodedName("application/json", "ranking_options")
  rankingOptions?: FileSearchRankingOptions;

  @doc("The array of a file search results")
  results: RunStepFileSearchToolCallResult[];
}

@doc("""
    File search tool call result.
  """)
model RunStepFileSearchToolCallResult {
  @doc("The ID of the file that result was found in.")
  @encodedName("application/json", "file_id")
  fileId: string;

  @doc("The name of the file that result was found in.")
  @encodedName("application/json", "file_name")
  fileName: string;

  @doc("The score of the result. All values must be a floating point number between 0 and 1.")
  @minValue(0)
  @maxValue(1)
  score: float32;

  @doc("The content of the result that was found. The content is only included if requested via the include query parameter.")
  content?: FileSearchToolCallContent[];
}

@doc("The file search result content object.")
model FileSearchToolCallContent {
  @doc("The type of the content.")
  type: "text";

  @doc("The text content of the file.")
  text: string;
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
  @doc("The object type, which is always 'sharepoint_grounding'.")
  type: "sharepoint_grounding";

  @doc("Reserved for future use.")
  @encodedName("application/json", "sharepoint_grounding")
  sharePoint: Record<string>;
}

@doc("""
  A record of a call to a Microsoft Fabric tool, issued by the model in evaluation of a defined tool, that represents
  executed Microsoft Fabric operations.
  """)
model RunStepMicrosoftFabricToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'fabric_aiskill'.")
  type: "fabric_aiskill";

  @doc("Reserved for future use.")
  @encodedName("application/json", "fabric_aiskill")
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

  /** Tool type `fabric_aiskill` */
  microsoftFabric: "fabric_aiskill",

  /** Tool type `sharepoint_grounding` */
  sharepoint: "sharepoint_grounding",

  /** Tool type `azure_ai_search` */
  azureAISearch: "azure_ai_search",
}

/** The function name that will be used, if using the `function` tool */
model FunctionName {
  /** The name of the function to call */
  name: string;
}

/**
 * A set of connection resources currently used by either the `bing_grounding`, `fabric_aiskill`, or `sharepoint_grounding` tools.
 */
model ToolConnectionList {
  /**
   * The connections attached to this tool. There can be a maximum of 1 connection
   * resource attached to the tool.
   */
  @maxItems(1)
  @encodedName("application/json", "connections")
  connectionList?: ToolConnection[];
}

/**
 * A connection resource.
 */
model ToolConnection {
  /**
   * A connection in a ToolConnectionList attached to this tool.
   */
  @encodedName("application/json", "connection_id")
  connectionId: string;
}

@doc("The structure for keeping storage queue name and URI.")
model AzureFunctionBinding {
  @doc("The type of binding, which is always 'storage_queue'.")
  type: "storage_queue";

  @doc("Storage queue.")
  @encodedName("application/json", "storage_queue")
  storageQueue: AzureFunctionStorageQueue;
}

@doc("The structure for keeping storage queue name and URI.")
model AzureFunctionStorageQueue {
  @doc("URI to the Azure Storage Queue service allowing you to manipulate a queue.")
  @encodedName("application/json", "queue_service_endpoint")
  storageServiceEndpoint: string;

  @doc("The name of an Azure function storage queue.")
  @encodedName("application/json", "queue_name")
  queueName: string;
}
