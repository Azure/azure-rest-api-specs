import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Agents;

//
// Tool inputs -- definitions used before model evaluation to configure agents, threads, and messages
//

@doc("An abstract representation of an input tool definition that an agent can use.")
@discriminator("type")
@added(Versions.v2025_05_01)
model ToolDefinition {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;
}

@doc("The input definition information for a code interpreter tool as used to configure an agent.")
@added(Versions.v2025_05_01)
model CodeInterpreterToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'code_interpreter'.")
  type: "code_interpreter";
}

@doc("The input definition information for a file search tool as used to configure an agent.")
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
model FunctionToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'function'.")
  type: "function";

  @doc("The definition of the concrete function that the function tool should call.")
  function: FunctionDefinition;
}

// Azure Custom Tools

@doc("The input definition information for a bing grounding search tool as used to configure an agent.")
@added(Versions.v2025_05_01)
model BingGroundingToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'bing_grounding'.")
  type: "bing_grounding";

  @doc("The bing grounding search tool parameters.")
  bing_grounding: BingGroundingSearchToolParameters;
}

@doc("The fabric data agent tool parameters.")
@added(Versions.v2025_05_15_preview)
model FabricDataAgentToolParameters {
  /**
   * The connections attached to this tool. There can be a maximum of 1 connection
   * resource attached to the tool.
   */
  @maxItems(1)
  @encodedName("application/json", "connections")
  connectionList?: ToolConnection[];
}

@doc("The input definition information for a Microsoft Fabric tool as used to configure an agent.")
@added(Versions.v2025_05_15_preview)
model MicrosoftFabricToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'fabric_dataagent'.")
  type: "fabric_dataagent";

  @doc("The fabric data agent tool parameters.")
  fabric_dataagent: FabricDataAgentToolParameters;
}

@doc("The sharepoint grounding tool parameters.")
@added(Versions.v2025_05_15_preview)
model SharepointGroundingToolParameters {
  /**
   * The connections attached to this tool. There can be a maximum of 1 connection
   * resource attached to the tool.
   */
  @maxItems(1)
  @encodedName("application/json", "connections")
  connectionList?: ToolConnection[];
}

@doc("The input definition information for a sharepoint tool as used to configure an agent.")
@added(Versions.v2025_05_15_preview)
model SharepointToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'sharepoint_grounding'.")
  type: "sharepoint_grounding";

  @doc("The sharepoint grounding tool parameters.")
  sharepoint_grounding: SharepointGroundingToolParameters;
}

@doc("The input definition information for an Azure AI search tool as used to configure an agent.")
@added(Versions.v2025_05_01)
model AzureAISearchToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'azure_ai_search'.")
  type: "azure_ai_search";
}

@doc("The input definition information for an OpenAPI tool as used to configure an agent.")
@added(Versions.v2025_05_01)
model OpenApiToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'openapi'.")
  type: "openapi";

  @doc("The openapi function definition.")
  openapi: OpenApiFunctionDefinition;
}

@doc("The input definition information for a Bing custom search tool as used to configure an agent.")
@added(Versions.v2025_05_15_preview)
model BingCustomSearchToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'bing_custom_search'.")
  type: "bing_custom_search";

  @doc("The bing custom search tool parameters.")
  @encodedName("application/json", "bing_custom_search")
  bingCustomSearch: BingCustomSearchToolParameters;
}

@doc("The input definition information for a connected agent tool which defines a domain specific sub-agent")
@added(Versions.v2025_05_01)
model ConnectedAgentToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'connected_agent'.")
  type: "connected_agent";

  @doc("The sub-agent to connect")
  @encodedName("application/json", "connected_agent")
  connectedAgent: ConnectedAgentDetails;
}
@doc("The input definition information for a Deep Research tool as used to configure an agent.")
@added(Versions.v2025_05_15_preview)
model DeepResearchToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'deep_research'.")
  type: "deep_research";

  @doc("The deep_research tool definition configuration.")
  @encodedName("application/json", "deep_research")
  deepResearch: DeepResearchDetails;
}

