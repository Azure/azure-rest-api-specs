import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Index resource Definition")
@discriminator("type")
@Rest.resource("indexes")
@added(Versions.v2025_05_01)
model Index {
  @doc("Type of index")
  type: IndexType;

  ...AssetBase;
}

@doc("Azure AI Search Index Definition")
@added(Versions.v2025_05_01)
model AzureAISearchIndex extends Index {
  @doc("Type of index")
  type: IndexType.azureSearch;

  @doc("Name of connection to Azure AI Search")
  connectionName: string;

  @doc("Name of index in Azure AI Search resource to attach")
  indexName: string;
}

@doc("Managed Azure AI Search Index Definition")
@added(Versions.v2025_05_01)
model ManagedAzureAISearchIndex extends Index {
  @doc("Type of index")
  type: IndexType.managedAzureSearch;

  @doc("Vector store id of managed index")
  vectorStoreId: string;
}

@doc("CosmosDB Vector Store Index Definition")
@added(Versions.v2025_05_01)
model CosmosDBIndex extends Index {
  @doc("Type of index")
  type: IndexType.cosmosDB;

  @doc("Name of connection to CosmosDB")
  connectionName: string;

  @doc("Name of the CosmosDB Database")
  databaseName: string;

  @doc("Name of CosmosDB Container")
  containerName: string;

  @doc("Embedding model configuration")
  embeddingConfiguration: EmbeddingConfiguration;
}

@doc("Embedding configuration class")
@added(Versions.v2025_05_01)
model EmbeddingConfiguration {
  @doc("Deployment name of embedding model. It can point to a model deployment either in the parent AIServices or a connection.")
  modelDeploymentName: string;

  @doc("Embedding field")
  embeddingField: string;
}

@added(Versions.v2025_05_01)
union IndexType {
  string,

  @doc("Azure search")
  azureSearch: "AzureSearch",

  @doc("CosmosDB")
  cosmosDB: "CosmosDBNoSqlVectorStore",

  @doc("Managed Azure Search")
  managedAzureSearch: "ManagedAzureSearch",
}
