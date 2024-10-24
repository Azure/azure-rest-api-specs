import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

@doc("A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.")
model ToolResources {
  @doc("Resources to be used by the `code_interpreter tool` consisting of file IDs.")
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: CodeInterpreterToolResource;

  @doc("Resources to be used by the `file_search` tool consisting of vector store IDs.")
  @encodedName("application/json", "file_search")
  fileSearch?: FileSearchToolResource;
}

@doc("A set of resources that are used by the `code_interpreter` tool.")
model CodeInterpreterToolResource {
  @doc("A list of file IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files associated with the tool.")
  @encodedName("application/json", "file_ids")
  @maxItems(20)
  fileIds: string[] = #[];
}

@doc("A set of resources that are used by the `file_search` tool.")
model FileSearchToolResource {
  @doc("The ID of the vector store attached to this assistant. There can be a maximum of 1 vector store attached to the assistant.")
  @maxItems(1)
  @encodedName("application/json", "vector_store_ids")
  vectorStoreIds?: string[];
}

//
// Creation request objects
//
@doc("Request object. A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.")
model CreateToolResourcesOptions {
  @doc("A list of file IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files associated with the tool.")
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: CreateCodeInterpreterToolResourceOptions;

  @doc("A list of vector stores or their IDs made available to the `file_search` tool.")
  @encodedName("application/json", "file_search")
  fileSearch?: CreateFileSearchToolResourceOptions;
}

@doc("A set of resources that will be used by the `code_interpreter` tool. Request object.")
model CreateCodeInterpreterToolResourceOptions {
  @doc("A list of file IDs made available to the `code_interpreter` tool.")
  @maxItems(20)
  @encodedName("application/json", "file_ids")
  fileIds?: string[] = #[];
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the OpenAI API"
@doc("A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.")
union CreateFileSearchToolResourceOptions {
  @doc("The vector store attached to this assistant. There can be a maximum of 1 vector store attached to the assistant.")
  @encodedName("application/json", "vector_store_ids")
  vectorStoreIds: string[],

  @doc("A helper to create a vector store with file_ids and attach it to this assistant. There can be a maximum of 1 vector store attached to the assistant.")
  @encodedName("application/json", "vector_stores")
  vectorStores: CreateFileSearchToolResourceVectorStoreOptions[],
}

@doc("File IDs associated to the vector store to be passed to the helper.")
model CreateFileSearchToolResourceVectorStoreOptions {
  @doc("A list of file IDs to add to the vector store. There can be a maximum of 10000 files in a vector store.")
  @encodedName("application/json", "file_ids")
  @maxItems(10000)
  fileIds: string[];

  @doc("The chunking strategy used to chunk the file(s). If not set, will use the `auto` strategy.")
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

@doc("Request object. A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.")
model UpdateToolResourcesOptions {
  @doc("Overrides the list of file IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files associated with the tool.")
  @encodedName("application/json", "code_interpreter")
  codeInterpreter?: UpdateCodeInterpreterToolResourceOptions;

  @doc("Overrides the vector store attached to this assistant. There can be a maximum of 1 vector store attached to the assistant.")
  @encodedName("application/json", "file_search")
  fileSearch?: UpdateFileSearchToolResourceOptions;
}

@doc("Request object to update `code_interpreted` tool resources.")
model UpdateCodeInterpreterToolResourceOptions {
  @doc("A list of file IDs to override the current list of the assistant.")
  @encodedName("application/json", "file_ids")
  @maxItems(20)
  fileIds?: string[];
}

@doc("Request object to update `file_search` tool resources.")
model UpdateFileSearchToolResourceOptions {
  @doc("A list of vector store IDs to override the current list of the assistant.")
  @maxItems(1)
  @encodedName("application/json", "vector_store_ids")
  vectorStoreIds?: string[];
}