@doc("The input definition information for a MCP tool which defines a MCP server endpoint")
@added(Versions.v2025_05_15_preview)
model MCPToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'mcp'.")
  type: "mcp";

  @doc("The label for the MCP server")
  @encodedName("application/json", "server_label")
  serverLabel: string;

  @doc("The endpoint for the MCP server")
  @encodedName("application/json", "server_url")
  serverUrl: string;

  @doc("List of allowed tools for MCP server")
  @encodedName("application/json", "allowed_tools")
  allowedTools?: string[];
}

// Definition details: File Search

/**
 * Options overrides for the file search tool.
 */
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
model AzureFunctionToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'azure_function'.")
  type: "azure_function";

  @doc("The definition of the concrete function that the function tool should call.")
  @encodedName("application/json", "azure_function")
  azureFunction: AzureFunctionDefinition;
}

@doc("The input definition information for a Browser Automation Tool, as used to configure an Agent.")
@added(Versions.v2025_05_15_preview)
model BrowserAutomationToolDefinition extends ToolDefinition {
  @doc("The object type, which is always 'browser_automation'.")
  type: "browser_automation";

  @doc("The Browser Automation Tool parameters.")
  @encodedName("application/json", "browser_automation")
  browserAutomation: BrowserAutomationToolParameters;
}

@doc("Definition of input parameters for the Browser Automation Tool.")
@added(Versions.v2025_05_15_preview)
model BrowserAutomationToolParameters {
  @doc("The connection parameters associated with the Browser Automation Tool.")
  connection: BrowserAutomationToolConnectionParameters;
}

@doc("Definition of input parameters for the connection used by the Browser Automation Tool.")
@added(Versions.v2025_05_15_preview)
model BrowserAutomationToolConnectionParameters {
  @doc("The ID of the connection to your Azure Playwright resource.")
  id: string;
}

/**
 * Ranking options for file search.
 */
@added(Versions.v2025_05_01)
model FileSearchRankingOptions {
  @doc("File search ranker.")
  ranker: string;

  @doc("Ranker search threshold.")
  @encodedName("application/json", "score_threshold")
  scoreThreshold: float32;
}

// Definition details: Functions

@doc("The input definition information for a function.")
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
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

  @doc("List of OpenAPI spec parameters that will use user-provided defaults")
  @encodedName("application/json", "default_params")
  defaultParams?: string[];

  @doc("List of function definitions used by OpenApi tool")
  @visibility(Lifecycle.Read)
  functions?: FunctionDefinition[];
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
@added(Versions.v2025_05_01)
model OpenApiAuthDetails {
  @doc("The type of authentication, must be anonymous/connection/managed_identity")
  type: OpenApiAuthType;
}

@doc("Security details for OpenApi anonymous authentication")
@added(Versions.v2025_05_01)
model OpenApiAnonymousAuthDetails extends OpenApiAuthDetails {
  @doc("The object type, which is always 'anonymous'.")
  type: OpenApiAuthType.anonymous;
}

@doc("Security details for OpenApi connection authentication")
@added(Versions.v2025_05_01)
model OpenApiConnectionAuthDetails extends OpenApiAuthDetails {
  @doc("The object type, which is always 'connection'.")
  type: OpenApiAuthType.connection;

  @doc("Connection auth security details")
  security_scheme: OpenApiConnectionSecurityScheme;
}

@doc("Security details for OpenApi managed_identity authentication")
@added(Versions.v2025_05_01)
model OpenApiManagedAuthDetails extends OpenApiAuthDetails {
  @doc("The object type, which is always 'managed_identity'.")
  type: OpenApiAuthType.managedIdentity;

  @doc("Connection auth security details")
  security_scheme: OpenApiManagedSecurityScheme;
}

