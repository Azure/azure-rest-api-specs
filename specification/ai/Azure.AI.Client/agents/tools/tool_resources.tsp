import "@typespec/http";
import "@typespec/versioning";

import "../vector_stores/common/main.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Client.Agents;

//
// Response objects
//

/**
 * A set of resources that are used by the agent's tools. The resources are specific to the type of
 * tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search`
 * tool requires a list of vector store IDs.
 */
model ToolResources {
  /** Resources to be used by the `code_interpreter tool` consisting of file IDs. */
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: CodeInterpreterToolResource;

  /** Resources to be used by the `file_search` tool consisting of vector store IDs. */
  @encodedName("application/json", "file_search")
  fileSearch?: FileSearchToolResource;

  /** Resources to be used by the `bing_grounding` tool consisting of connection IDs. */
  @encodedName("application/json", "bing_grounding")
  bingGrounding?: ConnectionListResource;

  /** Resources to be used by the `microsoft_fabric` tool consisting of connection IDs. */
  @encodedName("application/json", "microsoft_fabric")
  microsoftFabric?: ConnectionListResource;

  /** Resources to be used by the `sharepoint` tool consisting of connection IDs. */
  @encodedName("application/json", "sharepoint")
  sharePoint?: ConnectionListResource;

  /** Resources to be used by the `azure_ai_search` tool consisting of index IDs and names. */
  @encodedName("application/json", "azure_ai_search")
  azureAISearch?: AzureAISearchResource;
}

/**
 * A set of resources that are used by the `code_interpreter` tool.
 */
model CodeInterpreterToolResource {
  /**
   * A list of file IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files
   * associated with the tool.
   */
  @encodedName("application/json", "file_ids")
  @maxItems(20)
  fileIds?: string[] = #[];
}

/**
 * A set of resources that are used by the `file_search` tool.
 */
model FileSearchToolResource {
  /**
   * The ID of the vector store attached to this agent. There can be a maximum of 1 vector
   * store attached to the agent.
   */
  @maxItems(1)
  @encodedName("application/json", "vector_store_ids")
  vectorStoreIds?: string[];
}

/**
 * A set of connection resources currently used by either the `bing_grounding`, `microsoft_fabric`, or `sharepoint` tools.
 */
model ConnectionListResource {
  /**
   * The connections attached to this agent. There can be a maximum of 1 connection
   * resource attached to the agent.
   */
  @maxItems(1)
  @encodedName("application/json", "connections")
  connectionList?: ConnectionResource[];
}

/**
 * A connection resource.
 */
model ConnectionResource {
  /**
   * A connection in a ConnectionListResource attached to this agent.
   */
  @encodedName("application/json", "connection_id")
  connectionId: string;
}

/**
 * A set of index resources used by the `azure_ai_search` tool.
 */
model AzureAISearchResource {
  /**
   * The indices attached to this agent. There can be a maximum of 1 index
   * resource attached to the agent.
   */
  @maxItems(1)
  @encodedName("application/json", "indexes")
  indexList?: IndexResource[];
}

/**
 * A Index resource.
 */
model IndexResource {
  /**
   * An index connection id in an IndexResource attached to this agent.
   */
  @encodedName("application/json", "index_connection_id")
  indexConnectionId: string;

  /**
   * The name of an index in an IndexResource attached to this agent.
   */
  @encodedName("application/json", "index_name")
  indexName: string;
}

//
// Creation request objects
//

/**
 * Request object. A set of resources that are used by the agent's tools. The resources are specific to the
 * type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search`
 * tool requires a list of vector store IDs.
 */
model CreateToolResourcesOptions {
  /**
   * A list of file IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files
   * associated with the tool.
   */
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: CreateCodeInterpreterToolResourceOptions;

  /** A list of vector stores or their IDs made available to the `file_search` tool. */
  @encodedName("application/json", "file_search")
  fileSearch?: CreateFileSearchToolResourceOptions;

  /** A list of connections to be used by the `bing_grounding` tool consisting of connection IDs. */
  @encodedName("application/json", "bing_grounding")
  bingGrounding?: ConnectionListResourceOptions;

  /** A list of connections to be used by the `microsoft_fabric` tool consisting of connection IDs. */
  @encodedName("application/json", "microsoft_fabric")
  microsoftFabric?: ConnectionListResourceOptions;

  /** A list of connections to be used by the `sharepoint` tool consisting of connection IDs. */
  @encodedName("application/json", "sharepoint")
  sharePoint?: ConnectionListResourceOptions;

  /** Resources to be used by the `azure_ai_search` tool consisting of index IDs and names. */
  @encodedName("application/json", "azure_ai_search")
  azureAISearch?: AzureAISearchToolResourceOptions;
}

