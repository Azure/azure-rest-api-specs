import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2023_12_01_Preview)
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

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("Parameters to use when configuring Elasticsearch® as an Azure OpenAI chat extension.")
model ElasticsearchChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The endpoint of Elasticsearch®.")
  endpoint: url;

  @doc("The index name of Elasticsearch®.")
  indexName: string;

  @doc("The index field mapping options of Elasticsearch®.")
  @projectedName("csharp", "FieldMappingOptions")
  fieldsMapping?: ElasticsearchIndexFieldMappingOptions;

  @doc("The query type of Elasticsearch®.")
  queryType?: ElasticsearchQueryType;

  @doc("The embedding dependency for vector search.")
  embeddingDependency?: OnYourDataVectorizationSource;
}

@doc("Optional settings to control how fields are processed when using a configured Elasticsearch® resource.")
@added(ServiceApiVersions.v2023_12_01_Preview)
model ElasticsearchIndexFieldMappingOptions {
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
}

@doc("""
The type of Elasticsearch® retrieval query that should be executed when using it as an Azure OpenAI chat extension.
""")
@added(ServiceApiVersions.v2023_12_01_Preview)
enum ElasticsearchQueryType {
  @doc("Represents the default, simple query parser.")
  simple: "simple",

  @doc("Represents vector search over computed data.")
  vector: "vector",
}
