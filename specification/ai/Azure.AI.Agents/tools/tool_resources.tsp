import "@typespec/http";
import "@typespec/versioning";

import "../vector_stores/common/main.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Agents;

//
// Response objects
//

/**
 * A set of resources that are used by the agent's tools. The resources are specific to the type of
 * tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search`
 * tool requires a list of vector store IDs.
 */
@added(Versions.v2025_05_01)
model ToolResources {
  /** Resources to be used by the `code_interpreter` tool consisting of file IDs. */
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: CodeInterpreterToolResource;

  /** Resources to be used by the `file_search` tool consisting of vector store IDs. */
  @encodedName("application/json", "file_search")
  fileSearch?: FileSearchToolResource;

  /** Resources to be used by the `azure_ai_search` tool consisting of index IDs and names. */
  @encodedName("application/json", "azure_ai_search")
  azureAISearch?: AzureAISearchToolResource;

  /** Resources to be used by the `mcp` tool consisting of a server label and headers. */
  @added(Versions.v2025_05_15_preview)
  mcp?: MCPToolResource[];
}

/**
 * A set of resources that are used by the `code_interpreter` tool.
 */
@added(Versions.v2025_05_01)
model CodeInterpreterToolResource {
  /**
   * A list of file IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files
   * associated with the tool.
   */
  @encodedName("application/json", "file_ids")
  @maxItems(20)
  fileIds?: string[] = #[];

  /** The data sources to be used. This option is mutually exclusive with the `fileIds` property. */
  @maxItems(20)
  @encodedName("application/json", "data_sources")
  dataSources?: VectorStoreDataSource[];
}

/**
 * A set of resources that are used by the `file_search` tool.
 */
@added(Versions.v2025_05_01)
model FileSearchToolResource {
  /**
   * The ID of the vector store attached to this agent. There can be a maximum of 1 vector
   * store attached to the agent.
   */
  @maxItems(1)
  @encodedName("application/json", "vector_store_ids")
  vectorStoreIds?: string[];

  /**
   * The list of vector store configuration objects from Azure.
   * This list is limited to one element.
   * The only element of this list contains the list of azure asset IDs used by the search tool.
   */
  @maxItems(1)
  @encodedName("application/json", "vector_stores")
  vectorStores?: VectorStoreConfigurations[];
}

/**
 * A set of index resources used by the `azure_ai_search` tool.
 */
@added(Versions.v2025_05_01)
model AzureAISearchToolResource {
  /**
   * The indices attached to this agent. There can be a maximum of 1 index
   * resource attached to the agent.
   */
  @maxItems(1)
  @encodedName("application/json", "indexes")
  indexList?: AISearchIndexResource[];
}

/**
 * A Index resource.
 */
@added(Versions.v2025_05_01)
model IndexResource {
  /**
   * An index connection id in an IndexResource attached to this agent.
   */
  @encodedName("application/json", "index_connection_id")
  indexConnectionId?: string;

  /**
   * The name of an index in an IndexResource attached to this agent.
   */
  @encodedName("application/json", "index_name")
  indexName?: string;
}

/**
 * A AI Search Index resource.
 */
@added(Versions.v2025_05_01)
model AISearchIndexResource {
  ...IndexResource;

  /**
   *  Type of query in an AIIndexResource attached to this agent.
   */
  @encodedName("application/json", "query_type")
  queryType?: AzureAISearchQueryType;

  /**
   * Number of documents to retrieve from search and present to the model.
   */
  @encodedName("application/json", "top_k")
  topK?: int32;

  /**
   *  filter string for search resource.
   */
  filter?: string;

  /**
   * Index asset id for search resource.
   */
  @encodedName("application/json", "index_asset_id")
  indexAssetId?: string;
}

/**
 * A set of resources that are used by the `mcp` tool.
 */
@added(Versions.v2025_05_15_preview)
model MCPToolResource {
  @doc("The label for the MCP server")
  @encodedName("application/json", "server_label")
  serverLabel: string;

  @doc("The headers for the MCP server updates")
  headers: Record<string>;

  @doc("Does MCP server require approval")
  @encodedName("application/json", "require_approval")
  requireApproval?: MCPRequiredApproval;
}

/** The Union of approval types. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
@added(Versions.v2025_05_15_preview)
union MCPRequiredApproval {
  string,

  /** The approval is not required for any of the tools. */
  `never`: "never",

  /** The approval is required for all tools. */
  always: "always",

  /** Customized MCP approval object, listing tools requiring and not requiring approvals */
  MCPApprovalPerTool,
}

/** Customized MCP approval object, listing tools requiring and not requiring approvals */
@added(Versions.v2025_05_15_preview)
model MCPApprovalPerTool {
  /** The list of tools, not requiring approval. */
  `never`?: MCPToolList;

  /** The list of tools, always requiring approval. */
  always?: MCPToolList;
}

/** The object, containing list of tools for approvals. */
@added(Versions.v2025_05_15_preview)
model MCPToolList {
  /** The list of tools for approval. */
  @encodedName("application/json", "tool_names")
  toolNames: string[];
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