alias ConnectionListResourceOptions = ConnectionListResource;

alias AzureAISearchToolResourceOptions = AzureAISearchResource;

/**
 * A set of resources that will be used by the `code_interpreter` tool. Request object.
 */
model CreateCodeInterpreterToolResourceOptions {
  /** A list of file IDs made available to the `code_interpreter` tool. */
  @maxItems(20)
  @encodedName("application/json", "file_ids")
  fileIds?: string[] = #[];
}

/**
 * A set of resources that are used by the agent's tools. The resources are specific to the type of tool.
 * For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires
 * a list of vector store IDs.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the OpenAI API"
union CreateFileSearchToolResourceOptions {
  /** The vector store attached to this agent. There can be a maximum of 1 vector store attached to the agent. */
  @encodedName("application/json", "vector_store_ids")
  // @maxItems(1) // this can't be applied to string[]
  vectorStoreIds: string[],

  /** A helper to create a vector store with file_ids and attach it to this agent. There can be a maximum of 1 vector
   * store attached to the agent. */
  @encodedName("application/json", "vector_stores")
  // @maxItems(1) // this can't be applied to string[]
  vectorStores: CreateFileSearchToolResourceVectorStoreOptions[],
}

/** File IDs associated to the vector store to be passed to the helper. */
model CreateFileSearchToolResourceVectorStoreOptions {
  /** A list of file IDs to add to the vector store. There can be a maximum of 10000 files in a vector store. */
  @encodedName("application/json", "file_ids")
  @maxItems(10000)
  fileIds: string[];

  /** The chunking strategy used to chunk the file(s). If not set, will use the `auto` strategy. */
  @encodedName("application/json", "chunking_strategy")
  chunkingStrategy: VectorStoreChunkingStrategyRequest;

  /** Set of 16 key-value pairs that can be attached to a vector store. This can be useful for storing additional information
   * about the vector store in a structured format. Keys can be a maximum of 64 characters long and values can be a maximum of
   *  512 characters long. */
  ...OptionalNullableMetadata;
}

//
// Update request objects
//

/**
 * Request object. A set of resources that are used by the agent's tools. The resources are specific to the type of tool.
 * For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of
 * vector store IDs.
 */
model UpdateToolResourcesOptions {
  /**
   * Overrides the list of file IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files
   * associated with the tool.
   */
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: UpdateCodeInterpreterToolResourceOptions;

  /** Overrides the vector store attached to this agent. There can be a maximum of 1 vector store attached to the agent. */
  @encodedName("application/json", "file_search")
  fileSearch?: UpdateFileSearchToolResourceOptions;

  /** Overrides the list of connections to be used by the `bing_grounding` tool consisting of connection IDs. */
  @encodedName("application/json", "bing_grounding")
  bingGrounding?: ConnectionListResourceOptions;

  /** Overrides the list of connections to be used by the `microsoft_fabric` tool consisting of connection IDs. */
  @encodedName("application/json", "microsoft_fabric")
  microsoftFabric?: ConnectionListResourceOptions;

  /** Overrides the list of connections to be used by the `sharepoint` tool consisting of connection IDs. */
  @encodedName("application/json", "sharepoint")
  sharePoint?: ConnectionListResourceOptions;

  /** Overrides the resources to be used by the `azure_ai_search` tool consisting of index IDs and names. */
  @encodedName("application/json", "azure_ai_search")
  azureAISearch?: AzureAISearchToolResourceOptions;
}

/** Request object to update `code_interpreted` tool resources. */
model UpdateCodeInterpreterToolResourceOptions {
  /** A list of file IDs to override the current list of the agent. */
  @encodedName("application/json", "file_ids")
  @maxItems(20)
  fileIds?: string[];
}

/** Request object to update `file_search` tool resources. */
model UpdateFileSearchToolResourceOptions {
  /** A list of vector store IDs to override the current list of the agent. */
  @maxItems(1)
  @encodedName("application/json", "vector_store_ids")
  vectorStoreIds?: string[];
}
