import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

import "../common/models.tsp";
import "../common/service.tsp";

namespace Azure.AI.Projects;

@doc("Index resource Definition")
@discriminator("type")
@Rest.resource("indexes")
model Index {
  @doc("Type of index")
  type: IndexType;

  ...AssetBase;
}

@doc("Azure AI Search Index Definition")
model AzureAISearchIndex extends Index {
  @doc("Type of index")
  type: IndexType.azureSearch;

  @doc("Name of connection to Azure AI Search")
  @visibility(Lifecycle.Create)
  connectionName: string;

  @doc("Name of index in Azure AI Search resource to attach")
  @visibility(Lifecycle.Create)
  indexName: string;

  @doc("Field mapping configuration")
  @visibility(Lifecycle.Create)
  fieldMapping?: FieldMapping;
}

@doc("Managed Azure AI Search Index Definition")
model ManagedAzureAISearchIndex extends Index {
  @doc("Type of index")
  type: IndexType.managedAzureSearch;

  @doc("Vector store id of managed index")
  @visibility(Lifecycle.Create)
  vectorStoreId: string;
}

@doc("CosmosDB Vector Store Index Definition")
model CosmosDBIndex extends Index {
  @doc("Type of index")
  type: IndexType.cosmosDB;

  @doc("Name of connection to CosmosDB")
  @visibility(Lifecycle.Create)
  connectionName: string;

  @doc("Name of the CosmosDB Database")
  @visibility(Lifecycle.Create)
  databaseName: string;

  @doc("Name of CosmosDB Container")
  @visibility(Lifecycle.Create)
  containerName: string;

  @doc("Embedding model configuration")
  @visibility(Lifecycle.Create)
  embeddingConfiguration: EmbeddingConfiguration;

  @doc("Field mapping configuration")
  @visibility(Lifecycle.Create)
  fieldMapping: FieldMapping;
}

@doc("Embedding configuration class")
model EmbeddingConfiguration {
  @doc("Deployment name of embedding model. It can point to a model deployment either in the parent AIServices or a connection.")
  @visibility(Lifecycle.Create)
  modelDeploymentName: string;

  @doc("Embedding field")
  @visibility(Lifecycle.Create)
  embeddingField: string;
}

@doc("Field mapping configuration class")
model FieldMapping {
  @doc("List of fields with text content")
  @visibility(Lifecycle.Create)
  contentFields: string[];

  @doc("Path of file to be used as a source of text content")
  @visibility(Lifecycle.Create)
  filepathField?: string;

  @doc("Field containing the title of the document")
  @visibility(Lifecycle.Create)
  titleField?: string;

  @doc("Field containing the url of the document")
  @visibility(Lifecycle.Create)
  urlField?: string;

  @doc("List of fields with vector content")
  @visibility(Lifecycle.Create)
  vectorFields?: string[];

  @doc("List of fields with metadata content")
  @visibility(Lifecycle.Create)
  metadataFields?: string[];
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
