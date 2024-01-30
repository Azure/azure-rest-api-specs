import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@added(ServiceApiVersions.v2024_02_15_Preview)
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
@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
Parameters to use when configuring Azure OpenAI On Your Data chat extensions when using Azure Cosmos DB for
MongoDB vCore. The supported authentication type is ConnectionString.
""")
model AzureCosmosDBChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The MongoDB vCore database name to use with Azure Cosmos DB.")
  @projectedName("csharp", "DatabaseName")
  @projectedName("json", "database_name")
  databaseName: string;

  @doc("The name of the Azure Cosmos DB resource container.")
  @projectedName("csharp", "ContainerName")
  @projectedName("json", "container_name")
  containerName: string;

  @doc("The MongoDB vCore index name to use with Azure Cosmos DB.")
  @projectedName("csharp", "IndexName")
  @projectedName("json", "index_name")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @projectedName("csharp", "FieldMappingOptions")
  @projectedName("json", "fields_mapping")
  fieldsMapping: AzureCosmosDBFieldMappingOptions;

  @doc("The embedding dependency for vector search.")
  @projectedName("json", "embedding_dependency")
  embeddingDependency: OnYourDataVectorizationSource;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@doc("Optional settings to control how fields are processed when using a configured Azure Cosmos DB resource.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model AzureCosmosDBFieldMappingOptions {
  @doc("The name of the index field to use as a title.")
  @projectedName("csharp", "TitleFieldName")
  @projectedName("json", "title_field")
  titleField?: string;

  @doc("The name of the index field to use as a URL.")
  @projectedName("csharp", "UrlFieldName")
  @projectedName("json", "url_field")
  urlField?: string;

  @doc("The name of the index field to use as a filepath.")
  @projectedName("csharp", "FilepathFieldName")
  @projectedName("json", "filepath_field")
  filepathField?: string;

  @doc("The names of index fields that should be treated as content.")
  @projectedName("csharp", "ContentFieldNames")
  @projectedName("json", "content_fields")
  contentFields: string[];

  @doc("The separator pattern that content fields should use.")
  @projectedName("csharp", "ContentFieldSeparator")
  @projectedName("json", "content_fields_separator")
  contentFieldsSeparator?: string;

  @doc("The names of fields that represent vector data.")
  @projectedName("csharp", "VectorFieldNames")
  @projectedName("json", "vector_fields")
  vectorFields: string[];
}