@doc("Security scheme for OpenApi managed_identity authentication")
@added(Versions.v2025_05_01)
model OpenApiManagedSecurityScheme {
  @doc("Authentication scope for managed_identity auth type")
  audience: string;
}

@doc("Security scheme for OpenApi managed_identity authentication")
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
model RequiredToolCall {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type for the required tool call.")
  type: string;

  @doc("The ID of the tool call. This ID must be referenced when submitting tool outputs.")
  id: string;
}

@doc("A representation of a requested call to a function tool, needed by the model to continue evaluation of a run.")
@added(Versions.v2025_05_01)
model RequiredFunctionToolCall extends RequiredToolCall {
  @doc("The object type of the required tool call. Always 'function' for function tools.")
  type: "function";

  @doc("Detailed information about the function to be executed by the tool that includes name and arguments.")
  function: RequiredFunctionToolCallDetails;
}

@doc("The detailed information for a function invocation, as provided by a required action invoking a function tool, that includes the name of and arguments to the function.")
@added(Versions.v2025_05_01)
model RequiredFunctionToolCallDetails {
  @doc("The name of the function.")
  name: string;

  @doc("The arguments to use when invoking the named function, as provided by the model. Arguments are presented as a JSON document that should be validated and parsed for evaluation.")
  arguments: string;
}

@doc("A representation of a requested call to a MCP tool, needed by the model to continue evaluation of a run.")
@added(Versions.v2025_05_15_preview)
model RequiredMcpToolCall extends RequiredToolCall {
  @doc("The object type of the required tool call. Always 'mcp' for MCP tools.")
  type: "mcp";

  @doc("The arguments to use when invoking the mcp tool, as provided by the model. Arguments are presented as a JSON document that should be validated and parsed for evaluation.")
  arguments: string;

  @doc("The name of the function used on the MCP server.")
  name: string;

  @doc("The label of the MCP server.")
  server_label: string;
}

//
// Tool calls -- present in run steps and provide information about tool execution
//

@discriminator("type")
@doc("An abstract representation of a detailed tool call as recorded within a run step for an existing run.")
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
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
@added(Versions.v2025_05_01)
model RunStepBingGroundingToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'bing_grounding'.")
  type: "bing_grounding";

  @doc("The dictionary with request and response from Bing Grounding search tool.")
  @encodedName("application/json", "bing_grounding")
  bingGrounding: Record<string>;
}

@doc("""
  A record of a call to an Azure AI Search tool, issued by the model in evaluation of a defined tool, that represents
  executed Azure AI search.
  """)
@added(Versions.v2025_05_01)
model RunStepAzureAISearchToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'azure_ai_search'.")
  type: "azure_ai_search";

  @doc("Reserved for future use.")
  @encodedName("application/json", "azure_ai_search")
  azureAISearch: Record<string>;
}

@doc("""
  A record of a call to a Browser Automation tool issued by the Agent.
  """)
@added(Versions.v2025_05_15_preview)
model RunStepBrowserAutomationToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'browser_automation'.")
  type: "browser_automation";

  @doc("Details of the browser automation tool call.")
  @encodedName("application/json", "browser_automation")
  browserAutomation: BrowserAutomationToolCallDetails;
}

@doc("""
  Details of a Browser Automation tool call.
  """)
@added(Versions.v2025_05_15_preview)
model BrowserAutomationToolCallDetails {
  @doc("The input provided to the Browser Automation tool.")
  input: string;

  @doc("The output returned by the Browser Automation tool.")
  output: string;

  @doc("The steps the Browser Automation tool executed.")
  steps: BrowserAutomationToolCallStep[];
}

@doc("""
  Describes a single step of a Browser Automation tool execution.
  """)
