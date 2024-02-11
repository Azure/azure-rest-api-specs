import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
A specific representation of configurable options for Azure Cosmos DB when using it as an Azure OpenAI chat
extension.
""")
model AzureCosmosDBChatExtensionConfiguration
  extends AzureChatExtensionConfiguration {
  @doc("""
  The type label to use when configuring Azure OpenAI chat extensions. This should typically not be changed from its
  default value for Azure Cosmos DB.
  """)
  type: AzureChatExtensionType.azureCosmosDB;

  @doc("The parameters to use when configuring Azure OpenAI CosmosDB chat extensions.")
  parameters: AzureCosmosDBChatExtensionParameters;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
Parameters to use when configuring Azure OpenAI On Your Data chat extensions when using Azure Cosmos DB for
MongoDB vCore. The supported authentication type is `connection_string`. The supported vectorization source types are `endpoint` and `deployment_name`.
""")
model AzureCosmosDBChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The MongoDB vCore database name to use with Azure Cosmos DB.")
  @projectedName("json", "database_name")
  @projectedName("csharp", "DatabaseName")
  databaseName: string;

  @doc("The name of the Azure Cosmos DB resource container.")
  @projectedName("json", "container_name")
  @projectedName("csharp", "ContainerName")
  containerName: string;

  @doc("The MongoDB vCore index name to use with Azure Cosmos DB.")
  @projectedName("json", "index_name")
  @projectedName("csharp", "IndexName")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @projectedName("json", "fields_mapping")
  @projectedName("csharp", "FieldMappingOptions")
  fieldsMapping: AzureCosmosDBFieldMappingOptions;

  @doc("The embedding dependency for vector search. The supported types are `endpoint` and `deployment_name`.")
  @projectedName("json", "embedding_dependency")
  embeddingDependency: OnYourDataVectorizationSource;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@doc("Optional settings to control how fields are processed when using a configured Azure Cosmos DB resource.")
@added(ServiceApiVersions.v2023_12_01_Preview)
model AzureCosmosDBFieldMappingOptions {
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
  contentFields: string[];

  @doc("The separator pattern that content fields should use.")
  @projectedName("json", "content_fields_separator")
  @projectedName("csharp", "ContentFieldSeparator")
  contentFieldsSeparator?: string;

  @doc("The names of fields that represent vector data.")
  @projectedName("json", "vector_fields")
  @projectedName("csharp", "VectorFieldNames")
  vectorFields: string[];
}
