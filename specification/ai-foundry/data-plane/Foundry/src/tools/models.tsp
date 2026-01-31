import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core/experimental";
import "@azure-tools/openai-typespec/views/client-emitters/models/responses";

import "../memory_stores/models.tsp";

using Azure.Core.Experimental;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
namespace Azure.AI.Projects {
  //
  // Tool inputs -- definitions used before model evaluation to configure agents, threads, and messages
  //

  // Preview tools (must end with "_preview"):
  union _PreviewAgentToolType {
    a2a_preview: "a2a_preview",
    bing_custom_search_preview: "bing_custom_search_preview",
    browser_automation_preview: "browser_automation_preview",
    fabric_dataagent_preview: "fabric_dataagent_preview",
    sharepoint_grounding_preview: "sharepoint_grounding_preview",
    memory_search_preview: "memory_search_preview",
  }

  // General availability tools:
  union _AgentToolType {
    azure_ai_search: "azure_ai_search",
    azure_function: "azure_function",
    bing_grounding: "bing_grounding",
    capture_structured_outputs: "capture_structured_outputs",
    openapi: "openapi",

    @removed(Versions.v1)
    memory_search: "memory_search",
  }

  @@copyVariants(OpenAI.ToolType, Azure.AI.Projects._PreviewAgentToolType);
  @@copyVariants(OpenAI.ToolType, Azure.AI.Projects._AgentToolType);

  union _AgentIncludable {
    "memory_search_call.results",
  }

  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
  @@copyVariants(OpenAI.IncludeEnum, Azure.AI.Projects._AgentIncludable);

  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
  @@copyProperties(OpenAI.MCPTool,
    {
      /**
       * The connection ID in the project for the MCP server. The connection stores authentication and other connection details needed to connect to the MCP server.
       */
      project_connection_id?: string,
    }
  );

  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
  @@copyProperties(OpenAI.WebSearchTool,
    {
      /**
       * The project connections attached to this tool. There can be a maximum of 1 connection
       * resource attached to the tool.
       */
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
  model BingGroundingTool extends OpenAI.Tool {
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
  model MicrosoftFabricPreviewTool extends OpenAI.Tool {
    /**
     * The object type, which is always 'fabric_dataagent_preview'.
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
  model SharepointPreviewTool extends OpenAI.Tool {
    /**
     * The object type, which is always 'sharepoint_grounding_preview'.
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
  model AzureAISearchTool extends OpenAI.Tool {
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
  model OpenApiTool extends OpenAI.Tool {
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
  model BingCustomSearchPreviewTool extends OpenAI.Tool {
    /**
     * The object type, which is always 'bing_custom_search_preview'.
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
  model BrowserAutomationPreviewTool extends OpenAI.Tool {
    /**
     * The object type, which is always 'browser_automation_preview'.
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
  model AzureFunctionTool extends OpenAI.Tool {
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
      parameters: Record<unknown>;
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
    spec: Record<unknown>;

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
      parameters: Record<unknown>;
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
    schema: Record<unknown>;

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
  model A2APreviewTool extends OpenAI.Tool {
    /**
     * The type of the tool. Always `"a2a_preview`.
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
  model MemorySearchPreviewTool extends OpenAI.Tool {
    /**
     * The type of the tool. Always `memory_search_preview`.
     */
    type: "memory_search_preview";

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

  /**
   * A tool for integrating memories into the agent.
   */
  @removed(Versions.v1)
  model MemorySearchTool extends OpenAI.Tool {
    /**
     * The type of the tool. Always `memory_search_preview`.
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

  model MemorySearchToolCallItemParam extends OpenAI.Item {
    type: "memory_search_call";
    ...MemorySearchToolCallItemBase;
  }

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
}