@added(Versions.v2025_05_15_preview)
model BrowserAutomationToolCallStep {
  @doc("The result of the last step executed with the Browser.")
  @encodedName("application/json", "last_step_result")
  lastStepResult: string;

  @doc("The current state of execution with the Browser.")
  @encodedName("application/json", "current_state")
  currentState: string;

  @doc("The next step to execute with the Browser.")
  @encodedName("application/json", "next_step")
  nextStep: string;
}

@doc("""
  A record of a call to a MCP tool, issued by the model in evaluation of a defined tool, that represents
  executed MCP actions.
  """)
@added(Versions.v2025_05_15_preview)
model RunStepMcpToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'mcp'.")
  type: "mcp";

  @doc("Arguments to the MCP tool call, as provided by the model. Arguments are presented as a JSON document that should be validated and parsed for evaluation.")
  arguments: string;

  @doc("Name of the function used on the MCP server.")
  name: string;

  @doc("Output of the MCP tool call.")
  output: string;

  @doc("The label for the MCP server")
  @encodedName("application/json", "server_label")
  serverLabel?: string;
}

@doc("""
  A record of a call to a SharePoint tool, issued by the model in evaluation of a defined tool, that represents
  executed SharePoint actions.
  """)
@added(Versions.v2025_05_15_preview)
model RunStepSharepointToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'sharepoint_grounding'.")
  type: "sharepoint_grounding";

  @doc("SharePoint tool input and output.")
  @encodedName("application/json", "sharepoint_grounding")
  sharePoint: Record<string>;
}

@doc("""
  A record of a call to a Microsoft Fabric tool, issued by the model in evaluation of a defined tool, that represents
  executed Microsoft Fabric operations.
  """)
@added(Versions.v2025_05_15_preview)
model RunStepMicrosoftFabricToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'fabric_dataagent'.")
  type: "fabric_dataagent";

  @doc("Fabric input and output.")
  @encodedName("application/json", "fabric_dataagent")
  microsoftFabric: Record<string>;
}

@doc("""
  A record of a call to a Bing Custom Search tool, issued by the model in evaluation of a defined tool, that represents
  executed search with Bing Custom Search.
  """)
@added(Versions.v2025_05_15_preview)
model RunStepBingCustomSearchToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'bing_custom_search'.")
  type: "bing_custom_search";

  @doc("The dictionary with request and response from Bing Custom Search tool.")
  @encodedName("application/json", "bing_custom_search")
  bingCustomSearch: Record<string>;
}

@doc("""
  A record of a call to an Azure Function tool.
  """)
@added(Versions.v1)
model RunStepAzureFunctionToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'azure_function'.")
  type: "azure_function";

  @doc("The description of an Azure function call.")
  azure_function: AzureFunctionToolCallDetails;
}

@doc("""
  The Azure function call description. All the fields are present in the completed run step, however
  only some fields are present in the RunStepDeltaAzureFunctionToolCall.
  """)
@added(Versions.v1)
model AzureFunctionToolCallDetails {
  @doc("The Azure function name")
  name?: string;

  @doc("JSON serialized function arguments.")
  arguments?: string;

  @doc("The function output.")
  output?: string;
}

@doc("""
  A record of a call to a function tool, issued by the model in evaluation of a defined tool, that represents the inputs
  and output consumed and emitted by the specified function.
  """)
@added(Versions.v2025_05_01)
model RunStepFunctionToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'function'.")
  type: "function";

  @doc("The detailed information about the function called by the model.")
  function: RunStepFunctionToolCallDetails;
}

@doc("""
  A record of a call to an OpenAPI tool, issued by the model in evaluation of a defined tool, that represents
  executed OpenAPI operations.
  """)
@added(Versions.v2025_05_01)
model RunStepOpenAPIToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'openapi'.")
  type: "openapi";

  @doc("Reserved for future use.")
  @encodedName("application/json", "openapi")
  openAPI: Record<string>;
}

@doc("""
  A record of a call to a Deep Research tool, issued by the model in evaluation of a defined tool, that represents
  executed deep research operations.
  """)
