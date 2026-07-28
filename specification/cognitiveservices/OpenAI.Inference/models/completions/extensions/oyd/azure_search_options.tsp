import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

@doc("""
  A specific representation of configurable options for Azure Search when using it as an Azure OpenAI chat
  extension.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
model AzureSearchChatExtensionConfiguration
  extends AzureChatExtensionConfiguration {
  @doc("""
    The type label to use when configuring Azure OpenAI chat extensions. This should typically not be changed from its
    default value for Azure Cognitive Search.
    """)
  type: AzureChatExtensionType.azureSearch;

  @doc("The parameters to use when configuring Azure Search.")
  parameters: AzureSearchChatExtensionParameters;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("Parameters for Azure Cognitive Search when used as an Azure OpenAI chat extension. The supported authentication types are APIKey, SystemAssignedManagedIdentity and UserAssignedManagedIdentity.")
model AzureSearchChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("""
    The authentication method to use when accessing the defined data source.
    Each data source type supports a specific set of available authentication methods; please see the documentation of
    the data source for supported mechanisms.
    If not otherwise provided, On Your Data will attempt to use System Managed Identity (default credential)
    authentication.
    """)
  @clientName("Authentication", "csharp")
  authentication?: OnYourDataAuthenticationOptions;

  @doc("The absolute endpoint path for the Azure Cognitive Search resource to use.")
  @clientName("SearchEndpoint", "csharp")
  endpoint: url;

  @doc("The name of the index to use as available in the referenced Azure Cognitive Search resource.")
  @encodedName("application/json", "index_name")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @clientName("FieldMappingOptions", "csharp")
  @encodedName("application/json", "fields_mapping")
  fieldsMapping?: AzureSearchIndexFieldMappingOptions;

  @doc("The query type to use with Azure Cognitive Search.")
  @encodedName("application/json", "query_type")
  queryType?: AzureSearchQueryType;

  @doc("The additional semantic configuration for the query.")
  @encodedName("application/json", "semantic_configuration")
  semanticConfiguration?: string;

  @doc("Search filter.")
  filter?: string;

  @doc("The embedding dependency for vector search.")
  @encodedName("application/json", "embedding_dependency")
  embeddingDependency?: OnYourDataVectorizationSource;
}

@doc("Optional settings to control how fields are processed when using a configured Azure Search resource.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model AzureSearchIndexFieldMappingOptions {
  @doc("The name of the index field to use as a title.")
  @clientName("TitleFieldName", "csharp")
  @encodedName("application/json", "title_field")
  titleField?: string;

  @doc("The name of the index field to use as a URL.")
  @clientName("UrlFieldName", "csharp")
  @encodedName("application/json", "url_field")
  urlField?: string;

  @doc("The name of the index field to use as a filepath.")
  @clientName("FilepathFieldName", "csharp")
  @encodedName("application/json", "filepath_field")
  filepathField?: string;

  @doc("The names of index fields that should be treated as content.")
  @clientName("ContentFieldNames", "csharp")
  @encodedName("application/json", "content_fields")
  contentFields?: string[];

  @doc("The separator pattern that content fields should use.")
  @clientName("ContentFieldSeparator", "csharp")
  @encodedName("application/json", "content_fields_separator")
  contentFieldsSeparator?: string;

  @doc("The names of fields that represent vector data.")
  @clientName("VectorFieldNames", "csharp")
  @encodedName("application/json", "vector_fields")
  vectorFields?: string[];

  @doc("The names of fields that represent image vector data.")
  @clientName("ImageVectorFieldNames", "csharp")
  @encodedName("application/json", "image_vector_fields")
  imageVectorFields?: string[];
}

@doc("""
  The type of Azure Search retrieval query that should be executed when using it as an Azure OpenAI chat extension.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
union AzureSearchQueryType {
  string,

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
