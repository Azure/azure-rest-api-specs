import "@typespec/http";
import "@azure-tools/typespec-azure-core/experimental";

import "../.external-readonly/openai.external.typespec/responses/models.tsp";
import "../memory_stores/models.tsp";

using Azure.Core.Experimental;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

//
// Tool inputs -- definitions used before model evaluation to configure agents, threads, and messages
//

union _AgentToolType {
  bing_grounding: "bing_grounding",
  browser_automation_preview: "browser_automation_preview",
  fabric_dataagent_preview: "fabric_dataagent_preview",
  sharepoint_grounding_preview: "sharepoint_grounding_preview",
  azure_ai_search: "azure_ai_search",
  openapi: "openapi",
  bing_custom_search_preview: "bing_custom_search_preview",
  capture_structured_outputs: "capture_structured_outputs",
  a2a_preview: "a2a_preview",
  azure_function: "azure_function",

  @added(Versions.v2025_11_15_preview)
  @removed(Versions.v1)
  memory_search: "memory_search",
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyVariants(OpenAI.ToolType, Azure.AI.Projects._AgentToolType);

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union _AgentIncludable {
  "memory_search_call.results",
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyVariants(OpenAI.Includable, Azure.AI.Projects._AgentIncludable);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(OpenAI.MCPTool,
  {
    /**
     * The connection ID in the project for the MCP server. The connection stores authentication and other connection details needed to connect to the MCP server.
     */
    @added(Versions.v2025_11_15_preview)
    @removed(Versions.v1)
    project_connection_id?: string,
  }
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(OpenAI.WebSearchPreviewTool,
  {
    /**
     * The project connections attached to this tool. There can be a maximum of 1 connection
     * resource attached to the tool.
     */
    @added(Versions.v2025_11_15_preview)
    @removed(Versions.v1)
    custom_search_configuration?: WebSearchConfiguration,
  }
);

/**
 * A web search configuration for bing custom search
 */
model WebSearchConfiguration {
  /**
   * Project connection id for grounding with bing custom search
   */
  project_connection_id: string;

  /**
   * Name of the custom configuration instance given to config.
   */
  instance_name: string;
}

/**
 * The input definition information for a bing grounding search tool as used to configure an agent.
 */
model BingGroundingAgentTool extends OpenAI.Tool {
  /**
   * The object type, which is always 'bing_grounding'.
   */
  type: "bing_grounding";

  /**
   * The bing grounding search tool parameters.
   */
  bing_grounding: BingGroundingSearchToolParameters;
}

/**
 * The fabric data agent tool parameters.
 */
model FabricDataAgentToolParameters {
  /**
   * The project connections attached to this tool. There can be a maximum of 1 connection
   * resource attached to the tool.
   */
  @maxItems(1)
  project_connections?: ToolProjectConnection[];
}

/**
 * The input definition information for a Microsoft Fabric tool as used to configure an agent.
 */
model MicrosoftFabricAgentTool extends OpenAI.Tool {
  /**
   * The object type, which is always 'fabric_dataagent'.
   */
  type: "fabric_dataagent_preview";

  /**
   * The fabric data agent tool parameters.
   */
  fabric_dataagent_preview: FabricDataAgentToolParameters;
}

/**
 * The sharepoint grounding tool parameters.
 */
model SharepointGroundingToolParameters {
  /**
   * The project connections attached to this tool. There can be a maximum of 1 connection
   * resource attached to the tool.
   */
  @maxItems(1)
  project_connections?: ToolProjectConnection[];
}

/**
 * The input definition information for a sharepoint tool as used to configure an agent.
 */
model SharepointAgentTool extends OpenAI.Tool {
  /**
   * The object type, which is always 'sharepoint_grounding'.
   */
  type: "sharepoint_grounding_preview";

  /**
   * The sharepoint grounding tool parameters.
   */
  sharepoint_grounding_preview: SharepointGroundingToolParameters;
}

/**
 * The input definition information for an Azure AI search tool as used to configure an agent.
 */
model AzureAISearchAgentTool extends OpenAI.Tool {
  /**
   * The object type, which is always 'azure_ai_search'.
   */
  type: "azure_ai_search";

  /**
   * The azure ai search index resource.
   */
  azure_ai_search: AzureAISearchToolResource;
}

/**
 * A set of index resources used by the `azure_ai_search` tool.
 */
model AzureAISearchToolResource {
  /**
   * The indices attached to this agent. There can be a maximum of 1 index
   * resource attached to the agent.
   */
  @maxItems(1)
  indexes: AISearchIndexResource[];
}

/**
 * A Index resource.
 */
model IndexResource {
  /**
   * An index connection ID in an IndexResource attached to this agent.
   */
  project_connection_id?: string;

  /**
   * The name of an index in an IndexResource attached to this agent.
   */
  index_name?: string;
}

/**
 * A AI Search Index resource.
 */
model AISearchIndexResource {
  ...IndexResource;

  /**
   *  Type of query in an AIIndexResource attached to this agent.
   */
  query_type?: AzureAISearchQueryType;

  /**
   * Number of documents to retrieve from search and present to the model.
   */
  top_k?: int32;

  /**
   *  filter string for search resource. [Learn more here](https://learn.microsoft.com/azure/search/search-filters).
   */
  filter?: string;

  /**
   * Index asset id for search resource.
   */
  index_asset_id?: string;
}

/** Available query types for Azure AI Search tool. */
union AzureAISearchQueryType {
  string,

  /** Query type `simple` */
  simple: "simple",

  /** Query type `semantic` */
  semantic: "semantic",

  /** Query type `vector` */
  vector: "vector",

  /** Query type `vector_simple_hybrid` */
  vector_simple_hybrid: "vector_simple_hybrid",

  /** Query type `vector_semantic_hybrid` */
  vector_semantic_hybrid: "vector_semantic_hybrid",
}

/**
 * The input definition information for an OpenAPI tool as used to configure an agent.
 */
model OpenApiAgentTool extends OpenAI.Tool {
  /**
   * The object type, which is always 'openapi'.
   */
  type: "openapi";

  /**
   * The openapi function definition.
   */
  openapi: OpenApiFunctionDefinition;
}

/**
 * The input definition information for a Bing custom search tool as used to configure an agent.
 */
model BingCustomSearchAgentTool extends OpenAI.Tool {
  /**
   * The object type, which is always 'bing_custom_search'.
   */
  type: "bing_custom_search_preview";

  /**
   * The bing custom search tool parameters.
   */
  bing_custom_search_preview: BingCustomSearchToolParameters;
}

/**
 * The input definition information for a Browser Automation Tool, as used to configure an Agent.
 */
model BrowserAutomationAgentTool extends OpenAI.Tool {
  /**
   * The object type, which is always 'browser_automation'.
   */
  type: "browser_automation_preview";

  /**
   * The Browser Automation Tool parameters.
   */
  browser_automation_preview: BrowserAutomationToolParameters;
}

/**
 * Definition of input parameters for the Browser Automation Tool.
 */
model BrowserAutomationToolParameters {
  /**
   * The project connection parameters associated with the Browser Automation Tool.
   */
  connection: BrowserAutomationToolConnectionParameters;
}

/**
 * Definition of input parameters for the connection used by the Browser Automation Tool.
 */
model BrowserAutomationToolConnectionParameters {
  /**
   * The ID of the project connection to your Azure Playwright resource.
   */
  project_connection_id: string;
}

/**
 * The input definition information for an Azure Function Tool, as used to configure an Agent.
 */
model AzureFunctionAgentTool extends OpenAI.Tool {
  /**
   * The object type, which is always 'browser_automation'.
   */
  type: "azure_function";

  /**
   * The Azure Function Tool definition.
   */
  azure_function: AzureFunctionDefinition;
}

/**
 * The definition of Azure function.
 */
model AzureFunctionDefinition {
  /**
   * The definition of azure function and its parameters.
   */
  function: {
    /**
     * The name of the function to be called.
     */
    name: string;

    /**
     * A description of what the function does, used by the model to choose when and how to call the function.
     */
    description?: string;

    /**
     * The parameters the functions accepts, described as a JSON Schema object.
     */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
    parameters: unknown;
  };

  /**
   * Input storage queue. The queue storage trigger runs a function as messages are added to it.
   */
  input_binding: AzureFunctionBinding;

  /**
   * Output storage queue. The function writes output to this queue when the input items are processed.
   */
  output_binding: AzureFunctionBinding;
}

/**
 * The input definition information for an openapi function.
 */
model OpenApiFunctionDefinition {
  /**
   * The name of the function to be called.
   */
  name: string;

  /**
   * A description of what the function does, used by the model to choose when and how to call the function.
   */
  description?: string;

  /**
   * The openapi function shape, described as a JSON Schema object.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
  spec: unknown;

  /**
   * Open API authentication details
   */
  auth: OpenApiAuthDetails;

  /**
   * List of OpenAPI spec parameters that will use user-provided defaults
   */
  default_params?: string[];

  /**
   * List of function definitions used by OpenApi tool
   */
  @visibility(Lifecycle.Read)
  functions?: {
    /**
     * The name of the function to be called.
     */
    name: string;

    /**
     * A description of what the function does, used by the model to choose when and how to call the function.
     */
    description?: string;

    /**
     * The parameters the functions accepts, described as a JSON Schema object.
     */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
    parameters: unknown;
  }[];
}

/**
 * Authentication type for OpenApi endpoint. Allowed types are:
 * - Anonymous (no authentication required)
 * - Project Connection (requires project_connection_id to endpoint, as setup in AI Foundry)
 * - Managed_Identity (requires audience for identity based auth)
 */
union OpenApiAuthType {
  anonymous: "anonymous",
  project_connection: "project_connection",
  managedIdentity: "managed_identity",
  string,
}

/**
 * authentication details for OpenApiFunctionDefinition
 */
@discriminator("type")
model OpenApiAuthDetails {
  /**
   * The type of authentication, must be anonymous/project_connection/managed_identity
   */
  type: OpenApiAuthType;
}

/**
 * Security details for OpenApi anonymous authentication
 */
model OpenApiAnonymousAuthDetails extends OpenApiAuthDetails {
  /**
   * The object type, which is always 'anonymous'.
   */
  type: OpenApiAuthType.anonymous;
}

/**
 * Security details for OpenApi project connection authentication
 */
model OpenApiProjectConnectionAuthDetails extends OpenApiAuthDetails {
  /**
   * The object type, which is always 'project_connection'.
   */
  type: OpenApiAuthType.project_connection;

  /**
   * Project connection auth security details
   */
  security_scheme: OpenApiProjectConnectionSecurityScheme;
}

/**
 * Security details for OpenApi managed_identity authentication
 */
model OpenApiManagedAuthDetails extends OpenApiAuthDetails {
  /**
   * The object type, which is always 'managed_identity'.
   */
  type: OpenApiAuthType.managedIdentity;

  /**
   * Connection auth security details
   */
  security_scheme: OpenApiManagedSecurityScheme;
}

/**
 * Security scheme for OpenApi managed_identity authentication
 */
model OpenApiManagedSecurityScheme {
  /**
   * Authentication scope for managed_identity auth type
   */
  audience: string;
}

/**
 * Security scheme for OpenApi managed_identity authentication
 */
model OpenApiProjectConnectionSecurityScheme {
  /**
   * Project connection id for Project Connection auth type
   */
  project_connection_id: string;
}

/**
 * A project connection resource.
 */
model ToolProjectConnection {
  /**
   * A project connection in a ToolProjectConnectionList attached to this tool.
   */
  project_connection_id: string;
}

/**
 * A set of project connection resources currently used by either the `bing_grounding`, `fabric_dataagent`, or `sharepoint_grounding` tools.
 */
model ToolProjectConnectionList {
  /**
   * The project connections attached to this tool. There can be a maximum of 1 connection
   * resource attached to the tool.
   */
  @maxItems(1)
  project_connections?: ToolProjectConnection[];
}

/**
 * Search configuration for Bing Grounding
 */
model BingGroundingSearchConfiguration {
  /**
   * Project connection id for grounding with bing search
   */
  project_connection_id: string;

  /**
   * The market where the results come from.
   */
  market?: string;

  /**
   * The language to use for user interface strings when calling Bing API.
   */
  set_lang?: string;

  /**
   * The number of search results to return in the bing api response
   */
  count?: int64;

  /**
   * Filter search results by a specific time range. See [accepted values here](https://learn.microsoft.com/bing/search-apis/bing-web-search/reference/query-parameters).
   */
  freshness?: string;
}

/**
 * The bing grounding search tool parameters.
 */
model BingGroundingSearchToolParameters {
  /**
   * The search configurations attached to this tool. There can be a maximum of 1
   * search configuration resource attached to the tool.
   */
  @maxItems(1)
  search_configurations: BingGroundingSearchConfiguration[];
}

/**
 * The bing custom search tool parameters.
 */
model BingCustomSearchToolParameters {
  /**
   * The project connections attached to this tool. There can be a maximum of 1 connection
   * resource attached to the tool.
   */
  @maxItems(1)
  search_configurations: BingCustomSearchConfiguration[];
}

/**
 * A bing custom search configuration.
 */
model BingCustomSearchConfiguration {
  /**
   * Project connection id for grounding with bing search
   */
  project_connection_id: string;

  /**
   * Name of the custom configuration instance given to config.
   */
  instance_name: string;

  /**
   * The market where the results come from.
   */
  market?: string;

  /**
   * The language to use for user interface strings when calling Bing API.
   */
  set_lang?: string;

  /**
   * The number of search results to return in the bing api response
   */
  count?: int64;

  /**
   * Filter search results by a specific time range. See [accepted values here](https://learn.microsoft.com/bing/search-apis/bing-web-search/reference/query-parameters).
   */
  freshness?: string;
}

/**
 * The structure for keeping storage queue name and URI.
 */
model AzureFunctionBinding {
  /**
   * The type of binding, which is always 'storage_queue'.
   */
  type: "storage_queue";

  /**
   * Storage queue.
   */
  storage_queue: AzureFunctionStorageQueue;
}

/**
 * The structure for keeping storage queue name and URI.
 */
model AzureFunctionStorageQueue {
  /**
   * URI to the Azure Storage Queue service allowing you to manipulate a queue.
   */
  queue_service_endpoint: string;

  /**
   * The name of an Azure function storage queue.
   */
  queue_name: string;
}

/**
 * A structured output that can be produced by the agent.
 */
model StructuredOutputDefinition {
  /**
   * The name of the structured output.
   */
  name: string;

  /**
   * A description of the output to emit. Used by the model to determine when to emit the output.
   */
  description: string;

  /**
   * The JSON schema for the structured output.
   */
  schema: unknown;

  @doc("""
    Whether to enforce strict validation. Default `true`.
    """)
  strict: boolean | null;
}

/**
 * A tool for capturing structured outputs
 */
model CaptureStructuredOutputsTool extends OpenAI.Tool {
  /**
   * The type of the tool. Always `capture_structured_outputs`.
   */
  type: "capture_structured_outputs";

  /**
   * The structured outputs to capture from the model.
   */
  outputs: StructuredOutputDefinition;
}

/**
 * An agent implementing the A2A protocol.
 */
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model A2ATool extends OpenAI.Tool {
  /**
   * The type of the tool. Always `a2a`.
   */
  type: "a2a_preview";

  /**
   * Base URL of the agent.
   */
  base_url?: url;

  /**
   * The path to the agent card relative to the `base_url`.
   * If not provided, defaults to  `/.well-known/agent-card.json`
   */
  agent_card_path?: string;

  /**
   * The connection ID in the project for the A2A server.
   * The connection stores authentication and other connection details needed to connect to the A2A server.
   */
  project_connection_id?: string;
}

/**
 * A tool for integrating memories into the agent.
 */
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model MemorySearchTool extends OpenAI.Tool {
  /**
   * The type of the tool. Always `memory_search`.
   */
  type: "memory_search";

  /**
   * The name of the memory store to use.
   */
  memory_store_name: string;

  /**
   * The namespace used to group and isolate memories, such as a user ID.
   * Limits which memories can be retrieved or updated.
   * Use special variable `{{$userId}}` to scope memories to the current signed-in user.
   */
  scope: string;

  /**
   * Options for searching the memory store.
   */
  search_options?: MemorySearchOptions;

  /**
   * Time to wait before updating memories after inactivity (seconds). Default 300.
   */
  update_delay?: int32 = 300;
}

alias MemorySearchToolCallItemBase = {
  @doc("The results returned from the memory search.")
  results?: MemorySearchItem[] | null;
};

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model MemorySearchToolCallItemParam extends OpenAI.ItemParam {
  type: "memory_search_call";
  ...MemorySearchToolCallItemBase;
}

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model MemorySearchToolCallItemResource extends OpenAI.ItemResource {
  type: "memory_search_call";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("""
    The status of the memory search tool call. One of `in_progress`,
    `searching`, `completed`, `incomplete` or `failed`,
    """)
  status: "in_progress" | "searching" | "completed" | "incomplete" | "failed";

  ...MemorySearchToolCallItemBase;
}

// =============================================================================
// Grounding Tool Call Document Models
// =============================================================================

@doc("A document returned from a grounding tool search.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model GroundingToolCallDocument {
  @doc("The unique identifier of the document.")
  id?: string;

  @doc("The content of the document.")
  content?: string;

  @doc("The file path or source path of the document.")
  filepath?: string;

  @doc("The title of the document.")
  title?: string;

  @doc("The URL of the document.")
  url?: string;

  @doc("The relevance score of the document.")
  score?: float64;

  @doc("The index of the knowledge source that provided the document.")
  knowledgeSourceIndex?: int32;
}

// =============================================================================
// Bing Grounding Tool Call Item Models
// =============================================================================

alias BingGroundingToolCallItemBase = {
  @doc("The query used for the Bing search.")
  query?: string;
};

alias BingGroundingToolCallOutputBase = {
  @doc("The documents returned from the Bing grounding search.")
  documents?: GroundingToolCallDocument[];
};

@doc("A Bing grounding tool call item for input.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model BingGroundingToolCallItemParam extends OpenAI.ItemParam {
  type: "bing_grounding_call";
  ...BingGroundingToolCallItemBase;
}

@doc("A Bing grounding tool call item resource.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model BingGroundingToolCallItemResource extends OpenAI.ItemResource {
  type: "bing_grounding_call";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("The status of the Bing grounding tool call.")
  status: "in_progress" | "completed" | "incomplete" | "failed";

  ...BingGroundingToolCallItemBase;
  ...BingGroundingToolCallOutputBase;
}

// =============================================================================
// SharePoint Grounding Tool Call Item Models
// =============================================================================

alias SharepointGroundingToolCallItemBase = {
  @doc("The query used for the SharePoint search.")
  query?: string;
};

alias SharepointGroundingToolCallOutputBase = {
  @doc("The documents returned from the SharePoint grounding search.")
  documents?: GroundingToolCallDocument[];
};

@doc("A SharePoint grounding tool call item for input.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model SharepointGroundingToolCallItemParam extends OpenAI.ItemParam {
  type: "sharepoint_grounding_preview_call";
  ...SharepointGroundingToolCallItemBase;
}

@doc("A SharePoint grounding tool call item resource.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model SharepointGroundingToolCallItemResource extends OpenAI.ItemResource {
  type: "sharepoint_grounding_preview_call";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("The status of the SharePoint grounding tool call.")
  status: "in_progress" | "completed" | "incomplete" | "failed";

  ...SharepointGroundingToolCallItemBase;
  ...SharepointGroundingToolCallOutputBase;
}

// =============================================================================
// Azure AI Search Tool Call Item Models
// =============================================================================

alias AzureAISearchToolCallItemBase = {
  @doc("The query used for the Azure AI Search.")
  query?: string;
};

alias AzureAISearchToolCallOutputBase = {
  @doc("The documents returned from Azure AI Search.")
  documents?: GroundingToolCallDocument[];

  @doc("URLs to retrieve the full document content.")
  get_urls?: string[];
};

@doc("An Azure AI Search tool call item for input.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model AzureAISearchToolCallItemParam extends OpenAI.ItemParam {
  type: "azure_ai_search_call";
  ...AzureAISearchToolCallItemBase;
}

@doc("An Azure AI Search tool call item resource.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model AzureAISearchToolCallItemResource extends OpenAI.ItemResource {
  type: "azure_ai_search_call";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("The status of the Azure AI Search tool call.")
  status: "in_progress" | "completed" | "incomplete" | "failed";

  ...AzureAISearchToolCallItemBase;
  ...AzureAISearchToolCallOutputBase;
}

// =============================================================================
// Bing Custom Search Tool Call Item Models
// =============================================================================

alias BingCustomSearchToolCallItemBase = {
  @doc("The query used for the Bing custom search.")
  query?: string;
};

alias BingCustomSearchToolCallOutputBase = {
  @doc("The documents returned from Bing custom search.")
  documents?: GroundingToolCallDocument[];
};

@doc("A Bing custom search tool call item for input.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model BingCustomSearchToolCallItemParam extends OpenAI.ItemParam {
  type: "bing_custom_search_preview_call";
  ...BingCustomSearchToolCallItemBase;
}

@doc("A Bing custom search tool call item resource.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model BingCustomSearchToolCallItemResource extends OpenAI.ItemResource {
  type: "bing_custom_search_preview_call";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("The status of the Bing custom search tool call.")
  status: "in_progress" | "completed" | "incomplete" | "failed";

  ...BingCustomSearchToolCallItemBase;
  ...BingCustomSearchToolCallOutputBase;
}

// =============================================================================
// OpenAPI Tool Call Item Models
// =============================================================================

alias OpenApiToolCallItemBase = {
  @doc("The name of the OpenAPI operation being called.")
  name?: string;

  @doc("The arguments passed to the OpenAPI operation as a JSON string.")
  arguments?: string;
};

alias OpenApiToolCallOutputBase = {
  @doc("The response from the OpenAPI operation.")
  response?: unknown;
};

@doc("An OpenAPI tool call item for input.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model OpenApiToolCallItemParam extends OpenAI.ItemParam {
  type: "openapi_call";
  ...OpenApiToolCallItemBase;
}

@doc("An OpenAPI tool call item resource.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model OpenApiToolCallItemResource extends OpenAI.ItemResource {
  type: "openapi_call";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("The status of the OpenAPI tool call.")
  status: "in_progress" | "completed" | "incomplete" | "failed";

  ...OpenApiToolCallItemBase;
  ...OpenApiToolCallOutputBase;
}

// =============================================================================
// Browser Automation Tool Call Item Models
// =============================================================================

alias BrowserAutomationToolCallItemBase = {
  @doc("The query or command for browser automation.")
  query?: string;
};

alias BrowserAutomationToolCallOutputBase = {
  @doc("The output from the browser automation operation.")
  output?: unknown;
};

@doc("A browser automation tool call item for input.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model BrowserAutomationToolCallItemParam extends OpenAI.ItemParam {
  type: "browser_automation_preview_call";
  ...BrowserAutomationToolCallItemBase;
}

@doc("A browser automation tool call item resource.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model BrowserAutomationToolCallItemResource extends OpenAI.ItemResource {
  type: "browser_automation_preview_call";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("The status of the browser automation tool call.")
  status: "in_progress" | "completed" | "incomplete" | "failed";

  ...BrowserAutomationToolCallItemBase;
  ...BrowserAutomationToolCallOutputBase;
}

// =============================================================================
// Fabric DataAgent Tool Call Item Models
// =============================================================================

alias FabricDataAgentToolCallItemBase = {
  @doc("The query for the Fabric data agent.")
  query?: string;
};

alias FabricDataAgentToolCallOutputBase = {
  @doc("The output from the Fabric data agent operation.")
  output?: unknown;
};

@doc("A Fabric data agent tool call item for input.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model FabricDataAgentToolCallItemParam extends OpenAI.ItemParam {
  type: "fabric_dataagent_preview_call";
  ...FabricDataAgentToolCallItemBase;
}

@doc("A Fabric data agent tool call item resource.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model FabricDataAgentToolCallItemResource extends OpenAI.ItemResource {
  type: "fabric_dataagent_preview_call";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("The status of the Fabric data agent tool call.")
  status: "in_progress" | "completed" | "incomplete" | "failed";

  ...FabricDataAgentToolCallItemBase;
  ...FabricDataAgentToolCallOutputBase;
}

// =============================================================================
// Azure Function Tool Call Item Models
// =============================================================================

alias AzureFunctionToolCallItemBase = {
  @doc("The name of the Azure Function being called.")
  name?: string;

  @doc("The arguments passed to the Azure Function as a JSON string.")
  arguments?: string;
};

alias AzureFunctionToolCallOutputBase = {
  @doc("The response from the Azure Function.")
  response?: unknown;
};

@doc("An Azure Function tool call item for input.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model AzureFunctionToolCallItemParam extends OpenAI.ItemParam {
  type: "azure_function_call";
  ...AzureFunctionToolCallItemBase;
}

@doc("An Azure Function tool call item resource.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model AzureFunctionToolCallItemResource extends OpenAI.ItemResource {
  type: "azure_function_call";

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("The status of the Azure Function tool call.")
  status: "in_progress" | "completed" | "incomplete" | "failed";

  ...AzureFunctionToolCallItemBase;
  ...AzureFunctionToolCallOutputBase;
}
