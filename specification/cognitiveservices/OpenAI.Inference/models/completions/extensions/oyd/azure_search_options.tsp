import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("""
A specific representation of configurable options for Azure Search when using it as an Azure OpenAI chat
extension.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
model AzureSearchChatExtensionConfiguration
  extends AzureChatExtensionConfiguration {
  @doc("""
  The type label to use when configuring Azure OpenAI chat extensions. This should typically not be changed from its
  default value for Azure Search.
  """)
  type: AzureChatExtensionType.azureSearch;

  @doc("The parameters to use when configuring Azure Search.")
  parameters: AzureSearchChatExtensionParameters;
}

@added(ServiceApiVersions.v2023_08_01_Preview)
@doc("Parameters for Azure Search when used as an Azure OpenAI chat extension. The supported authentication types are `api_key`, `system_assigned_managed_identity` and `user_assigned_managed_identity`. The supported vectorization source types are `endpoint` and `deployment_name`")
model AzureSearchChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The absolute endpoint path for the Azure Search resource to use.")
  @projectedName("csharp", "SearchEndpoint")
  endpoint: url;

  @doc("The name of the index to use as available in the referenced Azure Search resource.")
  @projectedName("json", "index_name")
  indexName: string;

  @doc("The API key to use when interacting with the Azure Search resource.")
  @added(ServiceApiVersions.v2023_08_01_Preview)
  @removed(ServiceApiVersions.v2023_12_01_Preview)
  key?: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @projectedName("json", "fields_mapping")
  @projectedName("csharp", "FieldMappingOptions")
  fieldsMapping?: AzureSearchIndexFieldMappingOptions;

  @doc("The query type to use with Azure  Search.")
  @projectedName("json", "query_type")
  queryType?: AzureSearchQueryType;

  @doc("The additional semantic configuration for the query.")
  @projectedName("json", "semantic_configuration")
  semanticConfiguration?: string;

  @doc("Search filter.")
  filter?: string;

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("The embedding dependency for vector search.")
  @projectedName("json", "embedding_dependency")
  embeddingDependency?: OnYourDataVectorizationSource;
}

@doc("Optional settings to control how fields are processed when using a configured Azure Search resource.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model AzureSearchIndexFieldMappingOptions {
  @doc("The name of the index field to use as a title.")
  @projectedName("json", "title_field")
  @projectedName("csharp", "TitleFieldName")
  titleField?: string;

  @doc("The name of the index field to use as a URL.")
  @projectedName("json", "url_field")
  @projectedName("csharp", "UrlFieldName")
  urlField?: string;

  @doc("The name of the index field to use as a filepath.")
  @projectedName("json", "filepath_field")
  @projectedName("csharp", "FilepathFieldName")
  filepathField?: string;

  @doc("The names of index fields that should be treated as content.")
  @projectedName("json", "content_fields")
  @projectedName("csharp", "ContentFieldNames")
  contentFields?: string[];

  @doc("The separator pattern that content fields should use.")
  @projectedName("json", "content_fields_separator")
  @projectedName("csharp", "ContentFieldSeparator")
  contentFieldsSeparator?: string;

  @doc("The names of fields that represent vector data.")
  @projectedName("json", "vector_fields")
  @projectedName("csharp", "VectorFieldNames")
  vectorFields?: string[];

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("The names of fields that represent image vector data.")
  @projectedName("json", "image_vector_fields")
  @projectedName("csharp", "ImageVectorFieldNames")
  imageVectorFields?: string[];
}

@doc("""
The type of Azure Search retrieval query that should be executed when using it as an Azure OpenAI chat extension.
""")
@added(ServiceApiVersions.v2023_08_01_Preview)
enum AzureSearchQueryType {
  @doc("Represents the default, simple query parser.")
  simple: "simple",

  @doc("Represents the semantic query parser for advanced semantic modeling.")
  semantic: "semantic",

  @doc("Represents vector search over computed data.")
  vector: "vector",

  @doc("Represents a combination of the simple query strategy with vector data.")
  vectorSimpleHybrid: "vector_simple_hybrid",

  @doc("Represents a combination of semantic search and vector data querying.")
  vectorSemanticHybrid: "vector_semantic_hybrid",
}
