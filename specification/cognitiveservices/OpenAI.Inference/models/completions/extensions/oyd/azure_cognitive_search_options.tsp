import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("""
A specific representation of configurable options for Azure Cognitive Search when using it as an Azure OpenAI chat
extension.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
model AzureCognitiveSearchChatExtensionConfiguration
  extends AzureChatExtensionConfiguration {
  @doc("""
  The type label to use when configuring Azure OpenAI chat extensions. This should typically not be changed from its
  default value for Azure Cognitive Search.
  """)
  type: AzureChatExtensionType.azureCognitiveSearch;

  @doc("The parameters to use when configuring Azure Cognitive Search.")
  parameters: AzureCognitiveSearchChatExtensionParameters;
}

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("Parameters for Azure Cognitive Search when used as an Azure OpenAI chat extension.")
model AzureCognitiveSearchChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The absolute endpoint path for the Azure Cognitive Search resource to use.")
  @projectedName("csharp", "SearchEndpoint")
  endpoint: url;

  @doc("The name of the index to use as available in the referenced Azure Cognitive Search resource.")
  indexName: string;

  @doc("The API key to use when interacting with the Azure Cognitive Search resource.")
  @added(ServiceApiVersions.v2023_08_01_Preview)
  @removed(ServiceApiVersions.v2023_12_01_Preview)
  key?: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @projectedName("csharp", "FieldMappingOptions")
  fieldsMapping?: AzureCognitiveSearchIndexFieldMappingOptions;

  @doc("The query type to use with Azure Cognitive Search.")
  queryType?: AzureCognitiveSearchQueryType;

  @doc("The additional semantic configuration for the query.")
  semanticConfiguration?: string;

  @doc("Search filter.")
  filter?: string;

  @doc("When using embeddings for search, specifies the resource endpoint URL from which embeddings should be retrieved. It should be in the format of format https://YOUR_RESOURCE_NAME.openai.azure.com/openai/deployments/YOUR_DEPLOYMENT_NAME/embeddings?api-version={api-version}.")
  @added(ServiceApiVersions.v2023_08_01_Preview)
  @removed(ServiceApiVersions.v2023_12_01_Preview)
  embeddingEndpoint?: url;

  @added(ServiceApiVersions.v2023_08_01_Preview)
  @removed(ServiceApiVersions.v2023_12_01_Preview)
  @doc("When using embeddings, specifies the API key to use with the provided embeddings endpoint.")
  embeddingKey?: string;

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("The embedding dependency for vector search.")
  embeddingDependency?: OnYourDataVectorizationSource;
}

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
  contentFields?: string[];

  @doc("The separator pattern that content fields should use.")
  @projectedName("csharp", "ContentFieldSeparator")
  contentFieldsSeparator?: string;

  @doc("The names of fields that represent vector data.")
  @projectedName("csharp", "VectorFieldNames")
  vectorFields?: string[];

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("The names of fields that represent image vector data.")
  @projectedName("csharp", "ImageVectorFieldNames")
  imageVectorFields?: string[];
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