@added(Versions.v2025_05_15_preview)
model RunStepDeepResearchToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'deep_research'.")
  type: "deep_research";

  @doc("The detailed information about the automated browser tasks performed by the model.")
  @encodedName("application/json", "deep_research")
  deepResearch: RunStepDeepResearchToolCallDetails;
}

/** A record of a call to the connected agent. */
@added(Versions.v2025_05_15_preview)
model RunStepConnectedAgentToolCall extends RunStepToolCall {
  @doc("The object type, which is always 'connected_agent'.")
  type: "connected_agent";

  @doc("The connected agent step information.")
  @encodedName("application/json", "connected_agent")
  connectedAgent: RunStepConnectedAgent;
}

// Call details: Code Interpreter

@doc("The detailed information about a code interpreter invocation by the model.")
@added(Versions.v2025_05_01)
model RunStepCodeInterpreterToolCallDetails {
  @doc("The input provided by the model to the code interpreter tool.")
  input: string;

  @doc("The outputs produced by the code interpreter tool back to the model in response to the tool call.")
  outputs: RunStepCodeInterpreterToolCallOutput[];
}

@discriminator("type")
@doc("An abstract representation of an emitted output from a code interpreter tool.")
@added(Versions.v2025_05_01)
model RunStepCodeInterpreterToolCallOutput {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The object type.")
  type: string;
}

@doc("A representation of a log output emitted by a code interpreter tool in response to a tool call by the model.")
@added(Versions.v2025_05_01)
model RunStepCodeInterpreterLogOutput
  extends RunStepCodeInterpreterToolCallOutput {
  @doc("The object type, which is always 'logs'.")
  type: "logs";

  @doc("The serialized log output emitted by the code interpreter.")
  logs: string;
}

@doc("A representation of an image output emitted by a code interpreter tool in response to a tool call by the model.")
@added(Versions.v2025_05_01)
model RunStepCodeInterpreterImageOutput
  extends RunStepCodeInterpreterToolCallOutput {
  @doc("The object type, which is always 'image'.")
  type: "image";

  @doc("Referential information for the image associated with this output.")
  image: RunStepCodeInterpreterImageReference;
}

@doc("An image reference emitted by a code interpreter tool in response to a tool call by the model.")
@added(Versions.v2025_05_01)
model RunStepCodeInterpreterImageReference {
  @encodedName("application/json", "file_id")
  @doc("The ID of the file associated with this image.")
  fileId: string;
}

// Call details: Functions

@doc("The detailed information about the function called by the model.")
@added(Versions.v2025_05_01)
model RunStepFunctionToolCallDetails {
  @doc("The name of the function.")
  name: string;

  @doc("The arguments that the model requires are provided to the named function.")
  arguments: string;
}

@doc("Search configuration for Bing Grounding")
@added(Versions.v2025_05_01)
model BingGroundingSearchConfiguration {
  @doc("Connection id for grounding with bing search")
  @encodedName("application/json", "connection_id")
  connectionId: string;

  @doc("The market where the results come from.")
  market?: string;

  @doc("The language to use for user interface strings when calling Bing API.")
  @encodedName("application/json", "set_lang")
  setLang?: string;

  @doc("The number of search results to return in the bing api response")
  count?: int64;

  @doc("Filter search results by a specific time range. Accepted values: https://learn.microsoft.com/bing/search-apis/bing-web-search/reference/query-parameters")
  freshness?: string;
}

// Call details: Deep Research
@doc("The detailed information about the deep research tasks performed by the model.")
@added(Versions.v2025_05_15_preview)
model RunStepDeepResearchToolCallDetails {
  @doc("The input provided by the model to the deep research tool.")
  input: string;

  @doc("The final output for the deep research tool.")
  output?: string;
}

// Call details: ConnectedAgent

