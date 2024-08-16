import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

//
// Response objects
//

/**
 * A set of resources that are used by the assistant's tools. The resources are specific to the type of
 * tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search`
 * tool requires a list of vector store IDs.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
model ToolResources {
  /** Resources to be used by the `code_interpreter tool` consisting of file IDs. */
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: CodeInterpreterToolResource;

  /** Resources to be used by the `file_search` tool consisting of vector store IDs. */
  @encodedName("application/json", "file_search")
  fileSearch?: FileSearchToolResource;
}

/**
 * A set of resources that are used by the `code_interpreter` tool.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
model CodeInterpreterToolResource {
  /**
   * A list of file IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files
   * associated with the tool.
   */
  @encodedName("application/json", "file_ids")
  @maxItems(20)
  fileIds: string[] = #[];
}

/**
 * A set of resources that are used by the `file_search` tool.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
model FileSearchToolResource {
  /**
   * The ID of the vector store attached to this assistant. There can be a maximum of 1 vector
   * store attached to the assistant.
   */
  @maxItems(1)
  @encodedName("application/json", "vector_store_ids")
  vectorStoreIds?: string[];
}

//
// Creation request objects
//

/**
 * Request object. A set of resources that are used by the assistant's tools. The resources are specific to the
 * type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search`
 * tool requires a list of vector store IDs.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
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
}

/**
 * A set of resources that will be used by the `code_interpreter` tool. Request object.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
model CreateCodeInterpreterToolResourceOptions {
  /** A list of file IDs made available to the `code_interpreter` tool. */
  @maxItems(20)
  @encodedName("application/json", "file_ids")
  fileIds?: string[] = #[];
}

/**
 * A set of resources that are used by the assistant's tools. The resources are specific to the type of tool.
 * For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires
 * a list of vector store IDs.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the OpenAI API"
@added(ServiceApiVersions.v2024_05_01_preview)
union CreateFileSearchToolResourceOptions {
  /** The vector store attached to this assistant. There can be a maximum of 1 vector store attached to the assistant. */
  @encodedName("application/json", "vector_store_ids")
  // @maxItems(1) // this can't be applied to string[]
  vectorStoreIds: string[],

  /** A helper to create a vector store with file_ids and attach it to this assistant. There can be a maximum of 1 vector
   * store attached to the assistant. */
  @encodedName("application/json", "vector_stores")
  // @maxItems(1) // this can't be applied to string[]
  vectorStores: CreateFileSearchToolResourceVectorStoreOptions[],
}

/** File IDs associated to the vector store to be passed to the helper. */
@added(ServiceApiVersions.v2024_05_01_preview)
model CreateFileSearchToolResourceVectorStoreOptions {
  /** A list of file IDs to add to the vector store. There can be a maximum of 10000 files in a vector store. */
  @encodedName("application/json", "file_ids")
  @maxItems(10000)
  fileIds: string[];

  /** Set of 16 key-value pairs that can be attached to a vector store. This can be useful for storing additional information
   * about the vector store in a structured format. Keys can be a maximum of 64 characters long and values can be a maximum of
   *  512 characters long. */
  ...OptionalNullableMetadata;
}

//
// Update request objects
//

/**
 * Request object. A set of resources that are used by the assistant's tools. The resources are specific to the type of tool.
 * For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of
 * vector store IDs.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
model UpdateToolResourcesOptions {
  /**
   * Overrides the list of file IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files
   * associated with the tool.
   */
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: UpdateCodeInterpreterToolResourceOptions;

  /** Overrides the vector store attached to this assistant. There can be a maximum of 1 vector store attached to the assistant. */
  @encodedName("application/json", "file_search")
  fileSearch?: UpdateFileSearchToolResourceOptions;
}

/** Request object to update `code_interpreted` tool resources. */
@added(ServiceApiVersions.v2024_05_01_preview)
model UpdateCodeInterpreterToolResourceOptions {
  /** A list of file IDs to override the current list of the assistant. */
  @encodedName("application/json", "file_ids")
  @maxItems(20)
  fileIds?: string[];
}

/** Request object to update `file_search` tool resources. */
@added(ServiceApiVersions.v2024_05_01_preview)
model UpdateFileSearchToolResourceOptions {
  /** A list of vector store IDs to override the current list of the assistant. */
  @maxItems(1)
  @encodedName("application/json", "vector_store_ids")
  vectorStoreIds?: string[];
}
