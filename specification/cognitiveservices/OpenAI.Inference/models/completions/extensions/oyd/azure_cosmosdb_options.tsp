import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
A specific representation of configurable options for Elasticsearch when using it as an Azure OpenAI chat
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
@doc("Parameters to use when configuring Azure OpenAI CosmosDB chat extensions.")
model AzureCosmosDBChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The database name of Azure Cosmos DB.")
  @projectedName("csharp", "DatabaseName")
  databaseName: string;

  @doc("The container name name of Azure Cosmos DB.")
  @projectedName("csharp", "ContainerName")
  containerName: string;

  @doc("The index name name of Azure Cosmos DB.")
  @projectedName("csharp", "IndexName")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @projectedName("csharp", "FieldMappingOptions")
  fieldsMapping: AzureCosmosDBFieldMappingOptions;

  @doc("The embedding dependency for vector search.")
  embeddingDependency?: OnYourDataEmbeddingDependency;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@doc("Optional settings to control how fields are processed when using a configured Azure Cosmos DB resource.")
@added(ServiceApiVersions.v2023_12_01_Preview)
model AzureCosmosDBFieldMappingOptions {
  @doc("The names of fields that represent vector data.")
  @projectedName("csharp", "VectorFieldNames")
  vectorFields: string[];
}
