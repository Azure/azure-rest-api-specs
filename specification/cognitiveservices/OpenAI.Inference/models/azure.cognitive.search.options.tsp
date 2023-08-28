import "@typespec/versioning";
import "./azure.chat.extensions.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@doc("Optional settings to control how fields are processed when using a configured Azure Cognitive Search resource.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model AzureCognitiveSearchIndexFieldMappingOptions {
  @doc("The name of the index field to use as a title.")
  @projectedName("csharp", "TitleFieldName")
  titleField?: string;

  @doc("The name of the index field to use as a URL.")
  @projectedName("csharp", "UrlFieldName")
  urlField?: string;

  @doc("The name of the index field to use as a filepath.")
  @projectedName("csharp", "FilepathFieldName")
  filepathField?: string;

  @doc("The names of index fields that should be treated as content.")
  @projectedName("csharp", "ContentFieldNames")
  contentFieldNames?: string[];

  @doc("The separator pattern that content fields should use.")
  @projectedName("csharp", "ContentFieldSeparator")
  contentFieldSeparator?: string;

  @doc("The names of fields that represent vector data.")
  @projectedName("csharp", "VectorFieldNames")
  vectorFields?: string[];
}

@doc("""
The type of Azure Cognitive Search retrieval query that should be executed when using it as an Azure OpenAI chat extension.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
enum AzureCognitiveSearchQueryType {
  @doc("Represents the default, simple query parser.")
  simple: "simple",

  @doc("Represents the semantic query parser for advanced semantic modeling.")
  semantic: "semantic",

  @doc("Represents vector search over computed data.")
  vector: "vector",

  @doc("Represents a combination of the simple query strategy with vector data.")
  vectorSimpleHybrid: "vectorSimpleHybrid",

  @doc("Represents a combination of semantic search and vector data querying.")
  vectorSemanticHybrid: "vectorSemanticHybrid",
}

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("""
A specific representation of configurable options for Azure Cognitive Search when using it as an Azure OpenAI chat
extension.
""")
model AzureCognitiveSearchChatExtensionConfiguration {
  @doc("""
  The type label to use when configuring Azure OpenAI chat extensions. This should typically not be changed from its
  default value for Azure Cognitive Search.
  """)
  type: AzureChatExtensionType.azureCognitiveSearch;

  @doc("The absolute endpoint path for the Azure Cognitive Search resource to use.")
  @projectedName("csharp", "SearchEndpoint")
  endpoint: url;

  @doc("The API admin key to use with the specified Azure Cognitive Search endpoint.")
  @projectedName("csharp", "SearchKey")
  key: string;

  @doc("The name of the index to use as available in the referenced Azure Cognitive Search resource.")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @projectedName("csharp", "FieldMappingOptions")
  fieldsMapping?: AzureCognitiveSearchIndexFieldMappingOptions;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The configured top number of documents to feature for the configured query.")
  @projectedName("csharp", "DocumentCount")
  topNDocuments?: int32;

  @doc("The query type to use with Azure Cognitive Search.")
  queryType?: AzureCognitiveSearchQueryType;

  @doc("Whether queries should be restricted to use of indexed data.")
  @projectedName("csharp", "ShouldRestrictResultScope")
  inScope?: boolean;

  @doc("The additional semantic configuration for the query.")
  semanticConfiguration?: string;

  @doc("When using embeddings for search, specifies the resource URL from which embeddings should be retrieved.")
  embeddingEndpoint?: url;

  @doc("When using embeddings, specifies the API key to use with the provided embeddings endpoint.")
  embeddingKey?: string;
}
