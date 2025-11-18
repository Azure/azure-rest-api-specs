import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

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

  @doc("""
    The authentication method to use when accessing the defined data source.
    Each data source type supports a specific set of available authentication methods; please see the documentation of
    the data source for supported mechanisms.
    If not otherwise provided, On Your Data will attempt to use System Managed Identity (default credential)
    authentication.
    """)
  @clientName("Authentication", "csharp")
  authentication?: OnYourDataAuthenticationOptions;

  @doc("The MongoDB vCore database name to use with Azure Cosmos DB.")
  @clientName("DatabaseName", "csharp")
  @encodedName("application/json", "database_name")
  databaseName: string;

  @doc("The name of the Azure Cosmos DB resource container.")
  @clientName("ContainerName", "csharp")
  @encodedName("application/json", "container_name")
  containerName: string;

  @doc("The MongoDB vCore index name to use with Azure Cosmos DB.")
  @clientName("IndexName", "csharp")
  @encodedName("application/json", "index_name")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @clientName("FieldMappingOptions", "csharp")
  @encodedName("application/json", "fields_mapping")
  fieldsMapping: AzureCosmosDBFieldMappingOptions;

  @doc("The embedding dependency for vector search.")
  @encodedName("application/json", "embedding_dependency")
  embeddingDependency: OnYourDataVectorizationSource;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@doc("Optional settings to control how fields are processed when using a configured Azure Cosmos DB resource.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model AzureCosmosDBFieldMappingOptions {
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
  contentFields: string[];

  @doc("The separator pattern that content fields should use.")
  @clientName("ContentFieldSeparator", "csharp")
  @encodedName("application/json", "content_fields_separator")
  contentFieldsSeparator?: string;

  @doc("The names of fields that represent vector data.")
  @clientName("VectorFieldNames", "csharp")
  @encodedName("application/json", "vector_fields")
  vectorFields: string[];
}
