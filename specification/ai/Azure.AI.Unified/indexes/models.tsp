import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../servicepatterns.tsp";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Unified;

@doc("Index resource Definition")
@discriminator("indexType")
model Index is ServicePatterns.Versioned {
  @key
  id: string;
  @doc("Type of index")
  indexType: IndexType;
}

@doc("Azure AI Search Index Definition")
model AzureAISearchIndex extends Index {
  @doc("Type of index")
  indexType: IndexType.azureSearch;

  @doc("Connection id to Azure AI Search")
  connectionId: string;

  @doc("Name of index in Azure AI Search resource to attach")
  indexName: string;
}

@doc("Managed Azure AI Search Index Definition")
model ManagedAzureAISearchIndex extends Index {
  @doc("Type of index")
  indexType: IndexType.managedAzureSearch;

  @doc("Vector store id of managed index")
  vectorStoreId: string;
}

@doc("CosmosDB Vector Store Index Definition")
model CosmosDBIndex extends AssetBase {
  @doc("Type of index")
  indexType: IndexType.cosmosDB;

  @doc("Connection id to CosmosDB")
  connectionId: string;

  @doc("Name of the CosmosDB Database")
  databaseName: string;

  @doc("Name of CosmosDB Container")
  containerName: string;

  @doc("Embedding model configuration")
  embeddingConfiguration: EmbeddingConfiguration;
}

@doc("Embedding configuration class")
model EmbeddingConfiguration {
  @doc("Connection id to embedding model")
  connectionId?: string;

  @doc("Deployment name of embedding model")
  deploymentName: string; 

  @doc("Embedding field")
  embeddingField: string;
}

union IndexType {
  string,

  @doc("Azure search")
  azureSearch: "AzureSearch",

  @doc("CosmosDB")
  cosmosDB: "CosmosDBNoSqlVectorStore",

  @doc("Managed Azure Search")
  managedAzureSearch: "ManagedAzureSearch",
}
