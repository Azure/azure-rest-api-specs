import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Unified;

@doc("AssetVersion Definition")
model AssetVersion {
  @doc("Fully qualified resource Id: azureml://workspace/{workspaceName}/indexes/{name}/versions/{version} of the index.")
  @visibility("read")
  id: string;

  @doc("Update stage to 'Archive' to archive the asset. Default is Development, which means the asset is under development.")
  stage?: string = "Development";

  @doc("Description information of the asset.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Asset's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Asset's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;
}

@doc("Index resource Definition")
model Index is AssetVersion {
  @doc("Index configuration")
  indexConfiguration: IndexConfiguration;

  @doc("Embedding configuration")
  embeddingConfiguration: EmbeddingConfiguration;
}

@doc("Paged collection of IndexVersion items.")
@pagedResult
model PagedIndex {
  @doc("The list of Indexes.")
  @extension("x-ms-identifiers", [])
  @items
  value: Index[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Index>;
}


@doc("Index configuration class")
model IndexConfiguration {
  @doc("Connection id of indexing service")
  connectionId: string;

  @doc("Name of index")
  indexName: string;

  @doc("Vector store id")
  vectorStoreId: string;

  @doc("Type of index")
  indexType: IndexType
}

@doc("Embedding configuration class")
model EmbeddingConfiguration {
  @doc("Connection id to embedding model")
  connectionId: string;

  @doc("Deployment name of embedding model")
  deploymentName: string;

  @doc("Dimension")
  dimension: int64;

  @doc("Embedding field")
  embeddingField: string;
}

union IndexType {
  string,

  @doc("Azure search")
  azureSearch: "AzureSearch",

  @doc("CosmosDB")
  cosmosDB: "CosmosDB",

  @doc("Managed Azure Search")
  managedAzureSearch: "ManagedAzureSearch",
}