@doc("The detailed information about connected agent tool call.")
@added(Versions.v2025_05_15_preview)
model RunStepConnectedAgent {
  @doc("The name of connected agent.")
  name?: string;

  @doc("The JSON serialized query to the connected agent.")
  arguments?: string;

  @doc("The tool output.")
  output?: string;

  @doc("The run ID used by the connected agent.")
  @encodedName("application/json", "run_id")
  runId?: string;

  @doc("The thread ID used by the connected agent.")
  @encodedName("application/json", "thread_id")
  threadId?: string;

  @doc("The ID of a connected agent.")
  @encodedName("application/json", "assistant_id")
  agentId?: string;
}

//
// Tool outputs -- structured data that provides requested information from tools back to the model
//

@doc("The data provided during a tool outputs submission to resolve pending tool calls and allow the model to continue.")
@added(Versions.v2025_05_01)
model ToolOutput {
  @doc("The ID of the tool call being resolved, as provided in the tool calls of a required action from a run.")
  @encodedName("application/json", "tool_call_id")
  toolCallId?: string;

  @doc("The output from the tool to be submitted.")
  output?: string;
}

//
// Tool approvals -- structured data that allows the client to send data to tool
//

@doc("The data provided during a tool outputs submission to resolve pending tool calls and allow the model to continue.")
@added(Versions.v2025_05_15_preview)
model ToolApproval {
  @doc("The ID of the tool call being resolved, as provided in the tool calls of a required action from a run.")
  @encodedName("application/json", "tool_call_id")
  toolCallId: string;

  @doc("The approval boolean value to be submitted.")
  approve: boolean;

  @doc("Headers to be attached to the approval.")
  headers?: Record<string>;
}

/**
 * Controls which (if any) tool is called by the model.
 * - `none` means the model will not call any tools and instead generates a message.
 * - `auto` is the default value and means the model can pick between generating a message or calling a tool.
 * Specifying a particular tool like `{"type": "file_search"}` or `{"type": "function", "function": {"name": "my_function"}}`
 * forces the model to call that tool.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the OpenAI API"
union AgentsToolChoiceOption {
  string,

  /** Specifies how the tool choice will be used */
  AgentsToolChoiceOptionMode,

  /** Specifies a tool the model should use. Use to force the model to call a specific tool. */
  AgentsNamedToolChoice,
}

/** Specifies how the tool choice will be used */
union AgentsToolChoiceOptionMode {
  string,

  /** The model will not call a function and instead generates a message. */
  none: "none",

  /** The model can pick between generating a message or calling a function. */
  auto: "auto",
}

/** Specifies a tool the model should use. Use to force the model to call a specific tool. */
@added(Versions.v2025_05_01)
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

  /** Tool type `fabric_dataagent` */
  @added(Versions.v2025_05_15_preview)
  microsoftFabric: "fabric_dataagent",

  /** Tool type `sharepoint_grounding` */
  @added(Versions.v2025_05_15_preview)
  sharepoint: "sharepoint_grounding",

  /** Tool type `azure_ai_search` */
  azureAISearch: "azure_ai_search",

  /** Tool type `bing_custom_search` */
  @added(Versions.v2025_05_15_preview)
  bingCustomSearch: "bing_custom_search",

  /** Tool type `connected_agent` */
  connectedAgent: "connected_agent",

  /** Tool type `deep_research` */
  @added(Versions.v2025_05_15_preview)
  deepResearch: "deep_research",

  /** Tool type `mcp` */
  @added(Versions.v2025_05_15_preview)
  mcp: "mcp",
}

/** The function name that will be used, if using the `function` tool */
@added(Versions.v2025_05_01)
model FunctionName {
  /** The name of the function to call */
  name: string;
}

/**
 * A set of connection resources currently used by either the `bing_grounding`, `fabric_dataagent`, or `sharepoint_grounding` tools.
 */
@added(Versions.v2025_05_01)
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
 * The bing grounding search tool parameters.
 */
