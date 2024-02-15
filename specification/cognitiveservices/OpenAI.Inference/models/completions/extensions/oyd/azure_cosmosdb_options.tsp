import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

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
MongoDB vCore. The supported authentication type is ConnectionString.
""")
model AzureCosmosDBChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The MongoDB vCore database name to use with Azure Cosmos DB.")
  @clientName("DatabaseName", "csharp")
  databaseName: string;

  @doc("The name of the Azure Cosmos DB resource container.")
  @clientName("ContainerName", "csharp")
  containerName: string;

  @doc("The MongoDB vCore index name to use with Azure Cosmos DB.")
  @clientName("IndexName", "csharp")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @clientName("FieldMappingOptions", "csharp")
  fieldsMapping: AzureCosmosDBFieldMappingOptions;

  @doc("The embedding dependency for vector search.")
  embeddingDependency: OnYourDataVectorizationSource;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@doc("Optional settings to control how fields are processed when using a configured Azure Cosmos DB resource.")
@added(ServiceApiVersions.v2023_12_01_Preview)
model AzureCosmosDBFieldMappingOptions {
  @doc("The name of the index field to use as a title.")
  @clientName("TitleFieldName", "csharp")
  titleField?: string;

  @doc("The name of the index field to use as a URL.")
  @clientName("UrlFieldName", "csharp")
  urlField?: string;

  @doc("The name of the index field to use as a filepath.")
  @clientName("FilepathFieldName", "csharp")
  filepathField?: string;

  @doc("The names of index fields that should be treated as content.")
  @clientName("ContentFieldNames", "csharp")
  contentFields: string[];

  @doc("The separator pattern that content fields should use.")
  @clientName("ContentFieldSeparator", "csharp")
  contentFieldsSeparator?: string;

  @doc("The names of fields that represent vector data.")
  @clientName("VectorFieldNames", "csharp")
  vectorFields: string[];
}
