import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  A specific representation of configurable options for Elasticsearch when using it as an Azure OpenAI chat
  extension.
  """)
model ElasticsearchChatExtensionConfiguration
  extends AzureChatExtensionConfiguration {
  @doc("""
    The type label to use when configuring Azure OpenAI chat extensions. This should typically not be changed from its
    default value for Elasticsearch®.
    """)
  type: AzureChatExtensionType.elasticsearch;

  @doc("The parameters to use when configuring Elasticsearch®.")
  parameters: ElasticsearchChatExtensionParameters;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("Parameters to use when configuring Elasticsearch® as an Azure OpenAI chat extension. The supported authentication types are KeyAndKeyId and EncodedAPIKey.")
model ElasticsearchChatExtensionParameters {
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

  @doc("The endpoint of Elasticsearch®.")
  endpoint: url;

  @doc("The index name of Elasticsearch®.")
  @encodedName("application/json", "index_name")
  indexName: string;

  @doc("The index field mapping options of Elasticsearch®.")
  @clientName("FieldMappingOptions", "csharp")
  @encodedName("application/json", "fields_mapping")
  fieldsMapping?: ElasticsearchIndexFieldMappingOptions;

  @doc("The query type of Elasticsearch®.")
  @encodedName("application/json", "query_type")
  queryType?: ElasticsearchQueryType;

  @doc("The embedding dependency for vector search.")
  @encodedName("application/json", "embedding_dependency")
  embeddingDependency?: OnYourDataVectorizationSource;
}

@doc("Optional settings to control how fields are processed when using a configured Elasticsearch® resource.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model ElasticsearchIndexFieldMappingOptions {
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
}

@doc("""
  The type of Elasticsearch® retrieval query that should be executed when using it as an Azure OpenAI chat extension.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
union ElasticsearchQueryType {
  string,

  @doc("Represents the default, simple query parser.")
  simple: "simple",

  @doc("Represents vector search over computed data.")
  vector: "vector",
}