@added(Versions.v2025_05_01)
model BingGroundingSearchToolParameters {
  /**
   * The connections attached to this tool. There can be a maximum of 1 connection
   * resource attached to the tool.
   */
  @removed(Versions.v2025_05_01)
  connections: ToolConnectionList;

  /**
   * The search configurations attached to this tool. There can be a maximum of 1
   * search configuration resource attached to the tool.
   */
  @added(Versions.v2025_05_01)
  @maxItems(1)
  @encodedName("application/json", "search_configurations")
  searchConfigurations: BingGroundingSearchConfiguration[];
}

/**
 * The bing custom search tool parameters.
 */
@added(Versions.v2025_05_15_preview)
model BingCustomSearchToolParameters {
  /**
   * The connections attached to this tool. There can be a maximum of 1 connection
   * resource attached to the tool.
   */
  @maxItems(1)
  @encodedName("application/json", "search_configurations")
  searchConfigurations: BingCustomSearchConfiguration[];
}

/**
 * Information for connecting one agent to another as a tool
 */
@added(Versions.v2025_05_01)
model ConnectedAgentDetails {
  @doc("The identifier of the child agent.")
  id: string;

  @doc("The name of the agent to be called.")
  name: string;

  @doc("A description of what the agent does, used by the model to choose when and how to call the agent.")
  description: string;
}

/**
 * The details of the Deep Research tool.
 */
@added(Versions.v2025_05_15_preview)
model DeepResearchDetails {
  @doc("The deep research model deployment name.")
  @encodedName("application/json", "deep_research_model")
  `model`: string;

  @doc("The array containing Bing grounding connection IDs to enhance deep research capabilities.")
  @encodedName("application/json", "bing_grounding_connections")
  bingGroundingConnections: DeepResearchBingGroundingConnection[];
}

/**
 * The connection resource ID for the Bing grounding resource .
 */
@added(Versions.v2025_05_15_preview)
model DeepResearchBingGroundingConnection {
  @doc("The connection ID for the Bing grounding connection.")
  @encodedName("application/json", "connection_id")
  connectionId: string;
}

/**
 * A connection resource.
 */
@added(Versions.v2025_05_01)
model ToolConnection {
  /**
   * A connection in a ToolConnectionList attached to this tool.
   */
  @encodedName("application/json", "connection_id")
  connectionId: string;
}

/**
 * A bing custom search configuration.
 */
@added(Versions.v2025_05_01)
model BingCustomSearchConfiguration {
  @doc("Connection id for grounding with bing search")
  @encodedName("application/json", "connection_id")
  connectionId: string;

  /**
   * Name of the custom configuration instance given to config.
   */
  @encodedName("application/json", "instance_name")
  instanceName: string;

  @doc("The market where the results come from.")
  market?: string;

  @doc("The language to use for user interface strings when calling Bing API.")
  @encodedName("application/json", "set_lang")
  setLang?: string;

  @doc("The number of search results to return in the bing api response")
  count?: int64;

  @doc("Filter search results by a specific time range. Accepted values: https://learn.microsoft.com/bing/search-apis/bing-web-search/reference/query-parameters")
  freshness?: string;
}

@doc("The structure for keeping storage queue name and URI.")
@added(Versions.v2025_05_01)
model AzureFunctionBinding {
  @doc("The type of binding, which is always 'storage_queue'.")
  type: "storage_queue";

  @doc("Storage queue.")
  @encodedName("application/json", "storage_queue")
  storageQueue: AzureFunctionStorageQueue;
}

@doc("The structure for keeping storage queue name and URI.")
@added(Versions.v2025_05_01)
model AzureFunctionStorageQueue {
  @doc("URI to the Azure Storage Queue service allowing you to manipulate a queue.")
  @encodedName("application/json", "queue_service_endpoint")
  storageServiceEndpoint: string;

  @doc("The name of an Azure function storage queue.")
  @encodedName("application/json", "queue_name")
  queueName: string;
}
